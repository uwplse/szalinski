//!OpenSCAD
// radius of the main holer
Hole_radius = 15;
//roundness of the main hole
Hole_sides = 60;
// width of the phone in mm
width = 75;
// length of the grabber inmm
Phone_grabber_length = 10;
//thivkness of your phone+ tolerance + material thickness
Phone_thickness = 12;
// Length of theplug+ cablecurve length
Plug_length = 40;
//length of the holder
Holder_length = 40;
// angle of the back side
Angle = 60;
//Angle of the phone
Phone_Angle = 110;
// thickness of the material used inmm
Material_thickness = 3;
//radius of the hole inthe base
Base_hole_radius = 20;
// sides of thebase hole
Base_hole_sides = 6;
Side_length = (sin(Phone_Angle) * (Holder_length * 1) + Plug_length) / sin(Angle);


union(){
  difference() {
    rotate([0, 90, 0]){
      translate([0, (Side_length / -2), (width / -2)]){
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
              {
                $fn=Hole_sides;    //set sides to Hole_sides
                cylinder(r1=Hole_radius, r2=Hole_radius, h=20000, center=true);
              }
            }
          }
        }
      }
    }

    {
      $fn=Base_hole_sides;    //set sides to Base_hole_sides
      cylinder(r1=Base_hole_radius, r2=Base_hole_radius, h=10, center=true);
    }
  }
  difference() {
    translate([0, (Side_length / -2 + 5), 0]){
      rotate([0, 90, 0]){
        cylinder(r1=5, r2=5, h=width, center=true);
      }
    }

    translate([-500, -500, -11]){
      cube([1000, 1000, 10], center=false);
    }
  }
}