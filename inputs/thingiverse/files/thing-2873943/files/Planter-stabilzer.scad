// thickness of the material in mm
Material_thickness = 3;
//width of your planter in mm when it is compressed
width_of_the_planter = 165;
// height of the rim in mm
height_of_the_rim = 5;
// length of the holder in mm (if you don't want that, set to 0)
length_of_the_holder = 5;
// width of the clamb in mm
width_of_the_whole_clamb = 10;
linear_extrude( height=width_of_the_whole_clamb, twist=0, scale=[1, 1], center=false){
  union(){
    mirror([0,1,0]){
      union(){
        square([Material_thickness, (width_of_the_planter / 2)], center=false);
        translate([0, (width_of_the_planter / 2), 0]){
          square([(height_of_the_rim + Material_thickness * 2), Material_thickness], center=false);
        }
        translate([(height_of_the_rim + Material_thickness), (width_of_the_planter / 2 - (length_of_the_holder + Material_thickness)), 0]){
          square([Material_thickness, (length_of_the_holder + Material_thickness)], center=false);
        }
      }
    }
    union(){
      square([Material_thickness, (width_of_the_planter / 2)], center=false);
      translate([0, (width_of_the_planter / 2), 0]){
        square([(height_of_the_rim + Material_thickness * 2), Material_thickness], center=false);
      }
      translate([(height_of_the_rim + Material_thickness), (width_of_the_planter / 2 - (length_of_the_holder + Material_thickness)), 0]){
        square([Material_thickness, (length_of_the_holder + Material_thickness)], center=false);
      }
    }
  }
}