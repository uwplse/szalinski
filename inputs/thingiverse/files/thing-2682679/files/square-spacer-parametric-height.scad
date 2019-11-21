//Parametric Spacer block for FTC
//Alissa Jurisch
//11/28/2017
//rev 2


//thickness of spacer in mm
x=8; //thickness of spacer in mm


module screw_hole(){
translate([8,0,-32.5]){
    cylinder(d=4.5,h=65, $fn=20);
}
}
module hub(){
    translate ([0,0,-32.5]) {
    cylinder(d=8, h=65, $fn=20);
}
}
 // creates screw and hub holes 
module flower(){
for (i=[0 :45: 360]) //90 for 4 holes 45 for 8 holes.
    rotate(i,[0,0,1]){
screw_hole();
    }
    
hub();    
}
//creates a spindle with one side open for chain pulley
module pulley(){  
    cylinder (d=25,h=14, $fn=60, center=true);
    translate([0,0,-7]){
    cylinder (d=50,h=3, $fn=60, center=true);
}}


//spacer with holes cut out
     difference(){
    cube ([30,30,x], center=true); //30mm is just under the 32mm the tetrix block size
         flower();
         translate([6,8,x/2])
    linear_extrude(5)
        text(str(x), size = 5); //converts thickness into text
     }
