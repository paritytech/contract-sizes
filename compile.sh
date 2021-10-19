#!/bin/sh

set -e

compile_solidity() {
	local infile=${1}
	local compiler=${2}
	local name=${infile##*/}
	local outpath=target/solidity/${name}
	local outfile=${outpath}/${name}
	mkdir -p ${outpath}
	${compiler} -o ${outpath} --optimize --bin contracts/${infile}.sol &> /dev/null && \
		xxd -r -p ${outfile}.bin ${outfile}.raw
		mv ${outfile}.raw ${outfile}.bin
		cat ${outfile}.bin >> ${outpath}/../combined.bin
		zstd ${outfile}.bin &> /dev/null
		mv ${outfile}.bin.zst ${outpath}/../result
}

compile_solang() {
	local infile=${1}
	local name=${infile##*/}
	local outpath=target/1solang/${name}
	local outfile=${outpath}/${name}
	mkdir -p ${outpath}
	solang contracts/${infile}.sol -I . --target substrate --address-length 4 --value-length 4 -O default -o ${outpath} &> /dev/null && \
		rm ${outfile}.contract && \
		wasm-opt -Oz --strip-producers --zero-filled-memory -o ${outfile}_opt.wasm ${outfile}.wasm &> /dev/null && \
		mv ${outfile}_opt.wasm ${outfile}.wasm
		cat ${outfile}.wasm >> ${outpath}/../combined.wasm
		zstd ${outfile}.wasm &> /dev/null
		mv ${outfile}.wasm.zst ${outpath}/../result
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
	local solc_size=$(wc -c <"target/solidity/result")
	local solang_size=$(wc -c <"target/1solang/result")
	echo "${ident} solidity: $((solc_size)) solang: $((solang_size)) wasm_overhead: $((solang_size * 100 / solc_size - 100))%"
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

compile "open-zeppelin/token/ERC20/presets/ERC20PresetFixedSupply" "v0.8.9+commit.e5eed63a"
compile "UniswapV2Router02" "v0.6.6+commit.6c089d02"

COMBINED_EVM=target/solidity/combined.bin
COMBINED_WASM=target/1solang/combined.wasm

zstd ${COMBINED_EVM}
zstd ${COMBINED_WASM}

EVM_SIZE=$(wc -c <"${COMBINED_EVM}.zst")
WASM_SIZE=$(wc -c <"${COMBINED_WASM}.zst")

echo "wasm overhead: $((WASM_SIZE * 100 / EVM_SIZE - 100))%"
