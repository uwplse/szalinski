//bummster's hubba hubba file.
//v1 August 15, 2015.
//ask me questions about this file through the thingiverse comments @ http://www.thingiverse.com/thing:969819


//This is how to get the library for the build plate visual.
include <utils/build_plate.scad>

//CUSTOMIZER VARIABLES  <-- this doesn't seem to do a darn thing.  
//  Provide a radius for the small diameter cylinder.  It's the one on the bottom.  All dimensions are in mm.
Smaller_Axle_Radius=8;

//  How tall should the small diameter cylinder be?
Smaller_Axle_Height=7;

//  How large of a flat should the small diamenter cylinder have against it?
Smaller_Axle_Flat = 1;

//  Provide a Radius for the larger diameter cylinder.  It's the one on the top
Larger_Axle_Radius=19;

//  How tall should the larger diameter cylinder be?
Larger_Axle_Height=30;

//  How wide should the flange be against the larger cylinder?  The flange sits against the face of whatever this is potentially fit into.
flange_width=1;

//  How tall should this flange be?
flange_height=1;

//  How far apart are the two things from each other?  This will help determine the shape of the cone between the two cylinders.  The cone height plus the flange height equals this number.
how_far_apart_are_they = 10;

//Gotta use the callout like below to get a menu tab to appear.
/* [Make it hollow] */

//  Do you need this to be hollow?
i_need_it_hollow = 2; //[0:No,1: Hollow enough for a rod,2:Like a shell]

//  For Hollow enough for a rod:  What rod radius do you need?
rod_radius = 3;

//  For Like a shell: What shell thickness do you need?  It should be smaller than the radius of the small cylinder if you want a hole through the entire thing.  Values larger than the radius of the small cylinder will give you a flat at the same plane as the flange.
shell_thickness = 1;

/* [Build Plate Reference] */

//	This section creates the build plates for scale
//	for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//	when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//	when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

//Gotta use the callout like below to hide variables.  Really annoying when you don't know how to do this.
/* [Hidden] */
$fa=0.5;
$fs=0.5;

var_cone_angle_percentage = 1;
var_cone_height_offset = 1;
//  How tall should the conical profile be that joins the two axles?
cone_height = how_far_apart_are_they - flange_height;

//CUSTOMIZER VARIABLES END <-- this doesn't seem to do a darn thing.

//	This is just a Build Plate for scale
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

if (i_need_it_hollow == 0) {
    
//here's the initial axle_a being created
cylinder(r=Smaller_Axle_Radius,h = Smaller_Axle_Height);

//here's the cone being created.  the cone goes from the r of axle_a to the r of axle_b plus whatever the flange width is.
translate([0,0,Smaller_Axle_Height]) cylinder(r1=Smaller_Axle_Radius+Smaller_Axle_Flat, r2=Larger_Axle_Radius+flange_width, h=cone_height);

//now we are going to create the flange itself.
translate([0,0,Smaller_Axle_Height+cone_height]) cylinder(r=Larger_Axle_Radius+flange_width,h=flange_height);

//and now we are creating the the final axle b
translate([0,0,Smaller_Axle_Height+cone_height+flange_height]) cylinder(r=Larger_Axle_Radius,h=Larger_Axle_Height);
}
if (i_need_it_hollow == 1) {
    difference(){
        //This is the same stuff as i_need_it_hollow == 0
        union(){
            cylinder(r=Smaller_Axle_Radius,h = Smaller_Axle_Height);
            translate([0,0,Smaller_Axle_Height]) 
                cylinder(r1=Smaller_Axle_Radius+Smaller_Axle_Flat, r2=Larger_Axle_Radius+flange_width, h=cone_height);
            translate([0,0,Smaller_Axle_Height+cone_height]) 
                cylinder(r=Larger_Axle_Radius+flange_width,h=flange_height);
            translate([0,0,Smaller_Axle_Height+cone_height+flange_height])
                cylinder(r=Larger_Axle_Radius,h=Larger_Axle_Height);
        }
        //Here's the rod cylinder that we'll use to make the difference function work.
        translate([0,0,-rod_radius/10])
            cylinder(r=rod_radius,h=Smaller_Axle_Height + Larger_Axle_Height + flange_height + cone_height + rod_radius);
    }
}
if (i_need_it_hollow == 2) {
    //if(shell_thickness > Smaller_Axle_Radius)
    difference(){
        //This is the same stuff as i_need_it_hollow == 0
        union(){
            cylinder(r=Smaller_Axle_Radius,h = Smaller_Axle_Height);
            translate([0,0,Smaller_Axle_Height]) 
                cylinder(r1=Smaller_Axle_Radius+Smaller_Axle_Flat, r2=Larger_Axle_Radius+flange_width, h=cone_height);
            translate([0,0,Smaller_Axle_Height+cone_height]) 
                cylinder(r=Larger_Axle_Radius+flange_width,h=flange_height);
            translate([0,0,Smaller_Axle_Height+how_far_apart_are_they])
                cylinder(r=Larger_Axle_Radius,h=Larger_Axle_Height);
        }
        //Here is the void we want to make.  What we're going to do is ignore the flange and assume it's part of the cone itself.  That leaves us with 3 objects to make the void and give us a smooth inner surface with a nice sharp transition with no steps.
        var_cone_angle_percentage = atan(how_far_apart_are_they/(Larger_Axle_Radius - Smaller_Axle_Radius)) / 90;
        //echo("the var_cone_angle_percentage value is ", var_cone_angle_percentage);
        var_cone_height_offset = shell_thickness * var_cone_angle_percentage;
        //echo("the var_cone_height_offset value is ", var_cone_height_offset);
        
        union(){
        translate([0,0,-shell_thickness/10])
            cylinder(r=Smaller_Axle_Radius - shell_thickness, h=Smaller_Axle_Height+shell_thickness/10 + var_cone_height_offset+shell_thickness);
        translate([0,0,Smaller_Axle_Height + var_cone_height_offset]) 
            cylinder(r1=Smaller_Axle_Radius - shell_thickness, r2=Larger_Axle_Radius - shell_thickness, h=how_far_apart_are_they);
        if (var_cone_angle_percentage == 0) {
            //echo ("i'm in here and Smaller_Axle_Height + how_far_apart_are_they + shell_thickness is ", Smaller_Axle_Height + shell_thickness);
            translate([0,0,Smaller_Axle_Height + how_far_apart_are_they + shell_thickness])
            cylinder(r=Larger_Axle_Radius - shell_thickness,h=Larger_Axle_Height+shell_thickness);
        }
        else {
            translate([0,0,Smaller_Axle_Height + how_far_apart_are_they + var_cone_height_offset])
            cylinder(r=Larger_Axle_Radius - shell_thickness,h=Larger_Axle_Height+shell_thickness);
        }
        }
    }
}