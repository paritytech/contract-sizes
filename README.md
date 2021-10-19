# Contract Code Size Comparison

The goal of this repository is to compare the sizes of compiled solidity contracts when
compiled to EVM (with [solc](https://soliditylang.org/)) versus WASM
(with [solang](https://github.com/hyperledger-labs/solang)).

After some experimentation it turned out that a huge contributor to WASM code sizes is the
smaller word size of WASM. Solidity treats 256bit variables as value types and passes
them on the stack. Solang generates four 32bit stack accesses to emulate this. In order to
improve comparability we do the following:

- Patch all contracts used for comparisons to not use wide integers (use `uint32` everywhere).
- Pass `--value-size 4 --address-size 4` to solang so that 32bit is usedfor the builtin types (address, msg.value).

## How to use this repository

Put `solang` in your `PATH` and run `compile.sh` which is located in the root
of this repository. The `solc` compiler will be downloaded automatically.

## Test corpus

The current plan is to use the following sources as a test corpus:

- The [OpenZeppelin library](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts).
- Popular contracts according to [this](https://etherscan.io/gasTracker) statistic.

Adding a new contract to the corpus from either of those sources is a time consuming process
because solang isn't a drop in replacement. It tries hard to be one but there are some things
that won't work on solang: First, almost all contracts use EVM inline assembly which obviously
won't work on a compiler targeting another architecture. Second, differences in builtin types
(address, balance) will prevent the compilation of most contracts.

Therefore we need to apply substantial changes to every contract before it can bea dded to the
corpus in order to make it compile and establish comparability.

## Results

The following results show the compressed sizes (zstd) of the evm and wasm targets together
with their compression ratio. Wasm relative describes the relative size of the compressed
wasm output when compared to the evm output.

The concatenated row is what we get when we concatenate the uncompressed results of all
contracts.

Used solang version is commit `c2a8bd9881e64e41565cdfe088ffe9464c74dae4`.

| Contract | EVM Compressed | WASM Compressed | EVM Ratio | WASM Ratio | Wasm Relative |
| -------- | -------------- | --------------- | --------- | ---------- | ------------- |
| `ERC20PresetFixedSupply.sol` |  2162 |  2891 | 50% | 34% | 133% |
| `UniswapV2Router02.sol`   |  5826 |  9219 | 30% | 28% | 158% |
| **concatenated**          |  7849 | 11579 | 33% | 28% | 147% |