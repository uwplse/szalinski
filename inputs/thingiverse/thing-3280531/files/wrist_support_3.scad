$fn=100;

support_width = 130;
support_length = 50;
support_height = 25;

difference(){
cube([120,40,15],true);
translate([0,0,13])rotate([20,0,0])cube([support_width*1.15,support_length*1.2,support_height],true);
translate([0,0,130])rotate([90,0,0])cylinder(h=support_length,r=support_width, center=true);
}

