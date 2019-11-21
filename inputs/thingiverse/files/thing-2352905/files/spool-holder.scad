bearing_hole_diameter=7.9;
inner_cylinder_diameter=24;

union() {
  difference() {
    union() {
      base_roller();
      arc();
    }
    groove();
    pin_hole();
  }  
  bearing_mounts();
  tabs();
}

base_rect_size=16;

module pin_hole() {
  translate([base_rect_size/2,18,126-11])
    rotate([90,0,0])
      linear_extrude(20)
        square(5, true);
}

module tabs() {
  thick=2;
  linear_extrude(thick)
    translate([base_rect_size/2,30,0])
      circle(8);
  translate([0,0,95-thick])
    linear_extrude(thick)
      translate([base_rect_size/2,30,0])
        circle(8);
}

module bearing_mounts() {
  translate([base_rect_size/2,25,63])
    cylinder(d=bearing_hole_diameter,h=10);
  translate([base_rect_size/2,25,17])
    cylinder(d=bearing_hole_diameter,h=10);
}

module groove() {
  translate([base_rect_size/2,25,20]) 
    cylinder(d=inner_cylinder_diameter,h=50);
}

module arc() {
  radius=23;
  height=95;
  
  difference() {
    translate([base_rect_size/2,base_rect_size/2,0])
      cylinder(r=radius,h=height);
    
    linear_extrude(2000) {
      translate([base_rect_size/2,0,0])
        rotate([0,0,-45])
          square([100,100]);
      translate([base_rect_size/2,0,0])
        rotate([0,0,135])
          square([100,100]);
      translate([-50,-100,0])
        square([100,100]);
    }    
  }    
}

module base_roller() {  
  chamfer=4;  
  linear_extrude(126)
    translate([chamfer,chamfer,0])
      minkowski() {    
        square([base_rect_size-chamfer*2,base_rect_size-chamfer*2]);
        circle($fn=60,r=chamfer);
    }
  //square([base_rect_size,base_rect_size]);
}