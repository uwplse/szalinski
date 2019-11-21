// preview[view:northwest]

//Resolution of Model

res = 500;

//Speaker Total Diameter mm

speaker_diameter = 177.5;

//Speaker Hole Diameter mm

speaker_hole_cutout = 143;

//Speaker Baffle Depth mm

baffle_depth = 4;

// Thickness of Part that Holds Speaker mm

speaker_holder_thickness = 15;

// "Beefiness" of the Entire Structure mm

baffle_beef = 10;

// Number of Baffle Holes for Bolts

number_holes = 4;

// Additional Rotation to Baffle Holes (Allows you to make odd numbers of baffle holes look nice)

speaker_extra_hole_rotate = 45;

//Size of Baffle Bolt Holes Diameter mm

hole_size = 7;

//Offset of Baffle Holes mm

hole_offset = 3;

//Height of Stand

stand_height = 101;

//Length of Base

base_length=150;

//Height of Triangle Supports

triangle_supports_height = 102;

//Length of Triangle Supports

triangle_supports_length = 150;

//Raise Rear Vertices of Triangle Supports to be Flush with Base. Should equal "Beefiness" value

back_triangle_support = 10;

//Size of Base Circle Cutout 

save_plastic=55;

// Move the XLR Panel Forward or Backward

XLR_jack_move_forward_back = 17;

// Move the XLR Panel Up or Down

XLR_jack_move_up_down = -3;

// Move XLR Jack Up or Down (Remember you can use negative numbers too!)

XLR_up_down = 2;

// Raise XLR Panel Front Corner to Intersect with Triangle Support

raise_jack_corner = 53;

// Raise XLR Panel Rear Corner to Intersect with Triangle Support

raise_rear_jack_corner = 29;

// Thickness of XLR Panel. 3 is the maximum panel depth recommended by Neutrik

xlr_mount_thickness = 3;

//Orient Sub-Kick Properly for 3D Printing? (Rotates model so no support will be necessary - Choose "Yes"!)
ready_for_print = "No"; // [Yes, No] 

module sub_holder(){

difference(){

rotate([0,90,0]) cylinder(speaker_holder_thickness,(speaker_diameter/2)+baffle_beef,(speaker_diameter/2)+baffle_beef, $fn=res);

rotate([0,90,0]) translate([0,0,-1]) cylinder(speaker_holder_thickness+2,(speaker_hole_cutout/2),(speaker_hole_cutout/2), $fn=res);
    
rotate([0,90,0]) translate([0,0,-1]) cylinder(baffle_depth+1,(speaker_diameter/2),(speaker_diameter/2), $fn=res);
    
for ( booyah = [0 : number_holes] )
{
    rotate( (booyah * 360 / number_holes) + speaker_extra_hole_rotate, [1, 0, 0])
    translate([0, ((speaker_diameter/2) + (speaker_hole_cutout/2))/2 + hole_offset, 0])
    rotate([0,90,0]) translate([0,0,-1]) cylinder(speaker_holder_thickness+2,(hole_size/2),(hole_size/2), $fn=res/2);}
    
}

}

module stand_risers(){

rotate([0,180,0]) translate([-speaker_holder_thickness,(speaker_diameter/2),0]) cube([speaker_holder_thickness,baffle_beef,stand_height]);
    
difference(){
rotate([0,0,180])translate([-speaker_holder_thickness,0,-stand_height]) cube([base_length,(speaker_diameter/2)+baffle_beef,baffle_beef]);
    

//Circle cutout

 translate([((-base_length+speaker_holder_thickness)/2),0,-stand_height+(baffle_beef/2)]) cylinder((baffle_beef+2),save_plastic,save_plastic, $fn=res, center=true);

}
    
rotate([0,-90,90])translate([-stand_height,-speaker_holder_thickness,(speaker_diameter/2)]) linear_extrude(height = baffle_beef) polygon(points=[[0,0],[triangle_supports_height,0],[back_triangle_support,triangle_supports_length],[10,10],[triangle_supports_height-25,10],[back_triangle_support+2,triangle_supports_length-25]], paths=[[0,1,2],[3,4,5]]);

}

module XLR_TRS_Mount(){

translate([XLR_jack_move_up_down,0,0]) 
    
 difference(){

 union(){

translate([0,0,-xlr_mount_thickness/2])linear_extrude(xlr_mount_thickness) polygon(points=[[-20,-20],[-20,20],[raise_jack_corner,20],[raise_rear_jack_corner,-20]], paths=[[0,1,2,3]]);
    
}

translate([XLR_up_down,0,0]) cylinder(xlr_mount_thickness+5,24.5/2,24.5/2, $fn=res/3, center=true);
translate([XLR_up_down+(24/2),19/2,0]) cylinder(xlr_mount_thickness+5,4/2,4/2, $fn=res/3, center=true);
translate([XLR_up_down-(24/2),-19/2,0]) cylinder(xlr_mount_thickness+5,4/2,4/2, $fn=res/3, center=true);
}
}

module Mount_reflect(){

translate([XLR_jack_move_up_down,0,0]) 

translate([0,0,-xlr_mount_thickness/2])linear_extrude(xlr_mount_thickness) polygon(points=[[-20,-20],[-20,20],[raise_jack_corner,20],[raise_rear_jack_corner,-20]], paths=[[0,1,2,3]]);
    
//translate([0,22.5,5]) cube([40,5,15], center = true);
//translate([0,-22.5,5]) cube([40,5,15], center = true);

}



if (ready_for_print == "Yes"){

rotate([0,90,0]) union(){
sub_holder();
stand_risers();
mirror([0,1,0]) stand_risers();
translate([-XLR_jack_move_forward_back,(speaker_diameter/2)+baffle_beef-xlr_mount_thickness/2,-stand_height+30]) rotate([-90,-90,0]) XLR_TRS_Mount();
  translate([-XLR_jack_move_forward_back,(-speaker_diameter/2)+(-baffle_beef+xlr_mount_thickness/2),-stand_height+30]) rotate([-90,-90,0]) Mount_reflect();  
}

} else {
    
union(){
sub_holder();
stand_risers();
mirror([0,1,0]) stand_risers();  
translate([-XLR_jack_move_forward_back,(speaker_diameter/2)+baffle_beef-xlr_mount_thickness/2,-stand_height+30]) rotate([-90,-90,0]) XLR_TRS_Mount(); 
    
    
    translate([-XLR_jack_move_forward_back,(-speaker_diameter/2)+(-baffle_beef+xlr_mount_thickness/2),-stand_height+30]) rotate([-90,-90,0]) Mount_reflect();
    
}
    
}





