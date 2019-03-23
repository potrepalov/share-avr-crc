; share/avr/crc/crc8-table.S
;
; Таблица для вычисления CRC-8
;


#if defined( CRC8_BY_TABLE )


#include "crc.h"
#include "crc.inc"


;	.section	".progmem.data"
; Секция .progmem.data в формируемый файл включается всегда,
; даже если на неё нет ссылок.  Поэтому таблицу размещаем в секции .text.

	.text


	.balign	256		; выравнивание на границу в 256 байтов
crc8_table:	.global	crc8_table
	.set	bt, 0
	.rept	256		; формируем 256 байтов таблицы
	lo_crc_byte	bt, CRC8_POLY
	.set	bt, bt+1
	.endr

.size	crc8_table, . - crc8_table


#endif /* defined( CRC8_BY_TABLE ) */


;
; wordset:avr-gcc
;
; End of file  crc8-table.S
