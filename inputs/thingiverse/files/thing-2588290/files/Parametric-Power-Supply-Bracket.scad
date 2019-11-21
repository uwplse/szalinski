// Mounting depth -- distance from the top of the power supply to the center of the mounting holes.
depth = 39;

// Mounting hole horizontal separation, center to center
separation = 151;

// Mounting hole screw size
hole_size = 4.5;

// Extrusion height
extrusion_height = 20;

// How thick to make the uprights that hold the weight
upright_thickness = 5;

// How wide to make the uprights that hold the weight
upright_width = 10;

// How thick to make the runner that holds the spacing
runner_thickness = 1;

// How wide to make the runner that holds the spacing
runner_width = 10;

// ------------- END PARAMETERS -----------------

height = depth + (extrusion_height / 2) + 10;
width = separation + 10;

x0 = upright_width / 2;
y0 = 5;

difference() 
{
    union() 
    {
        cube([upright_width, height, upright_thickness]);
    
        translate([separation, 0, 0])
        cube([upright_width, height, upright_thickness]);

        translate([0, depth - 10, 0])
        cube([width, runner_width ,runner_thickness]);
    }

    translate([x0, y0, -1]) 
    cylinder(r = hole_size / 2, h = upright_thickness + 2);

    translate([x0 + separation, y0, -1]) 
    cylinder(r = hole_size / 2, h = upright_thickness + 2);

    translate([x0, y0 + height - 10, -1])
    cylinder(r = hole_size / 2, h = upright_thickness + 2);

    translate([x0 + separation, y0 + height - 10, -1]) 
    cylinder(r = hole_size / 2, h = upright_thickness + 2);
}