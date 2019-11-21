use <utils/build_plate.scad>

//Declare the scale that will be used for the model. This scale is used to calculate the pixel to mm scale. EX. scale of 5 means 1pixel on skin = 5mm.

scale=1.5;
hturn=0; // (-45,45)
part="work"; // [work, run, custom]

langle=-15; // Custom left arm angle, 0 is straight down, 45 is forward, -45 is back
rangle=45; // Custom right arm angle, 0 is straight down, 45 is forward, -45 is back
legAngle=15; // Custom angle of legs, 0 = standing, 45 = running

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]


//Create the head of guy

module head() 
{
difference() 
{
cube(size = scale * 8, center=true);
//translate([0,0,scale*4])cylinder(r=scale*1,h=8, center=true,$fn=100);
}
}

//create the connector hole for use to connect the leg to body with a piece of filament 

module leg_connector()
{
//translate([scale*2,scale*1,0])cylinder(r=1.5,h=scale*2, center=true,$fn=100); 
//translate([scale*2,scale*2,0])cylinder(r=1.5,h=scale*2, center=true,$fn=100);
}

//Create the body of guy

module body() 
{
difference()
{
union()
{
translate([0,0,scale*10])cube([scale*8,scale*4,scale*12], center=true);
//translate([0,0,scale*4])cylinder(r=scale*1-0.25,h=8, center=true,$fn=100);
}
translate([0,scale*-1.5,scale*16])leg_connector();
translate([scale*-4,scale*-1.5,scale*16])leg_connector();
//translate([scale*4,0,scale*6])rotate(a=[90,0,90])cylinder(r=1.5,h=scale*2, center=true,$fn=100);
//translate([scale*-4,0,scale*6])rotate(a=[90,0,90])cylinder(r=1.5,h=scale*2, center=true,$fn=100);
}
}

//Create the legs of the guy

module legs(llangle,rlangle)
{
difference()
{
union()
{
// leg and foot
translate([0,0,scale*16]) rotate([llangle,0,0]) translate([0,0,-scale*16]) {
	translate([scale*2.015+1/2,0,scale*22])cube([scale*3.97-1,scale*4,scale*12], center=true);
	translate([scale*2.015+1/2,scale/2,scale*(12+22-7)])cube([scale*3.97-1,scale*5,scale*2], center=true);
	}

// other leg and foot
translate([0,0,scale*16]) rotate([rlangle,0,0]) translate([0,0,-scale*16]) {
	translate([scale*-2.015-1/2,0,scale*22])cube([scale*3.97-1,scale*4,scale*12], center=true);
	translate([scale*-2.015-1/2,scale/2,scale*(12+22-7)])cube([scale*3.97-1,scale*5,scale*2], center=true);
	}

}
//translate([0,scale*-1.5,scale*16])leg_connector();
//translate([scale*-4,scale*-1.5,scale*16])leg_connector();
}
}

//Create the tools arm of guy

module toolarm(rangle)
{
translate([0,0,6*scale]) rotate([90-rangle,0,0]) translate([0,0,-6*scale]) difference()
{
translate([-5.75*scale,4*scale,6*scale])rotate([90,0,0])cube([3.5*scale,3.5*scale,12*scale],center=true);
translate([-5.75*scale,8.5*scale,6*scale])rotate([0,90,0])cube([5*scale+0.5,1.4*scale+0.5,1*scale+0.5],center=true);
//translate([scale*-4,0,scale*6])rotate(a=[90,0,90])cylinder(r=scale*0.2,h=scale*2, center=true,$fn=100);
}
}

//Create the normal arm of guy

module freearm(langle)
{
translate([0,0,6*scale]) rotate([90-langle,0,0]) translate([0,0,-6*scale]) difference()
{
translate([5.75*scale,4*scale,6*scale])rotate([90,0,0])cube([3.5*scale,3.5*scale,12*scale],center=true);
//translate([scale*4,0,scale*6])rotate(a=[90,0,90])cylinder(r=scale*0.2,h=scale*2, center=true,$fn=100);
}
}

w = scale * (8 + 3.5 + 3.5);
h = sqrt(w*w/2);
echo(w,h);

module supportarms() {
	translate([0,0,4*scale]) rotate([90,0,0]) rotate([0,0,45]) cube([h,h,0.5], center=true);
	}

module drawSteve(hturn,langle,rangle,llangle,rlangle) {
	rotate([0,0,180]) translate([0,0,scale * 4]) {
		rotate([0,0,hturn]) head();       //Call to generate the guy's head
		body();       //Call to generate the guy's body
		legs(llangle,rlangle);         //Call to generate the guy's legs
		toolarm(rangle);   //Call to generate the guy's tool arm
		freearm(langle);  //Call to generate the guy's free arm
		supportarms();
		}
	}

if (part=="run") drawSteve(hturn,45, -45, 45, -45);
if (part=="work") drawSteve(hturn,0,45,0,0);
if (part=="custom") drawSteve(hturn,langle,rangle,legAngle,-legAngle);

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);