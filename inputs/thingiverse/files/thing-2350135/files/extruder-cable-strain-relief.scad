// Extruder cable strain relief
// based on mount for proximity sensor of Ewald Beekman

// Height of the horizontal base
base_height = 17;
// Length of vertical plate before it connects to the holder cylinder. Negative value to position holder higher, Positive value position holder lower and 0 to make it level with the base.
vert_base_length = -5;
// Height of main cylinder that hold your cable. Same as the base height should be enough
holder_height = base_height;
// Thickness of the base plate. Adjust to your bolt length or just print a new bolt.
thickness = 3;  
// Thickness of the holder cylinder
thickness_c = 2;

// Screws for attachment to the extruder
// Distant between two screw
screws_spacing = 30.6;
// Diameter of the screw bolt, remember to add 0.2-0.3 to account for tolerance
screws_diameter = 4;

// Main cable holder
// Diameter of your cable bundle or wire wrap
cable_diameter = 12;
// Set ot the distance of the cable bundle to the last (rightmost) screwhole
holder_spacing = 6;
// Distant of cable holder from base plate, just to make sure there is enought room for the zip tie hole
holder_dist_base = 4;

// Sometime there is a scew in the middle we don't want to use. This hole is for side stepping that.
scew_hole = 10;
// Distance of the scew hole to the first (left) scew hole
scew_hole_dist = 11.8;

// Zip ties width. Standard zip ties width seem to be 2.5, 3.6 and 4.8
zip_width = 3.6;

$fn=50;

{
    base_start = thickness_c+holder_spacing+screws_spacing+screws_diameter+thickness;
    base_width = cable_diameter+2*thickness_c; // width of the vertical part to which the cylinder connects

    translate([0,-base_start,-base_height/2])
    union(){            // this is to combine base and holder
        // base
        difference(){
            union() {
                // horizontal base
                color("green")
                    cube([thickness, base_start+thickness+cable_diameter/2, base_height]);
                // vertical plate, to connect to the holder
                vert_base_length_tmp = vert_base_length >= 0 ? vert_base_length : 0;
                color("blue")
                    translate([0, base_start, -vert_base_length_tmp-holder_height+base_height])
                    cube([thickness, base_width, abs(vert_base_length)+holder_height]);
            }
            
            //Screw 1
            translate([-0.5, thickness_c+thickness_c/2+thickness, base_height/2])
                rotate([0,90,0])
                cylinder(d=screws_diameter, h=thickness + 1);
            //Screw 2
            translate([-0.5, thickness_c+thickness_c/2+thickness+screws_spacing, base_height/2])
                rotate([0,90,0])
                cylinder(d=screws_diameter, h=thickness + 1);
            // this is the hole of the screw I don't want to use
            color("blue")
                translate([-1, thickness_c + thickness_c/2 + thickness + scew_hole_dist, (base_height/2)])
                rotate([0,90,0])
                cylinder(d=scew_hole, h=thickness*2);
        }

        // holder
        translate([0, 0, -vert_base_length]) 
        union() {
            //Sensor cylinder
            $fn=100;
            difference() {
                union() {
                    translate([cable_diameter/2+2*thickness_c+holder_dist_base,base_start+thickness_c+cable_diameter/2, base_height-holder_height])
                        cylinder(d=cable_diameter+2*thickness_c, h=holder_height);

                    // this cube is for adhesion of the cylinder to the plate
                    color("red")
                        translate([thickness, base_start, base_height-holder_height])
                        cube([cable_diameter/2+2*thickness_c-thickness+holder_dist_base, cable_diameter+2*thickness_c, holder_height]);
                }
                

                // this is to form the hole for the sensor to go through
                translate([cable_diameter/2+2*thickness_c+holder_dist_base,base_start+thickness_c+cable_diameter/2, base_height-holder_height])
                    cylinder(d=cable_diameter, h=holder_height);
                
                // this is to cut the holder in half
                color("gray")
                    translate([cable_diameter/2 + 2*thickness_c + holder_dist_base, base_start, 0])
                    cube([cable_diameter + thickness_c, cable_diameter + thickness_c*2, holder_height]);
            } // diff
            
            // zip tie holder
            ext_height = (holder_height*1.5) / 2;
            color("orange")
                translate([0, base_start, base_height-ext_height*2])
                cube([thickness, cable_diameter+2*thickness_c, holder_height * 2]);
            difference() {
                zip_tie_base_width = cable_diameter/2+2*thickness_c-cable_diameter/2+holder_dist_base;
                color("purple")
                    translate([zip_tie_base_width, base_start + base_width/2 - thickness/2, base_height-ext_height*2])
                    rotate([0,0,90])
                    cube([thickness, zip_tie_base_width, holder_height * 2]);
                // holes for the zip ties
                // zip hole 1
                color("black")
                    translate([zip_tie_base_width - thickness_c,
                        base_start + base_width/2 - thickness/2,
                        base_height + ext_height/2 - zip_width])
                    rotate([0,0,90])
                    cube([thickness, zip_width/2, zip_width]);
                // zip hole 2
                color("black")
                    translate([zip_tie_base_width - thickness_c,
                        base_start + base_width/2 - thickness/2,
                        0 - ext_height/2])
                    rotate([0,0,90])
                    cube([thickness, zip_width/2, zip_width]);
            }
            difference() {
                // outer shell
                color("white")
                    translate([cable_diameter/2+2*thickness_c+holder_dist_base,
                        base_start+thickness_c+cable_diameter/2,
                        base_height-holder_height*1.5])
                    cylinder(d=cable_diameter+2*thickness_c, h=holder_height * 2);
                // inner cut out
                color("green")
                    translate([cable_diameter/2+2*thickness_c+holder_dist_base,
                        base_start+thickness_c+cable_diameter/2,
                        base_height-holder_height*1.5])
                    cylinder(d=cable_diameter, h=holder_height*2);
                // this is to cut the holder in half
                color("pink")
                    translate([cable_diameter/2 + 2*thickness_c + holder_dist_base,
                        base_start,
                        -holder_height/2])
                    cube([cable_diameter + thickness_c, cable_diameter + thickness_c*2, holder_height*2]);
                color("pink")
                    translate([cable_diameter/2 + 2*thickness_c + holder_dist_base,
                        base_start-cable_diameter,
                        -holder_height/2])
                    rotate([0,0,45])
                    cube([cable_diameter + thickness_c, cable_diameter + thickness_c, holder_height*2]);
                color("pink")
                    translate([cable_diameter/2 + 2*thickness_c + holder_dist_base,
                        base_start+cable_diameter-thickness,
                        -holder_height/2])
                    rotate([0,0,45])
                    cube([cable_diameter + thickness_c, cable_diameter + thickness_c, holder_height*2]);
            }
        }
    } // union
}