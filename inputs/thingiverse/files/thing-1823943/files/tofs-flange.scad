height=20;
inside_diameter=24.5;
thickness=2;
fillet=true;	// [true, false]
screwcount=4;
countersink=true;	// [true, false]

$fn=32;

difference(){
	intersection(){
		union(){
			//main cylinder
			cylinder(d=inside_diameter+2*thickness,h=height);
			//flange
			cylinder(r=inside_diameter/2+thickness+12,4.8);
			rotate_extrude(convexity=10)
			translate([inside_diameter/2+thickness+12, 0, 0])
			circle(r = 4.8);
			//fillet
			if(fillet){
				difference(){
					cylinder(r=inside_diameter/2+thickness+4,h=4.8+4);
					translate([0,0,4.8+4]) rotate_extrude(convexity = 10)
					translate([inside_diameter/2+thickness+4, 0, 0])
					circle(r = 4);
				}
			}
		}
		cylinder(r=inside_diameter+2*thickness+5,height);
	}
	//main cylinder hollow
	translate([0,0,-1]) cylinder(d=inside_diameter,h=height+2);
	//screw holes
	for (i = [0:screwcount]) {
		rotate([0,0,360/screwcount*i]) union(){
			translate([inside_diameter/2+thickness+8,0,0]) cylinder(d=3.5,h=10,center=true);
			if(countersink){
				translate([inside_diameter/2+thickness+8,0,1.8]) cylinder(d1=3.5,d2=8,h=4);
			}
		}
	}
}