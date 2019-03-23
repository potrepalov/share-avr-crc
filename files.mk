# share/avr/crc/files.mk
#

C_SRC    := byte-modbus-crc.c byte-crc8.c
AS_SRC   := modbus-crc.S crc8.S modbus-crc-table.S crc8-table.S

byte-modbus-crc.c := --std=gnu99
byte-crc8.c       := --std=gnu99

#
# End of file  files.mk
