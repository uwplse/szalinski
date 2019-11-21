$fn=100;

support_width = 130;
support_length = 50;
support_height = 25;

difference(){
cube([support_width*0.615,support_length*0.6,support_length*0.7],true);

translate([0,0,75])rotate([90,0,0])cylinder(h=support_length,r=support_width*0.515, center=true);
translate([0,0,-10])cube([support_width*0.415,support_length*0.62,support_length*0.32],true);
}
