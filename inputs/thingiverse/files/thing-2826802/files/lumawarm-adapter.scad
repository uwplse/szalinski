top_width=6.7;
top_height=3.6;
top_separation=2.6;
middle_width=3.1;
middle_height=2.8;
middle_separation=6;
bottom_width=16;
bottom_height=4.5;

length=30;

hole_diameter=6;
countersink_diameter=13;
$fn=100;

intersection(){
translate([0,0,-(bottom_height+middle_height+top_height)/2])
difference(){
solid_adapter();
translate([0,0,-0.01])
cylinder(d1=hole_diameter,d2=countersink_diameter,h=bottom_height+0.02);
translate([0,0,bottom_height])
cylinder(d=countersink_diameter,h=middle_height+top_height+0.01);
}
translate([0,length/2,0])
rotate([90,0,0])
cylinder(d=bottom_width*1.15,h=length);
}

module solid_adapter(){
translate([0,-length/2,0])
union(){
translate([-top_width-top_separation/2,0,middle_height+bottom_height])
cube([top_width,length,top_height]);
translate([top_separation/2,0,middle_height+bottom_height])
cube([top_width,length,top_height]);

translate([-middle_width-middle_separation/2,0,bottom_height])
cube([middle_width,length,middle_height]);
translate([middle_separation/2,0,bottom_height])
cube([middle_width,length,middle_height]);

translate([-bottom_width/2,0,0])
cube([bottom_width,length,bottom_height]);
}
}