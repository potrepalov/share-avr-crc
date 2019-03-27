; share/avr/crc/modbus-crc-table.S
;
; Таблица для вычисления MODBUS CRC-16
;


#if defined( MODBUS_CRC_BY_TABLE )


#include "crc.h"
#include "crc.inc"


;	.section	".progmem.data"
; Секция .progmem.data в формируемый файл включается всегда,
; даже если на неё нет ссылок.  Поэтому таблицу размещаем в секции .text.

	.text


	.balign	256		; выравнивание на границу в 256 байтов
modbus_crc_table:	.global	modbus_crc_table
modbus_lo_crc_table:	.global modbus_lo_crc_table
	; формируем таблицу из 256-ти младших байтов MODBUS-CRC
	.set	bt, 0
	.rept	256		; формируем 256 байтов таблицы
	lo_crc_byte	bt, MODBUS_POLY
	.set	bt, bt+1
	.endr

modbus_hi_crc_table:	.global modbus_hi_crc_table
	; формируем таблицу из 256-ти старших байтов MODBUS-CRC
	.set	bt, 0
	.rept	256		; формируем 256 байтов таблицы
	hi_crc_byte	bt, MODBUS_POLY
	.set	bt, bt+1
	.endr

.size	modbus_crc_table, . - modbus_crc_table


#endif /* defined( MODBUS_CRC_BY_TABLE ) */


;
; wordset:avr-gcc
;
; End of file  modbus-crc-table.S
