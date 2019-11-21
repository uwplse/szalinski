$fn=80;
sphereRadius=35;
thickness=1;
switchbaseheight=3.61;
switchtotalheight=9.5;
switchbuttondiameter=3.51;
switchtravel=.012 * 25.4;
switchlenwid=5.99;
meltage=.25;
ridge=6;
chamfer_radius =.75;
domeText="STOP";
microSwitch=true;
microSwitchHeight = 10;
microSwitchWidth = 5.8;
microSwitchLength = 12.8;
domeLength = len(domeText);

outerdiam = (sphereRadius + ridge  + meltage)*2;
innerdiam = (sphereRadius + ridge - meltage)*2-thickness;

module base() {
	union() {
		 difference() {
			translate([0,0,thickness]) cylinder(d=outerdiam,h=switchtotalheight+thickness);
			translate([0,0,thickness]) cylinder(d=innerdiam,h=switchtotalheight+thickness);
			rotate([0,0,90])translate([innerdiam/2-thickness,0,switchtotalheight]) rotate([0,90,0]) cylinder(d=thickness*2,h=3);
		}

		difference() {
			linear_extrude(thickness*2) difference() {
				circle(outerdiam/2);
				circle(sphereRadius+meltage);
			}
			// chamfer
			rotate_extrude() translate([outerdiam/2-chamfer_radius*2, 0, switchtotalheight+thickness*2-chamfer_radius*2]) difference() {
				square(chamfer_radius*2);
				translate([0,chamfer_radius*2]) circle(chamfer_radius*2);
			}
		}
		
		render(2) for (angle=[0:120:359]) difference() {
			rotate(angle) translate([(innerdiam-ridge)/2+thickness,0,thickness]) cylinder(d=5.5,h=switchtotalheight+thickness);
			rotate(angle) translate([(innerdiam-ridge)/2+thickness,0,thickness*2]) cylinder(d=4,h=switchtotalheight);
		}
	}
}

module dome() {
	translate([0,0,-thickness*2]) union() {
		difference() {
			sphere(r=sphereRadius);
			sphere(r=sphereRadius-thickness);
			translate([-sphereRadius,-sphereRadius,0]) cube([2*sphereRadius,2*sphereRadius,sphereRadius]);
		}
		difference() {
			translate([0,0,-sphereRadius+thickness/2]) cylinder(d=switchbuttondiameter+thickness*2+meltage,h=sphereRadius+thickness*2-meltage*2);
			translate([0,0,thickness*2-switchtravel-meltage/2]) cylinder(d=switchbuttondiameter+meltage,h=switchtravel+meltage);
			if (microSwitch) {
				render(2) translate([0,0,-microSwitchHeight]) {
					rotate_extrude() polygon(points=[[.5,0],[switchbuttondiameter+thickness*2+meltage,3],[switchbuttondiameter+thickness*2+meltage,0]]);
				}
			}
		}
	
		difference() {
			linear_extrude(thickness*2) difference() {
				circle(sphereRadius+ridge-thickness-meltage*2);
				circle(sphereRadius-thickness-meltage);
			}
			for (angle=[0:120:359]) difference() {
			rotate(angle) translate([(innerdiam-ridge)/2+thickness,0,0]) cylinder(d=ridge+thickness*2,h=switchtotalheight+thickness);
			}
		}

			for (idx = [0:domeLength]) {
				rotate([-4,205-idx*55/domeLength,0]) translate([0,0,sphereRadius-thickness/2]) rotate([-5,7,180]) linear_extrude(thickness*2+meltage) text(t=domeText[idx],font="LiberationMono",size=10);
			}
	}
}

module switch() {
	union() {
		translate([-switchlenwid/2 -meltage,-switchlenwid/2-meltage,0]) cube([switchlenwid+meltage*2,switchlenwid+meltage*2,switchbaseheight]);
		translate([-switchlenwid/2 -meltage-2.2,-switchlenwid/2-meltage+1.1,0]) cube([2.2,1.1,1]);
		translate([-switchlenwid/2 -meltage-2.2,switchlenwid/2-meltage-1.1,0]) cube([2.2,1.1,1]);
		translate([switchlenwid/2 +meltage,-switchlenwid/2-meltage+1.1,0]) cube([2.2,1.1,1]);
		translate([switchlenwid/2 +meltage,switchlenwid/2-meltage-1.1,0]) cube([2.2,1.1,1]);
		cylinder(d=switchbuttondiameter, h=switchtotalheight);
	}
}

module bottom() {
	difference() {
		union() {
			cylinder(d=outerdiam, h=thickness*2);
			if (microSwitch) {
				translate([-thickness,-microSwitchLength/2,0]) {
					translate([-microSwitchWidth/2 - meltage - thickness,microSwitchLength/2-3,thickness*2]) cube([thickness*2,microSwitchLength,microSwitchHeight]);
					translate([microSwitchWidth/2 + meltage + thickness,microSwitchLength/2-3,thickness*2]) cube([thickness*2,microSwitchLength,microSwitchHeight]);
				}
			}
		}
		for (angle=[0:120:359]) difference() {
			rotate(angle) translate([(innerdiam-ridge)/2+thickness,0,0]) cylinder(d=4,h=switchtotalheight);
		}
		if (microSwitch) {
			translate([0,-1.32-meltage/2,0]) cylinder(r=.6+meltage,h=thickness*2);
			translate([0,3.76-meltage/2,0]) cylinder(r=.6+meltage,h=thickness*2);
			translate([0,8.84-meltage/2,0]) cylinder(r=.6+meltage,h=thickness*2);
			translate([-microSwitchWidth/2 - meltage - thickness*2,.15,1.5+thickness*2]) rotate([0,90,0]) cylinder(r=1+meltage,h=thickness*2);
			translate([microSwitchWidth/2 + meltage,.15,1.5+thickness*2]) rotate([0,90,0]) cylinder(r=1+meltage,h=thickness*2);
			translate([-microSwitchWidth/2 - meltage - thickness*2,6.65,1.5+thickness*2]) rotate([0,90,0]) cylinder(r=1+meltage,h=thickness*2);
			translate([microSwitchWidth/2 + meltage,6.65,1.5+thickness*2]) rotate([0,90,0]) cylinder(r=1+meltage,h=thickness*2);
		} else {
			#rotate([0,0,90])translate([0,0,thickness]) switch();
			translate([-switchlenwid/2 -meltage,-innerdiam/2+switchlenwid/2-thickness,thickness]) cube([switchlenwid+meltage*2,innerdiam/2-switchlenwid-meltage*2,1]);
		}
		
		translate([-innerdiam/2+18,innerdiam/2-15,thickness]) linear_extrude(thickness) text($fn=40, t="© 2014 Robert ◊",size=4,font="LiberationSans");
		translate([-innerdiam/2+15,innerdiam/2-22,thickness]) linear_extrude(thickness) text($fn=40, t="All Rights Reserved",size=4,font="LiberationSans");
	}
}

//base();
translate([0,0,thickness*5]) dome();
//translate([0,0,switchtotalheight+thickness*5]) rotate([180,0,0])  
	//bottom();
//switch();
				