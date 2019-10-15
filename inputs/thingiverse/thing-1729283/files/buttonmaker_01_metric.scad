diameter=20.56; // [8:44]
thickness=3; // [2:5]
liptype=0; // [0:flat, 1:pipe]
lipsize=2; // [0:5]
holecount=4; // [2,4]
holespacing=6; // [3:8]
flatness=-1; // [-1:concave, 0:flat, 1:convex]

difference(){
	union(){
		cylinder(d=diameter,h=thickness,center=true,$fn=64);
		if(flatness==1){
		translate([0,0,thickness/2]) scale([1,1,1/diameter*thickness*2]) sphere(d=diameter-lipsize*2,$fn=64);
		}
	}
	for(i=[1:holecount]){
		rotate([0,0,360/holecount*i]) translate([holespacing/2,0,0]) cylinder(d=2,h=thickness+2*3,$fn=32,center=true);
	}
	if(flatness==-1){
	translate([0,0,thickness/2]) scale([1,1,1/diameter*thickness*2]) sphere(d=diameter-lipsize*2,$fn=64);
	}
}
if(lipsize && liptype==1){
			translate([0,0,thickness/2]) rotate_extrude(convexity = 10,$fn=64)
			translate([diameter/2-lipsize/2, 0, 0])
			circle(d = lipsize, $fn=64);
		}