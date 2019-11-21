motor_screw_hole_size=3;
screw_hole_size=4.1;
screw_radius=21.92;
inner_circle_radius=11.5;
mount_size=42;
tslot_size=30;
thickness=5;
width=40;
screw_spacing=50/3;

y_motor_mount();

module y_motor_mount() {
  $fn=60;
  translate([0,mount_size/2+tslot_size+thickness,-5])
    rotate([0,90,0])
      motor_bracket();
  tslot_attach();
  bottom_brace();
  motor_rest();

  module motor_rest() {    
    translate([0,tslot_size+thickness,-tslot_size])
      linear_extrude(thickness-.2)
        square([thickness,mount_size]);
  }

  module bottom_brace() {    
    translate([thickness,tslot_size+thickness,-tslot_size])
      linear_extrude(thickness)
        polygon([[0,0],[0,mount_size],[width-thickness,0]]);
  }

  module tslot_attach() {
    difference() {
      bracket();
      holes();
    }
    module holes() {
      translate([width/2-screw_spacing/2,tslot_size/2,0])
        cylinder(d=screw_hole_size,h=thickness+1);
      translate([width/2+screw_spacing/2,tslot_size/2,0])
        cylinder(d=screw_hole_size,h=thickness+1);
      translate([width/2-screw_spacing/2,tslot_size+thickness,-tslot_size/2])
        rotate([90,0,0])
          cylinder(d=screw_hole_size,h=thickness+1);
      translate([width/2+screw_spacing/2,tslot_size+thickness,-tslot_size/2])
        rotate([90,0,0])
          cylinder(d=screw_hole_size,h=thickness+1);
    }  
    module bracket() {
      linear_extrude(thickness)
        sketch();
      translate([0,tslot_size+thickness,-tslot_size])
        rotate([90,0,0])
          linear_extrude(thickness)
            sketch();
    }
    module sketch() {
      square([width,tslot_size+thickness]);
    }
  }

  module motor_bracket() {  
    linear_extrude(thickness)
      sketch(); 
    module sketch() {
      difference() {
        square(mount_size,true);
        for(i=[45:90:315]) {
          rotate([0,0,i])
            translate([screw_radius,0,0])
              circle(d=motor_screw_hole_size);
        }
        circle(inner_circle_radius);
      }
    }
  }
}