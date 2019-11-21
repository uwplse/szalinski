// The required angle between the two plates
angle = 90; // [10:1:180]

// The width of the bracket across the bolt holes (Y)
width = 20; // [10:1:999]

// The length of each plate from apex out (X and Z)
length = 20; // [10:1:999]

// Material thickness
thickness = 3; // [1:1:10]

// The diameter of the bolt holes
bolt_diameter = 6; // [1:1:10]

// The number of bolts per plate
bolts_per_face = 1; // [1:1:10]

/* [hidden] */
$fn=20;
inside_offset = thickness/tan(angle/2);

/* fixed (horizontal) plate with clipping mask */
difference(){
    cube([length, width, thickness]);
    rotate([0, -angle, 0]){
        translate([0, -.1, 0]){
            cube([length, width+.2, thickness]);
        }
    }
    
    /* bolt holes */
    for (i = [1 : 1 : bolts_per_face]){
        translate([inside_offset+((length-inside_offset)/(bolts_per_face+1))*i, width/2, -.1]){
            cylinder(h=thickness+.2, d=bolt_diameter);
        }
    }
}

/* movable (vertical-ish) plate with clipping mask */
difference(){
    rotate([0, -angle, 0]){
        translate([0, 0, -thickness]){
            cube([length, width, thickness]);
        }
    }
    translate([0,-.1,-thickness]){
        cube([length, width+.2, thickness]);
    }
    
    /* bolt holes */
    for (i = [1 : 1 : bolts_per_face]){
        rotate([0,-angle, 0]){
            translate([inside_offset+((length-inside_offset)/(bolts_per_face+1))*i, width/2, -thickness-.1]){
                cylinder(h=thickness+.2, d=bolt_diameter);
            }
        }
    }
}

support_offset = thickness/tan(angle/2);
support_width = support_offset > (length/2) ? length-support_offset : (length/2);
echo(support_width);
/* near support */
translate([support_offset, width/10, thickness]){
    rotate([90, 0, 0]){
        triangle(support_width, support_width, width/10, false, angle);
    }
}

/* far support */
translate([support_offset, width, thickness]){
    rotate([90, 0, 0]){
        triangle(support_width, support_width, width/10, false, angle);
    }
}



/**
 * Triangle
 *
 * @param number  o_len   Length of the opposite side
 * @param number  a_len   Length of the adjacent side
 * @param number  depth   How wide/deep the triangle is in the 3rd dimension
 * @param boolean center  Whether to center the triangle on the origin
 * @param boolean o_angle The angle (default=90) between the adjacent and oposite sides
 */
module triangle(o_len, a_len, depth, center=false, adj_angle=90)
{
    centroid = center ? [-a_len/3, -o_len/3, -depth/2] : [0, 0, 0];
    translate(centroid) linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[a_len,0],[sin(90-adj_angle)*o_len, cos(90-adj_angle)*o_len]], paths=[[0,1,2]]);
    }
}