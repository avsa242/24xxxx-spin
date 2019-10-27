# at24cxxxx-spin 
----------------

This is a P8X32A/Propeller driver object for AT24Cxxxx series EEPROMs.

## Salient Features

* I2C connection at up to 400kHz
* Read single byte, read multiple bytes
* Write single byte, write multiple bytes (up to 64 per transaction)

## Requirements

* 1 extra core/cog for the PASM I2C driver

## Compiler Compatibility

- [x] OpenSpin (tested with 1.00.81)

## Limitations

* Very early in development - may malfunction, or outright fail to build
* Page mode currently hardcoded for 256kbit/32kByte EEPROMs (64 byte pages)

## TODO
- [ ] Support different size EEPROMs
