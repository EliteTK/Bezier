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

#include <stdint.h>

#include "bezier.h"
#include "colour.h"

const double step = 0.01;

static struct point lerp_points(struct point points[2], double factor)
{
	struct point delta;

	delta.x = points[1].x - points[0].x;
	delta.y = points[1].y - points[0].y;

	delta.x *= factor;
	delta.y *= factor;

	return (struct point){.x = points[0].x + delta.x,
			      .y = points[0].y + delta.y};
}

static struct point bezier_point(struct point *points, int count, double factor)
{
	struct point retval = points[0];

	if (count < 2)
		return retval;

	if (count == 2)
		return lerp_points(points, factor);

	struct point newpoints[count - 1];

	for (int i = 0; i < count - 1; i++)
		newpoints[i] = lerp_points(points + i, factor);

	return bezier_point(newpoints, count - 1, factor);
}

void plot_bezier(struct point *points, int count, colour_t *buff,
		 uint32_t width, uint32_t height, colour_t colour)
{
	struct point last = points[0];

	for (double factor = 0; factor < 1; factor += step) {
		struct point next = bezier_point(points, count, factor);
		uint32_t x = next.x, y = next.y;

		if (x > width)
			x = width;

		if (y > height)
			y = height;

		buff[x + width * y] = colour;
	}
}
