/*
    Author: Daniel Devine
    Date: 13/01/17
    Description: T-Slot aluminium cover for the extrusions used for the Anet A2.
    Particularly useful for running the x-axis endstop wire separately from the X-axis belt.
    Either adjust the length in the OpenSCAD file or stretch along the x-axis in your slicer.
*/

length = 100; // The length of the extrusion.
base_width = 7.05;
base_thickness = 0.75;
sidewall_thickness = 0.8;
sidewall_offset = 0.5;
part_height = 4.6;
un_overhang = 0.25; // 0.25 prints better, but 0 would be optimal for functionality.

// Build the object
rotate([90, 0, 90]){
    union(){
        // First half
        translate([-(base_width), 0, 0]){
            linear_extrude(length) half_extrusion();
        };
        // Second half
        linear_extrude(length) mirror([1, 0, 0]) half_extrusion();
    }   
}
        


module half_extrusion(){
    // Half the extrusion is modelled so that there is less description of the polygon needed.
    polygon(points=[
            [0,0], // origin 
            [base_width/2, 0],
            [base_width/2 , base_thickness],
            [sidewall_offset + sidewall_thickness, base_thickness],
            [sidewall_offset + sidewall_thickness, part_height - base_thickness], // This is the highest point.
            [0, part_height - (sidewall_thickness * 1.875)], // Down roughly 45deg to make a point that sticks out to anchor under lip of extrusion Multiply sidewall by 1.8 to keep linear?
            [sidewall_offset, part_height - (sidewall_thickness * 1.875) - un_overhang], // back in...
            [sidewall_offset, base_thickness],
            [0, base_thickness],
            [0, 0]
        ]
    );
}