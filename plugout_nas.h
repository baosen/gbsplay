/*
 * gbsplay is a Gameboy sound player
 *
 * 2004 (C) by Christian Garbs <mitch@cgarbs.de>
 * Licensed under GNU GPL.
 *
 * header file for NAS sound output plugin
 */

#ifndef _PLUGOUT_NAS_H_
#define _PLUGOUT_NAS_H_

void    regparm nas_open (long endian, long rate);
ssize_t regparm nas_write(const void *buf, size_t count);
void    regparm nas_close();

#endif
