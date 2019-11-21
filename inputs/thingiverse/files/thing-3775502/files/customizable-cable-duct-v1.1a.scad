/*
 * Parametric cable duct with cover
 * ========================================
 *
 * Parametric cable duct creator with OpenSCAD
 * Copyright (C) 2019  Thomas Hessling <mail@dream-dimensions.de>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.*
 * Create your own custom cable duct with desired dimensions and matching top cover.
 *
 * https://www.dream-dimensions.de
 * https://www.thingiverse.com/thing:3775502
 *
 * Version: 1.1 (2019-08-03)
 *
 * ChangeLog:
 *  ## v1.1a (2019-09-21)
 *  ### Changes
 *  - Changed the license to GPLv3.
 *
 *  ## v1.1  (2019-08-03)
 *  ### Added
 *	- Add some custom text to your duct's cover
 *  - Option to create a cover with the same width as the duct, for narrow places
 *
 *  ## v1.0  (2019-07-28)
 *  - model creation works, first print successful.
 */
 
 
/*
 * Define the cable duct's final dimensions.
 * All values are millimetres. 
 */
 

/* [General settings] */
// Cable duct overall length
cd_length = 100;
// Cable duct width
cd_width = 15;
// Cable duct height
cd_height = 15;
// Number of fins
cd_fins = 8;
// Fin width
cd_fin_width = 3;
// Shell thickness (should be a multiple of your nozzle diameter)
cd_shell = 1.2;
// Force equal cover width - no overlap
cd_cover_equalwidth = 1; // [0:false, 1:true]

// Which part to create? Duct, cover or both.
part = "both"; // [duct:Cable duct,cover:Duct top cover,both:Both parts]


/* [Mounting feature settings] */
// Mounting feature height
mf_length = 2;
// Mounting feature angle 
mf_angle = 45;
// Mounting feature depth
mf_depth = 0.8;
// Mounting feature offset from top
mf_top_offset = 0.6;
// Tolerance between cover and duct
mf_top_tolerance = 0.15;

/* [Cover text] */
// Show the text?
text_enable = 1; // [0:false, 1:true]
// The text
text_string = "thing:3775502";
// Engraving depth, should be a multiple of layer height
text_depth = 0.6;
// Scaling relative to duct width
text_scale = 0.5;
// The font to use
text_font = "DejaVu Sans";


/* [Hidden] */
// the color
col = [0.3,0.5,0.85];
// safety offset for boolean operations, prevents spurious surfaces
s = 0.01;

cd_fin_spacing = (cd_length - cd_fin_width) / cd_fins;
cd_slit_width = cd_fin_spacing - cd_fin_width;


// Create the part
render()
print_part();

/*
	Create the part based on the part-variable: duct, cover or both
*/
module print_part()
{
	if (part == "duct") {
		create_duct();		
	} else if (part == "cover") {
		create_cover();		
	} else if (part == "both") {
		create_duct();
		create_cover();
	}
}


/*
 Create each children and a mirrored version of it along the given axis.
 */
module create_and_mirror(axis)
{
	for (i=[0:$children-1]) {
		children(i);
		mirror(axis) children(i);
	}	
}



/*
	Generates a trapezoidal profile that serves as a mounting feature for a	cover.
*/
module clip_profile(forCover)
{
	// Make the the angle is properly defined and does not lead to geometry errors
	assert(mf_angle > 0, "The angle must be greater than 0 deg.");
	assert(mf_angle <= 90, "The angle cannot be greater than 90 deg.");
	assert(mf_depth*tan(90-mf_angle)*2 <= mf_length, 
		   "The mounting feature length is too small. Increase length or the angle.");
	
	polyp = [[0,0], 
			 [0,-mf_length], 
			 [mf_depth,-mf_length+mf_depth*tan(90-mf_angle)], 
			 [mf_depth,-mf_depth*tan(90-mf_angle)]];
	polygon(polyp);
}


/*
	Cut profile for the interior of the rectangle, taking into account the mounting feature.
*/
module inner_duct_profile()
{
	cd_hwidth = cd_width/2;
    depth_factor = cd_cover_equalwidth ? 2 : 1;

    polygon([[cd_hwidth-depth_factor*mf_depth-cd_shell, cd_height+s],
     [cd_hwidth-depth_factor*mf_depth-cd_shell, cd_height-mf_length-mf_top_offset],
     [cd_hwidth-cd_shell, cd_height-mf_length-mf_top_offset-depth_factor*mf_depth*tan(45)],
     [cd_hwidth-cd_shell, cd_shell],
     [0, cd_shell],
     [0, cd_height+s]]);
}

