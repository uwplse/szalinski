hole =30; //	[10:extra small, 20:small, 30:medium, 40:large, 50:XL]
box_thickness = 30;
center_hole = 9; 
screw_hole = 3;
mount_thickness = 5;
base_width = 70;

//bottom half 
difference () {
cube ([box_thickness, hole + 10, hole + 10]);
    
    // center hole 
translate ([0, (hole + 10)/2, (hole + 10)/2])
rotate ([0,90,0])
cylinder (box_thickness +55,center_hole, center_hole,center=true);
    // screw holes
  translate ([box_thickness/2,6,0])    
cylinder (hole + 10,screw_hole,screw_hole);
    translate ([box_thickness/2,hole +4,0])
    cylinder (hole + 10,screw_hole,screw_hole);
     translate ([0,0,hole/1.55])
    
    // cuts in half 
 cube (250,250,hole/2);
}

//screw base
difference () {
translate ([box_thickness/2, (hole+10)/2,mount_thickness/2])
rotate ([0,90,0])
cube ([mount_thickness, base_width, box_thickness], center= true);
translate ([box_thickness/2,-7,-10])
cylinder (hole + 10,screw_hole,screw_hole);
    translate ([box_thickness/2, 47,-10])
cylinder (hole + 10,screw_hole,screw_hole);
}

//top half
translate ([-60,0,0])
difference () {
cube ([box_thickness, hole + 10, hole + 10]);
translate ([0, (hole + 10)/2, (hole + 10)/2])
rotate ([0,90,0])
cylinder (box_thickness +55,center_hole, center_hole,center=true);
  translate ([box_thickness/2,6,0])
cylinder (hole + 10,screw_hole,screw_hole);
    translate ([box_thickness/2,hole + 4,0])
    cylinder (hole + 10,screw_hole,screw_hole);
    translate ([0,0,hole/1.55])
 cube (250,250,hole/2);
  
}