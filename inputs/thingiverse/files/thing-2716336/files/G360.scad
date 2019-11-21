//detils quality
mult=2;//[0.01:0.1:3]
//body quality
mult2=1.5 ;//[0.01:0.1:3]
/* [Hidden] */
//main body
 difference(){
intersection(){
{
translate([0,0,26.2])rotate([0,90,0])bod();
color([1,1,1]*0.3)translate([0,0,30])cube([70,70,60],center=true);
}}
color([1,1,1]*0.3)translate([0,0,-0.01])cylinder(8,4,4, $fn=24*mult);
color([1,1,1]*0.3)translate([0,9,-0.01])cylinder(8,1.5,1.5, $fn=24*mult);
color([1,1,1]*0.3)translate([0,-9,-0.01])cylinder(8,1.5,1.5, $fn=24*mult);

translate([0,0,26.2])
color([1,1,1]*0.65)union(){
intersection(){
 rotate([0,90,0])bodu(1);
rotate([0,0,-35])hull(){
rotate([90+3,0,0]) cylinder(32,0.5,0.5, $fn=6*mult);
rotate([90-3,0,0]) cylinder(32,0.5,0.5, $fn=6*mult);
}}



color([1,1,1]*0.05)intersection(){
 rotate([0,90,0])bodu(1);
rotate([0,0 ,40])hull(){
rotate([90+0,0,0]) cylinder(32,0.5,0.5, $fn=6*mult);
 }}
color([1,1,1]*0.05)intersection(){
 rotate([0,90,0])bodu(1);
rotate([0,0 ,-40])hull(){
rotate([-90+0,0,0]) cylinder(32,0.5,0.5, $fn=6*mult);
 }}
}
}



// lens assenly and bezel
translate([0,0,26.2])rotate([0,90,0]){
bez();
color([1,1,1]*0.6)lens();
 }

// body details
// 1/4 1/4 Screw Mount
color([1,1,1]*0.6)rotate_extrude( $fn=24*mult){offset(0.25,$fn=1)offset(-0.25)translate([2.5,0,0])square([1.5,8]);}

translate([0,0,26.2])union(){

// battery lid
color("white" ){ intersection(){
 rotate([0,90,0])bodu(0.2);
hull(){
rotate([-90+25,0,0]) cylinder(32,13,13, $fn=24*mult);
rotate([-90-0,0,0]) cylinder(32,13,13, $fn=24*mult);
rotate([-90-25,0,0]) cylinder(32,13,13, $fn=24*mult);
}}}
//side buttons
color([1,1,1]*0.92){intersection(){
 rotate([0,90,0])bodu(0.17);
hull(){
rotate([90+25,0,0]) cylinder(32,6,6, $fn=12*mult);
rotate([90-0,0,0]) cylinder(32,6,6, $fn=12*mult);
rotate([90-25,0,0]) cylinder(32,6,6, $fn=12*mult);
}}}



color("white" ) {intersection(){
 rotate([0,90,0])bodu(0.27);
union(){
rotate([90+25,0,0]) cylinder(34,5,5, $fn=12*mult);
rotate([90-25,0,0]) cylinder(34,5,5, $fn=12*mult);
}}}

//leds


 
 color("blue")  {
rotate([0,0,0])
rotate([90-0,0,0])translate([0,0,30])cylinder(0.4,0.5,0.5, $fn=6*mult);
 } 

color("red"){
intersection(){
 rotate([0,90,0])bodu(0.3);
rotate([32,0,0])
rotate([0,-45,0])hull(){
rotate([0,-3,0]) cylinder(32,0.5,0.5, $fn=6*mult);
rotate([0,+3,0]) cylinder(32,0.5,0.5, $fn=6*mult);
}}}

color("red"){
intersection(){
 rotate([0,90,0])bodu(0.3);
rotate([32,0,0])
rotate([0,45,0])hull(){
rotate([0,-3,0]) cylinder(32,0.5,0.5, $fn=6*mult);
rotate([0,+3,0]) cylinder(32,0.5,0.5, $fn=6*mult);
}}}
// top  panel
  //button
color([0.23,0.23,0.23] ) 
intersection(){
sphere(30.1+0.025,$fn=80*mult2 );
translate([0,0,30.1-2])cylinder(5,7,7);
}

color("red",,[0.2,0.2,0.2] )
intersection(){
sphere(30.1+0.03,$fn=80*mult2);
translate([0,0,30.1-3])cylinder(5,1,1, $fn=12*mult);
}

color([0.1,0.1,0.1] ) intersection(){
 rotate([0,90,0])bodu(0.005);
hull(){
rotate([0,0,0]) cylinder(32,8.5,8.5, $fn=12*mult);
rotate([0,14,0]) cylinder(32,8.5,8.5, $fn=12*mult);
rotate([0,28,0]) cylinder(32,8.5,8.5, $fn=12*mult);
}}

  //display
color([0.45,0.45,0.45] ) intersection(){
 rotate([0,90,0])bodu(0.01);

hull(){
rotate([0,25,0])translate([0,-5,0])cylinder(35, 1, 1,$fn=6*mult);
rotate([0,25,0])translate([0,5,0])cylinder(35, 1, 1,$fn=6*mult);
 rotate([0,35,0])translate([0,-5,0])cylinder(35, 1, 1,$fn=6*mult);
rotate([0,35])translate([0,5,0])cylinder(35, 1, 1,$fn=6*mult);
}}
}

module bod(){
color("white")rotate_extrude($fn=80*mult2)
rotate([0,0,0])difference(){
union(){
 offset(0.25,$fn=3)offset(-0.25,$fn=3) intersection(){
circle(30.1,$fn=80*mult2);
//square([60.2,50.9],center=true);
square([60.2,44.1],center=true);
 }
 
 }
translate([30.1,0])circle(0.1,$fn=4);
rotate([0,0,47.5])translate([30.1,0])circle(0.2,$fn=4);
rotate([0,0,-47.5])translate([30.1,0])circle(0.2,$fn=4);
translate([-30.1,0])square([60.2,70],center=true);

}}
module bodu(x){
color("white")rotate_extrude($fn=80*mult2)
 rotate([0,0,0])difference(){
union(){
 intersection(){
circle(30.1+x,$fn=80*mult2);
//square([60.2,50.9],center=true);
square([60.2+x*2,44.1],center=true);

 }

 }
  circle(30.1-0.5,$fn=80*mult2);

translate([-30.1,0])square([60.2,70],center=true);

}}
module bez(){
color("lightgrey")rotate_extrude($fn=80*mult2)
 rotate([0,0,0])
 offset(-0.25,$fn=3)offset(0.25,$fn=3)difference(){
union(){
 intersection(){
circle(30.1,$fn=80*mult2);
 square([60.2,50.9],center=true);
}
 
 }
 
translate([-30.1,0])square([60.2,70],center=true);
square([60.2,44.1],center=true);

}}


module lens(){
color([0.3,0.3,0.3] )rotate_extrude($fn=40*mult2,convexity=10)
 rotate([0,0,0])
difference(){
union(){
 
 translate([0,15.2])circle(18.3,$fn=40*mult2);
 translate([0,-15.2])circle(18.3,$fn=40*mult2);
 }
translate([-30.1,0])square([60.2,70],center=true);
square([60.2,44.1],center=true);

}}