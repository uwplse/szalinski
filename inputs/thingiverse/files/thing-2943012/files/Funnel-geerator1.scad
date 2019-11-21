//!OpenSCAD

Upper__outer__radius = 30;
tube_outer_radius = 5;
Material_thickness = 1;
tube_length = 30;
funnel_height = 30;
lower_tube_phase_angle = 30;
hang_loop_radius = 3;
funnel_sides = 8;
union(){
  {
    $fn=funnel_sides;    //set sides to funnel_sides
    difference() {
      union(){
        difference() {
          cylinder(r1=tube_outer_radius, r2=Upper__outer__radius, h=funnel_height, center=false);

          cylinder(r1=(tube_outer_radius - Material_thickness), r2=(Upper__outer__radius - Material_thickness), h=funnel_height, center=false);
        }
        translate([0, 0, (tube_length * -1)]){
          difference() {
            cylinder(r1=(tube_outer_radius - 0), r2=(tube_outer_radius - 0), h=tube_length, center=false);

            cylinder(r1=(tube_outer_radius - Material_thickness), r2=(tube_outer_radius - Material_thickness), h=tube_length, center=false);
          }
        }
      }

      translate([0, 0, ((tube_length + 50) * -1)]){
        rotate([0, lower_tube_phase_angle, 0]){
          translate([-20, 0, 0]){
            cube([100, 100, 100], center=true);
          }
        }
      }
    }
  }
  difference() {
    translate([0, Upper__outer__radius, (funnel_height - 2)]){
      difference() {
        cylinder(r1=(hang_loop_radius + Material_thickness), r2=(hang_loop_radius + Material_thickness), h=2, center=false);

        cylinder(r1=hang_loop_radius, r2=hang_loop_radius, h=2, center=false);
      }
    }

    cylinder(r1=(tube_outer_radius - Material_thickness), r2=(Upper__outer__radius - Material_thickness), h=funnel_height, center=false);
  }
}