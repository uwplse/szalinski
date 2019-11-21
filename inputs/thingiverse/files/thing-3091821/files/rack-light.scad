// Rack Boss Outside Width
design_width = 70; // [62:100]
// Height of light (center-to-center on bolts)
design_height = 50; // [20:75]
// Part Thickness
thickness = 5; //[4,5,6]

/* [Hidden] */

holes = 6;
base_width = 18;
height = design_height + base_width/2;
width = design_width;

//define base

module base () {
    union()
        difference(){
            //cube(size=[width, base_width, thickness], center=true);
            linear_extrude(thickness)
                polygon(points=[
                    [width/2, base_width/2],
                    [width/2, -base_width/2-thickness],
                    [width/2-thickness, -base_width/2],
                    [-width/2+thickness, -base_width/2],
                    [-width/2, -base_width/2-thickness],
                    [-width/2, base_width/2],
                    [width/2, base_width/2]
                    
            ]);
            translate([25,0,0])
                cylinder(thickness*4, d=holes, center=true);
            translate([-25,0,0])
                cylinder(thickness*4, d=holes, center=true);
        }

}

//design flange
module flange () {
    union() {
        translate([thickness/2, height/2,0])
            rotate([0,-90,0])
                union() {
                    linear_extrude(thickness)
                        polygon(points=[
                            [0, 0],
                            [0, -height],
                            [base_width/2, -height+base_width/2],
                            [base_width, -height],
                            [base_width, -height+base_width/2],
                            [thickness*2, -thickness],
                            [thickness, 0],
                            [0, 0] 
                        ]);
                }
        translate([0,-height/2,base_width/2]) 
            rotate([0,90,0])
                difference() {
                    cylinder(thickness, d=base_width, center=true);
                    cylinder(thickness*2, d=holes, center=true);
                }
    }
}

//build
t = thickness;
union() {
    base();
    translate([(width + t)/2, -(height - base_width)/2, 0]) flange();
    translate([(width + t)/-2, -(height - base_width)/2, 0]) flange();
}