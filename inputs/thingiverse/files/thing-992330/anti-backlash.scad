
screw_len=6; //total threaded length
minus=4;
$fn=50;

//color([0.6,0.2,0.3])import("anti-z-wobbling.stl");

difference(){
hull()
{
cylinder(d=25,3);
translate([20,0,0])cylinder(d=23,3);
translate([0,0,-screw_len+minus])cylinder(d=25,screw_len-minus);
translate([20,0,-screw_len+minus])cylinder(d=23,screw_len-minus);
}

for(i=[0:1]){
rotate(i*-360/2){translate([0,8,-screw_len-1])cylinder(d=3.5,screw_len+5);
translate([0,8,0])cylinder(d=6,4);
   }
   }

translate([0,0,-screw_len-3]){
hull(){
cylinder(d=10.5,screw_len*2);
translate([-13,0,0])cylinder(d=10.5,screw_len*2);
}
hull(){
translate([15,0,0])cylinder(d=8.25,screw_len*2);
translate([30,0,0])cylinder(d=8.25,screw_len*2);
}
}
}