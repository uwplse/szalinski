//Alissa Jurisch
//Cam for FTC robot
//1-12-18
//Rev 2

//radius 1
radius_large = 50;
//radius 2
radius_small = 25;
//width of cam
cam_width = 35;
//offset of bolt pattern from center radius 
offset = 20;
//depth of cutout
cutout = 20;



//creates screw hole
module screw_hole(){
translate([8,0,-32.5]){
    cylinder(d=4,h=65, $fn=20);
}
}
//creates oval for cam
module oval(w,h, height, center = false,$fn=50) {
 scale([1, h/w, 1]) cylinder(h=height, r=w, center=center);
}
//creates hub hole
module hub(){
    translate ([0,0,-32.5]) {
    cylinder(d=8, h=65, $fn=20);
}
}
//creates whole flower, chose 45 for 8 holes, 90 for 4 holes
module flower(){
for (i=[0 :90: 360])
    rotate(i,[0,0,1]){
screw_hole();
    }
    
hub();    
}
//creates pulley without holes and only one side
module pulley(){
    cylinder (d=50,h=35, $fn=60, center=true);
translate([0,0,-19]){
    cylinder (d=60,h=3, $fn=60, center=true);
}}
//creates holes in pulley
difference(){
//pulley();
  oval(radius_large,radius_small,cam_width,$fn=60, center=true);  
    translate([15+offset,0,0]){
        cylinder(d=25,h=cutout, $fn=20);
            flower();
    }
}
