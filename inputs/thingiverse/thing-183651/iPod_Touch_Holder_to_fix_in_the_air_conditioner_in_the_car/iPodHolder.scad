// variable description
thickness = 7; //[6:12]
height = 114; //[110:150]
angle = 35; //[20:60]


module case(){
	difference(){
		difference(){
			difference(){
				difference(){
					translate([4,0,0])cube([height,64,thickness+4],center=true);
					cube([height+6,60,thickness],center=true);
				}
				translate([-4,0,-5])cube([height+6,56,thickness+2],center=true);
			}	
			translate([height/2,0,0])cube([10,25,4],center=true);
		}
		translate([height/2,-22,0])rotate(a=[0,90,0])cylinder(h=8,r=4);
	}
}

module anchor(){
	union(){
		translate([-15,0,(thickness/2)+2.2])cube([30,10,2],center=true);
		translate([-25,0,(thickness/2)+4.2])rotate(a=[0,-25,0])cube([10,10,2],center=true);
	}
}

union(){
	case();
	translate([0,10,0])rotate([0,angle,0])anchor();
	translate([0,-10,0])rotate([0,angle,0])anchor();
}

