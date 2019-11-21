/*----------------------------------------------------------------------------*/
/*-------                           SETTINGS                          --------*/
/*----------------------------------------------------------------------------*/

// Height of stoma without balloon
Stoma_Height = 25; // [15:1:50]

// Diameter of stoma
Stoma_Diameter = 5; // [2:1:10]

// Length of the complete training dummy
Dummy_Length = 110.5; // [50:0.1:200]

// Width of the complete training dummy
Dummy_Width = 80; // [50:0.1:200]



/////////////

/* [Hidden] */

$fn = 99;

// Longer side of mold always length
Mold_Length = Dummy_Length > Dummy_Width ? Dummy_Length : Dummy_Width;
Mold_Width = Dummy_Length > Dummy_Width ? Dummy_Width : Dummy_Length;

// Size of the mold
Mold_Size = [Mold_Length, Mold_Width, Stoma_Height];

// Radius of the rounded edges of the training dummy
Dummy_Outer_Radius = 10;

// Thickness of the outer shell
Shell_Thickness = 3;

// Radius of stoma
Stoma_Radius = Stoma_Diameter/2;

// Tolerance
tolerance = 0.18;

// Get assembled STL
assembled = false;



// TODO rounded edge for better build plate removal
// TODO pin tampering cuts are not parameterized
// TODO animation von parameteranpassung und zusammensetzen


//// Create model

obj_translate = (assembled == true) ? [0, 0, 0] : [0, -Mold_Width, 0];
make_case(Mold_Size, Shell_Thickness, Dummy_Outer_Radius);
translate(obj_translate)
make_pin(Mold_Size, Shell_Thickness, Dummy_Outer_Radius, Stoma_Height, Stoma_Diameter);


//// Modules

module make_pin(inner_size, thickness, shell_fillet_radius, stoma_height, stoma_diameter) {
    union() {
        // Negative of the case hole
        intersection() {
            make_case(inner_size, thickness, shell_fillet_radius, hole=false);
            scale([2,1,1])
            cylinder(inner_size[2]*4, r=inner_size[1]/5, center=true);
        }
        make_inner_shape(stoma_height, stoma_diameter);
        translate([0,0,8])
        cylinder(h = 1, r1 = 10, r2=0);
    }
}

module make_inner_shape(stoma_height, stoma_diameter) {
    shrinkage = -0.05; // Shrinkage factor of inner tunnel
    tightness = 0.55; // Controls the tightness of the upper 3 canals
    
    pin_height = stoma_height+8; // Stoma height + ground_plate height
    shaft_radius = Stoma_Diameter/2*(1-shrinkage); // Shrink inner tunnel according to stoma diameter
    canal_radius = shaft_radius*tightness; // Radius of the 3 canals which tighten the upper half
    
    difference() {
        // Pin
        translate([0,0,pin_height/2])
        rounded_cylinder(pin_height, shaft_radius);
        // Tapering bottom
        translate([0,0,9.2])
        torus(shaft_radius*1.4, 1.3);
        // Tapering middle
        middle = 8+stoma_height/2;
        translate([0,0,middle])
        torus(shaft_radius*1.4, 1.5);
        // Narrowing top
        upper_third = 8+(stoma_height/4)*3;
        for (i = [1:3]) {
            angle = (360/3)*i;
            x = shaft_radius*cos(angle);
            y = shaft_radius*sin(angle);
            translate([x,y,upper_third])
            rounded_cylinder(stoma_height/2, canal_radius);
        }
    }
}

module make_case(inner_size, thickness, shell_fillet_radius, hole=true) {
    // Outer dimensions
    length = inner_size[0]+2*thickness;
    width = inner_size[1]+2*thickness;
    height = inner_size[2]+8+2; // 8=ground plate 2=overflow protection
    
    difference() {
        rounded_cube([length, width, height], r = shell_fillet_radius);
        translate([0,0,8])
        make_case_pocket(inner_size, shell_fillet_radius);
        if (hole) {
            scale([2,1,1])
            cylinder(20, r=(inner_size[1]/5)+tolerance, center=true);
        }
    }
}

module make_case_pocket(size, shell_fillet_radius) {
    // Outer rounding radius
    orr = 2;
    // Because of the minkowski, we will add orr*2 in every direction, this is why we have to substract it from the cube to get the right dimensions
    corrected_size = [size[0]-2*orr,size[1]-2*orr, size[2]];
    
    translate([0,0,size[2]/2+orr])
    union() {
        minkowski() {
            intersection() {
                rounded_cube(corrected_size, r = shell_fillet_radius-orr, center = true);
                scale([0.1*size[0], 0.1*size[0], 1])
                sphere(size[2]/2); // Half of stoma height
            }
            sphere(2);
        }
        rounded_cube(size, r = shell_fillet_radius, center = false);
    }
}

//// HELPER MODULES

// Makes a cube with rounded corner
// NOTE: This is not completely safe, will generate wrong stuf if radius is smaller equal than half of a side
module rounded_cube(size, r = 5, center = false) {
    l = size[0]-r*2; b = size[1]-r*2; h = size[2]/2;
    
    obj_translate = (center == true) ?
        [0,0,0] : [0,0,h];
    translate(v = obj_translate)
    minkowski() {
        cylinder(r = r, h, center = true);
        cube([l,b,h], center = true);
    }
}

// Makes a cylinder which has a rounded top and bottom
module rounded_cylinder (h, r) {
    h = h-r*2;
    hull () {
        translate([0,0,-h/2])
        sphere(r);
        translate([0,0,h/2])
        sphere(r);
    }
}

// Makes a torus
module torus (r1, r2) {
    rotate_extrude(convexity = 10)
    translate([r1, 0, 0])
    circle(r = r2);
}