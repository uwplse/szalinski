//Outside Sphere Diameter
OD=50;//[45:60]
//Inside Sphere Diameter
ID=120;//[95:120]
//min/max:[95:115];

difference(){
difference(){
sphere(OD,$fn=10);

//to make the bottom flat
translate([0,0,-50])
cube([200,200,60],center=true);
}
//To make inside of plate
translate([0,0,95])
sphere(ID,$fn=10);
}
