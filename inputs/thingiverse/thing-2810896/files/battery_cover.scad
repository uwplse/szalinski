// Simple battery cover with 1 and 2 slots to hold it in place


// length of the cover/base plate
x=55;

//width of the cover/base plate
y=30;

// thickness of the cover/base plate
thickness=2;

// width of the 2 holders on the back side (other side with regards to the slot)
double_holder_width = 4;

// legnth of each of the 2 holders, including overlap with the base plate
double_holder_length = 4;

// overlap of each holder with the base plate
double_holder_overlap = 2;

// thickness of each holder
double_holder_thickness = 2;

// distance between the holder and the edge of the base plate
double_holder_offset = 12;

// same as previous offset, but measured from the other side
double_holder_offset2 = x - double_holder_offset - double_holder_width; 

// dimensions of the slot that allows to move the slot holder
slot_length = 45;

// thickness of the slot (in the X axis)
slot_thickness = 2;

// distance between long side of slot and base plate edge
slot_y = 1.5;

// distance between short side of slot and base plate edge
slot_offset = 5;

// width of the single holder at the front (near the slot)
slot_holder_width = 8;

// distance from the edge of the base plate to the holder
slot_holder_offset = 24;
// overlap of the single holder with the base plate
slot_holder_overlap = 1.5;
// length of the single holder, includes overlap
slot_holder_length = 4.5;

// thickness of the holder
slot_holder_thickness = 2;

rotate([0,180,0]) {

difference() {
    cube([x,y,thickness]);
    translate([slot_offset, y-slot_y-slot_thickness, 0]) cube([slot_length, slot_thickness, thickness]);
}

translate([double_holder_offset2, double_holder_overlap-double_holder_length, -thickness]) cube([double_holder_width, double_holder_length, double_holder_thickness]);

translate([double_holder_offset, double_holder_overlap-double_holder_length, -thickness]) cube([double_holder_width, double_holder_length, double_holder_thickness]);

translate([slot_holder_offset, y - slot_holder_overlap, -thickness]) cube([slot_holder_width, slot_holder_length, slot_holder_thickness]);
}