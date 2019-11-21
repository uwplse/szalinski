// Rack Boss Outside Width
design_width = 70; // [62:100]
// center of bolts to bottom edge of light mount (i.e. cable clearance)
design_height = 50; // [20:75]
// Part Thickness
thickness = 5.0; //[4,5,6]

/* [Hidden] */

holes = 6;
base_width = 18;
t = thickness;
sin45 = 1/sqrt(2);
tan45 = sqrt(2);
height = design_height + base_width/2 + t*tan45;
width = design_width;

//define base



module base () {
    rotate([45,0,0]) {
        union()
            difference(){
                cube(size=[width, base_width*2, thickness], center=true);
                
                translate([25,t/2,0])
                    cylinder(thickness*4, d=holes, center=true);
                translate([-25,t/2,0])
                    cylinder(thickness*4, d=holes, center=true);
            }
        }
}

//design flange
module flange () {
   union() {
        translate([thickness/2, 0, 0])
            rotate([0,-90,0])
                    linear_extrude(thickness)
                        polygon(points=[
                            [base_width/2,0],
                            [0, -base_width/2],
                            [0, -height],
                            [base_width/2, -height+base_width/2],
                            [base_width, -height],
                            [base_width, base_width/2],
                            [base_width/2,0] 
                        ]);
        translate([0,-height,base_width/2]) 
            rotate([0,90,0])
                difference() {
                    cylinder(thickness, d=base_width, center=true);
                    cylinder(thickness*2, d=holes, center=true);
                }
    }
}

//build
translate([0, base_width/2 + t*tan45, 0])
difference() {
    union() {
        translate([0, -tan45*t/2, 0]) base();
        translate([(width + t)/2, 0, -base_width/2]) flange();
        translate([(width + t)/-2, 0, -base_width/2]) flange();
    }
    translate([0,0, base_width/2+t]) cube(size=[2*width, 2*width, 2*t], center=true);
    translate([0,0, -base_width/2-t]) cube(size=[2*width, 2*width, 2*t], center=true);
}