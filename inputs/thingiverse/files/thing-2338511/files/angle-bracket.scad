// t-slot 90 deg bracket

size=50;
width=30; // 30mm t-slot
thickness=3;
hole_diameter=3;

bracket();

module bracket() {
  $fn=60;
  difference() {
    body();
    holes();
  }  
}

module body() {
  base();
  translate([0,thickness,thickness])
    rotate([0,90,0])
      side();
  translate([width-thickness,thickness,thickness])
    rotate([0,90,0])
      side();
}

module holes() {
  holes_bottom();
  translate([0,thickness,0])
    rotate([90,0,0])
      holes_bottom();
}

module holes_bottom() {
  translate([width/2,size/3,0])
    cylinder(d=hole_diameter, h=thickness+1);
  translate([width/2,2*(size/3),0])
    cylinder(d=hole_diameter, h=thickness+1);
}

module base() {
  linear_extrude(thickness)
    bottom_sketch();  
  back();
}

module side() {
  linear_extrude(thickness)
    side_sketch();
}

module side_sketch() { 
  polygon([[0,0],[-(size-thickness),0],[0,size-thickness]]);
}

module bottom_sketch() {
  square([width,size]);
}

module back() {
  translate([0,thickness,0])
    rotate([90,0,0])
      linear_extrude(thickness)  
        bottom_sketch();
}