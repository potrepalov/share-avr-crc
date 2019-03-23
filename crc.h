/* share/avr/crc/crc.h */


#define MODBUS_POLY	0xA001
#define CRC8_POLY	0xAB


#if !defined( __ASSEMBLER__ )


#include <avr/pgmspace.h>


// вычисляет CRC-8 массива байтов
unsigned char GetCRC8(
	unsigned char crc,
	unsigned char * buf,
	unsigned char len );


// вычисляет MODBUS-CRC массива байтов
unsigned short GetModbusCRC(
	unsigned short crc,
	unsigned char * buf,
	unsigned char len );



#if defined( CRC8_BY_TABLE )

extern unsigned char const PROGMEM crc8_table[256];

// вычисляет CRC-8 одного байта
#define ByteCRC8( crc, b )  pgm_read_byte( crc8_table + (0xFF & ((b) ^ (crc))) )


#else /* !defined( CRC8_BY_TABLE ) */

// вычисляет CRC-8 одного байта
unsigned char ByteCRC8( unsigned char crc, unsigned char byte );

#endif /* defined( CRC8_BY_TABLE ) */



#if defined( MODBUS_CRC_BY_TABLE )

extern unsigned char const PROGMEM modbus_lo_crc_table[256];
extern unsigned char const PROGMEM modbus_hi_crc_table[256];

// вычисляет MODBUS-CRC одного байта
#if 1
#define ByteModbusCRC( crc, b )		({			\
	unsigned short r_crc = (crc) ^ ((b) & 0xFF);		\
	asm volatile(						\
		"mov	__tmp_reg__, ZH"		"\n"	\
		"ldi	ZH, hi8( modbus_lo_crc_table )"	"\n"	\
		"lpm	ZH, Z"				"\n"	\
		"eor	__tmp_reg__, ZH"		"\n"	\
		"ldi	ZH, hi8( modbus_hi_crc_table )"	"\n"	\
		"lpm	ZH, Z"				"\n"	\
		"mov	ZL, __tmp_reg__"		"\n"	\
		: /* outputs */ "=z" (r_crc)			\
		: /* inputs */  "0" (r_crc)			\
	);   r_crc; })
#else
#define ByteModbusCRC( crc, b )		({				\
	const unsigned short old_crc = (crc);				\
	const unsigned char idx = ((b) ^ old_crc) & 0xFF;		\
	unsigned short new_crc;						\
	new_crc = pgm_read_byte(modbus_hi_crc_table + idx);		\
	new_crc = (new_crc << 8) 					\
		+ (	((unsigned char)(old_crc >> 8))			\
			^ pgm_read_byte(modbus_lo_crc_table + idx)	\
		); new_crc; })
#endif

#else /* !defined( MODBUS_CRC_BY_TABLE ) */

// вычисляет MODBUS-CRC одного байта
unsigned short ByteModbusCRC( unsigned short crc, unsigned char b );

#endif /* defined( MODBUS_CRC_BY_TABLE ) */


#endif /* !defined( __ASSEMBLER__ ) */


/* End of file  crc.h */
