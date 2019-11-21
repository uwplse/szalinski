// This is a stand-in for the Blizzard Software (digipass) authenticator
// Licensed under Creative Commons: Attribution, Share-Alike
//
// For attribution you can direct people to the original file on thingiverse:
// 		http://www.thingiverse.com/thing:593551

// ================ variables

//CUSTOMIZER VARIABLES

/* [main] */

// This is used to cut holes for the LCD and button (like if you're making a "skin")
holes=0;  // [0:"false",1:"true"]

// How far the holes above extend
hole_d=20;

/* [ overall dimensions ] */

// Total height
h=26.19;

// Total width (less any keychain stuff)
w=56.23;

// Total depth
d=10.22;

// make the authenticator this much larger in all directions
// (when making a box for an authenticator, set to like 1mm or something)
oversize=1;

// How far the chord side (keyring side) extends beyond a straight rectangle
chord_w=7.7;

/* [ keychain settings] */

// Whether to cut a hole for a keyring to attach (probably always want this =true)
keyring_hole=1;  // [0:"false",1:"true"]

// Extend the keyring forward or back to make a channel for inserting it
project_keyring=10;

// How big around the keychain post is
keychain_dia=6.54;

// How far the keychain post extends beyond the authentictor body
keychain_outset=2.0;

/* [ button options ] */

// How high the button sticks up
button_d=0.59;

// How big around the button is
button_dia=9.49;

// How far the center of the button is from the button end of the device
button_inset=14.275;

// used to make cut holes for buttons on both sides in case you put it in upside down
two_buttons=1; // [0:"false",1:"true"]

/* [ LCD screen ] */

// How wide the screen is (only used if holes=true)
lcd_w=22.62;

// How high the screen is (only used if holes=true)
lcd_h=7.54;

// How far the nearest edge of the LCD is from the button end of the device (only used if holes=true)
lcd_inset=22.68;

/* [ hidden ] */

// Make a hearthstone box (only works offline with the hearthstone stl file in the same folder)
hearthstone_box=false;

// Whether to create the front or the back side of a hearthstone box
front=true;

function chord_wh_to_r(w,h)=sqrt(pow(h/2,2)+pow(w,2));

module mainbody(oversize=0){
	h_real=h+oversize;
	d_real=d+oversize;
	chord_r=chord_wh_to_r(chord_w,h)+h/2;
	union(){ // the main body
		translate([h/2,-h_real/2,-d_real]) cube([w-(h/2)-chord_w+oversize,h_real,d_real]);
		translate([h/2,0,-d_real]) cylinder(r=h_real/2,h=d+oversize,$fn=32);
		intersection(){ // the chord side
			translate([w-chord_r,0,-d_real]) cylinder(r=chord_r+(oversize/2),h=d_real,$fn=64);
			translate([h/2,-h_real/2,-d_real]) cube([w-(h/2)+oversize,h_real,d_real]);
		}
	}
}

module authenticator(oversize=0,project_keyring=0){
	mainbody(oversize);
	// the button
	translate([button_inset,0,0.01]) cylinder(r=button_dia/2+oversize/2,h=holes?hole_d:(button_d+oversize),$fn=32);
	if(two_buttons){
		translate([button_inset,0,0.01-(holes?hole_d:(button_d+oversize))-(d+oversize)]) cylinder(r=button_dia/2+oversize/2,h=holes?hole_d:(button_d+oversize),$fn=32);
	}
	if(holes){
		// the lcd
		translate([lcd_inset,-lcd_h/2,0]) cube([lcd_w,lcd_h,hole_d]);
	}
	if(keyring_hole){
		// a keyring hole
		translate([w+keychain_outset/2+h/2,0,-(d+oversize)/2 -keychain_dia/2]) cylinder(r=h/2,h=keychain_dia+project_keyring,$fn=32);
	}
	// the keychain outset
	hull(){
		translate([w,0,-(d+oversize)/2]) rotate([0,90,0]) cylinder(r=keychain_dia/2,h=keychain_outset,$fn=20);
		translate([w,0,project_keyring-(d+oversize)/2]) rotate([0,90,0]) cylinder(r=keychain_dia/2,h=keychain_outset,$fn=20);
	}
}

module box(project_keyring=0){
	difference() {
		translate([-27,85,25]) import_stl("hearthstone.STL");
		translate([0,-d/2,0]) rotate([90,0,0]) rotate([0,0,90]) authenticator(oversize,project_keyring);
	}
}

module dovetail(width=25,depth=4,angle=45,z_angle=0){
	b=depth*tan(angle);
	littlewidth=width+b*2;
	smallness=0.01;
	linear_extrude(100) rotate([0,0,z_angle]) hull() {
		// dovetail profile
		square([smallness,width]);
		translate([depth,(width-littlewidth)/2,0]) square([smallness,littlewidth]);
	}
}

module dovetailer(width=30,depth=5.101,angle=45,reverse=false,zstop=0){	
	translate([-50,0,-25]) {
		if(reverse){
			difference() {
				cube([100,100,100]);
				translate([50+width/2,-0.01,zstop]) dovetail(width,depth,angle,90);
			}
		}else{
			union() {
				cube([100,100,100]);
				translate([50-width/2,0.01,zstop]) dovetail(width,depth,angle,-90);
			}
		}
	}
}

module container(){
	if(front){
		difference(){
			box(project_keyring=0);
			dovetailer();
		}
	}else{
		intersection(){
			box(project_keyring=project_keyring);
			dovetailer();
		}
	}
}

if(hearthstone_box){
	difference() {
		container();
		translate([-50,-50,-58]) cube([100,100,50]); // flatten the bottom so it prints easier
	}
}else{
	authenticator(oversize);
}