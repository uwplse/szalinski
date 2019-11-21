// increases to tighten, decrease to loosen
tol=.5; 
length=40;

size="30"; // [20:20mm,30:30mm]
screw_hole_diameter=3;
// from furthest corners
nut_diameter=6.3; 
nut_depth=2.3;
num_screws=2;
screw_spacing=20;
initial_screw_offset=10;

connector((size=="30")?30:20);

module connector(size) {
  base_size=size;
  edge_width=(size==30)?2.21:1.5;
  top_width=(size==30)?16.51:11.99;
  cross_width=(size==30)?2.54:1.5;
  core_size=(size==30)?11.64:7.32; 

  $fn=60;
  top_width_tol=top_width-tol*2;
  edge_width_tol=edge_width+tol;
  cross_width_tol=cross_width+tol*2;
  core_size_tol=core_size+tol;

  difference() {
    linear_extrude(length)
      sketch();   
    screw_holes();
  }  

  module screw_holes() {  
    for(i=[0:screw_spacing:screw_spacing*num_screws-1]) {
      translate([0,core_size/2,initial_screw_offset+i])
        rotate([270,0,0])  
          screw_hole();  
    }
  }
    
  module screw_hole() {
    cylinder(d=screw_hole_diameter+tol,h=50);
    cylinder(h=nut_depth, $fn=6, d=nut_diameter);
  }  

  module sketch() {
    difference() {
      base();
      cross_beams();
      core();
      corner_cut();
    }
    
    module core() {
      square(core_size_tol, true);
    }

    module corner_cut() {
      corner_size=(base_size-top_width_tol)/2;
      translate([-base_size/2,base_size/2-corner_size,0])
        square(corner_size);    
      translate([base_size/2-corner_size,base_size/2-corner_size,0])
        square(corner_size);  
    }

    module base() { 
      translate([-base_size/2,0,0])
        square([base_size,base_size/2-edge_width_tol]);
    }

    module cross_beams() {
      rotate([0,0,-45])
        translate([-cross_width_tol/2,0,0])
          square(30);
      
      rotate([0,0,45])
        translate([-30+cross_width_tol/2,0,0])
          square(30);
    }
  }
}