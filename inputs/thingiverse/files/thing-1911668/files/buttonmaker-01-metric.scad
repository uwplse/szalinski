/*

Parametric Button Generator - Metric Edition
Modified by: Craig Wood
Last Modified: Nov. 22, 2016

Modified From:
http://www.thingiverse.com/thing:1729283
*/

diameter=30; // [8:44]
thickness=5; // [3:7]
liptype=1; // [0:flat, 1:pipe]
lipsize=3; // [0:5]
holecount=4; // [2,4]
holespacing=8; // [3:8]
centerdiameter=17; //[8:44]
centerdesign=-1; // [-1:concave, 0:flat, 1:convex]
x_flatten = .7; // [.1,.2,.3,.5,.7,.9,1,1.2,1.5,2]
y_flatten = 1; // [.1,.2,.3,.5,.7,.9,1,1.2,1.5,2]
z_flatten = .4; // [.1,.2,.3,.5,.7,.9,1,1.2,1.5,2]
bottom_chamfer=1; //[0:off, 1:on]
 
 difference () {
scale([x_flatten,y_flatten,z_flatten])
translate([0,0,(thickness/2)]) 
union() {
difference(){
	union(){
        
            if(lipsize && liptype == 1 && bottom_chamfer) {
                translate([0,0,-(lipsize-2)/2]) 
                cylinder(d=diameter-lipsize,h=thickness,center=true,$fn=64);

                translate([0,0,.5])
                cylinder(d=diameter,h=thickness-.5,center=true,$fn=64);
                
                translate([0,0,-(thickness-2)/2])
                rotate_extrude(convexity = 10,$fn=64)
                translate([diameter/2-lipsize/2, 0, 0]) 
                circle(d = lipsize, $fn=64);
            } else {
                cylinder(d=diameter,h=thickness,center=true,$fn=64);
            }
            
        if(centerdesign==1){
            translate([0,0,thickness/2]) 
            scale([1,1,1/centerdiameter*thickness*2]) 
            sphere(d=centerdiameter,$fn=64);
		}
        
	}
	if(centerdesign==-1 && centerdiameter<=diameter) {
        translate([0,0,thickness/2]) 
        scale([1,1,1/centerdiameter*thickness*2]) 
        sphere(d=centerdiameter,$fn=64);
	}
}
if(lipsize && liptype==1){
			translate([0,0,thickness/2]) 
            rotate_extrude(convexity = 10,$fn=64)
			translate([diameter/2-lipsize/2, 0, 0]) 
            circle(d = lipsize, $fn=64);
		}
    }
    
    
	for(i=[1:holecount]){
		rotate([0,0,360/holecount*i]) 
        translate([holespacing/2,0,0]) 
        cylinder(d=2,h=thickness+2*8,$fn=32,center=true);
	}
}