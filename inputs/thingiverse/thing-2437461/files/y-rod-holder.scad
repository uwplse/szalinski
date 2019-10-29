// RebeliX
//
// y-rod-holder
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz
// Modified by Andras Biro

/* [Screw] */

//Diameter of the screw head. 1mm additional spacing recommended
screw_head_diameter = 11.4;
//Diameter of the screw hole. 0.2 - 0.5mm additional spacing recommended
screw_diameter = 5.3;
//Width of the hammer nut. 1mm additional spacing recommended
hammer_nut_width = 7;
//Distance of screw hole center from the edge
holes_from_edge = 5.5;

/* [Base shape] */

width = 42;
height = 17;
base_thickness = 3;
thickness = 17;
rod_diameter = 8;
//Distance of the zip tie from the middle
zip_tie_offset = 3;

/* [Extrusion profile settings] */
//Width of the notch in the extrusion
slot_width = 6;
//Depth of the plastic that goes to the extrusion
slot_depth = 3;
//Enable or disable the support for the plastic that goes to the extrusion
with_support = 1; //[1:Enable, 0:Disable]
//Distance between the support and the part. Recommended to use the print layer height
support_distance = 0.2;

module y_rod_holder_base(){
  //base shape
  cube([width,thickness,height]);
  //notch to the extrusion
  notch_width = width-2*(holes_from_edge+hammer_nut_width/2);
  translate([width/2,0,height/2]) cube([notch_width,slot_depth*2,slot_width],center=true);
  //support
  if ( with_support ) {
    support_height = (height-slot_width)/2-support_distance;
    translate([width/2-notch_width/2,-slot_depth,height-support_height]) cube([notch_width,1,support_height]);
  }
}

module y_cuts(){
  // rod slot
  translate([width/2,thickness - 1.6,-0.1]) cylinder(h=(height/2)+5,r=(rod_diameter/2)+0.1,$fn = 32);
  // cut triangles from the sides
  cut_triangle_adj = (width-rod_diameter)/2-2;
  cut_triangle_opp = thickness-base_thickness;
  cut_triangle_hyp=sqrt(pow(cut_triangle_adj,2)+pow(cut_triangle_opp,2));
  angle = atan2(cut_triangle_opp,cut_triangle_adj);
  translate([0,base_thickness,0]) rotate([0,0,angle]) cube([cut_triangle_hyp,20,height]);
  translate([width-cut_triangle_adj,thickness,0]) rotate([0,0,-angle]) cube([cut_triangle_hyp,20,height]);

  //screw holes
  translate([holes_from_edge,0,height/2]) rotate([-90,0,0]) cylinder(h=40,r=screw_diameter/2,$fn = 32,center=true);
  translate([width-holes_from_edge,0,height/2]) rotate([-90,0,0]) cylinder(h=40,r=screw_diameter/2,$fn = 32,center=true);
  //deepen for screw heads
  translate([holes_from_edge,base_thickness,height/2]) rotate([-90,0,0]) cylinder(r = screw_head_diameter/2, h = 20, $fn = 30);
  translate([width-holes_from_edge,base_thickness,height/2]) rotate([-90,0,0]) cylinder(r = screw_head_diameter/2, h = 20, $fn = 30);
 
  //extend screw head deepening towards the printer
  translate([width-holes_from_edge-screw_head_diameter/2,base_thickness,0]) cube([screw_head_diameter,20,height/2]);
  translate([holes_from_edge-screw_head_diameter/2,base_thickness,0]) cube([screw_head_diameter,20,height/2]);
  
  // zip tie
  translate([width/2,thickness - 1.6,height/2 - zip_tie_offset - 2]) difference(){
    cylinder(r=rod_diameter/2+4.5,h=3,$fn=50);
    cylinder(r=rod_diameter/2+2.5,h=3.1,$fn=50);
  }
}

rotate([180,0,0]) 
difference(){
	y_rod_holder_base();
	y_cuts();
}	