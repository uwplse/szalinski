//A way to save your "random" arrangement
seed=74;				
//Number of crystals
num=10;							
//Width of crystals
wide=1;
//Height of each crystal
high=6;
//Number of sides on each crystal
side=6;
//Lower numbers will have shorter outer crystals
dropoff=.8;
//Overhang angle of the outermost crystals
bouquet_angle=30;
//The density of the crystals
density=10;
R_max=wide*num/density;
angle=rands(0,360*10,num+1,seed);
rad=rands(0,R_max,num+1,seed);
hyp=R_max/sin(bouquet_angle);
adj=R_max*cos(bouquet_angle)/sin(bouquet_angle);
difference(){
	union(){
	translate([0,0,-2*adj+hyp]) 
		sphere(hyp,$fn=3*side);
	for(i=[1:num]){
		translate([rad[i]*cos(angle[i]),rad[i]*sin(angle[i]),0]) 
			rotate([-bouquet_angle*sin(angle[i])*rad[i]/R_max,bouquet_angle*cos(angle[i])*rad[i]/R_max,0])
				crystal(side,high*exp(-pow((rad[i]/(dropoff*R_max)),2)),wide/2,(high)/10);
		}
	}
	translate([0,0,-hyp]) 
		cube(2*hyp,true);
	}

module crystal(sides, height, width, taper_height){
	cylinder(height,width,width,$fn=sides);
	translate([0,0,height]) 
		cylinder(taper_height,width,width/2,$fn=sides);
	}
