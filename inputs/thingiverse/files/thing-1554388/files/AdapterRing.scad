$fn=20;
height = 2.7;
inner_diameter = 3; //M3
outer_diameter = 5.8;   //the diameter of the hole in the key
difference(){
    cylinder(height, d=5.8);
    translate([0,0,-1])cylinder(height+2, d=3);
}