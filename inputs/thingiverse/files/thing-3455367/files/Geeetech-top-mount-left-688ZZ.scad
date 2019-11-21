translate([0,0,-19]) import("Geeetech_top_mount_left.stl");


translate([-15,-61,1.5]) 
difference(){
    cylinder(r1=23/2,r2=23/2,h=5);
    cylinder(r1=17/2,r2=17/2,h=5);
}