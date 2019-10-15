board_hole_diameter=4;
board_hole_spacing=80; //spacing on the PCB
board_width=126; //spacing of the cricut holes in the middle area
board_length=64; //spacing of the cricut holes in the middle area
wing_width=45; //spacing of the cricut holes for the sides
cutout_board_large=70; //hole diameter to cut out
cutout_board_small=40; //hole diameter to cut out
cutout_wing=90; //hole diameter to cut out
button_offset_width=6.7; //measured from the bottom left hole
button_offset_length=4.4;
button_to_button_width=15.75;
button_hole_size=2; //hole in mounting board to assist with placing of the buttons
button_width=7;
button_length=10;
mount_board_width=130;
mount_board_length=86.5;
mount_wing_width=53;
mount_wing_length=70;
mount_thickness=4;
$fn=30;
wing_board_overlap=6;

pointsleft=[[(mount_wing_width-wing_width)/2-mount_wing_width+wing_board_overlap,(mount_board_length-board_length)/2,-0.01],[mount_wing_width-(mount_wing_width-wing_width)/2-mount_wing_width+wing_board_overlap,(mount_board_length-board_length)/2,-0.01],[(mount_wing_width-wing_width)/2+button_offset_width-mount_wing_width+wing_board_overlap,(mount_board_length-board_length)/2+button_offset_length,-0.01],[(mount_wing_width-wing_width)/2+button_offset_width+button_to_button_width-mount_wing_width+wing_board_overlap,(mount_board_length-board_length)/2+button_offset_length,-0.01],[(mount_wing_width-wing_width)/2+button_offset_width-mount_wing_width+wing_board_overlap-button_width/2,(mount_board_length-board_length)/2+button_offset_length-button_length/2,-0.01],[(mount_wing_width-wing_width)/2+button_offset_width+button_to_button_width-mount_wing_width+wing_board_overlap-button_width/2,(mount_board_length-board_length)/2+button_offset_length-button_length/2,-0.01]];

pointsmiddle=[[(mount_board_width-board_width)/2,(mount_board_length-board_length)/2,-0.01],[mount_board_width-(mount_board_width-board_width)/2,(mount_board_length-board_length)/2,-0.01],[mount_board_width-(mount_board_width-board_width)/2,mount_board_length-(mount_board_length-board_length)/2,-0.01],[(mount_board_width-board_width)/2,mount_board_length-(mount_board_length-board_length)/2,-0.01],[mount_board_width/2-board_hole_spacing/2,mount_board_length/2-board_hole_spacing/2+2,-0.01],[mount_board_width/2+board_hole_spacing/2,mount_board_length/2-board_hole_spacing/2+2,-0.01],[mount_board_width/2+board_hole_spacing/2,mount_board_length/2+board_hole_spacing/2+2,-0.01],[mount_board_width/2-board_hole_spacing/2,mount_board_length/2+board_hole_spacing/2+2,-0.01]];

module leftwing(){
for (a=[0:3])
translate(pointsleft[a])
difference(){
cylinder(d=board_hole_diameter+2,h=mount_thickness);
cylinder(d=board_hole_diameter,h=mount_thickness);
}
}

module leftwingholes(){
for (a=[0:3])
translate(pointsleft[a])
cylinder(d=board_hole_diameter,h=mount_thickness);
for (a=[4:5])
translate(pointsleft[a])
cube([button_width,button_length,mount_thickness/4]);
}

module rightwing(){
translate([board_width+wing_board_overlap/2+1,0,0])
mirror([180,0,0])
leftwing();
}

module rightwingholes(){
translate([board_width+wing_board_overlap/2+1,0,0])
mirror([180,0,0])
leftwingholes();
}

module middle(){
for (a=[0:7])
translate(pointsmiddle[a])
difference(){
cylinder(d=board_hole_diameter+2,h=mount_thickness);
cylinder(d=board_hole_diameter,h=mount_thickness);
}
}

module middleholes(){
for (a=[0:7])
translate(pointsmiddle[a])
cylinder(d=board_hole_diameter,h=mount_thickness);
}

module mount(){
union(){
leftwing();
middle();
rightwing();
}
}

module mountholes(){
union(){
leftwingholes();
middleholes();
rightwingholes();
}
}

module mountwithholes(){
difference(){
hull(){
mount();
}
mountholes();
}
}

difference(){
mountwithholes();
translate([mount_board_width/2,mount_board_length/2,-0.01])
cylinder(d=cutout_board_large,h=mount_thickness+0.02);
translate([mount_board_width/2-cutout_board_large/2,mount_board_length/2,-0.01])
cylinder(d=cutout_board_small,h=mount_thickness+0.02);
translate([mount_board_width/2+cutout_board_large/2,mount_board_length/2,-0.01])
cylinder(d=cutout_board_small,h=mount_thickness+0.02);
}

