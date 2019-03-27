; share/avr/crc/modbus-crc.S
;
; Реализует функцию вычисления CRC-16 массива на основе полинома 0xA001
; (MODBUS).  Если определён символ препроцессора MODBUS_CRC_BY_TABLE,
; то вычисление CRC производится табличным методом.
;


#include <avr/io.h>
#include "genmacro/genmacro.inc"
#include "crc.h"


	.text

.global	GetModbusCRC
.type	GetModbusCRC, @function


GetModbusCRC:
; unsigned char GetModbusCRC( unsigned short crc,
;	unsigned char *, unsigned char len )
; Вычисляет CRC-16 массива
; На входе:
;	регистры r25:r24: начальное значение CRC
;	регистры r23:r22: адрес начала массива
;	регистр r20: размер массива (0 соответствует 256-ти байтам)
; На выходе:
;	регистры r25:r24: конечное значение CRC
;

#if !defined( MODBUS_CRC_BY_TABLE )

	movw	Z, r22
	letw	r22, MODBUS_POLY
BytesLoop:
	ld	r21, Z+
	eor	r24, r21
	ldi	r21, 8
BitsLoop:
	lsr	r25
	ror	r24
	brcc	skip
	eor	r25, r23
	eor	r24, r22
skip:	dec	r21
	brne	BitsLoop
	dec	r20
	brne	BytesLoop
	ret

#else /* defined( MODBUS_CRC_BY_TABLE ) */

	movw	X, r22
BytesLoop:
	ld	ZL, X+
	eor	ZL, r24		; byte ^ old_lo
	ldi	ZH, High( modbus_crc_table )
	lpm	r24, Z		; table_lo[ byte ^ old_lo ]
	eor	r24, r25	; new_lo = table_lo[ byte ^ old_lo ] ^ old_hi
	inc	ZH
	lpm	r25, Z		; new_hi = table_hi[ byte ^ old_lo ]
	dec	r20
	brne	BytesLoop
	ret

#endif /* !defined( MODBUS_CRC_BY_TABLE ) */

.size	GetModbusCRC, . - GetModbusCRC


;
; wordset:avr-gcc
;
; End of file  modbus-crc.S
