
// Size of the clip, thickness of the bed frame +2mm seems to work well
clip_width = 22; // [1:0.5:50]

// Width of the phone slot
phone_slot_width = 80; // [10:200]

// Height of the phone slot
phone_slot_height = 80; // [10:200]

// Thickness of the phone slot
phone_slot_thickness = 20; // [1:100]

// Thickness of the clip/box, lower to save time/material, higher to increase strength 
clip_thickness = 3; // [1:20]

// Thickness of the tablet slot, set to 0 to remove it
tablet_slot_thickness = 20; // [0:100]

// Number of phone slots side-by-side
number_of_phone_slots = 2; //  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]


bed_caddy(  clip_width, 
            phone_slot_width, 
            phone_slot_height, 
            phone_slot_thickness, 
            clip_thickness, 
            tablet_slot_thickness, 
            number_of_phone_slots );

module bed_caddy(clip_length, width, height, depth, thickness, tablet_thickness, phone_slots) {
    for (i =[1:phone_slots])
        translate([0,i*(width+thickness),0]) phone_holder(clip_length, width, height, depth, thickness, tablet_thickness);
    
}

module phone_holder(clip_length, width, height, depth, thickness, tablet_thickness) {
    tablet_offset = tablet_thickness ? thickness + tablet_thickness : 0;
    total_depth = clip_length+depth+thickness*3+tablet_offset;

    difference(){
        translate([-thickness,-thickness,0]) 
            cube([total_depth, width+thickness*2, height+thickness]);
        
        translate([0,-thickness-1,-1])
            cube([clip_length, width+thickness*2+2, height+1]);
        
        translate([clip_length+thickness,-thickness-1,thickness])
            cube([tablet_thickness, width+thickness*2+2, height+1]);
        
        translate([clip_length+thickness+tablet_offset,0,thickness]) 
            cube([depth, width, height+1]);
    }
}