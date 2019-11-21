// Heart-shaped compartmentalized box. For holding small objects,
// or, if your printer is large enough, big objects.

/* [Box] */

// Render the box part?
drawbox = 1; // [0:No, 1:Yes]

// Render the lid?
drawlid = 1; // [0:No, 1:Yes]

// If both, view them how?
assembled = 1; // [1:Side-by-side,0:Assembled]

// Width (across the widest part)
width=80; // [10:300]

// Overall height 
height=20; // [4:300]

// Thickness of the bottom, the walls, and the dividers
wall=2;  // [1:10]

// Thickness of the lid
hlid = 4; // [2:20]

// Shrink the lid slightly, to avoid sanding?
lidscale = 1.0; // [1.0:No, 0.99:1%, 0.98:2%]

/* [ Build plate ] */

//for display only, doesn't contribute to final object
build_plate_selector = 2; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]


/* [Hidden] */
$fn=50;

// End of customizer variables

use <utils/build_plate.scad>

lr = width/4.0;
lrinset = lr-wall;
hcav = height*2;
hinset = height-hlid;
hbase = wall;



build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

drawboth = drawbox * drawlid;
do_offset = drawboth * assembled;
uphigh = (drawboth && !assembled) ? 1 : 0;


if (drawbox == 1) {
// with two compartments
translate([-(do_offset*0.5*width),0,0]) color("red") union() {
	difference() {
		heart(lober=lr, height=height);
		translate([0,0,hbase]) heart(lober=lrinset, height=hcav);
		translate([0,(lr/2)+(lr/20),hbase]) cylinder(r=(lr/2),h=hcav);
	}

	difference() {
		intersection() {
			translate([0,lr,0]) mirror([0,1,0]) rotate([0,0,1]*45) 
				translate([0,0,hinset/2]) cube([width*2,(lr-lrinset),hinset], center=true);
			heart(lr,height);
		}
		translate([-lrinset,lrinset,hbase]) cylinder(r=lrinset,h=hcav);
	}

	difference() {
		intersection() {
			translate([0,lr,0]) rotate([0,0,1]*45) translate([0,0,hinset/2]) 
				cube([width*2,(lr-lrinset),hinset], center=true);
			heart(lr, height);
		}
		translate([lrinset,lrinset,hbase]) cylinder(r=lrinset,h=hcav);
	}
}
}

if (drawlid == 1) {
	// lid 
	translate([(do_offset*0.5*width),0,0])  scale([lidscale,lidscale,1])
	color("blue")  translate([0,0,(hinset*uphigh)]) union() {
		translate([0,0,-(hlid+5)+hlid/2]) intersection() {
			union() {
				heart(lober=lrinset,height=hcav);
				translate([0,(lr/2)+(lr/20),hbase]) cylinder(r=(lr/2),h=hcav);
			}
			translate([0,0,5+hlid]) cube([width*4,width*4,hlid],center=true);
		}
	
	//	translate([0,11,3]) cylinder(r=10,h=4);
		translate([0,lr/2,hlid]) rotate([0,0,1]*90) union() {
			hull() {
				rotate([1,0,0]*-90) translate([0,0,-(lr*1.5)/2]) cylinder(r=hlid/8,h=lr*1.5);
				translate([0,0,hlid]) rotate([1,0,0]*-90) translate([0,0,-(lr*1.5)/2]) cylinder(r=hlid/2,h=lr*1.5);
			}
			hull() {
				translate([0,-(lr*1.5/2+hlid/2),0]) sphere(hlid/1.5);
				translate([0,-(lr*1.5)/2,hlid]) sphere((hlid/2));
			}
			hull() {
				translate([0,(lr*1.5)/2+hlid/2,0]) sphere(hlid/1.5);
				translate([0,(lr*1.5)/2,hlid]) sphere(hlid/2);
			}
		}
	}
}


module heart(lober=10,height=20) {
union() {
	hull() {
		translate([lober,lober,0]) cylinder(r=lober,h=height);
		translate([0,-1.5*lober,0]) rotate([0,0,1]*45) cube([lober/2,lober/2,height]);
	}

	hull() {
		translate([-lober,lober,0]) cylinder(r=lober,h=height);
		translate([0,-1.5*lober,0]) rotate([0,0,1]*45) cube([lober/2,lober/2,height]);
	}
}
}
