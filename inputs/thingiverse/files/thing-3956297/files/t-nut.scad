use <threads.scad>

// Made by position88

thread_diameter = 12;
thread_pitch = 1.75;
thread_length = 20;

// width of narrow part
small_cx = 14;

// total height of the T-nut
total_height = 15.2;

// width and height of the wide part
wide_cx = 22;
wide_cz = 8;

// total length of T-nut
length = 28.5;

// diameter of groove in inside edge
groove_diameter = 1.2;
// offset groove from inside edge
groove_translation = 0.3;

// creating T-nut
difference() {
    // making two cubes
    union() {
        cube([small_cx,length,total_height], center=true);
        translate([0,0,-total_height / 2 + wide_cz / 2])
        cube([wide_cx,length,wide_cz], center=true);
    }
    // making grooves in edges
    groove();
    mirror([1,0,0])
    groove();
    
    // making metric thread
    translate([0,0,-thread_length / 2])
    metric_thread(thread_diameter, thread_pitch, thread_length, internal=true);
}

// making grooves easily
module groove() {
   rotate([90,0,0])
    translate([small_cx / 2 + groove_translation,groove_translation * 2,0])
    cylinder(d=groove_diameter,length,center=true, $fs=0.5);
}