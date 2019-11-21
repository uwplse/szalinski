/*
   hole
 ___↓___
|_ | | _| ←catch
  || ||	  ←base
*/
earphone_base_length = 1.7;
earphone_base_diameter = 5.1;
earphone_catch_diameter = earphone_base_diameter + 1;
earphone_catch_length = 1.7;
earphone_hole_diameter = earphone_base_diameter - 1.5;
earphone_hole_length = earphone_base_length + earphone_catch_length;

/*
|--breadth--|
 _____ _____	___
\ \ \ ' / / /  length
   \  _	 /		_|_
*/
tail_breadth = 20;
tail_length = 15;
tail_thickness = 0.5;

quality = 3; //[1:draft, 2:meh, 3:best]
$fa = 3 / quality;
$fs = 1.5 / quality;

module earphone() {
	difference() {
		union() {
			cylinder(d=earphone_catch_diameter, h=earphone_catch_length);
			translate([0,0,earphone_catch_length])
				cylinder(d=earphone_base_diameter, h=earphone_base_length);
		}
		translate([0,0,-0.1])
			cylinder(d=earphone_hole_diameter, h=earphone_hole_length + 0.2);
	}
}

fin_ridge_diameter = tail_thickness * 2;
max_fin_ridge_count = 5 * 1;

module tailfin() {
	translate([0,tail_thickness * 0.5,0])
		rotate([90,-45,0])
		cube([tail_breadth, tail_breadth, tail_thickness]);
	difference() {
		union() {
			rotate([0, -45, 0]) {
				for (i = [1 : 1 : max_fin_ridge_count]) {
					translate([fin_ridge_diameter * i, tail_thickness * 0.5, 0])
						cylinder(d=fin_ridge_diameter, h=100);
				}
				for (i = [0 : 1 : max_fin_ridge_count]) {
					translate([fin_ridge_diameter * (i + 0.5), tail_thickness * -0.5, 0])
						cylinder(d=fin_ridge_diameter, h=100);
				}
			} //rotate
			rotate([0, 45, 0]) {
				for (i = [-1 : -1 : -(max_fin_ridge_count + 0)]) {
					translate([fin_ridge_diameter * i, tail_thickness * 0.5, 0])
						cylinder(d=fin_ridge_diameter, h=100);
				}
				for (i = [-1 : -1 : -(max_fin_ridge_count + 1)]) {
					translate([fin_ridge_diameter * (i + 0.5), tail_thickness * -0.5, 0])
						cylinder(d=fin_ridge_diameter, h=100);
				}
			} //rotate
		} //union
		translate([0,tail_thickness * 2,-1])
			rotate([90,-45,0])
			cube([tail_breadth /3 + tail_thickness / 2, tail_breadth/3, tail_thickness * 4]);
	} //difference
}

globe_height = earphone_base_diameter * 0.8;
globe_diameter = earphone_base_diameter*2;

module tail() {
	difference() {
		union() {
			translate([0,0,globe_height])
			sphere(d=globe_diameter);
			tailfin();
		} //union

		//Void in center of globe
		translate([0,0,globe_height * -0.5])
		cylinder(d1=earphone_hole_diameter, d2=0, h=globe_diameter);

		//Sound holes
		translate([0,0,-1]) {
//			resize([2,1,700])
				rotate([3,0,0])
				translate([0,-1.25,0])
				cylinder(d1=2, d2=3, h=globe_diameter);
//			resize([2,1,700])
				rotate([-3,0,0])
				translate([0,+1.25,0])
				cylinder(d1=2, d2=3, h=globe_diameter);
		} //translate z-1

		//Cube to cut off top of model
		translate([-250, -250, tail_length])
			cube([500, 500, 500]);
	} //difference
} //tail

earphone();
translate([0,0,earphone_hole_length])
tail();
