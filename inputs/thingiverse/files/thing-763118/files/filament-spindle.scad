/* [filament spool dimensions] */

// filament spool minimum diameter
min_diameter=26;

// filament spool minimum diameter
max_diameter=70;

/* [spindle dimensions] */

// width of spindle
spindle_width=20;

// width of spindle collar
collar_width=5;

/* [Hidden] */

//rod_diameter=5/16*24.5;
rod_diameter=spindle_width-2;

$fn=50;
include <MCAD/bearing.scad>;

module base(){
	union(){
		difference(){
			union(){
				rotate([0,0,0])translate([max_diameter/2,0,0])cube([max_diameter/1.5,0.5*min_diameter,collar_width],center=true);
				rotate([0,0,120])translate([max_diameter/2,0,0])cube([max_diameter/1.5,0.5*min_diameter,collar_width],center=true);
				rotate([0,0,-120])translate([max_diameter/2,0,0])cube([max_diameter/1.5,0.5*min_diameter,collar_width],center=true);
			}
			difference(){
				cylinder(d=2*max_diameter,h=1.1*collar_width,center=true);
				cylinder(d=1.1*max_diameter,h=1.2*collar_width,center=true);
			}
		}
		cylinder(d=min_diameter,h=collar_width,center=true);
		difference(){
			cylinder(d=1.2*max_diameter,h=collar_width,center=true);
			cylinder(d=1*max_diameter,h=1.2*collar_width,center=true);
		}
	}
}

module core(){
		union(){
			cylinder(d=min_diameter,h=spindle_width,center=true);
			intersection(){
				cylinder(d1=max_diameter,d2=min_diameter,h=spindle_width,center=true);
				union(){
					rotate([0,0,0])translate([max_diameter/2,0,0])cube([max_diameter,0.5*min_diameter,spindle_width],center=true);
					rotate([0,0,120])translate([max_diameter/2,0,0])cube([max_diameter,0.5*min_diameter,spindle_width],center=true);
					rotate([0,0,-120])translate([max_diameter/2,0,0])cube([max_diameter,0.5*min_diameter,spindle_width],center=true);
				}
			}
		}
}

module spindle(){
	difference(){
		union(){
			translate([0,0,-(collar_width)/1.99])base();
			translate([0,0,(spindle_width)/2]){
				difference(){
					core();
					translate([0,0,-0.1*spindle_width])difference(){
						cylinder(d1=0.8*max_diameter,d2=0.8*min_diameter,h=0.8*spindle_width,center=true);
						cylinder(d=1.1*min_diameter,h=0.9*spindle_width,center=true);
					}
				}
			}
		}
		translate([0,0,(spindle_width-collar_width)/2])cylinder(d=0.9*bearingOuterDiameter(SkateBearing),h=1.2*(spindle_width+collar_width),center=true);
	}
}

difference(){
	spindle();
	scale([1.02,1.02,1])bearing(pos=[0,0,(spindle_width)/1.4], model=SkateBearing, outline=true);
	scale([1.02,1.02,1])bearing(pos=[0,0,-(collar_width)/0.8], model=SkateBearing, outline=true);
}

