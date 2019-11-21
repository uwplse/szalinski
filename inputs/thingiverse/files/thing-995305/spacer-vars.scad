

//Height of the spacer, default is flush with the mounting surface
spacer_height = 45; // [45:90]

//Radius of hole to fix screw length
screw_head_radius = 4; // [2:4.5]

//Radius of screw thread
screw_radius = 2; // [1:4.5]

//Length of thread to be inside spacer
screw_length = 10; // [3:45]
head_hole_height = spacer_height - screw_length;

difference() {
	difference() {
		difference() {
			difference() {
				difference() {
					cube(size = [90, 13, spacer_height]);
					translate(v = [0, 0, 3]) {
						cube(size = [90, 10, 2]);
					}
				}
				translate(v = [0, -1, 0]) {
					translate(v = [0, 0, 2]) {
						rotate(a = spacer_height, v = [1, 0, 0]) {
							cube(size = [90, 4, 4]);
						}
					}
				}
			}
			translate(v = [22.5000000000, 0, 0]) {
				translate(v = [0, 5, 0]) {
					union() {
						cylinder($fn = 32, h = head_hole_height, r = screw_head_radius);
						translate(v = [0, 0, head_hole_height]) {
							cylinder($fn = 32, h = screw_length, r = screw_radius);
						}
					}
				}
			}
		}
		translate(v = [67.5000000000, 0, 0]) {
			translate(v = [0, 5, 0]) {
				union() {
					cylinder($fn = 32, h = head_hole_height, r = screw_head_radius);
					translate(v = [0, 0, head_hole_height]) {
						cylinder($fn = 32, h = screw_length, r = screw_radius);
					}
				}
			}
		}
	}
	translate(v = [0, 0, 20]) {
		cube(size = [90, 4, 9]);
	}
}
/***********************************************
*********      SolidPython code:      **********
************************************************
 
''' Mounting spacers for lvpin LP-2020a+ stereo

Spacers which allow an lvpin LP-2020a+ stereo to be mounted under a bench,
table or cabinet. There is a slot to allow for wires to pass through to the
front (I am using them for the power and audio of my music source).

Customised parameters allow different sized screws to be used for mounting.

This work is licensed under a Creative Commons Attribution-ShareAlike 4.0
International License.
http://creativecommons.org/licenses/by-sa/4.0/
'''
import solid as s
import solid.utils as u

spacer_width = 13
spacer_depth = 90
screw_offset = 22.5
screw_offset_2 = spacer_depth - screw_offset

v = s.variables(
    s.var('spacer_height', 45,
          comment='Height of the spacer, default is flush with the '
                  'mounting surface',
          end_comment='[45:90]'),
    s.var('screw_head_radius', 4,
          comment='Radius of hole to fix screw length',
          end_comment='[2:4.5]'),
    s.var('screw_radius', 2,
          comment='Radius of screw thread',
          end_comment='[1:4.5]'),
    s.var('screw_length', 10,
          comment='Length of thread to be inside spacer',
          end_comment='[3:45]'),
    s.var('head_hole_height', 'spacer_height - screw_length'),
)

body = s.cube(size=[spacer_depth, spacer_width, v.spacer_height])

slot = u.up(3)(s.cube(size=[spacer_depth, 10, 2]))
slot_round = u.back(1)(u.up(2)(
    s.rotate(a=v.spacer_height, v=[1, 0, 0])(
        s.cube(size=[spacer_depth, 4, 4])
    )
))


def screw_hole():
    return u.forward(5)(
        s.cylinder(r=v.screw_head_radius, h=v.head_hole_height, segments=32) +
        u.up(v.head_hole_height)(
            s.cylinder(r=v.screw_radius, h=v.screw_length, segments=32)
        )
    )

screw_hole_1 = u.right(screw_offset)(screw_hole())
screw_hole_2 = u.right(screw_offset_2)(screw_hole())

wire_run = u.up(20)(s.cube(size=[spacer_depth, 4, 9]))

final = body - slot - slot_round - screw_hole_1 - screw_hole_2 - wire_run

s.scad_render_to_file(final, __file__.replace('.py', '.scad'), variables=v)
 
 
************************************************/
