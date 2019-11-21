//!OpenSCAD

filament_radius = 1.75;
grabber_length = 2;
spool_side_width = 5;
Height = 5;
/*[Hidden]*/
material_thickness = 1;

linear_extrude( height=Height, twist=0, scale=[1, 1], center=false){
  union(){
    translate([0, ((filament_radius - material_thickness * 1) / -1), 0]){
      difference() {
        difference() {
          {
            $fn=40;    //set sides to 40
            circle(r=(filament_radius + material_thickness));
          }

          {
            $fn=40;    //set sides to 40
            circle(r=filament_radius);
          }
        }

        translate([-50, (filament_radius - material_thickness * 1), 0]){
          square([100, 2], center=false);
        }
      }
    }
    union(){
      translate([(filament_radius - (filament_radius / 0.75) * 0.2), 0, 0]){
        square([7, material_thickness], center=false);
      }
      translate([((filament_radius - (filament_radius / 0.75) * 0.2) + 7), material_thickness, 0]){
        rotate([0, 0, 90]){
          square([spool_side_width, material_thickness], center=false);
        }
      }
      translate([((filament_radius - (filament_radius / 0.75) * 0.2) - 3), (spool_side_width + material_thickness * 1), 0]){
        square([10, material_thickness], center=false);
      }
    }
    translate([((filament_radius - (filament_radius / 0.75) * 0.2) - 3), (spool_side_width + (material_thickness - (grabber_length - material_thickness))), 0]){
      square([material_thickness, grabber_length], center=false);
    }
  }
}