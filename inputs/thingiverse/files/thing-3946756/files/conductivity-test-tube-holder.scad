//Material Thickness
t=2;
//Cup Height
h=15;
//Cup Diameter
top_d=37;
//Brim Width
brim=10;
//Through-Hole Diameter
th_d=15;
//Resolution
$fn=2000;

bot_d=top_d+2*brim;

module solid(){union(){translate([0,0,0])cylinder(h=h,r=top_d/2+t);cylinder(h=t,r=bot_d/2+t);}};
module holder(){difference(){solid();translate([0,0,t])cylinder(h=h,r=top_d/2);translate([0,0,-t])cylinder(h=h,r=th_d/2);}};
holder();