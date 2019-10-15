$fn=120;

width=210;  // [50:1:1000]
length=200; // [50:1:1000]
base_thickness=3;// [3:1:25]
support_radius=16;

difference() {

    // adds
    union() {
        translate([0,0,0]) cube([width,length,base_thickness]);
        translate([30,30,0]) cylinder(h=12+base_thickness,r=support_radius);
        translate([width-30,30,0]) cylinder(h=12+base_thickness,r=support_radius);
        translate([30,length-30,0]) cylinder(h=12+base_thickness,r=support_radius);
        translate([width-30,length-30,0]) cylinder(h=12+base_thickness,r=support_radius);
    }

    // subtracts
    union() {
        translate([30,30,3]) cylinder(h=12+base_thickness,r=support_radius-4);
        translate([width-30,30,3]) cylinder(h=12+base_thickness,r=support_radius-4);
        translate([30,length-30,3]) cylinder(h=12+base_thickness,r=support_radius-4);
        translate([width-30,length-30,3]) cylinder(h=12+base_thickness,r=support_radius-4);        
    }


}