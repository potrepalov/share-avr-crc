; share/avr/crc/crc8.S
;
; ��������� ������� ���������� CRC-8 ������� �� ������ �������� 0xAB.
; ���� �������� ������ ������������� CRC8_BY_TABLE, �� ���������� CRC
; ������������ ��������� �������.
;


#include <avr/io.h>
#include "genmacro/genmacro.inc"
#include "crc.h"


	.text

.global	GetCRC8
.type	GetCRC8, @function


GetCRC8:
; unsigned char GetCRC8( unsigned char crc, unsigned char *, unsigned char len )
; ��������� CRC-8 ������� �� ������ �������� 0xAB
; �� �����:
;	������� r24: ��������� �������� CRC
;	�������� r23:r22: ����� ������ �������
;	������� r20: ������ ������� (0 ������������� 256-�� ������)
; �� ������:
;	������� r24: �������� �������� CRC
;

#if !defined( CRC8_BY_TABLE )

	movw	Z, r22
	ldi	r22, CRC8_POLY
BytesLoop:
	ld	r21, Z+
	eor	r24, r21
	ldi	r21, 8
BitsLoop:
	lsr	r24
	brcc	skip
	eor	r24, r22
skip:	dec	r21
	brne	BitsLoop
	dec	r20
	brne	BytesLoop
	ret

#else /* defined( CRC8_BY_TABLE ) */

	movw	X, r22
	ldi	ZH, High( crc8_table )
BytesLoop:
	ld	ZL, X+
	eor	ZL, r24
	lpm	r24, Z
	dec	r20
	brne	BytesLoop
	ret

#endif /* !defined( CRC8_BY_TABLE ) */

.size	GetCRC8, . - GetCRC8


;
; wordset:avr-gcc
;
; End of file  crc8.S