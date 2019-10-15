//made by RevisionNr3

/* [Basic Settings] */

// Width of your smartphone (with cover if you use one) in mm (please note: numbers like 70, 70.1 and 70.15 work, but numbers like 70. and 70.10 generate errors in customizer).
smartphone_width=70; //
// Thickness of your smartphone (with cover if you use one) in mm.
smartphone_thickness=9; //
// Height of the printed part. 20mm is enough to hold a phone.
bracket_height=20;
// Thickness of the printed part. 2.5 to 3 mm is a good value. The thicker, the stronger the part and clamp.
thickness=2.5; //[1:0.1:6]
// Rotation of the clamp. Adjust if you don't have a horizontal air frame.
clamp_rotation=0; //[-70:1:70]
// Gap between the clamp. 0.5 works for most cars.
clamp_gap=0.5; //[0.1:0.1:5]
// Clamp length. A value around 25mm should work for most cars.
clamp_length=23;  //[15:1:50]

/* [Less important Settings] */

// Length of the small bracket ends
bracket_small_ends=5; //[3:1:15]
// Angle at which the clamp closes
clamp_angle1=20; //[15:1:35]
// Angle to center on air frame
clamp_angle2=30; //[30:1:45]
// Length of the small ends on the clamp
clamp_centering_length=5; //[3:1:10]

/* [hidden] */

//calculations
//------------

//calculate clamp height and width based on the previous parameters
clamp_width=calc_wc();
clamp_height=calc_hc();
clamp_width_rotated=calc_wc_rotated();
clamp_height_rotated=calc_hc_rotated();

// code for bracket
//----------------
bracket(thickness,bracket_height,smartphone_width,smartphone_thickness);

// code for clamp
//---------------
difference(){
    
rotate([clamp_rotation,0,0]){ //rotate the clamp around the angle, max 60°

clamp_one_side(thickness,clamp_length,clamp_height,clamp_gap);
mirror([0,1,0])
clamp_one_side(thickness,clamp_length,clamp_height,clamp_gap); 
}

//these cubes will cut off the top,bottom and sides of the clamps, so the clamp stays within the bracket's outside dimensions.
cube_for_cut();
mirror([0,0,1]) cube_for_cut();
cube_for_cut2();
mirror([0,1,0]) cube_for_cut2();
}

//modules
//-------

module bracket(thickness,height,smartphone_width,smartphone_thickness){
    
//long piece
    translate([thickness/2,0,0])
cube([thickness,smartphone_width+thickness,height],center=true);

//2 cylinders at end of long piece
translate([thickness/2,smartphone_width/2+thickness/2,0]) cylinder(h=height,r=thickness/2,center=true,$fn=30);

translate([thickness/2,-smartphone_width/2-thickness/2,0]) cylinder(h=height,r=thickness/2,center=true,$fn=30);

//2 short cubes to clamp phone
translate([smartphone_thickness/2+thickness,smartphone_width/2+thickness/2,0]) cube([smartphone_thickness+thickness,thickness,height],center=true);

translate([smartphone_thickness/2+thickness,-smartphone_width/2-thickness/2,0]) cube([smartphone_thickness+thickness,thickness,height],center=true);

//2 cylinders at end of previous cubes
translate([smartphone_thickness+3/2*thickness,smartphone_width/2+thickness/2,0]) cylinder(h=height,r=thickness/2,center=true,$fn=30);

translate([smartphone_thickness+3/2*thickness,-smartphone_width/2-thickness/2,0]) cylinder(h=height,r=thickness/2,center=true,$fn=30);

//2 cubes to keep smartphone in the bracket
translate([smartphone_thickness+3/2*thickness,smartphone_width/2-bracket_small_ends/2+thickness/2]) cube([thickness,bracket_small_ends,height],center=true);

translate([smartphone_thickness+3/2*thickness,-smartphone_width/2+bracket_small_ends/2-thickness/2,0]) cube([thickness,bracket_small_ends,height],center=true);

//2 cylinders at end of previous cubes
translate([smartphone_thickness+3/2*thickness,smartphone_width/2-bracket_small_ends+thickness/2,0]) cylinder(h=height,r=thickness/2,center=true,$fn=30);

translate([smartphone_thickness+3/2*thickness,-smartphone_width/2+bracket_small_ends-thickness/2,0]) cylinder(h=height,r=thickness/2,center=true,$fn=30);
}

module clamp_one_side(thickness,length,height,distance){
    
translate([-length,0,0]){    
//cylinder    
translate([0,thickness/2+distance/2,-height/2]) 
cylinder(r=thickness/2,h=height,$fn=30);

//cube
translate([0,thickness/2+distance/2,0])
rotate([0,0,clamp_angle1/2])
translate([1/2*(length/(cos(clamp_angle1/2))+thickness/2*tan(clamp_angle1/2)),0,0]) 
cube([length/cos(clamp_angle1/2)+thickness/2*tan(clamp_angle1/2),thickness,height],center=true);

//cube
translate([0,thickness/2+distance/2,0])
rotate([0,0,-clamp_angle2/2])
translate([-clamp_centering_length/2,0,0]) 
cube([clamp_centering_length,thickness,height],center=true);

//cylinder
translate([-cos(clamp_angle2/2)*clamp_centering_length,thickness/2+distance/2+sin(clamp_angle2/2)*clamp_centering_length,-height/2]) 
cylinder(r=thickness/2,h=height,$fn=30);
}
}

module cube_for_cut(){ //for cutting the clamp off in the length direction (length direction = x axis, same direction as smartphone thickness)
    
tl=calc_total_length();
tw=calc_total_width();

translate([-tl+thickness,-tw/2,bracket_height/2])
cube([tl,tw,clamp_height]);
}

module cube_for_cut2(){ //for cutting the clamp off in the width direction if needed (width direction = y axis, same direction as smartphone width)
    
tl=calc_total_length();
tw=calc_total_width();
    
translate([-tl+thickness,smartphone_width/2+thickness,-clamp_height/2])
cube([tl,tw,clamp_height]); 
}


//functions
//---------

function calc_wc()= //wc stands for width clamp
    2*clamp_length*tan(clamp_angle2/2)+2*thickness*cos(clamp_angle2/2)+clamp_gap;

function calc_hc()= //hc stands for height clamp
    bracket_height/abs(cos(clamp_rotation))+calc_wc()*abs(tan(clamp_rotation)); //wb stands for width bracket, a max for the maximal angle to which the clamp can be rotated (i take this to be 60°)

function calc_hc_rotated()=
    bracket_height+2*calc_wc()*abs(sin(clamp_rotation));

function calc_wc_rotated()=
    calc_wc()*abs(cos(clamp_rotation))+calc_hc()*abs(sin(clamp_rotation));

function calc_total_width()= //total width of the part (width in the same direction as smarthone width)
max(calc_wc_rotated(),smartphone_width+2*thickness);

function calc_total_length()= //total length of the part
2*thickness+smartphone_thickness+clamp_length+clamp_centering_length*cos(clamp_angle1/2)+thickness/2;