# Chuff - Huff Utility Contracts

Common Solidity contract patterns, based on Openzeppelin's contract library, implemented in the Huff language:

- Access Control: `access/Ownable.huff`
- Safe Math: `math/SafeMath.huff`

Spoiler: [It's cheap](https://github.com/alexroan/huff-math/blob/master/.gas-snapshot#L1-L2).

## Table Of Contents

- [Table Of Contents](#table-of-contents)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Quickstart](#quickstart)
  - [Gas Comparison](#gas-comparison)
  - [Testing](#testing)
- [Misc](#misc)
  - [Disclaimer](#disclaimer)
  - [Contributing](#contributing)
  - [Resources](#resources)
  - [Helpful Debugging Resources:](#helpful-debugging-resources)

## Getting Started

### Requirements

Please install the following:

-   [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)  
    -   You'll know you've done it right if you can run `git --version`
-   [Foundry / Foundryup](https://github.com/gakonst/foundry)
    -   This will install `forge`, `cast`, and `anvil`
    -   You can test you've installed them right by running `forge --version` and get an output like: `forge 0.2.0 (f016135 2022-07-04T00:15:02.930499Z)`
    -   To get the latest of each, just run `foundryup`
-   [Huff Compiler](https://docs.huff.sh/get-started/installing/)
    -   You'll know you've done it right if you can run `huffc --version` and get an output like: `huffc 0.2.0`


### Quickstart

```sh
git clone https://github.com/alexroan/huff-math.git
cd huff-math
make
```

### Gas Comparison

Gas comparison tests between the Huff implementation and native Solidity checked math can be found in the [test files](https://github.com/alexroan/huff-math/tree/master/test). The naming convention for these comparisons are:

```
function test<function_name>Gas[Huff/Solidity]() public {...}
```

Results can be found in [.gas-snapshot](https://github.com/alexroan/huff-math/blob/master/.gas-snapshot) in the repo root.


### Testing

`make test` or `forge test`

## Misc

### Disclaimer

> None of the contacts have been audited, use at your own risk.

### Contributing

Contributions are always welcome! Open a PR or an issue!

Thank You!

### Resources

-   [Foundry Documentation](https://book.getfoundry.sh/)
-   [Huff Documentation](https://docs.huff.sh/)

### Helpful Debugging Resources:

- [evm.codes](https://www.evm.codes/)
- [evm.codes playground](https://www.evm.codes/playground)
- [Huff VSCode Debugger & Highlighter](https://github.com/huff-language/vscode-huff)