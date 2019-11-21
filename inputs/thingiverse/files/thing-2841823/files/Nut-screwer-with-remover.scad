// The accuracy of your printer
printer_accuracy = 0.2;
// If you need aremover for the nuts
remover = "yes";//[yes,no]
// height of the holder in mm
height = 20;
// Outer diameter of your nuts in mm
nut_diameter = 3;
// Diameter of the handle in mm
Main_diameter = 8;
// Lengh of the screws you want to secrew your nuts on in mm
screw_lengh = 15;
if (remover == "yes") {
  union(){
    difference() {
      union(){
        linear_extrude( height=height, twist=0, scale=[1, 1], center=false){
          {
            $fn=6;    //set sides to 6
            circle(r=Main_diameter);
          }
        }
        translate([0, 0, height]){
          difference() {
            linear_extrude( height=screw_lengh, twist=0, scale=[1, 1], center=false){
              {
                $fn=6;    //set sides to 6
                circle(r=(nut_diameter + 2));
              }
            }

            linear_extrude( height=screw_lengh, twist=0, scale=[1, 1], center=false){
              {
                $fn=6;    //set sides to 6
                circle(r=nut_diameter);
              }
            }
          }
        }
      }

      {
        $fn=50;    //set sides to 50
        cylinder(r1=(2 + printer_accuracy), r2=2, h=100, center=false);
      }
    }
    translate([(Main_diameter + 10), 0, 0]){
      union(){
        linear_extrude( height=3, twist=0, scale=[1, 1], center=false){
          {
            $fn=6;    //set sides to 6
            circle(r=Main_diameter);
          }
        }
        {
          $fn=50;    //set sides to 50
          cylinder(r1=2, r2=2, h=(height + (screw_lengh - 1)), center=false);
        }
      }
    }
  }
} else {
  union(){
    linear_extrude( height=height, twist=0, scale=[1, 1], center=false){
      {
        $fn=6;    //set sides to 6
        circle(r=Main_diameter);
      }
    }
    translate([0, 0, height]){
      difference() {
        linear_extrude( height=screw_lengh, twist=0, scale=[1, 1], center=false){
          {
            $fn=6;    //set sides to 6
            circle(r=(nut_diameter + 2));
          }
        }

        linear_extrude( height=screw_lengh, twist=0, scale=[1, 1], center=false){
          {
            $fn=6;    //set sides to 6
            circle(r=nut_diameter);
          }
        }
      }
    }
  }
}
