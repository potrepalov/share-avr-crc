/* share/avr/crc/byte-modbus-crc.c */

/* Вычисление MODBUS-CRC для одного байта */


#if !defined( MODBUS_CRC_BY_TABLE )


#include <avr/io.h>
#include "crc.h"


unsigned short ByteModbusCRC( unsigned short crc, unsigned char b )
{
	crc ^= b;
	for ( unsigned char bits = 0; bits < 8; ++ bits )
	{
#if 0
		if ( crc & 1 )
		{
			crc >>= 1;
			crc ^= MODBUS_POLY;
		} else crc >>= 1;
#else
		asm volatile(
			"lsr	%B0"		"\n"
			"ror	%A0"		"\n"
			"brcc	1f"		"\n"
			"eor	%B0, %B2"	"\n"
			"eor	%A0, %A2"	"\n"
			"1:"			"\n"
			: /* outputs */ "=r" (crc)
			: /* inputs */  "0" (crc), "r" (MODBUS_POLY)
		);
#endif
	} // for
	return crc;
} // ByteModbusCRC


#endif /* !defined( MODBUS_CRC_BY_TABLE ) */


/* End of file  byte-modbus-crc.c */
