//Customizable Rock Climbing Hold v1.2
//v1 had 125 views and 11 downloads
//v1.1 had 16 views and 4 downloads
//Created by Ari M. Diacou, October 2014
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

// preview[view:north west, tilt:top diagonal]

//Maximum(ish) size of hold in mm
Dmax=120;
//Changes hold thickness based on climb difficulty
difficulty=5.7;//[5.4,5.5,5.6,5.7,5.8,5.9,"5.10"]
//A way to save your random arrangement
seed=20;
//Diameter of the socket wrench you will tighten your bolt with in mm
head_diameter=26;
//Diameter of the hole that the bolt will fit into in mm
bore_diameter=10;
//number of spheres
n=12;
//Parameter for scaling of element sizes (smaller makes spikier rocks)
a=7;//[1:10]
//Changes curviness of rocks ($fn= 4 or 20) and adds an uncut reference rock
testing_mode=false;

                 /*[Hidden]*/

///////////////// Variables ///////////////////////
Rmax=Dmax/2;
vector=rands(0,1,3*n,seed);
//Figures how thin to make the hold based on the desired difficulty of the route
z_adjustment = (difficulty=="5.10" || difficulty-5.1<.04) ? 
	-0.4 :
	(difficulty-5.7)*(-4/3);
//Use lower resolution in testing mode for speed
$fn= testing_mode ? 4 : 20;

///////////////////Main()/////////////////////////
hold(vector);

//A bunch of other testing/debugging options
if(testing_mode){
	//Reference copy, uncomment to see whole rock
	translate([3*Rmax,0,0]) rock(vector);
	translate([3*Rmax,0,0]) show_space();
	echo(str("For difficulty of ",difficulty," the z adjustment is: ",z_adjustment));
	}

/////////////////Functions///////////////////////
module hold(vector_of_n_random_triplets){
	difference(){
		translate([0,0,Rmax*z_adjustment])
			rock(vector_of_n_random_triplets);
		//Remove the bottom to give a flat base
		translate([0,0,-Rmax*1.5]) 
			cube(Rmax*3,center=true);
		//Drill a hole for the bolt
		cylinder(r=bore_diameter/2,h=4*Rmax,center=true,$fn=20);
		//Counter-sink for the bolt head
		translate([0,0,Rmax*(0.5+z_adjustment)]) //0.68 is an average because I cant 
			if(testing_mode){
				#cylinder(r=head_diameter/2,h=Rmax,$fn=20);}
			else{
				cylinder(r=head_diameter/2,h=Rmax,$fn=20);}
		}
	}

module rock(vector_of_n_random_triplets){
	v=vector_of_n_random_triplets;
	hull(){
		for(i=[0:n-1]){ //For each i, pass a triplet to module element()
			element([v[i],v[i+1],v[i+2]]);
			}
		}
	}

module element(v){
	//Sets up a sphere of radius R randomly placed in a cylinder
	//a triplet of random [0,1] numbers are converted to a cylindrical triplet
	//the cylinder has a radius of Rmax, and a height of Rmax

	//Coordinates of a sphere in cylindrical coordinates
	r=Rmax*v[0]; 
	theta=360*v[1]; 
	z=(v[2]-0.5)*Rmax;
	//But OpenSCAD thinks in cartesian
	y=r*sin(theta);
	x=r*cos(theta);
	/*We have to wrap/hull() all of these spheres to make a rock. To make it aesthetically convincing, spheres at the edges of the allowed range should be smaller than those placed towards the center. I chose a gaussian distribution of sphere radius as a function of r/Rmax, which is simply v[0]. */
	R=.5*Rmax*exp(-v[0]*v[0]/(a/10));
	translate([x,y,z]) sphere(R);
	}

module show_space(){ 
	//makes a transparent highlighted cylinder spanning the space that
	//element()s can be placed in.
	%# cylinder(2*Rmax,r=Rmax,center=true, $fn=40);
	}