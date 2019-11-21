//Customizable TerraTile Road Tile
//Created by Ari M. Diacou, July 2015
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

// preview[view:south east, tilt:top diagonal]
/*[Stones]*/
//Length of a block that makes a stone
U=7;
//Thickness of a block that makes a stone
V=6;
//Height of a a block that makes a stone
W=5;
//A way to save the arrangement of stones
master_seed=5;
//Higher angles make more wedge-shaped stones, lower angles produce blocks. Reccomend 5-30 (zero crashes).
maximum_rotation_angle=30;
//Number of cubes that make up a block. Changes the number of facets on a stone.
n=8; 
//A way to reduce the abilty of higher n to chop up a block (should be -2 to 2)
power=0.4;

inch=25.4+0; //most g-code compliers intercpret 1 unit = 1 mm.
inches=inch;

/*[Path Surface]*/
//How many stones do you want?
num_stones=16;
//What is the width of your path?
path_width=46;
//How high is the top part of the path?
path_rise=25.4;
//How far does the path extend?
path_run=100;

/*[Base]*/
//How much bigger than the top of the path should the base be?
base_base_ratio=2;

/*[Hidden]*/
//////////////////////// Parameters ////////////////////////////////////////////
dimensions=[U,V,W];
half_dimensions=[U/2,V,W];
//inches and inch defined above
incline=atan(path_rise/path_run); echo(str("incline angle = ",incline," degrees."));
path_length=path_rise/sin(incline);

/////////////////////////// Main() /////////////////////////////////////////////
intersection(){
    bounding_box(); //cut off stones that are outside the bounding box
    translate([-0*path_run*(1-cos(incline)),0,path_rise/2]) //move the stones to the surface of the base
        rotate([0,incline,0]) //rotate the stones to the incline of the base
            color("dimgray") top_surface(); //the stones only
    }
color("sienna") base();  //the base
//////////////////////// Functions /////////////////////////////////////////////
module bounding_box(){
    //Cuts off stones that would make the ramp not lie flat
    fudge=max(dimensions);
    translate([-path_run/2,-path_width/2-fudge])
    cube([path_run+fudge,path_width+2*fudge,path_rise+fudge]);
    }
module base(){
    //The base is made by wrapping a hull around 3 horizontal rods
    hull(){
        translate([path_run/2,0,0]) rod(path_width);
        translate([-path_run/2,0,0]) rod(path_width*base_base_ratio);
        translate([-path_run/2,0,path_rise]) rod(path_width);
        }
    }
module rod(l,d=.01){ 
    //creating a function "rod" made typing and legibility easier
    rotate([90,0,0])
        cylinder(r=d/2,h=l,center=true);
    }
module top_surface(seed=master_seed){
    //Puts a whole bunch of stones on the top part of the ramp
    random=rands(-1,1,num_stones*3+1,seed);
    for(i=[0:num_stones-1]){
        rotation_triplet=90*[random[i+0],random[i+1],random[i+2]];
        translation_triplet=[0.5*path_length*random[i+1],0.5*path_width*random[i+2],0];
        translate(translation_triplet)
            rotate(rotation_triplet)
                stone(dimensions, 12, seed+i);
        }
    }
module stone(unit_dimension, max_rotation, seed){
    //Makes a single stone by the intersection of n cubes rotated by a random amount.
	random=rands(-1,1,n*3,seed);
        intersection_for(i=[0:n-1]){
            rotate([	max_rotation*random[3*i+0]*pow(i,power),
                        max_rotation*random[3*i+1]*pow(i,power),
                        max_rotation*random[3*i+2]*pow(i,power)])
                cube(unit_dimension, center=true);
            }
	}