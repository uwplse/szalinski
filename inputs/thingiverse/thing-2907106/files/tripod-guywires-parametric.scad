/* [Flange Dimensions] */
flange_height = 15;
flange_diameter = 70;
guy_hole_diameter = 7;

/* [Pole Dimensions] */
fishing_pole_diameter = 26;
pvc_diameter = 35;
height = 80;


/* [hidden] */
$fn=360;
guy_hole_radius = flange_diameter / 2 - 7;

difference() {
difference() {
difference() {
difference() {
    difference() {
    difference() {    
        union() {
            cylinder(h=flange_height, d=flange_diameter);
            cylinder(h=height, d=pvc_diameter + 5);
        };
        cylinder(h=flange_height, d=fishing_pole_diameter);
    };
        translate([0,0,flange_height])
        cylinder(h=height-flange_height, d=pvc_diameter);
        };
    };
    translate([guy_hole_radius,0,0])
    cylinder(h=flange_height, d=guy_hole_diameter);
   };
   rotate([0,0,120])
   translate([guy_hole_radius,0,0])
   cylinder(h=flange_height, d=guy_hole_diameter);
   };
   rotate([0,0,-120])
   translate([guy_hole_radius,0,0])
   cylinder(h=flange_height, d=guy_hole_diameter);
};
