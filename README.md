# 24xxxx-spin
-------------

This is a P8X32A/Propeller, P2X8C4M64P/Propeller 2 driver object for 24xxxx series EEPROMs (e.g., 24C512).

**IMPORTANT**: This software is meant to be used with the [spin-standard-library](https://github.com/avsa242/spin-standard-library) (P8X32A) or [p2-spin-standard-library](https://github.com/avsa242/p2-spin-standard-library) (P2X8C4M64P). Please install the applicable library first before attempting to use this code, otherwise you will be missing several files required to build the project.

## Salient Features

* I2C connection at up to 1MHz
* Read single byte, read multiple bytes
* Write single byte, write multiple bytes (up to 64 per transaction)

## Requirements

P1/SPIN1:
* spin-standard-library
* 1 extra core/cog for the PASM I2C engine
* memory.common.spinh (provided by spin-standard-library)

P2/SPIN2:
* p2-spin-standard-library
* memory.common.spin2h (provided by p2-spin-standard-library)

## Compiler Compatibility

| Processor | Language | Compiler               | Backend      | Status                |
|-----------|----------|------------------------|--------------|-----------------------|
| P1        | SPIN1    | FlexSpin (6.1.1)       | Bytecode     | OK                    |
| P1        | SPIN1    | FlexSpin (6.1.1)       | Native/PASM  | OK                    |
| P2        | SPIN2    | FlexSpin (6.1.1)       | NuCode       | OK                    |
| P2        | SPIN2    | FlexSpin (6.1.1)       | Native/PASM2 | FTBFS                 |

(other versions or toolchains not listed are __not supported__, and _may or may not_ work)

## Limitations

* TBD