/*
	The duct's cross-sectional profile, used in an extrusion.
*/
module create_duct_profile()
{
	/*
		Basic shape: rectangle
		Subtract the mounting features from it, and also the interior bulk.
		This then serves as an extrusion profile.	
	*/
	difference() {
		difference() {
			difference() {
				scale([cd_width, cd_height])
				translate([-0.5, 0])
				square(1, center=false);
				
				if (cd_cover_equalwidth)
				{
					union() {
						create_and_mirror([1, 0]) {
							translate([-cd_width/2-s+cd_shell+mf_top_tolerance, cd_height-mf_top_offset])
							clip_profile();
							translate([-cd_width/2, cd_height-mf_top_offset])
							polygon([[0,mf_top_offset],
									 [cd_shell+mf_top_tolerance, mf_top_offset],
									 [cd_shell+mf_top_tolerance, -mf_length],
									 [cd_shell+mf_top_tolerance*(1-cos(mf_angle)), -mf_length-mf_top_tolerance*cos(mf_angle)],
									 [0, -mf_length-mf_top_tolerance*cos(mf_angle)]]);
						}
					}
					
				} else {
					union() {
						create_and_mirror([1,0]) {
							translate([-cd_width/2-s, cd_height-mf_top_offset])
							clip_profile();
						}
					}
				}
			}
		}
		union() {
			create_and_mirror([1,0]) {
            inner_duct_profile();
			}
		}
	}
}

/*
	Create the cover profile to be extruded.
*/
module create_cover_profile()
{
	union() {
        xoffset = cd_cover_equalwidth ? cd_shell+mf_top_tolerance : 0;
        
		create_and_mirror([1,0]) {
			translate([cd_width/2+mf_top_tolerance-xoffset, cd_height-mf_top_offset, 0])
			mirror([1, 0])
			clip_profile(1);
		}
		
		polygon([[cd_width/2+mf_top_tolerance-xoffset, cd_height-mf_top_offset-mf_length],
				 [cd_width/2+mf_top_tolerance-xoffset, cd_height+mf_top_tolerance],
				 [-cd_width/2-mf_top_tolerance+xoffset, cd_height+mf_top_tolerance],
				 [-cd_width/2-mf_top_tolerance+xoffset, cd_height-mf_top_offset-mf_length],
				 [-cd_width/2-mf_top_tolerance-cd_shell+xoffset, cd_height-mf_top_offset-mf_length],
				 [-cd_width/2-mf_top_tolerance-cd_shell+xoffset, cd_height+mf_top_tolerance+cd_shell],
				 [cd_width/2+mf_top_tolerance+cd_shell-xoffset, cd_height+mf_top_tolerance+cd_shell],
				 [cd_width/2+mf_top_tolerance+cd_shell-xoffset, cd_height-mf_top_offset-mf_length],
				]);
	}
}

/*
	Extrude the duct's cross-section profile, cut boxes in regular distance to create the
	"fins" and cut holes in the bottom to save material.
*/
module create_duct()
{
	color(col)
	rotate(90, [1, 0, 0])
	difference() {
		linear_extrude(height=cd_length, center=false)
		create_duct_profile();
        
		union() {
			for (i = [0:cd_fins-1]) {
				translate([-cd_width/2-1, 3*cd_shell, i*cd_fin_spacing+cd_fin_width])
				cube([cd_width+2, cd_height+1, cd_fin_spacing-cd_fin_width]);
			}
		}
	}
	
}


/*
	Create a cover for the duct.
*/
module create_cover() 
{
	color(col)
    difference() {
        translate([2*cd_width, 0, cd_height+mf_top_tolerance+cd_shell])
        rotate(180, [0, 1, 0])
        rotate(90, [1, 0, 0])
        linear_extrude(height=cd_length, center=false)
        create_cover_profile();

        if (text_enable) {
            translate([2*cd_width, -cd_length/2, -s+0.6])
            rotate(90, [0, 0, -1])
            rotate(180, [1, 0, 0])
            linear_extrude(height=text_depth, center=false)
            text(text_string, cd_width*text_scale, text_font, valign="center", halign="center", $fn=32);
        }
    }
}
