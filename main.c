/* Main function
 *
 * Copyright (C) 2015  Tomasz Kramkowski <tk@the-tk.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include <stdint.h>
#include <stdio.h>

#include "bezier.h"
#include "colour.h"
#include "xsdl.h"

#define ARRSIZE(a) (sizeof (a) / sizeof *(a))

int main(void)
{
	const uint32_t width = 640, height = 480;
	struct point points[] = {{0, 0}, {width, 0}, {0, height}, {width, height}};

	xsdl_init(width, height, "Bezier");
	xsdl_clear(rgb(0, 0, 0));

	plot_bezier(points, ARRSIZE(points), xsdl_buffer,
		    width, height, rgb(0, 255, 0));

	xsdl_draw();

	while (!xsdl_window_closed)
		xsdl_poll_events();

	return 0;
}
