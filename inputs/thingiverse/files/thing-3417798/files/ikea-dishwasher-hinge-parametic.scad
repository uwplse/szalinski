$fn=150+0;
// offset 0 is like the original part. you can offset for instance 2cm by entering 20 here:
offset=0;

rotate([90,0,0]) translate([0,9.5,0])
union(){
    difference(){
        cylinder(r=18.5, h=2.9);
        translate([-19,9.5,-0.5]) cube([38,20,4]);
        translate([-19,-29.5,-0.5]) cube([38,20,4]);
    }
    
    translate([0,0,0+offset])
    difference(){
        translate([0,9.5,9]) rotate([90,0,0]) cylinder(d=18,h=19);
        translate([0,10,9]) rotate([90,0,0]) cylinder(d=12,h=20);

        translate([-5.1,-11,10]) cube([10.2, 21, 20]);
    }
    
    difference(){
        translate([-8.7,-9.5,0]) cube([17.5,19,8+offset]);
        translate([0,10,9+offset]) rotate([90,0,0]) cylinder(d=12,h=20);
    }
}