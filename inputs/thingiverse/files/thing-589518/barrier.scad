// Singer Spool Holder Clamp
// by zeus - zeus@ctdo.de - 2014-12-11


// Parameters are in mm

// Inner Diameter
id=5; // 5 is good for the Singer Professional XL1000
// Outer Diameter
od=8.5; // 8.5 Gives enought Material thickness when id is "5"
// Width of the cut
cut_w=1; // Increase when your Printer is very sloppy and almost fills this gap
// Height
h=5; //Height of the Clamp

$fn=050;


difference(){
	cylinder(h=h, r=od/2, center=true);
	cylinder(h=h+0.1, r=id/2, center=true);
	translate([od/2-cut_w,0,0]){
		#cube([od/2,cut_w,h+0.1],center=true);
	}
}