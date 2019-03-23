; share/avr/crc/crc.inc
;
; ������� ������������ ������� ����� CRC
;



.macro	lo_crc_byte	b, poly
	; ��������� ���� ���� �������
	; (�������� � ������� ������� ���� ���������� ���������� CRC ����� b)
	.set	crc, \b

	.rept	8
	.if crc & 1
	.set	crc, ((crc >> 1) ^ \poly)
	.else ; \crc & 1
	.set	crc, (crc >> 1)
	.endif ; \crc & 1
	.endr

	.byte	crc & 0xFF
.endm


.macro	hi_crc_byte	b, poly
	; ��������� ���� ���� �������
	; (�������� � ������� ������� ���� ���������� ���������� CRC ����� b)
	.set	crc, \b

	.rept	8
	.if crc & 1
	.set	crc, ((crc >> 1) ^ \poly)
	.else ; \crc & 1
	.set	crc, (crc >> 1)
	.endif ; \crc & 1
	.endr

	.byte	(crc >> 8) & 0xFF
.endm


;
; wordset:avr-gcc
;
; End of file  crc.inc