//
// mounting bracket for GoPro Hero with housing
// for use on the HobbyKing Brushless ActionCam Gimbal
// http://hobbyking.com/hobbyking/store/__51184__HobbyKing_Brushless_ActionCam_Gimbal_With_2208_Motors_and_3K_Carbon_Construction.html
//
// Design by Egil Kvaleberg, Jan 2015
//


// adjust for best balance:
camera_yoffs = 28.0; // measured from tab1 to nearest camera tab
// adjust for best balance:
camera_zoffs = 2.0; // measured from bracket plane


cbracket_screw = 1*5.3; // M5 with margin
cbracket_circ = 1*4.5; // circumference round screw (5.0)
cbracket_circ2 = 1*6.5; // clearance with margin
cbracket_suppw = 1*12.0; // width of support piece
cbracket_wall = 1*3.1; // 3.0 with clearance
cbracket_dist = 1*3.3; // with clearance
nut_height = 3.5;
nut_af = 1*8.6; // 8mm plus margin

thickness = 1*1.90; // of tabs
wall = 1*2.5;
inner_width = 1*21.7;
outer_width = 1*26.0;
tabs = 1*2.0; 
board_extra = 9.0; // extra space for accelerometer board
tab1 = 1*10.25;
tabd = 1*28.9;
tab2 = 1*5.25;
d = 1*0.01;

module add_this()
{
	// middle section, two parts
	translate([-inner_width/2, -board_extra, -thickness/2]) cube([inner_width, board_extra+tabs+camera_yoffs-cbracket_wall-2*nut_height, thickness]);
	translate([-inner_width/2, tabs+tab1+tabd, -thickness/2]) cube([inner_width, tab2+tabs, thickness]);

	// strengthening bars along edge
	translate([-inner_width/2, tabs+3.0, -thickness/2]) cube([wall, tab1-3.0+tabd+tab2+tabs, wall+thickness]);
	translate([inner_width/2-wall, tabs+3.0, -thickness/2]) cube([wall, tab1-3.0+tabd+tab2+tabs, wall+thickness]);

	// two tabs
	translate([-outer_width/2, tabs, -thickness/2]) cube([outer_width, tab1, thickness]);
	translate([-outer_width/2, tabs+tab1+tabd, -thickness/2]) cube([outer_width, tab2, thickness]);

	// bottom support
	translate([0, tabs+camera_yoffs-cbracket_wall-2*nut_height, camera_zoffs]) difference() {
		translate([-cbracket_suppw/2, -wall, -(cbracket_screw/2 + cbracket_circ2 + wall)]) cube([cbracket_suppw, wall+15.0, wall+cbracket_circ2+cbracket_screw/2-camera_zoffs]);
		rotate([-90, 0, 0]) cylinder(r = cbracket_screw/2 + cbracket_circ2, h=15.0+d);
	}
	translate([-cbracket_suppw/2, tabs+camera_yoffs-cbracket_wall, -(cbracket_screw/2 + cbracket_circ2 + wall)+camera_zoffs]) cube([cbracket_suppw, cbracket_wall+cbracket_wall+cbracket_dist+cbracket_wall+cbracket_wall, wall+ cbracket_circ2]);

	translate([0, tabs+camera_yoffs-cbracket_wall, camera_zoffs]) rotate([-90, 0, 0]) {
		// cage for nut
		translate([0, 0, -nut_height]) {	
			cylinder(r1 = (nut_af/2)/cos(30), r2 = cbracket_screw/2 + cbracket_circ, h=nut_height);
		}
		cylinder(r = cbracket_screw/2 + cbracket_circ, h=cbracket_wall+cbracket_wall+cbracket_dist+cbracket_wall+cbracket_wall);
		translate([0, 0, cbracket_wall+cbracket_wall+cbracket_dist+cbracket_wall+cbracket_wall]) cylinder(r = cbracket_screw/2 + wall, h=2*cbracket_wall);
	}
}

module sub_this()
{
	translate([0, tabs+camera_yoffs-cbracket_wall, camera_zoffs]) rotate([-90, 0, 0]) {
		translate([0, 0, -nut_height]) {	
			rotate([0, 0, 30]) translate([0, 0, -nut_height]) cylinder(r = (nut_af/2)/cos(30), h=nut_height*2, $fn=6);
			cylinder(r = cbracket_screw/2, h=50.0, $fn=30);
		}
		translate([0, 0, cbracket_wall]) cylinder(r = cbracket_screw/2 + cbracket_circ2, h=cbracket_wall);
		translate([0, 0, cbracket_wall+cbracket_wall+cbracket_dist]) cylinder(r = cbracket_screw/2 + cbracket_circ2, h=cbracket_wall);
		translate([0, 0, cbracket_wall+cbracket_wall+cbracket_dist+cbracket_wall+cbracket_wall+3*cbracket_wall]) cylinder(r = cbracket_screw/2 + wall + 0.5, h=cbracket_wall);
	}
}

difference() {
	add_this();
	sub_this();
}
