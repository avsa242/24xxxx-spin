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
* 1 extra core/cog for the PASM I2C driver

P2/SPIN2:
* p2-spin-standard-library

## Compiler Compatibility

* P1/SPIN1: OpenSpin (tested with 1.00.81), FlexSpin (tested with 5.3.3-beta)
* P2/SPIN2: FlexSpin (tested with 5.3.3-beta)
* ~~BST~~ (incompatible - no preprocessor)
* ~~Propeller Tool~~ (incompatible - no preprocessor)
* ~~PNut~~ (incompatible - no preprocessor)

## Limitations

* Very early in development - may malfunction, or outright fail to build

## TODO
- [x] Support different size EEPROMs
- [x] Port to P2/SPIN2
