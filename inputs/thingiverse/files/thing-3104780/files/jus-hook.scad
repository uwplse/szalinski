/* [Hook] */

// thickness of upper hook
doorthickness=19.5; // [1:100]
// height of upper hook
doorheight=30; // [1:100]
// diameter of bottom hook
dia=10; // [1:100]
// Width of whole hook
width=25; // [1:100]
// Length of body of hook
length=60; // [1:100]
// Overral thickness of hook
thickness=4; // [1:100]
// Height of the bottom hook 
hookheight=50; // [1:100]

// close hook
closeHook=false;

/* [Hidden] */
difference()
{
	cylinder(h=width,r=.5*dia+thickness,center=true);
	cylinder(h=width+1,r=.5*dia, center=true);
    translate([dia,0,0]) cube([2*dia,dia,width],center=true);
}

translate([0,.5*dia,-.5*width]) 
	cube([length-.5*dia,thickness,width]);

translate([length-.5*dia-thickness,.5*dia+thickness,-.5*width]) 
	cube([thickness,doorthickness,width]);

translate([length-.5*dia-doorheight-thickness,.5*dia+doorthickness+thickness,-.5*width]) 
	cube([doorheight+thickness,thickness,width]);

translate([0,-.5*dia-thickness,-.5*width]) 
	cube([.5*dia+hookheight,thickness,width]);

if(closeHook) {
translate([-.5*dia,-.5*dia,-.5*width]) 
	cube([dia+hookheight,dia,thickness]);
    
}









