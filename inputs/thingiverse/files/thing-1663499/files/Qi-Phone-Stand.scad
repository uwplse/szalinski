// Diameter of your wireless charger
QiDiameter = 70;
// Thickness of your wireless charger
QiThickness = 10;
// Width of the USB connector that you're using with the wireless charger. I would recommend giving an extra 1mm buffer over what you measured.
USBWidth = 11;
// We'll need this to position the wireless charger at the center of your phone.
PhoneHeight = 140;
// This determines the size of the base where the phone rest on. The default should be fine for most naked phones, but you may want to use a larger value if you have a thick casing.
PhoneThickness = 12;
// The default should be fine, but you can use a different value to have a thicker or thinner wall.
WallThickness = 3;
// The angle (in degrees) that the holder is tilted at.
Tilt = 70;

/* [Hidden] */
$fa = 6;
$fs = 0.5;


// Side Profile in 2D
module Side_Profile() {
 p2x = 0.25*QiDiameter + 0.5*PhoneHeight;
 p4x = p2x + WallThickness;
 p3x = p2x+1.5*cos(Tilt)+1.5;
 p3y = PhoneThickness+1.5*sin(Tilt);
 temp1 = (PhoneThickness-3*tan(Tilt))*cos(Tilt)+3;
 p5x = p3x + temp1*sin(Tilt);
 p5y = p3y - temp1*cos(Tilt);
 temp2 = sin(Tilt) * (p5x - (p5y + QiThickness + WallThickness) / tan(Tilt));
 p6x = temp2*sin(Tilt);
 p6y = -temp2*cos(Tilt) - QiThickness - WallThickness;
    
 difference() {
  union() {
   polygon([[0,0],
            [p2x - 1, 0],
            [p2x - 0.35, 0.35],  // Simple fillet
            [p2x, 1],
            [p2x, PhoneThickness], 
            [p3x, p3y],
            [p5x, p5y],
            [p6x, p6y],
            [0,-QiThickness - WallThickness]
           ]);
   translate([0,-0.5*(QiThickness+WallThickness),0]) circle(d=QiThickness+WallThickness);
   translate([p2x+1.5,PhoneThickness,0]) circle(d=3);
  }
  temp3 = 0.5 * temp2 / cos(Tilt);
  translate([0,-QiThickness - WallThickness - temp3,0]) circle(r=temp3);
 }
}

// Extruded and excess removed
module Extruded() {
 difference() {
  linear_extrude(height = QiDiameter + 2*WallThickness) Side_Profile();
  translate ([-100,-400-QiThickness-WallThickness,WallThickness]) resize([400,400,0]) cube(QiDiameter);
 }
}

// Qi Hole cut
module Qi_Hole() {
 difference() {
  Extruded();
  translate([0,-QiThickness,QiDiameter+WallThickness])
   rotate([-90,0,0])
    linear_extrude(height = 100)
     union() {
      polygon([[-100,0],
               [QiDiameter*0.25,0],
               [QiDiameter*0.25,QiDiameter],
               [-100,QiDiameter]
              ]);
      translate ([QiDiameter*0.25,QiDiameter/2,0]) circle(d=QiDiameter);
     }
  translate([0,-50,QiDiameter+WallThickness-QiThickness])
   rotate([-90,0,0])
    linear_extrude(height = 100)
     difference() {
      union() {
       polygon([[0,0],
                [QiDiameter*0.25,0],
                [QiDiameter*0.25,QiDiameter-2*QiThickness],
                [0,QiDiameter-2*QiThickness],
                [-QiThickness,QiDiameter-QiThickness],
                [-QiThickness,-QiThickness]
               ]);
       translate ([QiDiameter*0.25,(QiDiameter-2*QiThickness)/2,0]) circle(d=QiDiameter-2*QiThickness);
      }
      translate([0,-(QiThickness+WallThickness)/2,0]) circle(r=(QiThickness+WallThickness)/2);
      translate([0,QiDiameter-2*QiThickness+(QiThickness+WallThickness)/2,0]) circle(r=(QiThickness+WallThickness)/2);
     }
 }
}

  


// USB Hole cut
module USB_Hole() {
 difference() {
  Qi_Hole();
  translate([QiDiameter*0.75,-QiThickness/2,QiDiameter/2+WallThickness])
   resize([50,QiThickness,0])
    cube(USBWidth,center=true);
//  translate([QiDiameter*0.75+30+20,-QiThickness-WallThickness,QiDiameter/2+WallThickness])
  translate([PhoneHeight*0.5+QiDiameter*0.25+15,-QiThickness-WallThickness,QiDiameter/2+WallThickness])
   resize([60,QiThickness*2,0])
    cube(USBWidth,center=true);
 }
}

USB_Hole();