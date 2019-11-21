$fa=5;
$fs=0.1;

o_height = 60;
o_top_width = 14;
o_bottom_width = 21;

wall_thickness = 2;

edge_radius = 3;

overlap = 5;

flap_length = 10;
flap_overlap = 8;

angle = 45; // 0 is right end, 360 is left end, others create edges


module slice(r = 10, deg = 30) {
/* This is taken from the mailing list:
http://forum.openscad.org/Creating-pie-pizza-slice-shape-need-a-dynamic-length-array-td3148.html  
*/  
  degn = (deg % 360 > 0) ? deg % 360 : deg % 360 + 360;
  difference() {
    circle(r);
    if (degn > 180) intersection_for(a = [0, 180 - degn]) 
      rotate(a) translate([-r, 0, 0]) square(r * 2);
    else 
      union() for(a = [0, 180 - degn]) rotate(a) translate([-r, 0, 0]) square(r * 2);

  }
}


module outer() {
  hull() {
    translate([o_top_width-edge_radius, o_height-edge_radius]) circle(r=edge_radius);
    
    polygon([ [0,0], [o_bottom_width,0], [o_top_width-edge_radius, o_height-edge_radius], [0, o_height]   ]);
  }
}


module inner() {
  hull() {
    translate([o_top_width-edge_radius-wall_thickness, o_height-edge_radius-wall_thickness]) circle(r=edge_radius);
    
    polygon([ [-0.1,-0.1], [o_bottom_width-wall_thickness,-0.1], [o_top_width-edge_radius-wall_thickness, o_height-edge_radius-wall_thickness], [-0.1, o_height-wall_thickness]   ]);    
  }
}


module flap() {
  linear_extrude(flap_overlap)
    polygon([[0,0], [wall_thickness/2, 0], [wall_thickness/2, flap_length], [0, flap_length]]);
  for (x = [flap_length/4, flap_length/2, 3*(flap_length/4)]) {
    translate([wall_thickness/2, x, 0])
      cylinder(h=flap_overlap*0.6, d1=wall_thickness*0.7, d2=wall_thickness/3);
  }
}

module full_mount() {
  difference() {
    linear_extrude(overlap + wall_thickness) outer();
    translate([0,0,wall_thickness]) linear_extrude(overlap*1.01) inner();
  }

  translate([0, o_height-9-flap_length, 0]) flap();

  translate([o_bottom_width-8, 3, 0])
    rotate([0,0,90-61.14]) flap();
}

if (0 == angle) {
  full_mount();
} else if (360 == angle) {

  mirror([1,0,0]) full_mount();
} else {
  translate([0,0,-0.1])full_mount();
  rotate([0,-180+angle,0]) 
  mirror([1,0,0]) full_mount();
  rotate([0,-1,0])
  difference() {
    rotate([-90,0,0]) rotate_extrude() outer();
    translate([0,-1,0]) rotate([-90,0,0]) 
      linear_extrude(o_height+2)  slice(o_bottom_width+2, 360-(angle+2));
   
    
  }
}

