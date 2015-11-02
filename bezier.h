/* Bezier calculation function
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

#ifndef BEZIER_H
#define BEZIER_H

#include "colour.h"
#include "stdint.h"

struct point {
	double x, y;
};

void plot_bezier(struct point *points, int count, colour_t *buff,
		 uint32_t width, uint32_t height, colour_t colour);

#endif /* BEZIER_H */
