// thickness of the matreial(glass) yu want to slide it on in mm
glass_thickness = 5;
// lengh of the part which is sliding onto the glass in mm
grabber_length = 35;
// widht of the holder in mm
grabber_width = 30;
// thicknss of the used plastic in mm
Material_thickness = 2;
union(){
  linear_extrude( height=grabber_length, twist=0, scale=[1, 1], center=false){
    union(){
      square([grabber_width, Material_thickness], center=false);
      translate([0, (glass_thickness + Material_thickness * 1), 0]){
        square([grabber_width, Material_thickness], center=false);
      }
    }
  }
  translate([0, 0, grabber_length]){
    cube([grabber_width, (glass_thickness + Material_thickness * 2), Material_thickness], center=false);
  }
  translate([0, -15, 0]){
    cube([grabber_width, 15, Material_thickness], center=false);
  }
  translate([0, -15, 0]){
    cube([grabber_width, Material_thickness, 20], center=false);
  }
}