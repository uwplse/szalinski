//Customizable Interlocking Stone Wall
//Created by Ari M. Diacou, June 2016
//Edited version of Customizable Stone Wall (http://www.thingiverse.com/thing:219574)
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

// preview[view:south east, tilt:side]
/*[Wall]*/
//Length of a stone
stone_length=4;
//Height of a stone
stone_height=1.7;
//Number of stones along wall
run_of_stones=6;
//The wall height in number of stones
stack_of_stones=4;
//Higher angles make more wedge-shaped stones, lower angles produce blocks. Reccomend 5-30 (zero crashes).
maximum_rotation_angle=6; //[3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
//Higher rotation angles might need more compression
z_compression=1;
//Facets per face of each stone (this will increase filesize dramatically)f
Facets_Per_Face=7; 
//A way to reduce the abilty of higher n to chop up a block (should be -2 to 0)
power=0; //[0,-0.1,-0.2,-0.3,-0.4,-0.5,-0.6,-0.7,-0.8,-0.9,-1,-1.1,-1.2,-1.3,-1.4,-1.5,-1.6,-1.7,-1.8,-1.9,-2]
//A way to save the arrangement of stones
master_seed=4;

/*[Hidden]*/
//What percentage of a brick do you want the mortar in the running direction?
u_adjust=-0.52;
//How much of the wall's thickness do you want the mortar to take up?
v_ratio=0.5;
stone_color="SlateGray";
mortar_color="Silver";
///////////////////// Derived Parameters //////////////////////////
//Thickness of wall
stone_thickness=stone_length/2;
n=Facets_Per_Face;
num_x=floor(run_of_stones)+1;
num_z=stack_of_stones>2?floor(stack_of_stones):2;
dimensions=[stone_length,stone_thickness,stone_height];
half_dimensions=[stone_length/2,stone_thickness,stone_height];
total_length=stone_length*(num_x-.5); 
total_height=stone_height*z_compression*(num_z-.5); 

echo(str("total length=",total_length," mm"));
echo(str("total height=",total_height," mm"));
echo(str("thickness=",stone_thickness," mm"));
echo(str("Suggested Filename: Interlocking Wall ", num_x,"x",num_z," s=",stone_length,"x",stone_height," ",option_string_2));
option_string_1=str("o=",maximum_rotation_angle,".",z_compression,".",n,".",power,".",master_seed);
option_string_2=str("r",maximum_rotation_angle,"zc",z_compression,"n",n,"p",power,"ms",master_seed);
option_string_3=str("Max Rotation=",maximum_rotation_angle,", Z compression ratio=",z_compression,", Facets per face=",n,", Power=",power,", Master Seed=",master_seed);
echo(option_string_3);
/////////////////////////// Main() ////////////////////////////////
translate([-total_length/2,0,0]) wall();
//Uncomment the code below to check if your walls will interlock properly
////Angled Wall
//translate([total_length/2-.40*stone_length,-stone_thickness/4,0]) rotate([0,0,45]) wall();
////Purpendicular Wall
//translate([-total_length/2+stone_thickness/2,total_length-stone_length/4,0]) rotate([0,0,90]) mirror([1,0,0]) wall();
///////////////////////// Functions ///////////////////////////////
module rock(unit_dimension, max_rotation, seed){
    random=rands(-1,1,n*3,seed);
		intersection(){
			intersection_for(i=[0:n-1]){
				rotate([	max_rotation*random[3*i+0]*pow(i,power),
							max_rotation*random[3*i+1]*pow(i,power),
							max_rotation*random[3*i+2]*pow(i,power)])
					cube(unit_dimension, center=true);
					}
			}	
	}

module wall(){
	union(){
		difference(){
			for(z=[0:num_z-1]){
				for(x=[0:num_x-1]){
					if(!half_condtion(x, z, num_x)){
						translate([stone_length*(x+0.5-0.25*(1+pow(-1,z))), 0,z*stone_height*z_compression]) 
							color(stone_color)
								rock(dimensions,maximum_rotation_angle,num_x*z+x+master_seed);
						}
					}
				}
            //Block that removes the bottom half of the bottom layer of stones
			translate([-0.25*stone_length,-stone_thickness/1.3,-stone_height])
				cube([stone_length*num_x,stone_thickness*1.5,stone_height]);
			}
			//Mortar
            translate([(-u_adjust)*stone_length,-stone_thickness*v_ratio/2,0])
				color(mortar_color)
					cube([(num_x-0.5+2*u_adjust)*stone_length,stone_thickness*v_ratio,stone_height*(num_z-1)*z_compression]);
		}
	}

function half_condtion(i, j, num_i)=((i==0 && j%2==0) || (i==num_i-1 && j%2==1));