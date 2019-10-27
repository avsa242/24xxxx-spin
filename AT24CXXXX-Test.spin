{
    --------------------------------------------
    Filename: AT24CXXXX-Test.spin
    Author: Jesse Burt
    Description: Test of the AT24Cxxxx driver
    Copyright (c) 2019
    Started Oct 26, 2019
    Updated Oct 27, 2019
    See end of file for terms of use.
    --------------------------------------------
}

CON

    _clkmode    = cfg#_clkmode
    _xinfreq    = cfg#_xinfreq

    LED         = cfg#LED1
    SCL_PIN     = 24
    SDA_PIN     = 25
    I2C_HZ      = 400_000

    EE128K      = $01_FF_FF
    EE64K       = $00_FF_FF
    EE32K       = $00_7F_FF
    EE16K       = $00_3F_FF
    EE8K        = $00_1F_FF

OBJ

    cfg     : "core.con.boardcfg.flip"
    ser     : "com.serial.terminal"
    time    : "time"
    ee      : "memory.eeprom.at24cxxxx.i2c"

VAR

    byte _ser_cog
    byte _ee_page[64]
    byte _blank_page[64]
    byte _array[4]

PUB Main | i, tmp

    Setup

    ser.Position (0, 5)
    tmp := CheckSig
    ifnot tmp
        ser.Str (string("Writing pattern and retrying..."))
        WritePattern
        CheckSig

    repeat i from 0 to 32767-64 step 64
        ee.ReadBytes (i, 64, @_ee_page)
        HexDump (@_ee_page, i, 128, 16, 0, 8)
        ser.CharIn

    Flash (LED, 100)

PUB CheckSig | tmp

    ser.Str (string("Checking pattern..."))
    ee.ReadBytes (0, 4, @tmp)
    if tmp == $54_53_45_54
        ser.Str (string("Found", ser#NL))
        return TRUE
    else
        ser.Str (string("Not found", ser#NL))
        return FALSE

PUB WritePattern | i

    _array[0] := "T"
    _array[1] := "E"
    _array[2] := "S"
    _array[3] := "T"

    ee.WriteBytes (0, 4, @_array)

PUB Erase(bytes) | i

    bytefill(@_blank_page, $00, 64)
    repeat i from 0 to bytes-64 step 64
        ser.Position (0, 3)
        ser.Str (string("Erasing page @"))
        ser.Hex (i, 5)
        ee.WriteBytes (i, 64, @_blank_page)
    ser.Str (string(ser#NL, "Erase complete", ser#NL))

PUB HexDump(buff_addr, base_addr, nr_bytes, columns, x, y) | digits, offset, col, hexcol, asccol, row, currbyte

    digits := 5
    hexcol := asccol := col := 0
    row := y
    repeat offset from 0 to nr_bytes-1
        currbyte := byte[buff_addr][offset]
        if col > (columns - 1)
            row++
            col := 0

        if col == 0
            ser.Position (x, row)
            ser.Hex (base_addr+offset, digits)
            ser.Str (string(": "))

        hexcol := x + (offset & (columns-1)) * 3 + (digits + 2)
        asccol := x + (offset & (columns-1)) + (columns * 3) + (digits + 3)

        ser.Position (hexcol, row)
        ser.Hex (currbyte, 2)

        ser.Position (asccol, row)
        case currbyte
            32..127:
                ser.Char (currbyte)
            OTHER:
                ser.Char (".")
        col++

PUB Setup

    repeat until _ser_cog := ser.Start (115_200)
    ser.Clear
    ser.Str(string("Serial terminal started", ser#NL))
    if ee.Startx (SCL_PIN, SDA_PIN, I2C_HZ)
        ser.Str(string("AT24Cxxxx driver started", ser#NL))
    else
        ser.Str(string("AT24Cxxxx driver failed to start - halting", ser#NL))
        ee.Stop
        time.MSleep (500)
        ser.Stop
        Flash (LED, 500)

PUB Flash(led_pin, delay_ms)

    dira[led_pin] := 1
    repeat
        !outa[led_pin]
        time.MSleep (delay_ms)

DAT
{
    --------------------------------------------------------------------------------------------------------
    TERMS OF USE: MIT License

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
    associated documentation files (the "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
    following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial
    portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
    LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    --------------------------------------------------------------------------------------------------------
}
