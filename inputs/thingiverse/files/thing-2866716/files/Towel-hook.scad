// diameter of the wall mounting plate in mm
Wall_plate_diameter = 30;
// roundness of your wall mounting plate in edges
base_roundness = 60;//[3:100]
// hight/thickness  of your wall mounting plate in mm
base_height = 2;
// diameter of the holder in mm
holder_thickness = 5;
// length of the holder in mm
holder_legth = 10;
// roundness of the holder in mm
holder_roundness = 60;//[3:100]
// angle f the holder
holder_angle = 30;
difference() {
  union(){
    translate([(Wall_plate_diameter / -4), 0, 0]){
      rotate([0, holder_angle, 0]){
        union(){
          {
            $fn=holder_roundness;    //set sides to holder_roundness
            cylinder(r1=(holder_thickness / 2), r2=(holder_thickness / 2), h=holder_legth, center=false);
          }
          translate([0, 0, holder_legth]){
            {
              $fn=holder_roundness;    //set sides to holder_roundness
              sphere(r=(holder_thickness / 2));
            }
          }
        }
      }
    }
    union(){
      {
        $fn=base_roundness;    //set sides to base_roundness
        cylinder(r1=(Wall_plate_diameter / 2), r2=(Wall_plate_diameter / 2), h=(base_height - 1), center=false);
      }
      translate([0, 0, (base_height - 1)]){
        {
          $fn=base_roundness;    //set sides to base_roundness
          cylinder(r1=(Wall_plate_diameter / 2), r2=((Wall_plate_diameter - 2) / 2), h=(base_height - 1), center=false);
        }
      }
    }
  }

  translate([0, 0, -5]){
    cube([100, 100, 10], center=true);
  }
}