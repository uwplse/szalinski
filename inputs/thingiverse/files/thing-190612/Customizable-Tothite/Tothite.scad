//Customizable Tothite
//Inspired by "Giant Crystal" (http://www.thingiverse.com/thing:189703) by Tothe (http://www.thingiverse.com/Tothe/designs)
//Using modified code written by me in (http://www.thingiverse.com/thing:142079)
//Created by Ari M. Diacou, November 2013
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/


//A way to save your "random" arrangement
seed=5;				
//Number of crystals
num=8;							
//Minimum width of crystals
min_width=.5;
//Minimum width of crystals
max_width=3;
//Height of each crystal
high=6;
//Number of sides on each crystal
num_sides=6;
//Lower numbers will have shorter outer crystals
dropoff=.8;
//Overhang angle of the outermost crystals
bouquet_angle=40;
//The density of the crystals
density=10;
//For fine-tuning the width of the base
base_width=7; //[0:10]

R_max=(.1*base_width*max_width+.1*(10-base_width)*min_width)*num/density;
angle=rands(0,360*10,num+1,seed); //The azimuthal angle that the axis of the crystal will be at
crystal_length=rands(0,R_max,num+1,seed+2); 
crystal_width=rands(min_width,max_width,num+1,seed+1);
hyp=R_max/sin(bouquet_angle);
adj=R_max*cos(bouquet_angle)/sin(bouquet_angle);
difference(){
	union(){
		translate([0,0,-2*adj+hyp]) 
			sphere(hyp,$fn=3*num_sides);
		for(i=[1:num]){
			translate([crystal_length[i]*cos(angle[i]),crystal_length[i]*sin(angle[i]),0]) 
				rotate([-bouquet_angle*sin(angle[i])*crystal_length[i]/R_max,bouquet_angle*cos(angle[i])*crystal_length[i]/R_max,0])
					crystal(num_sides,high*exp(-pow((crystal_length[i]/(dropoff*R_max)),2)),crystal_width[i]/2,crystal_width[i]/2);
		}
	}
	translate([0,0,-.5*max_width*hyp]) 
		cube(max_width*hyp,true);
	}

module crystal(sides, height, width, taper_height){
	cylinder(height,width,width,$fn=sides);
	translate([0,0,height]) 
		cylinder(taper_height,width,0*width/2,$fn=sides);
	}