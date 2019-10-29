/*
    Author: Daniel Devine
    Date: 19/02/17
    Description: Snorkel clip for snorkels with a round tube. Requires cutting out two small support pillars in order to be able to get the straps into the strap clip. Existing models on Thingiverse were too weak and/or required too much support material to print.
    CC-BY-SA License - https://creativecommons.org/licenses/by-sa/2.5/
*/

snorkel_diameter = 26.5; // 27mm diameter, but we want it to clip tight.
snorkel_clip_height = 18; // Height of the clip that attaches to the snorkel tube.
strap_height = 18; // Height of the snorkel holder.
strap_clip_offset = 3; // Distance (effective thickness) of the top part of the clip. Don't be too thin!
strap_allowance = 7; // Give room for the straps to run through nicely.
holder_wall_thickness = 3.4; // Thicker = less flex, more friction.
strap_clip_width = 17;
strap_entrance_scale = 0.38; // How narrow the slot that the strap will need to squeeze through is in relation to strap_allowance. Should be a bit less than half.

clip();

module clip(){
    _uncenter = snorkel_clip_height/2;

    difference(){
        union(){
            difference(){
                union(){
                    translate([0, 0, _uncenter])
                        cylinder(snorkel_clip_height, d=(snorkel_diameter + holder_wall_thickness), center=true, $fn=50); // Snorkel clip
                    intersection(){
                        translate([(snorkel_diameter/2)+holder_wall_thickness, 0, _uncenter + strap_clip_offset])
                            cube(size=[14+(holder_wall_thickness*1.5),strap_clip_width,strap_height+(strap_clip_offset*2)], center=true); // strap clip
                    translate([(snorkel_diameter/2)+holder_wall_thickness, 0, _uncenter+ strap_clip_offset])
                        cylinder(h=strap_height+(strap_clip_offset*2), d=strap_clip_width*1.3, center=true, $fn=50); // clip reinforcing
                    } 
                }
     
                translate([0, 0, _uncenter])
                    cylinder(h=snorkel_clip_height*4, d=snorkel_diameter, center=true, $fn=50); // snorkel hole
                translate([0-((snorkel_diameter/2)+holder_wall_thickness)+0.5, 0, _uncenter])
                    cube(size=[holder_wall_thickness*2,2, snorkel_clip_height+1], center=true); // Snorkel clip expansion gap
            }
        }

        translate([0, 0, _uncenter])
        union(){
            translate([(snorkel_diameter/2) - 2, 0 , (snorkel_clip_height/2)+(strap_clip_offset/2)])
                // purposefully strap_clip_width -2 so that two little pillars form as support. Factor of 0.38 on the strap entrance hole - possibly too tight?
                cube([strap_allowance+5, strap_clip_width-1.4, (strap_allowance*strap_entrance_scale)], center=true);// strap-hole entrance
            translate([(snorkel_diameter/2)+holder_wall_thickness+1.75, 0, strap_clip_offset * 1.25 ])
                cube([strap_allowance, strap_clip_width+4, strap_height], center=true);// strap hole
        }
    }
}