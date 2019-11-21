/* [Parameters] */
// Ingress Agent Level
ingress_level = 16; // [1:16]

// Ingress Game Name
in_game_name = "YOURNAME";

/* [Hidden] */
_ASCII_SPACE 	= 32;
_ASCII_0 		= 48;
_ASCII_9 		= _ASCII_0 + 9;
_ASCII_UPPER_A 	= 65;
_ASCII_UPPER_Z 	= _ASCII_UPPER_A + 25;
_ASCII_LOWER_A 	= 97;
_ASCII_LOWER_Z 	= _ASCII_LOWER_A + 25;
_ASCII = "\t\n\r !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
_ASCII_HACK = "\""; // only here to work around syntax highlighter defficiencies in certain text editors
_WHITESPACE = " \t\r\n";
_ASCII_CODE = concat(9,10,13, [for(i=[_ASCII_SPACE : _ASCII_LOWER_Z+4]) i]);

radius = 19;

ingress_ign = upper(in_game_name);

// Generate the outer ring of blocks
for (a =[0:min(7, ingress_level - 1)])
{
    rotate([0, 0, a * -45])
    {
        translate([0, 11.7, 3.0])
        {
            cube([8.5, 1.5, 2.0], true);
        }
    }
}

// Generate the inner ring of double blocks for ingress_level 9 and above
if (ingress_level > 8)
{
    for (a =[0:(ingress_level - 9)])
    {
        rotate([0, 0, a * -45])
        {
            translate([0, 9.0, 3.0])
            {
                translate([-1.75, 0.5, 0.0])
                {
                    cube([3.0, 1.0, 2.0], true);
                }
                cube([6.5, 0.5, 2.0], true);
            }
        }
    }
}

// Add the level as text in the centre
translate([0, 0, 2.0])
{
    linear_extrude(2.0)
    {
        text(str(ingress_level), font = "Liberation Sans:style=Bold", valign="center", halign="center");
    }
}

difference()
{
    union()
    {
        translate([0, -radius, 0])
        {
            revolve_text(radius, ingress_ign);
        }

        difference()
        {
            // Octagonal block
            linear_extrude(4.0)
            {
                rotate([0, 0, 22.5])
                {
                    regular_polygon(8, 16.0);
                }
            }

            // Octagonal cut out to contain detail
            translate([0, 0, 2.0])
            {
                linear_extrude(2.01)
                {
                    rotate([0, 0, 22.5])
                    {
                        regular_polygon(8, 14.5);
                    }
                }
            }
        }
    }
    // Cut out for badge pin
    translate([-2.6, -12.5, -0.05])
    {
        cube([5.2, 25, 1.2]);
    }
}

// From https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_the_2D_Subsystem#regular_polygon
module regular_polygon(order, r=1){
    angles=[ for (i = [0:order-1]) i*(360/order) ];
    coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
    polygon(coords);
}

module revolve_text(radius, chars)
{
    chars_len = len(chars);
    font_size = min(radius / 4, 90 / chars_len);
    // step_angle = 360 / chars_len;
    step_angle = min(12, 180 / chars_len);
    offset = step_angle * (chars_len - 1) / 2;
    
    translate([0, radius, 2.0])
    {
        linear_extrude(2.0)
        {
            for(i = [0 : chars_len - 1])
            {
                rotate((i * step_angle) - offset)
                {
                    translate([0, -(radius), 0])
                    {
                        text(
                            chars[i], 
                            font = "Liberation Mono:style=Bold", 
                            size = font_size, 
                            valign = "center", halign = "center"
                            );
                    }
                }
            }
        }
    }
    backing = step_angle * (chars_len + 1);
    translate([0, radius, 0])
    {
        pie(radius + font_size / 2 + 1, backing, 2.0, -(90 + backing / 2));
    }
}

// PieTest

/**
* @author: Marcel Jira

 * This module generates a pie slice in OpenSCAD. It is inspired by the
 * [dotscad](https://github.com/dotscad/dotscad)
 * project but uses a different approach.
 * I cannot say if this approach is worse or better.

 * @param float radius Radius of the pie
 * @param float angle  Angle (size) of the pie to slice
 * @param float height Height (thickness) of the pie
 * @param float spin   Angle to spin the slice on the Z axis
 */
module pie(radius, angle, height, spin=0) {
	// calculations
	ang = angle % 360;
	absAng = abs(ang);
	halfAng = absAng % 180;
	negAng = min(ang, 0);

	// submodules
	module pieCube() {
		translate([-radius - 1, 0, -1]) {
			cube([2*(radius + 1), radius + 1, height + 2]);
		}
	}

	module rotPieCube() {
		rotate([0, 0, halfAng]) {
			pieCube();
		}
	}

	if (angle != 0) {
		if (ang == 0) {
			cylinder(r=radius, h=height);
		} else {
			rotate([0, 0, spin + negAng]) {
				intersection() {
					cylinder(r=radius, h=height);
					if (absAng < 180) {
						difference() {
							pieCube();
							rotPieCube();
						}
					} else {
						union() {
							pieCube();
							rotPieCube();
						}
					}
				}
			}
		}
	}
}

function upper(string) = 
	let(code = ascii_code(string))
	join([for (i = [0:len(string)-1])
			code[i] >= 97 && code[i] <= 122?
                chr(code[i]-97+65)
            :
                string[i]
		]);
                
function join(strings, delimeter="") = 
	strings == undef?
		undef
	: strings == []?
		""
	: _join(strings, len(strings)-1, delimeter, 0);
function _join(strings, index, delimeter) = 
	index==0 ? 
		strings[index] 
	: str(_join(strings, index-1, delimeter), delimeter, strings[index]) ;
	
function ascii_code(string) = 
	!is_string(string)?
		undef
    :
        [for (result = search(string, _ASCII, 0)) 
            result == undef?
                undef
            :
                _ASCII_CODE[result[0]]
        ]
	;

function is_string(x) = 
	x == str(x);
