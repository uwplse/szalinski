// alternate femur

use <servo_arm.scad>;

cutoff_margin=0.01;

module body2(thickness=5,
  t1= 4,
  t2=4,
  center_to_center = 45,
  width=12
) {
	difference() {
		translate([0,0,thickness/2]) 
      union() {
        
        difference() {
          x_size_1=center_to_center;
          
          /* box */
          
          ofs=width/2-thickness/2;
          
          translate([
            0,
            0,
            ofs
          ])
            cube([x_size_1, width, width],
            center = true);
          
          
          /* box CUTOFF*/
          x_size=x_size_1+cutoff_margin;
          y_size=width+cutoff_margin;
          z_size=width+cutoff_margin;
          x_offset=center_to_center/2;
          z_offset_1=ofs+thickness;

          
          translate([
            -x_offset,
            0,
            z_offset_1
          ])
            cube([x_size, y_size, width], center = true);
          
          z_offset=width/2;
          
          translate([
            x_offset,
            -thickness,
            ofs
          ])
            cube([x_size, width, z_size], center = true);
        
          
          /*CYLINDERS*/
          
          thickness_a=thickness+cutoff_margin;
          radius=center_to_center/2;
          rad_off=radius+thickness/2;
          
          translate([
            0,
            -radius+width/2-thickness,
            0
          ])
            cylinder(r=radius+0.08, h=thickness_a, center = true);

          translate([
            0,
            ofs,
            rad_off
          ])
            rotate([-90,0,0])
              cylinder(r=radius+0.08, h=thickness_a, center = true);
        }
        

        
        translate([
          -center_to_center/2,
          0,
          (t1-thickness)/2
        ])
          cylinder(
            r = width/2,
            h = t1,
            center = true
          );
        

        rotate([90,0,0])
          translate([
            center_to_center/2,
            width/2-thickness/2,
            t2/2-width/2
          ])
            cylinder(
              r = width/2,
              h = t2,
              center = true
            );
      }
  }
}

module femur2(
  thickness1 = 6.5,
  thickness2 = 8, 
  center_to_center = 35, 
  width = 12
) {
  
  t=min(thickness1,thickness2);
  of=center_to_center/2;
	translate([of, 0, 0])
    difference() {
      body2(t,
      thickness1,
      thickness2, 
      center_to_center, 
      width);
      
      color("red"){
        translate([
          of,
          width/2-thickness2-0.01,
          width/2
        ])
          rotate([90,0,0]) 
            rotate([0, 180, 100])
              servo_arm(body_thickness=thickness2+0.02);
        translate([
          -of,
          0,
          thickness1 + 0.01
        ])
          rotate([0, 180, -80])
            servo_arm(body_thickness=thickness1+0.02);
    }
}

}


femur2();

translate([0,30,0])
mirror([0,1,0])
femur2();