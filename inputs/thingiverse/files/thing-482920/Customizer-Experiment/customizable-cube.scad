
//customizable cylinder


left_eye = 9; //[0:9]
right_eye = 9; //[0:9]

difference() 
{ 
union(){
translate([0,-25,-25]) 
	cylinder(60,10,10); 

translate([25,-25,-25]) 
	cylinder(60,10,10); 

translate([-25,-25,0])
rotate([0, 90, 0]) 
	cylinder(80,10,10);
}
translate([0,-5,0])
rotate([90,0,0]) 
	cylinder(40, left_eye, left_eye); 

translate([25,0,0])
rotate([90,0,0]) 
	cylinder(40, right_eye, right_eye); 

}




