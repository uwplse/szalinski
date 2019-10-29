// length of the tube
length = 9;
// diameter of the tube end
diameter = 2.2;
// Width of the gap for the elastic and the tube end
gapWidth = 0.2;
// thickness of the print
thickness = 0.4;

$fn = 50;
module TubeHolder(length, radius, thickness, gapWidth){
    

            difference(){
                cylinder(length,radius, radius);
                
                translate([0,0,thickness]){
                    cylinder(length, radius - thickness/2, radius - thickness/2);
                }
                translate([0,0,length - gapWidth/2 ]){
                    cube([2*radius, gapWidth, gapWidth], true);
                    cube([gapWidth, 2*radius, gapWidth], true);
                }
                cube([2*radius,gapWidth,thickness * 2], true);
            }
}

TubeHolder(length, diameter/2, thickness, gapWidth);