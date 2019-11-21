$fn=100;
pad=0.01;

//cone params
cone_caliber=15.8; //(.625 inches in mm ) / 2 - fudge
cone_thickness=1.2;
cone_height=15.5;

//bolt cup params
bolt_radius=1.5;
cup_height=6.5;
cup_thickness=.9;

//bolt cup spine params
spine_thickness=.255;
spine_count=10;


//cone
module cone() {
	difference() {
		cylinder( h = cone_height, r1=cone_caliber, r2=bolt_radius+cup_thickness);
		translate([0,0,0-pad]){
			cylinder( h = cone_height-cone_thickness, r1=cone_caliber-cone_thickness, r2=bolt_radius+cup_thickness-cone_thickness);
		}
	};
};

//bolt cup
module bolt_cup() {
	//cup
	difference() {
		cylinder( h = cup_height, r = bolt_radius+cup_thickness);
		translate([0,0,2]){
			cylinder( h = cup_height-cup_thickness+pad, r = bolt_radius);
		}
	}; 
	
	//cup spines
	for (i=[0:spine_count-1]) {
		rotate( i*360/spine_count, [0,0,1] ) {
			translate([bolt_radius-spine_thickness,-(spine_thickness/2),0]){
				cube([spine_thickness,spine_thickness,cup_height]);
			}
		}
	};
};

cone();
translate([0,0,cone_height]){
	bolt_cup();
}