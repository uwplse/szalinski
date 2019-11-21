// What is the diameter of your knob spindle? (mm) This means, what is the radius of the approximately cylindrical post that connects the larger knob to the cabinet?
spindle_diameter = 8.7;

// What is the distance between centers of your two knobs? (mm)
between_centers = 57;

// What is the desired thickness of the piece? (mm) This significantly affects the flexiblity of the piece so a thicker piece will make it harder to release and certainly more secure, more baby-proof. If you think it's too hard to release, make it thinner.
thickness = 2; //[1:0.2:4]

// What is the desired depth of the extrusion? (mm) You will need to tilt the preview to see the effect of this parameter.
depth = 6;

/* [Advanced] */

// Coefficient between 0.65 and 0.9 to define how tightly the fixed side of the lock holds onto the knob. Lower numbers mean it's more tightly held on there but may mean it's difficult to get it on there in the first place. I've found that about 0.8 is good with PLA.
fixed_side_tightness = 0.8;

// Radius of the release part (mm)
thumb_r = 16;

// Angle #1 to fine tune the geometry and "tightness" of the release (degrees)
thumb_angle = 135; //[100:2:150]

// Angle #2 to fine tune the geometry and "tightness" of the release (degrees)
thumb_angle2 = 60; //[30:2:100]

// preview[view:south, tilt:top]

linear_extrude(depth) {
    translate([-0.001,0,0]) square([between_centers+0.002,thickness]); //.001 and .002 are to ensure intersection
    translate([0,-spindle_diameter/2]) difference() {
        circle(r=spindle_diameter/2+thickness,$fs=1);
        translate([0,0]) circle(r=spindle_diameter/2,$fs=1);
        
        cutout_height = spindle_diameter*fixed_side_tightness;
        
        translate([0,(spindle_diameter/2)-cutout_height]) square([spindle_diameter+thickness,cutout_height]);
    }
}

translate([between_centers,-spindle_diameter/2,0]) rotate([0,0,-thumb_angle+90]) {
    mirror([1,1,0]) arc(thickness,depth,spindle_diameter/2+thickness,thumb_angle);
    
    translate([thumb_r+spindle_diameter/2,0,0]) mirror([0,1,0]) mirror([1,0,0]) mirror([1,1,0]) {
        
        arc(thickness,depth,thumb_r,thumb_angle2);
        rotate([0,0,-thumb_angle2]) translate([0,-thumb_r+thickness/2,0]) cylinder(h=depth,d=thickness,$fs=0.5);
        
    }
}

module arc( height, depth, radius, degrees ) {
    // This dies a horible death if it's not rendered here 
    // -- sucks up all memory and spins out of control 
    render() {
        difference() {
            // Outer ring
            rotate_extrude($fn = 100)
                translate([radius - height, 0, 0])
                    square([height,depth]);
         
            // Cut half off
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
            // Cover the other half as necessary
            rotate([0,0,180-degrees])
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
        }
    }
}