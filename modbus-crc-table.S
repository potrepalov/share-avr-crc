; share/avr/crc/modbus-crc-table.S
;
; ������� ��� ���������� MODBUS CRC-16
;


#if defined( MODBUS_CRC_BY_TABLE )


#include "crc.h"
#include "crc.inc"


;	.section	".progmem.data"
; ������ .progmem.data � ����������� ���� ���������� ������,
; ���� ���� �� �� ��� ������.  ������� ������� ��������� � ������ .text.

	.text


	.balign	256		; ������������ �� ������� � 256 ������
modbus_crc_table:	.global	modbus_crc_table
modbus_lo_crc_table:	.global modbus_lo_crc_table
	; ��������� ������� �� 256-�� ������� ������ MODBUS-CRC
	.set	bt, 0
	.rept	256		; ��������� 256 ������ �������
	lo_crc_byte	bt, MODBUS_POLY
	.set	bt, bt+1
	.endr

modbus_hi_crc_table:	.global modbus_hi_crc_table
	; ��������� ������� �� 256-�� ������� ������ MODBUS-CRC
	.set	bt, 0
	.rept	256		; ��������� 256 ������ �������
	hi_crc_byte	bt, MODBUS_POLY
	.set	bt, bt+1
	.endr

.size	modbus_crc_table, . - modbus_crc_table


#endif /* defined( MODBUS_CRC_BY_TABLE ) */


;
; wordset:avr-gcc
;
; End of file  modbus-crc-table.S