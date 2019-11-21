y_shaft_mount();

thickness=5;
width=40;
size=30;
bar_height=40;
hole_spacing=50/3;

module y_shaft_mount() {
  difference() {
    union() {
      linear_extrude(thickness)
        square([width,size]);
      translate([0,size,-size])
        linear_extrude(size+thickness)    
          square([width,thickness]);
      translate([0,0,thickness])
        linear_extrude(bar_height)
          square([width,thickness]);
      translate([0,size-thickness,size-thickness*2])
        side_wall();
      translate([width-thickness,size-thickness,size-thickness*2])
        side_wall();
    }
    holes();
  }  
  
  module holes() {
    $fn=60;
    translate([width/2+hole_spacing/2,15,0])
      cylinder(d=4,h=15);
    translate([width/2-hole_spacing/2,15,0])
      cylinder(d=4,h=15);
    translate([width/2+hole_spacing/2,40,-15])
      rotate([90,0,0])
        cylinder(d=4,h=15);
    translate([width/2-hole_spacing/2,40,-15])
      rotate([90,0,0])
        cylinder(d=4,h=15);
    translate([width/2,15,30])
      rotate([90,0,0])
        cylinder(d=8.2,h=20);
  }
  
  module side_wall() {
    rotate([0,180,0])
      rotate([90,0,0])
        rotate([0,90,0])
          translate([-20,-25,-5])
            linear_extrude(5)
              polygon([[0,0],[0,40],[30,40]]);
  }
}