//Stand for Depth Guage
//Ari M. Diacou
//Created Jan 16, 2016
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/


//Measure the widest part of the base of your depth guage.
depth_guage_width = 52.8;
//Measure the base of your depth guage in a direction perpendicular to the distance measured above.
depth_guage_length = 7;
//How much could the depth guage be recessed into the block (and still lie flat)?
depth_guage_depth = 4.2;
//By what height does the bridge have to clear the belt above the top of the rails?
clearance=3.4;
//How high should this block be?
block_height = 12;
//What is the diameter of your depth guage pin (plus a tolerance)?
hole_diameter = 4.8;
//Measure the distance between your rails.
inner_rail_distance = 62.1;
//Measure the distance between the outsides of your rails.
outer_rail_distance = 77.7;

// preview[view:south east, tilt:top]

/* [Hidden] */
//////////////// Derived Parameters ////////////////////////
rail_diameter=(outer_rail_distance-inner_rail_distance)/2;
ep=0+0.05; //epsilon, a small number, used for overlaps
block=[depth_guage_length*2, outer_rail_distance+rail_diameter, block_height];
inner_height=rms([block_height,clearance+depth_guage_depth+rail_diameter/2,clearance+depth_guage_length/2+rail_diameter/2])-rms([depth_guage_length/2,depth_guage_depth]);
//Tries to make an estimate of the thickenss of the "bridge". Should be thick enough that the bridge will not bend while taking readings.
echo(str("block height = ",block_height));
echo(str("inner height = ",inner_height));


cutout=[block[0]+2*ep,inner_rail_distance-rail_diameter,inner_height];

////////////////////// Main() /////////////////////////////
type1();
//////////////////// Functions ////////////////////////////
function rms(list)=norm(list)/sqrt(len(list));
module centered_cube(block){
    translate(-0.5*block+[0,0,.5*block[2]])
        cube(block);
    }
module type1(){
    difference(){
        outer();
        rails();
        inner();
        hole();
        }
    }
module outer(){
    centered_cube(block);
    }
    
module inner(){
    translate([0,0,-ep])
        centered_cube(cutout);
    }

module rails(){
    dist=[0,inner_rail_distance/2+rail_diameter/2,0];
    rotate([0,90,0])
        translate(dist)
            cylinder(d=rail_diameter,h=block[0]+ep, center=true);
    rotate([0,90,0])
        translate(-dist)
            cylinder(d=rail_diameter,h=block[0]+ep, center=true);
    }
module hole(){
    cylinder(h=block[2]+ep,d=hole_diameter);
    }
module recess(){
    
    }