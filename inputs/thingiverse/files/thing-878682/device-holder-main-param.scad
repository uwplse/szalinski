/* [Global] */
// iphone 5 bare 59x124.2x7.8
// iphone5 w thin case 62x126.5x11
// iphone5 w otterbox 69x134.5x16.2
// iphone6 (default) 69.2x140x9.2
// ipad 2 bare 186.6x241.6x8.85
// ipad 2 full cover 254x200x14
// ipadpro 221x305x7.5
// width of the device in mm in portrait orientation (iphone6 bare = 67)
width = 200; // [50:.2:220]
// height of the device in mm (iphone 6 bare=138)
height = 254; // [100:.2:300]
// thickness of device in mm (iphone 6 bare=7)
thickness = 15; // [5:.1:15]

/* [Hidden] */
module MMark() {
//    difference() {
//     translate([-6,-33,0]) cube([12,18,1]);
     rotate([0,0,180]) translate([4.3,19,-.1])  linear_extrude(1,0,.9) scale([-1,1,1]) { 
        translate([5.8,-2.9,0]) rotate([0,0,50]) text("S",10,font="Jim Nightshade"); 
        translate([.2,-2.5,0]) scale([1.2,.8,1]) text("J",4,font="Aldrich");   
        translate([-.3,0,0]) scale([1.2,1,1]) text("L",6,font="Aldrich");
        translate([4.4,8.6,0]) circle(r=2,$fn=20);
        translate([4.4,8.6,0]) for (i = [235:50:460]) {
            rotate([0,0,i]) translate([-.5,2.5,0]) square([1,2]);
        }
        }    
//    }
}      

difference() {
union() {
difference() {
	translate([-(height+12)/2+1.5,-(width+12)/2+3,0]) {
	difference() {
		translate([-1.5,-3,0]) cube([height+12,width+12,thickness+4]);
		translate([4.5,3,4]) cube([height,width,thickness+4]);
	}
	}
	union() {
		translate([-106,106,thickness/2+3]) cube([200,200,thickness+7],center=true);
		translate([-106,-106,thickness/2+3]) cube([200,200,thickness+7],center=true);
		translate([height/4-14,-111,thickness/2+3]) cube([height/2-41,200,thickness+7],center=true);
		translate([height/4-14,111,thickness/2+3]) cube([height/2-41,200,thickness+7],center=true);
		translate([90,-130,thickness/2+3]) cube([140,200,thickness+7],center=true);
		translate([90,130,thickness/2+3]) cube([140,200,thickness+7],center=true);
		translate([height/2+25,0,thickness/2+3]) cube([80,40,thickness+7],center=true);
		translate([0,-width/2-3,2]) cylinder(h=thickness+4,r=1,$fn=180);
		translate([0,width/2+3,2]) cylinder(h=thickness+4,r=1,$fn=180);
		translate([height/2+3,-25,2]) cylinder(h=thickness+4,r=1,$fn=180);
		translate([height/2+3,25,2]) cylinder(h=thickness+4,r=1,$fn=180);
		translate([-height/2-3,0,2]) cylinder(h=thickness+4,r=1,$fn=180);
	}
}
translate([0,0,2.1]) cylinder(h=4.2,r=25,$fn=360,center=true);
}
union() {
	translate([0,0,4]) cylinder(h=4.2,r=21,$fn=360,center=true);
	translate([0,0,0]) cylinder(h=8,r=6.2,$fn=360,center=true);
    translate([0,-12,0]) sphere(r=1.7,$fn=24);
    translate([12,0,0]) sphere(r=1.7,$fn=24);
    translate([0,12,0]) sphere(r=1.7,$fn=24);
    translate([-12,0,0]) sphere(r=1.7,$fn=24);
    translate([0,0,-.2]) rotate_extrude($fn=72) translate([12,0,0]) circle(r=.9,$fn=30);
    translate([6,0,-.1])rotate([0,0,90]) scale([1.3,1.3,1]) MMark();
}
}
