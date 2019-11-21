// Ball joint in SCAD by Erik de Bruijn
// Based on a design by Makerblock ( http://makerblock.com/2010/03/blender-help/ )
// Improved by Alejandro Medrano

//Part selection
part = "Demo"; //[Demo, Male, Female, Segment]
// for Demo fun
Demo_size=7;
// size of the ball joint
size=10; 
 // some space between them?
joint_spacing =0.1;
// thickness of the arms
joint_thickness = 2; 
// how many arms do you want?
joint_arms = 3; 
// how much is removed from the arms Larger values will remove more
arm_width = 5; 
// relative length of arms (0 = no arms, 1 = full length arms)
joint_arms_lenght_ratio= 0.66; 
// base radius
baser=5; 
// base height, only applies for Male part
baseh=1; 
//indicate if base should be extruded, or differenciated in joint.
base_invert= false; 
// ratio of cut out joint, in order for it to work < 0.5
lock_ratio= 0.3; 
// adding a helper angle in joint, 0 to disable
lock_help_h= 3; 
// radius for hollowed part, 0 to disable
hole_r = 4; 

/* [Hidden] */
//render settings
$fs=0.8; // def 1, 0.2 is high res
$fa=4;//def 12, 3 is very nice

if (part == "Demo"){
    demo(true,Demo_size); 
}
if (part == "Male"){
    hollow() ball();
}
if (part == "Female"){
    hollow() joint();
}
if (part == "Segment"){
    hollow() segment();
}

module demo(init=true, nSegments=7)
{
    //colours = ["black","white"];
    colours = ["Red","Orange","Yellow","Green","Blue","Indigo","Violet"];
    if (init){
    color(colours[nSegments%len(colours)]) 
        hollow() ball();
        rotate([sin($t*720)*28,cos($t*360*4)*28,cos($t*360*2)*20])
            demo(false,nSegments-1);
    }
    else if (nSegments == 0){
        
    color(colours[nSegments%len(colours)]) 
        hollow() joint();
    }
    else {
        outerSphr= size+joint_spacing+joint_thickness;
        interh = sphereHeigth(size,baser); 
    color(colours[nSegments%len(colours)]) 
        hollow()        
            segment();
        translate([0,0,outerSphr+size-interh-sphereHeigth(outerSphr,baser)])
        rotate([sin($t*720)*28,cos($t*360*4)*28,cos($t*360*2)*20])
            demo(init,nSegments-1);
    }
}

module ball(size=size, baser=baser, baseh=baseh)
{
	sphere(r=size);
	translate([0,0,-size]) 
        cylinder(r2=sphereIntersection(size,baseh),r1=baser,h=baseh);
	translate([0,0,-size-baseh]) cylinder(r=baser,h=baseh);
}

function sphereIntersection(r,h) = sqrt(2*h*r-h*h);
function sphereHeigth(r1,r2) = r1- sqrt(r1*r1-r2*r2);

module joint(
    size=size, // inner ball radius
    baser=baser, // base radius
    base_invert= base_invert, //indicate if base should be extruded, or differenciated.
    lock_ratio= lock_ratio, // locking ratio, to work < 0.5
    lock_help_h= lock_help_h, // the height of the helper angle, 0 to disable
    joint_spacing = joint_spacing, // some space between them?
    joint_thickness = joint_thickness, // thickness of the arms
    joint_arms = joint_arms, // how many arms do you want?
    joint_arms_lenght_ratio=joint_arms_lenght_ratio, // relative length of arms
    arm_width = arm_width // inter-arm  space
)
{
    outerSphr= size+joint_spacing+joint_thickness;
    cutH=outerSphr*2*lock_ratio;
difference()
{
	sphere(r=outerSphr);
	sphere(r=size+joint_spacing);
	//bottom cut
    translate([0,0,-outerSphr])
        cylinder(r=sphereIntersection(outerSphr, cutH), h=cutH);
    // lock helper
    translate([0,0,-outerSphr + cutH])
        cylinder(
            r1=sphereIntersection(outerSphr, cutH), 
            r2=sphereIntersection(size+joint_spacing,cutH-joint_spacing-joint_thickness+lock_help_h), h=lock_help_h);
	
    //arms
    for(a=[0:360/joint_arms:360])
	{
		rotate([0,0,a]) translate([-arm_width/2,0, -outerSphr - (outerSphr*2-cutH)*(1-joint_arms_lenght_ratio)])
			cube([arm_width,outerSphr,outerSphr*2]);
	}
    if (base_invert){
        //Base
        baseh = sphereHeigth(outerSphr,baser); 
            translate([0,0,outerSphr-baseh]) cylinder(r=baser,h=baseh);
            
    }
}
    if(!base_invert){
        //Base
        baseh = sphereHeigth(outerSphr,baser);
        difference(){
            translate([0,0,outerSphr-baseh]) cylinder(r=baser,h=baseh);
            sphere(r=size+joint_spacing);
        }
    }
}

module segment(
    size=size, // inner ball radius
    baser=baser, // base radius
    lock_ratio= lock_ratio, // locking ratio, to work < 0.5
    lock_help_h= lock_help_h, // the height of the helper angle, 0 to disable
    joint_spacing = joint_spacing, // some space between them?
    joint_thickness = joint_thickness, // thickness of the arms
    joint_arms = joint_arms, // how many arms do you want?
    joint_arms_lenght_ratio=joint_arms_lenght_ratio, // relative length of arms
    arm_width = arm_width // inter-arm  space
)
{
    outerSphr= size+joint_spacing+joint_thickness;
    baseh = sphereHeigth(size,baser); 
    union(){
        joint(size,baser,true,lock_ratio, lock_help_h,joint_spacing,joint_thickness, joint_arms, joint_arms_lenght_ratio,arm_width);
        translate([0,0,outerSphr+size-baseh-sphereHeigth(outerSphr,baser)])
            difference(){
                sphere(r=size);
                translate([0,0,-size]) cylinder(r=baser,h=baseh);
            }
        }            
}

module hollow(hole_r=hole_r){
    difference(){
        children(0);
        cylinder(r=hole_r,h=1e3,center=true);
    }
}