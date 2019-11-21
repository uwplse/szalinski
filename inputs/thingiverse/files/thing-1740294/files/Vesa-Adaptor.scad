/*********************************************************
 *                                VESA 75 to VESA 100 adaptor                                *
 *                             by Blair Thompson, AKA Justblair                              *
 *                                       www.justblair.co.uk                                         *
 *                                                                                                               *
 *********************************************************/

// ********************     Parametrics!      ********************

// Set test_piece variable to false for adaptor, true for calibration piece

test_piece=false;				// if true, a calibration piece will be created instead of the adaptor

// I designed this adaptor to mount a M350 ITX case to a VESA75 monitor, for this I used trapped nuts on the VESA100 mounts
// If you are using the adaptor for other purposes this may not suit you, adjust the variables below for different combinations

vesa_75_nut=false;  			// if true, vesa 75 mounts will include a trapped m4 nut, round hole if false
vesa_100_nut=true;			// if true, vesa 100 mounts will include a trapped m4 nut, round hole if false

// Depending on how strong you wish your adaptor to be, you can adjust here the style of adaptors

outer_ring_option=true;			// if true, outer ring will be included
center_piece_option=true;		// if true, center strengthening bars will be included
outer_ring_cutouts_option=true;	// if true, oval cutouts will be added to lighten the outer ring

// Variables, play around with these to calibrate and tweak the dimensions of the adaptor

plate_height=9;				// How high do you wish the plate to be

m4_thread_diameter=5.2;			// Adjust this to suit your printer
m4_nut_diameter=9.5;				// If you are using trapped nuts in the adaptor you can adjust this to suit your printer
m4_washer_diameter=10.2;			// Even if you are using trapped nuts throughout the adaptor, this also adjusts the mount diameters!
m4_head_depth=4;			// Adjust to the max height of either your bolt head or nut (whichever is the larger)

mount_chunkiness=2;			// how thick are the walls of the mount around the screw_head

cutout_width=10;				// If using an outer strengthening ring, this adjusts the width of the oval cutout
cutout_length=24;			// If using an outer strengthening ring, this adjusts the length of the oval cutout
cutout_gap=5;				// If using an outer strengthening ring, this adjusts the gap between the oval cutouts

// ********************     Here comes the code!     ********************

// Main bit of code
if(test_piece==false){
	translate([-50,-50,0]){
		difference(){
			union(){
	
				if (center_piece_option==true){
					center_piece();
				} else{
					mount_joins();
				} // end if
				if(outer_ring_option==true){
					outer_ring();
				} // end if
				vesa100();
				vesa75();
			} // end union
		vesa_holes();
		} // end difference
	} // end translate
}else{
	translate([-6.25,-6.25,0]){
		difference(){
			union(){
				mount();
				translate([12.5,12.5,0]) mount();
				rotate([0,0,-45])  translate([-2.5,0,0,])cube([5,20,plate_height-2], center=false);
				rotate([0,0,-45])  translate([-5,0,0,])cube([10,20,(plate_height-2)/2], center=false);
			}
		vesa_holes();
		}
	}
} 
// end Main bit of code

// *******************     Here comes the modules!     *******************

module mount(){ 
		cylinder(r=m4_washer_diameter/2+mount_chunkiness, h=plate_height, $fn=60);
} // end module

module mount_holes(nut){
	translate([0,0,-10]) cylinder(r=m4_thread_diameter/2, h=plate_height+20, $fn=20);
	if (nut==true){
		translate([0,0,plate_height-m4_head_depth]) cylinder(r=m4_nut_diameter/2, h=6, $fn=6);
	} else {
		translate([0,0,plate_height-m4_head_depth]) cylinder(r=m4_washer_diameter/2, h=6, $fn=30);
	}  // end if
} // end module

module vesa75(){		// Adds the mounting posts for the 75mm spaced screws
	translate([12.5,12.5,0]) mount();
	translate([87.5,12.5,0]) mount();
	translate([12.5,87.5,0]) mount();
	translate([87.5,87.5,0]) mount();
}  // end module

module vesa100(){	// Adds the mounting posts for the 100mm spaced screws
	mount();
	translate([100,0,0]) mount();
	translate([0,100,0]) mount();
	translate([100,100,0]) mount();
}  // end module

module vesa_holes(){   	// Places all the mounting holes
	union(){
		translate([12.5,12.5,0]) mount_holes(vesa_75_nut);
		translate([87.5,12.5,0]) mount_holes(vesa_75_nut);
		translate([12.5,87.5,0]) mount_holes(vesa_75_nut);
		translate([87.5,87.5,0]) mount_holes(vesa_75_nut);
		rotate([0,180,0]){
			translate([-100,0,-plate_height]){
				mount_holes(vesa_100_nut);
				translate([100,0,0]) mount_holes(vesa_100_nut);
				translate([0,100,0]) mount_holes(vesa_100_nut);
				translate([100,100,0]) mount_holes(vesa_100_nut);
			} // end translate
		}  // end rotate
	}  // end union
}  // end module

module oval_cutout(){
	hull(){
		translate([0,0,0]) cylinder(r=cutout_width/2, h=plate_height+5, $fn=60, center=true);
		translate([cutout_length,0,0]) cylinder(r=cutout_width/2, h=plate_height+5, $fn=60, center=true);
	} //end hull	
}  // end module

module cutout_side(){
	translate ([-(cutout_gap/2+cutout_width/2+cutout_length),0,0]) oval_cutout();
	translate ([cutout_gap/2+cutout_width/2,0,0]) oval_cutout();
}  // end module

module outer_ring(){
	difference(){
		translate ([-5+m4_washer_diameter/2,-5m4_washer_diameter/2,0]) minkowski(){
			cube([110-m4_washer_diameter,110-m4_washer_diameter,(plate_height-2)/2]);
			cylinder(r=m4_washer_diameter/2, h=1);
		}  // end translate/minkowski
		translate ([10,10,-1]) cube ([80,80,plate_height]);
		if (outer_ring_cutouts_option==true){
			translate ([50,5,0]) cutout_side();
			translate ([50,100-5,0]) cutout_side();
			translate ([100,0,0]) rotate ([0,0,90]) {
				translate ([50,5,0]) cutout_side();
				translate ([50,100-5,0]) cutout_side();
			} // end translate/rotate
		} // end if
	} // end difference
	difference(){
		translate ([10,10,0]) cube([80,80,plate_height-2]);
		translate ([15,15,-10]) cube ([70,70,plate_height+20]);
	} // end difference
} // end module

module center_piece(){
	rotate([0,0,-45])  translate([-2.5,0,0,])cube([5,142,plate_height-2], center=false);
	rotate([0,0,-45])  translate([-5,0,0,])cube([10,142,(plate_height-2)/2], center=false);
	translate([100,0,0]) rotate([0,0,45])  translate([-2.5,0,0,])cube([5,142,plate_height-2], center=false);
	translate([100,0,0]) rotate([0,0,45])  translate([-5,0,0,])cube([10,142,(plate_height-2)/2], center=false);
} // end module

module mount_joins(){
	difference(){
		center_piece();
		translate([11.5,11.5,-1]) cube([77,77,plate_height+5]);
	} // end difference
} //end module