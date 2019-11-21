//!OpenSCAD
// diameter of the cutout hole in mm
Hole_Diameter = 10;
//width of the holder in mm
width = 50;
// length of the two holders in mm
Phone_grabber_length = 10;
// thicknessof your phone/tablet + a tolerance in mm
Phone_thickness = 5;
// length of your plug + lenth of the cable with the curve in mm
Plug_length = 20;
// length of the holder wich you phoneleads on in mm
Holder_length = 40;
// angle ofthe rear holder
Angle = 60;
//angle of the phone
Phone_Angle = 100;
//overall materialthickness in mm
Material_thickness = 2;
Side_length = (sin(Phone_Angle) * (Holder_length * 1) + Plug_length) / sin(Angle);
difference() {
  linear_extrude( height=width, twist=0, scale=[1, 1], center=false){
    union(){
      square([Material_thickness, Side_length], center=false);
      rotate([0, 0, Angle]){
        square([Material_thickness, Side_length], center=false);
      }
      translate([(sin(Angle) * (Side_length * -1) - sin(Phone_Angle) * (Holder_length * -1)), (cos(Angle) * Side_length + cos(Phone_Angle) * (Holder_length * -1)), 0]){
        rotate([0, 0, Phone_Angle]){
          union(){
            square([Material_thickness, Holder_length], center=false);
            union(){
              translate([Phone_thickness, 0, 0]){
                rotate([0, 0, 90]){
                  square([Material_thickness, Phone_thickness], center=false);
                }
              }
              translate([(Phone_thickness * 1), (Material_thickness * 0), 0]){
                rotate([0, 0, 0]){
                  square([Material_thickness, Phone_grabber_length], center=false);
                }
              }
            }
          }
        }
      }
    }
  }

  translate([((sin(Phone_Angle) * (Holder_length * 1) + Plug_length) / -2), 0, (width / 2)]){
    rotate([90, 0, 0]){
      cylinder(r=Hole_Diameter, r=Hole_Diameter, h=20000, center=true);
    }
  }
}