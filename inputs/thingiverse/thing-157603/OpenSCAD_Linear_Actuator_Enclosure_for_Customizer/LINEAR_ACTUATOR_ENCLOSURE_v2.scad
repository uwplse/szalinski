$fn = (100 * 1);

//distance between axis in mm 
dist = 15;

//joint rib thickness in mm =
rib_thickness = 5; //[2:10]


difference() {
	union() {
		difference() {
			cylinder(h = 25, r = 8); //linear actuator slider outer diam
			translate([0, 0, -2]) cylinder(h = 7, r = 6); //bottom bearing housing 
			cylinder(h = 40, r = 3); //linear actuator slider inner diam
			translate([0, 0, 21]) cylinder(h = 6, r = 6); //top bearing housing 
		}
		translate([dist, 0, 0]) {
			difference() {
				cylinder(h = 25, r = 6.5); //motor housing outer diam
				translate([0, 0, -2]) cylinder(h = 50, r = 5); //motor housing inner diam
				translate([0, -1, -2]) cube(size = [25, 2, 40], center = false);  //motor housing cut out
			}
			difference() {
				translate([-(dist / 2), 0, 12.5]) cube(size = [((dist / 2) + 15),rib_thickness,25], center = true); //join rib 
				translate([-dist, 0, -2]) cylinder(h = 50, r = 6); //join rib substraction from linear act slider
				translate([0, 0, -2])cylinder(h = 60, r = 5); //join rib substraction from motor 
			}
			
		
			difference() {
				union() {
					translate([5, 1, 0]) cube(size = [5, 2, 25], center = false);  //right wall to fasten the motor 
					translate([5, -3, 0]) cube(size = [5, 2, 25], center = false); //left wall to fasten the motor 
				}
				rotate([90, 0, 0]) translate([7.5, 12.5, 0]) cylinder(h = 17, r = 1.1, center = true); // hole for the bolt


			}
		}

	rotate([90, 0, 0]) translate([6, 12.5, 0]) cylinder(h = 17, r = 2.5, center = true); //rotation hinge 
	}
	rotate([90, 0, 0]) translate([6, 12.5, 0]) cylinder(h = 30, r = 1.5, center = true); //hole of the rotation hinge 
}
