//Rain Gauge Extension
//Designed by Bryscus: Bryce B.

//Most measurements are for the inside dimensions
//since in this case those are the dimensions
//that really matter.

//Height
H=38.1;

//Wall thickness
W=3;    

//Inside Corner radius
R=5.08; 

//Inside Length
L=109.5;

//Inside Width
B=49.5;

difference(){
translate([R+W,R+W,0]) 
minkowski(){
	cube([L-2*R,B-2*R,H/2]); // Outside
	cylinder(r=R+W, h=H/2,$fn=60);
	}
translate([R+W,R+W,-1]) 
minkowski(){
	cube([L-2*R,B-2*R,H/2]); // Inside
	cylinder(r=R, h=H/2+2,$fn=60);
	}
}

//cube([115.5,55.5,H]); //Minkowski Sanity Check
//Since Minkowski does weird things, this is a
//way to guarantee that the dimensions sought
//after are what we actually get