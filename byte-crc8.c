/* share/avr/crc/byte-crc8.c */

/* Вычисление CRC-8 для одного байта */


#if !defined( CRC8_BY_TABLE )


#include <avr/io.h>
#include "crc.h"


unsigned char ByteCRC8( unsigned char crc, unsigned char b )
{
	crc ^= b;
	for ( unsigned char bits = 0; bits < 8; ++ bits )
	{
#if 0
		if ( crc & 1 )
		{
			crc >>= 1;
			crc ^= CRC8_POLY;
		} else crc >>= 1;
#else
		asm volatile(
			"lsr	%0"		"\n"
			"brcc	1f"		"\n"
			"eor	%0, %2"		"\n"
			"1:"			"\n"
			: /* outputs */ "=r" (crc)
			: /* inputs */  "0" (crc), "r" (CRC8_POLY)
		);
#endif
	} // for
	return crc;
} // ByteCRC8


#endif /* !defined( CRC8_BY_TABLE ) */


/* End of file  byte-crc8.c */
