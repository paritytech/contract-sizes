#!/bin/sh

set -e

compile_solidity() {
	local infile=${1}
	local compiler=${2}
	local name=${infile##*/}
	local outpath=target/solidity/${name}
	local outfile=${outpath}/${name}
	mkdir -p ${outpath}
	${compiler} -o ${outpath} --optimize --bin contracts/${infile}.sol &> /dev/null  && \
		xxd -r -p ${outfile}.bin ${outfile}.raw
		mv ${outfile}.raw ${outfile}.bin
		cat ${outfile}.bin >> ${outpath}/../combined.bin
		zstd ${outfile}.bin &> /dev/null
		mv ${outfile}.bin ${outpath}/../result
		mv ${outfile}.bin.zst ${outpath}/../result_compressed
}

compile_solang() {
	local infile=${1}
	local name=${infile##*/}
	local outpath=target/solang/${name}
	local outfile=${outpath}/${name}
	mkdir -p ${outpath}
	solang contracts/${infile}.sol -I . --target substrate --address-length 4 --value-length 4 -O default -o ${outpath} &> /dev/null && \
		rm ${outfile}.contract && \
		wasm-opt -Oz --strip-producers --zero-filled-memory -o ${outfile}_opt.wasm ${outfile}.wasm &> /dev/null && \
		mv ${outfile}_opt.wasm ${outfile}.wasm
		cat ${outfile}.wasm >> ${outpath}/../combined.wasm
		zstd ${outfile}.wasm &> /dev/null
		mv ${outfile}.wasm ${outpath}/../result
		mv ${outfile}.wasm.zst ${outpath}/../result_compressed
}

download_solc() {
	local version=${1}
	local url="https://binaries.soliditylang.org/${OS}/solc-${OS}-${version}"
	local outfile="solc-bin/solc-${OS}-${version}"
	if ! [ -f ${outfile} ]; then
		curl -o ${outfile} ${url}
		chmod +x ${outfile}
	fi
	echo ${outfile}
}

compile () {
	local contract_name=${1}
	local solc_version=${2}
	local ident=${contract_name##*/}
	compile_solidity ${contract_name} $( download_solc ${solc_version} )
	compile_solang ${contract_name}
	local evm_plain=$(wc -c <"target/solidity/result")
	local wasm_plain=$(wc -c <"target/solang/result")
	local evm_compressed=$(wc -c <"target/solidity/result_compressed")
	local wasm_compressed=$(wc -c <"target/solang/result_compressed")
	printf "| %-25s | %5u | %5u | %2u%% | %2u%% | %2u%% |\n"\
		\`${ident}.sol\`\
		$((evm_compressed))\
		$((wasm_compressed))\
		$((evm_compressed * 100 / evm_plain))\
		$((wasm_compressed * 100 / wasm_plain))\
		$((wasm_compressed * 100 / evm_compressed))
}

rm -rf target/*
mkdir -p solc-bin

case "$OSTYPE" in
	darwin*)  OS="macosx-amd64" ;;
	linux*)   OS="linux-amd64" ;;
	*)
		echo "OS not supported: $OSTYPE"
		exit 1
		;;
esac

printf "| Contract | EVM Compressed | WASM Compressed | EVM Ratio | WASM Ratio | Wasm Relative |\n"
printf "| -------- | -------------- | --------------- | --------- | ---------- | ------------- |\n"

compile "open-zeppelin/token/ERC20/presets/ERC20PresetFixedSupply" "v0.8.9+commit.e5eed63a"
compile "uniswap-v2-solang/UniswapV2Pair" "v0.5.16+commit.9c3226ce"
compile "UniswapV2Router02" "v0.6.6+commit.6c089d02"

COMBINED_EVM=target/solidity/combined.bin
COMBINED_WASM=target/solang/combined.wasm

zstd ${COMBINED_EVM} &> /dev/null
zstd ${COMBINED_WASM} &> /dev/null

EVM_PLAIN=$(wc -c <"${COMBINED_EVM}")
WASM_PLAIN=$(wc -c <"${COMBINED_WASM}")
EVM_COMPRESSED=$(wc -c <"${COMBINED_EVM}.zst")
WASM_COMPRESSED=$(wc -c <"${COMBINED_WASM}.zst")

printf "| %-25s | %5u | %5u | %2u%% | %2u%% | %2u%% |\n"\
		**concatenated**\
		$((EVM_COMPRESSED))\
		$((WASM_COMPRESSED))\
		$((EVM_COMPRESSED * 100 / EVM_PLAIN))\
		$((WASM_COMPRESSED * 100 / WASM_PLAIN))\
		$((WASM_COMPRESSED * 100 / EVM_COMPRESSED))
