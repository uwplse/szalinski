// Square fan to pipe adapter
// Fits a standard PC cooling fan to a flexible pipe

// pipe side
pipe_od = 98; // experimentally determined for a nice close fit
pipe_id = 93;
pipe_length = 10; // length of straight section

// fan side
fan_od = 120;
fan_id = 115;
fan_length = 0; // generally not needed

transfer_length = 10; // length of the section part

// fan adapter
fan_size = 120;
hole_spacing = 105; // 104.8 is standard 120mm fan holesizing
hole_diameter = 6.3; // experimentat with this, fan screws need at least 5mm hole size
plate_thickness = 3.0; // adjust for optimum strength

$fa = 1.5;
$fs = 1.5;

// chamfer corners - not implemented
corner_chamfer_radius = (fan_size - hole_spacing)/2;

// polygon of rotated section
translate(v=[0,0,plate_thickness])
    rotate_extrude()
        polygon(points=[
            [fan_id/2,0], // 1
            [fan_od/2,0], // 2
            [fan_od/2,fan_length], // 3
            [pipe_od/2,fan_length+transfer_length], // 4
            [pipe_od/2,fan_length+transfer_length+pipe_length], // 5
            [pipe_id/2,fan_length+transfer_length+pipe_length], // 6
            [pipe_id/2,fan_length+transfer_length], // 7
            [fan_id/2,fan_length], // 8
        ]);

difference() {

    // the plate for attaching the fan onto
    linear_extrude(height=plate_thickness)
        square(size=fan_size,center=true);
        
    // holes for screws
    translate(v=[hole_spacing/2,hole_spacing/2,0])
        cylinder(h=plate_thickness,r=hole_diameter/2);
    translate(v=[hole_spacing/2,-hole_spacing/2,0]) 
        cylinder(h=plate_thickness,r=hole_diameter/2);
    translate(v=[-hole_spacing/2,hole_spacing/2,0])    
        cylinder(h=plate_thickness,r=hole_diameter/2);
    translate(v=[-hole_spacing/2,-hole_spacing/2,0])    
        cylinder(h=plate_thickness,r=hole_diameter/2);
    
    cylinder(h=plate_thickness,r=fan_id/2);
        
}
