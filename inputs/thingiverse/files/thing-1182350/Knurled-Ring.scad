// Customizable Napkin Rings and Knurled Knobs 
// by edak

//CUSTOMIZER VARIABLES
/* [Basic Options] */

// (mm)
print_height=35;
// (mm) 
print_resolution=0.2;
// (mm)
outer_diameter=43;
// (mm)
inner_diameter=36;
// Number of sides on bottom (6+ works best)
sides=8;
// Integer: More twists = more detail
twist_factor=6;

/* [Advanced Options] */
// Do you want a circular hole?
circular_hole="yes"; //[yes,no]
// Use as a cap?
close_top="no"; //[yes,no]
top_width=1;

//CUSTOMIZER VARIABLES END

/* [Hidden] */
twist = (360/sides) * twist_factor;
twist_b= twist * -1;  //we like symmetry but can be changed

no_slices=print_height/print_resolution;
rotation=360/sides; // create the basic shape to extrude and twist

  
union(){
    if(close_top == "yes") translate([  0,0,  print_height/2 - top_width]) cylinder(top_width,inner_diameter/2,inner_diameter/2,$fn=50);
        
    difference(){
        union(){
            linear_extrude(height = print_height, center = true, convexity = 10, twist = twist, slices = no_slices) rotate(rotation) translate([  0,  0]) circle(outer_diameter/2,$fn=sides);
            linear_extrude(height = print_height, center = true, convexity = 10, twist = twist_b, slices = no_slices) translate([  0,  0]) circle(outer_diameter/2,$fn=sides);
        }

        if (circular_hole == "yes") {
            cylinder(print_height+0.1,inner_diameter/2,inner_diameter/2,true, $fn=50);
        } else {
            union(){
                linear_extrude(height = print_height+0.01, center = true, convexity = 10, twist = twist, slices = no_slices) rotate(rotation) translate([  0,  0]) circle(inner_diameter/2,$fn=sides);
                linear_extrude(height = print_height+0.01, center = true, convexity = 10, twist = twist_b, slices = no_slices) translate([  0,  0]) circle(inner_diameter/2,$fn=sides);
            }
    }
        
    }
}
