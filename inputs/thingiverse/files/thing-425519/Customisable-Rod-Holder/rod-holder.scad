//default profile thickness
t=3;
//Diameter of rod to be held
d=11.5;
//extra clearance to be provided to account for thicker than design extrusions (to make up for 3D printer tolerances). This is applied as an extra clearance on all internal openings including screw holes.
clearance=0.25;
//Length of top and bottom sides of the C shaped clamp
l=30;
//Width between the top and bottom sides of the C shaped clamp. i.e. the thickness of the wall/plate/etc to which the bracket is being clamped.
w=21.6;
//Height of the clamp and rod holder. A short clamp will only have 1 screw hole, a long clamp will have 3.
h=60;
//Diameter of the screws (bolts) to be used to pressure the clamp
Dscrew=5;
//thickening factor applied to strengthen the bracket. The higher the factor, the stronger the clamp will be able to be tightened.
n=1.5;



difference() {

union(){ //start solids group
cube([t,n*t+4*clearance+t/2,h]);

cube([l+n*t,n*t,h]);

translate([t+4*clearance,n*t+4*clearance,0]) {
  cube([l-t-4*clearance,t/2,h]);
}

translate([(l+n*t)/2,n*t+4*clearance+t/2+w+n*t+d/2,0]) {
  cylinder(h = h, d=d+2*t);
}

translate([l,n*t,0]) {
  cube([n*t,4*clearance+t/2+w,h]);
}

translate([0,n*t+4*clearance+t/2+w,0]) {
  cube([l+n*t,n*t,h]);
}
translate([(l+n*t-(d+2*t))/2,n*t+4*clearance+t/2+w,0]) {
  cube([d+2*t,d/2+n*t,h]);
}

}//end solids group




union(){//start cut group

translate([(l+n*t)/2,n*t+4*clearance+t/2+w+n*t+d/2,t]) {
  cylinder(h = h-t, d=d+2*clearance);}
}


if(h>=15*Dscrew){
translate([(l+n*t)/2,0,0.25*h]) {
	rotate([-90,0,0]){
	  cylinder(h = n*t, d=Dscrew-0.6+2*clearance);}
	}
translate([(l+n*t)/2,0,0.5*h]) {
	rotate([-90,0,0]){
	  cylinder(h = n*t, d=Dscrew-0.6+2*clearance);}
	}
translate([(l+n*t)/2,0,0.75*h]) {
	rotate([-90,0,0]){
	  cylinder(h = n*t, d=Dscrew-0.6+2*clearance);}
	}
}else if(h>=10*Dscrew){
translate([(l+n*t)/2,0,0.25*h]) {
	rotate([-90,0,0]){
	  cylinder(h = n*t, d=Dscrew-0.6+2*clearance);}
	}
translate([(l+n*t)/2,0,0.75*h]) {
	rotate([-90,0,0]){
	  cylinder(h = n*t, d=Dscrew-0.6+2*clearance);}
	}
}else if(h>=2.5*Dscrew){
translate([(l+n*t)/2,0,h/2]) {
	rotate([-90,0,0]){
	  cylinder(h = n*t, d=Dscrew-0.6+2*clearance);}
	}
}


if(h>=15*Dscrew){
translate([(l+n*t)/2,n*t+4*clearance+t/2+w+n*t+d/2,0.25*h]) {
	rotate([-90,0,0]){
	  cylinder(h = t+d, d=Dscrew-0.6+2*clearance);}
	}
translate([(l+n*t)/2,n*t+4*clearance+t/2+w+n*t+d/2,0.5*h]) {
	rotate([-90,0,0]){
	  cylinder(h = t+d, d=Dscrew-0.6+2*clearance);}
	}
translate([(l+n*t)/2,n*t+4*clearance+t/2+w+n*t+d/2,0.75*h]) {
	rotate([-90,0,0]){
	  cylinder(h = t+d, d=Dscrew-0.6+2*clearance);}
	}
}else if(h>=10*Dscrew){
translate([(l+n*t)/2,n*t+4*clearance+t/2+w+n*t+d/2,0.25*h]) {
	rotate([-90,0,0]){
	  cylinder(h = t+d, d=Dscrew-0.6+2*clearance);}
	}
translate([(l+n*t)/2,n*t+4*clearance+t/2+w+n*t+d/2,0.75*h]) {
	rotate([-90,0,0]){
	  cylinder(h = t+d, d=Dscrew-0.6+2*clearance);}
	}
}else if(h>=2.5*Dscrew){
translate([(l+n*t)/2,n*t+4*clearance+t/2+w+n*t+d/2,h/2]) {
	rotate([-90,0,0]){
	  cylinder(h = t+d, d=Dscrew-0.6+2*clearance);}
	}
}

}//end cut group