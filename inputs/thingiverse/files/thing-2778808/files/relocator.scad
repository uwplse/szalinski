//------------------------------------
// Frame to reposition an enclosure by Mattki
//------------------------------------

// Dimensions in mm unless otherwise specified

// So you've printed a box to store your electronics but on your machine it's slightly too close to the moving parts. You wish you could move the holes a little bit to the left/right/up/down.

// This is a customisable model intended to allow you to reposition your electronics enclosure. It's not recommended to use very large offsets but you can try if you've feeling adventurous.

height = 100; // length of the board
width = 95; // width of the board
inset_w = 4.5; // how many millimeters the centres of the mounting holes in the board are inset from the PCB edge (width).
inset_h = 4; // how many millimeters the centres of the mounting holes in the board are inset from the PCB edge (height).
border = 4; // how many mm border around the edges of the board?
offset_w = 10; // how much do you want to offset the board in mm (width)?
offset_h = 0; // how much do you want to offset the board in mm (height)?
board_thickness = 6; // thickness of the board (usually 2x the nut thickness with a little extra for clearance is reasonable.
nut_dia = 6.25; // nut diameter
nut_thickness = 3; // nut thickness
nut_sides = 6; // change if your nut has a number of sides other than six!
hole_dia = 3.5; // through hole diameter
cutout_offset = 30; // control how wide the edges of your finished part are. 30 gives 15mm width on all sides.

module boards(){
    translate([offset_h/2,offset_w/2,0]) post_set(height-inset_h*2,width-inset_w*2,nut_thickness+0.01,nut_dia,hole_dia,nut_sides);
}

difference(){
    cube([height+border*2+abs(offset_h),width+border*2+abs(offset_w),board_thickness],center=true);
    cube([height+border*2+abs(offset_h)-cutout_offset,width+border*2+abs(offset_w)-cutout_offset,board_thickness+0.01],center=true);
    boards();
    translate([0,0,0]) rotate([180,0,0])  boards();
}

module post_set(board_height,board_width,post_height,od,id,complexity){
    translate([board_height/2,board_width/2,0]) mounting_post(post_height,od,id,complexity);
    translate([-board_height/2,board_width/2,0]) mounting_post(post_height,od,id,complexity);
    translate([board_height/2,-board_width/2,0]) mounting_post(post_height,od,id,complexity);
    translate([-board_height/2,-board_width/2,0]) mounting_post(post_height,od,id,complexity);
}

module mounting_post(post_height,od,id,complexity){
    union(){
        translate([0,0,post_height/2]) cylinder(h=post_height,d=od,$fn=complexity,center=true);
        translate([0,0,0]) cylinder(h=board_thickness+0.01,d=id,$fn=72,center=true);
    }
}