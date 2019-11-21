thickness			=	3.175;
wall_thickness	=	6;
screw_size			=	3;
width					= 20;
height					=	20;

translate([-height/2,-width/2,0]) difference(){
	cube([height,width,wall_thickness]);
	translate([wall_thickness,-1,wall_thickness-thickness]) cube([100,100,thickness]);
	translate([screw_size,width/2,0]) cylinder(d=screw_size, h=height, $fn=50);
	#translate([screw_size,width/2,0]) sphere(d=screw_size+1,  $fn=50);
}