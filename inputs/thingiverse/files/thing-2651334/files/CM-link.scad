// "Linkable" Floor Cable Protector
// variables for channel height and width.
// ADA compliance requires steepest approach to be 12 deg.  This determines width.

// Angle of attack, ADA requires steepest approach to be 12 degrees.  Also determines width.
AA=30; //[10,12,15,20,25,30]
// Height of channel, helps determine external height and width of chain
channel_height= 13; // [1:50]
// Width of channel, use narrower than a maximum (as determined by channel_height)
channel_width= 13; // [1:50]
// Thickness of bridge
bridge=2; //[1:5]
// Tolerance for mating parts
tolx=0.25; // [0:0.1:3]
// Which parts to print?
part = "both"; // [first:disk,second:linker,both:both]

print_part();

module print_part() {
	if (part == "first") {
		circle();
	} else if (part == "second") {
		link();
	} else if (part == "both") {
		both();
	} else {
		both();
	}
}

$fa=1;

// Perform cylinder calculations
cyl_rad=((channel_height+bridge)*cos(AA))/(1-cos(AA));
overlook=cyl_rad*sin(AA);

module track(){
    difference(){
        translate([0,0,-(cyl_rad-channel_height-bridge)])rotate([0,90,0])cylinder(h=overlook*2,r=cyl_rad);
        union(){
            translate([-tolx,-cyl_rad,-2*cyl_rad])cube([2*overlook+2*tolx,2*cyl_rad+tolx,2*cyl_rad]);
            translate([-tolx,-channel_width/2,-tolx])cube([2*overlook+2*tolx,channel_width,channel_height+tolx]);
        }
    }
}

module circle(){
    intersection(){
        track();
        translate([overlook,0,-tolx])cylinder(h=overlook,r=overlook);
   }
}

module cup(){
    difference(){
        track();
        union(){
            translate([1.5*overlook+2*tolx,0,-tolx])cylinder(h=overlook,r=overlook+tolx);
            translate([1*overlook+channel_width,-overlook-channel_width,-tolx])cube([2*(overlook+channel_width),2*(overlook+channel_width),overlook]);
        }
    }
}

module link(){
    translate([-overlook/2-3*bridge,0,0]) union(){
        cup();
        mirror([1,0,0])cup();}
}

module both(){
    circle();
    link();
}



