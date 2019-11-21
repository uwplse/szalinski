// radius of the bowl, may need to add ~1mm to fit nicely
cat_bowl_r = 64.5;

// Width and height of the faceplate
frame_size = 150;

// Thickness of the faceplate and legs
frame_thickness = 10;

// Angle of the faceplate to the ground
frame_angle = 15;

// Height of the front leg
frame_height = 50;

rotate([frame_angle,0,0]) difference() {
    cube([frame_size,frame_size+frame_thickness/2,frame_thickness], true);
    cylinder(frame_thickness+1, cat_bowl_r, cat_bowl_r, true);
}

translate([0,-cos(frame_angle)*frame_size/2,frame_height/2])
    cube([frame_size,frame_thickness,sin(frame_angle)*frame_size+frame_height], true);

translate([0,cos(frame_angle)*frame_size/2,sin(frame_angle)*frame_size/2+frame_height/2])
    cube([frame_size,frame_thickness,frame_height], true);