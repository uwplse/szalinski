// created by: Michael McWethy 2019
// You can use this design anyway you want for personal use.  You need permission from me for commercial use.

// The following OpenScad program creates one stackable Painter's Triangle that elevates an object with as little 
// contact as possible.

base_r = 30;        // circle radius that touches base triagle points
triangle_h = 50;    // height of the painter's triangle
skin = 1.5;         // thickness of the painter's triangle walls
bluntness = 3;    // how much of the top to round off

hole_r = min(base_r,triangle_h)/4;  // calculate the size of the side holes
hole_h = base_r;    // length of hole cutter

side_angle = atan(triangle_h/(base_r/2)); // angle at middle of one side to top point
triangle_cutter_difference = skin/cos(side_angle);  // distance for cutter to get proper skin thickness

echo ("side_angle=",side_angle);
echo("triangle_cutter_difference=",triangle_cutter_difference);

// create main body with holes.
difference(){
    // move the main body for hole placement
    translate([0, 0, triangle_h/3/2]) {
        // create the main body with proper wall thickness
        difference(){
            // create a solid pyramid with a base brim
            union(){
                cylinder(triangle_h, base_r, 0, $fn=3, center=true);
                translate([0,0,-triangle_h/2]) cylinder(r=base_r+skin, h=skin, center=true, $fn=3);
            }
            // cut out the inside with a cutter with same shape, but translated by calculated
            // distance to ensure proper wall thickness
            translate([0,0,-triangle_cutter_difference])cylinder(triangle_h, base_r, 0, $fn=3, center=true);
            // blunt the top
            translate([0,0,(triangle_h/2)-3*bluntness]) difference(){
                cylinder(r=bluntness*2, h=3*bluntness, $fn=20);
                sphere(r=bluntness*2,$fn=30);
            }
        }        
    }
    // create three cylinder cutters, emanating from the origin point
    rotate([0,90,180])cylinder(r=hole_r, h=hole_h);
    rotate([0,90,-60])cylinder(r=hole_r, h=hole_h);
    rotate([0,90, 60])cylinder(r=hole_r, h=hole_h);
}
