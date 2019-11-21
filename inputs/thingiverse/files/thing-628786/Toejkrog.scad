/*-------------------------------*\
|  YACH Yet Another Coat Hanger   |
| Parametrized for the Customizer |
| Creative Commons-Share alike    |
|  User Msquare on Thingverse     |
\*-------------------------------*/

// Based on my first simple "Yet Another Coat Hanger" Thing:593330

// Number of hooks
NOH = 2; //[1:7]

// Base Plate Height
BPH = 50 ; //[20:100]

// Base Plate Width
BPW = 25 ; //[20:60]

// Base Plate Thickness
BPT = 3 ; //[1:10]

// Screw Hole Diameter ( < BPW )
SHD = 2.5 ; //[2:20]

// Stem Length
SLN = 30 ; //[20:60]

// Stem Diameter Bottom 
SDB = 6 ; //[3:10]

// Stem Diameter Top 
SDT = 4 ; //[3:20]

// Size of tip ( > SDT*1.3 may require support material )
SOT = 6 ; //[3:20]

// Angle of Stem ( < 45 may require support material )
AOS = 55 ; //[10:85]

for (N=[1:NOH]) {
  translate([(N-1)*BPW-0.01,0,0]) 
  difference() {
    union() {
      // The Base plate
      cube([BPW, BPH, BPT]) ; 

      // The cylinder/cone, at an angle.
      translate([BPW/2, 10, -3]) rotate([AOS-90, 0, 0]) 
        cylinder(r1=SDB, r2= SDT, h=SLN) ;

     // The Sphere tip 
      translate([BPW/2, 10+SLN*cos(AOS), -3+SLN*sin(AOS)])
        sphere(r=SOT) ;
    }

    // Clean off bottom protrusions
    translate([0,0,-9.99])
      cube([BPW, BPH, 10]) ;

    // The screw hole
// 1 (BPW/2,BPW/2)
// 2 (-,BPW)(0,-)
// 3 (-,BPW)(0,BPW)(0,-)
      translate([(N>1)?0:(NOH==1)?BPW/2:BPW, BPH-SHD-(BPW-SHD)/4, -1])
        cylinder(r=SHD, h=BPT+2, $fn=10) ;
      translate([(N<NOH)?BPW:((NOH==1)?BPW/2:0), BPH-SHD-(BPW-SHD)/4, -1])
        cylinder(r=SHD, h=BPT+2, $fn=10) ;

  }
}