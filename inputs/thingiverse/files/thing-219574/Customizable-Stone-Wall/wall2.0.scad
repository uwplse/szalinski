//Customizable Stone Wall
//Created by Ari M. Diacou, January 2014 (updated February, 2014)
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

// preview[view:south east, tilt:side]
/*[Wall]*/
//Length of a stone
U=3;
//Thickness of wall
V=2;
//Height of a stone
W=1;
//Number of stones along wall
num_x=4;
//The wall height in number of stones
num_z=6;
//A way to save the arrangement of stones
master_seed=14;
//Higher angles make more wedge-shaped stones, lower angles produce blocks. Reccomend 5-30 (zero crashes).
maximum_rotation_angle=12;
//Higher rotation angles might need more compression
z_compression=0.9;
//Number of cubes that make up a block
n=8; 
//A way to reduce the abilty of higher n to chop up a block (should be -2 to 0)
power=0;


/*[Mortar]*/
//Do you want mortar between the stones?
mortar=1; //[1,0]
//What percentage of a brick do you want the mortar in the running direction?
u_adjust=-0.15;
//How much of the wall's thickness do you want the mortar to take up?
v_ratio=0.5;

/*[Base]*/
//Do you want a base for the wall
base=1; //[1,0]
//What percentage of a brick do you want the base to extend from the wall in the running direction?
bx_adjust=0.1;
//What percentage of a brick do you want the base to extend in the front and back of the wall?
by_adjust=0.1;
//What percentage of a brick do you want the base's height to be?
bz=.5;

/*[Hidden]*/
dimensions=[U,V,W];
half_dimensions=[U/2,V,W];
wall();

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
					if(half_condtion(x, z, num_x)){
						translate([U*(x+0.5-0.25), 0,z*W*z_compression]) 
							color("SlateGray")
								rock(half_dimensions,maximum_rotation_angle,num_x*z+x+master_seed);
						} else {
						translate([U*(x+0.5-0.25*(1+pow(-1,z))), 0,z*W*z_compression]) 
							color("SlateGray")
								rock(dimensions,maximum_rotation_angle,num_x*z+x+master_seed);
						}
					}
				}
			translate([-0.25*U,-V/1.3,-W])
				cube([U*num_x,V*1.5,W]);
			}
		if(mortar==1){
			translate([(-u_adjust)*U,-V*v_ratio/2,0])
				color("silver")
					cube([(num_x-0.5+2*u_adjust)*U,V*v_ratio,W*(num_z-1)*z_compression]);
			}
		if(base==1){
			translate([-bx_adjust*U,-(.5+by_adjust)*V,-W*(bz-0.01)])
				color("green")
					cube([U*(num_x-0.5+2*bx_adjust),V*(1+2*by_adjust),W*bz]);
			}
		}
	}

function half_condtion(i, j, num_i)=((i==0 && j%2==0) || (i==num_i-1 && j%2==1));

