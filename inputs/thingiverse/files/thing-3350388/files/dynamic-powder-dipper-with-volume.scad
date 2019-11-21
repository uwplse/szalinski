$fn=100;
//Volume in CC
V=2.5;
//Cup diameter in mm
d=15;
//Rim thickness of material.
rim=1.2;
//Outer chamfer.
chamfer=0.8;
//Handle length
length=100;
//Handle width
width=10;
// Text Font Size
fontsize=8;
//Volume in mm3
mm3=V*1000;
//Radius
r=d/2;
//Heigth of cylinder. Height=(Totalvolume-Halfsphere)/(cylinder area)
h=(mm3-2.1*r*r*r)/(3.14*r*r)+1; //One added to make sure it protrudes thru top.
echo(h);


module chamfered_hole(x,y,z,r,h,chamfer){
	translate([x,y,z])
rotate_extrude()
	polygon(points=[[0,-1],[r+chamfer,-1],[r+chamfer,0],[r,chamfer],[r,h-chamfer],[r+chamfer,h],[r+chamfer,h+1],,[0,h+1]]);	
}

module chamfered_cyl(x,y,z,r,h,chamfer){

translate([x,y,z])
rotate_extrude()
	polygon(points=[[0,0],[r-chamfer,0],[r,chamfer],[r,h-chamfer],[r-chamfer,h],[0,h]]);
	
}

module capacitytext(t, s = 6, style = "") {
  rotate([0, 180, 0])
    translate([-length/1.5,-fontsize/2,-1]){   
    linear_extrude(height = 1.5)
      text(t, size = s, font = str("Liberation Sans", style), $fn = 16);
}
}
if(h>0){
difference(){
rotate_extrude()
	polygon(points=[[r,0],[r+rim-chamfer,0],[r+rim,chamfer],[r+rim,h+rim-chamfer+r],[r+rim-chamfer,h+rim+r],[0,h+rim+r],[0,h],[r,h]]);
translate([0,0,h])
	sphere(r=r);
}
difference(){
	hull(){
		chamfered_cyl(0,0,0,3,6,chamfer);
		chamfered_cyl(0.4*length,width/2,0,3,2,chamfer);
		chamfered_cyl(0.4*length,width/-2,0,3,2,chamfer);
		chamfered_cyl(length,width/2,0,3,2,chamfer);
		chamfered_cyl(length,width/-2,0,3,2,chamfer);
	}
    capacitytext(str(V,"cc"), fontsize, ":style=Bold");
	translate([0,0,-1])
	cylinder(r=r,h=100);
	chamfered_hole(length-width/2,0,0,2,2.5,chamfer);

}

}


