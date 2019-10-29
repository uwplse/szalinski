
union(){
difference() {
cube([33,30,6], center=false); //Base
union() {
translate ([12,15,2.5])
cylinder (h = 10, r=6, center = false, $fn=50); //big Hole
translate ([12,15,-10])
cylinder (h = 20, r=3.5, center = false, $fn=50); //small Hole
translate ([15,15,8.5])
rotate([0,-2,0])
cube([40,40,6], center=true); //Slope
}
}
difference(){
union(){
//border
cube([33,3,11], center=false); //left
translate ([0,27,0])
cube([33,3,11], center=false); //right
translate ([30,0,0])
cube([3,30,13], center=false);//bottom

//upper Railing
translate ([0,0,9]) 
cube([33,5,4], center=false); //left
translate ([0,25,9])
cube([33,5,4], center=false); //right

translate ([16.5,2.9,9])
rotate([45,0,0])
cube([33,2.8,2.8], center=true); //left

translate ([16.5,30-2.9,9])
rotate([45,0,0])
cube([33,2.8,2.8], center=true); //right
}

translate ([15,15,13.5])
rotate([0,-2,0])
cube([40,40,6], center=true); //Slope
}
}
