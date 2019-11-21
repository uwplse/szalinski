/*
 *  arduino-uno-circuit-breadboard.scad
 *  http://www.thingiverse.com/thing:1534620
 *
 *  1.9 mm Hoehe Bord
 *    0.3 mm Nozzle = 0.3 + 8x 0.2 mm
 *    0.4 mm Nozzle = 0.4 + 5x 0.3 mm
 *  2.4 mm Hoehe Halter
 *    0.3 mm Nozzle = 12x 0.2 mm
 *    0.4 mm Nozzle =  8x 0.3 mm
 *
 *  2016-05-02 V0.1 large size 22x16
 *  2016-05-02 V0.2 small size 18x16
 *  2016-05-03 V0.3 Abstand 7/8, Lochgroesse, Extraloch links
 *
 */

height_mm = 1.9; // [1.5:0.1:4.5]
length_mm = 68.8; // [58.3:0.5:68.8]
enlarge_mm = 2; // [0:0.5:15]
grid_0 = 0; // [0:1,1:2,30:disable]
grid_x = 22; // [2:2:22]
grid_y = 16; // [2:2:16]
cable_flag = 1; // [0:disable,1:enable]
hole_flag = 2; // [1:circle,2:rectangle]
legend_flag = 1; // [0:disable,1:enable]

// height_mm = 1.2; 
// length_mm = 58.3;
// enlarge_mm = 2;
// grid_0 = 0; 
// grid_x = 18;
// grid_y = 16;
// cable_flag = 1;
// hole_flag = 2; 
// legend_flag = 0;

arduino_uno_board(
  height_mm,  // Hoehe in mm
  length_mm,  // Laenge in mm
  enlarge_mm, // vergroessern um mm
  grid_0,     // Lochraster beginnen bei Reihe 0 oder 1
  grid_x,     // Lochraster Anzahl x 
  grid_y,     // Lochraster Anzahl y
  cable_flag, // Kabelhalter fuer PINs
  hole_flag,  // Lochmuster fuer PINs
  legend_flag // Beschriftung fuer PINs
);

module arduino_uno_board(
    pheight=1.9     // Hoehe
   ,plength=68.8    // Laenge
   ,penlarge=2      // vergroessern
   ,pgrid0=1
   ,pgridx=22
   ,pgridy=16   
   ,pcablepin=1   // Halter fuer Kabel
   ,phole=2       // Muster fuer Loecher
   ,plegend=0     // Beschriftung
  ) {
  // Arduino Board
  lABx1 = 65;       // 65;
  lABx2 = 68.6;     // 68;    Laenge
  lABx3 = 0;        // 0; 
  lABy1 = 0;        // 0; 
  lABy2 = 2;        // 2; 
  lABy3 = 5;        // 5; 
  lABy4 = 37;       // 37;
  lABy5 = 40;       // 40;
  lABy6 = 53.3;     // 53;    Breite
  // Loecher
  lALd  = 3.2;      // 3.2;   Durchmesser
  lALx1 = 15.0;     // 15.0; 
  lALx2 = 65.5;     // 65.5; 
  lALy1 = 7.0;      // 7.0;  
  lALy2 = 35.0;     // 35.0; 
  lALy3 = 50.5;     // 50.5; 
  lALy4 = 2.54;     // 2.54;  53-50.5
  echo (str("Ldy: Soll=27.9mm, Ist=",(lALy2-lALy1),"mm"));
  echo (str("Ldx: Soll=50.8mm, Ist=",(lALx2-lALx1),"mm"));
  // Pins
  lAPd  = 1.00+0.2; // V03: 0.2 mm Aufmass
  lAPx  = 2.54;
  lAPx1 = 44.72;    // V03: 1.80=45.72
  lAPx2 = 40.656;   // V03: 1.64=41.656 (-21.844)
  lAPx3 = 62.50;    // V03: 2.50=63.5
  lAPy1 = 2.54;
  lAPy2 = 50.8;
  lAPn1 = 6;
  lAPn2 = 8;
  lAPn3 = 7;
  // Pin-Halter
  lAPHh = 2.40;
  lAPHy = 2.00;
  lAPHa = 0.0;
  lAPHd = 1+0.2;    // V03: 0.2 mm Aufmass
  // Lochraster
  lARd  = 1.00+0.2; // V03: 0.2 mm Aufmass
  lARx  = 2.54;
  lARy  = 2.54;
  lARx1 = 62.5-2.54*pgrid0;
  lARy1 = 2.54*3+(16-pgridy)/2*2.54;
  lARnx = pgridx;
  lARny = pgridy;
  translate([plength-68.8,0,0])
  union() {
    difference() {
      // Arduino Board
      union() {
        translate([penlarge/2,0,0])
        linear_extrude(height=pheight)
        polygon(points=[
         [lABx3-penlarge,lABy1-penlarge/2],
         [lABx1,lABy1-penlarge/2],
         [lABx1,lABy2],
         [lABx2,lABy3],
         [lABx2,lABy4],
         [lABx1,lABy5],
         [lABx1,lABy6+penlarge/2],
         [lABx3-penlarge,lABy6+penlarge/2]
        ]);
        // Lable
        translate([2,7,pheight])
        rotate([0, 0, 90]) 
        linear_extrude(height=0.6) 
        text("http://goo.gl/4p1V8P", size=3, valign="center", halign="left", font=":bold");
        // Lable
        translate([66,10,pheight])
        rotate([0, 0, 90]) 
        linear_extrude(height=0.6) 
        text("UnoPCB", size=4, valign="center", halign="left", font=":bold");
        // Beschriftung
        if (plegend == 1) {
          translate([49,0.8,pheight]) rotate([0, 0, 0]) 
          linear_extrude(height=0.4) 
          text("0  1  2  3  4  5", size=1.1, valign="center", halign="left", font="mono:bold");
          translate([27,0.8,pheight]) rotate([0, 0, 0]) 
          linear_extrude(height=0.4) 
          text("REF RES 3  5 \\GND/ VIN", size=1.1, valign="center", halign="left", font="mono:bold");
          translate([63.2,52.3,pheight]) rotate([0, 0, 180]) 
          linear_extrude(height=0.4) 
          text("0  1  2 ~3  4 ~5 ~6 7", size=1.1, valign="center", halign="left", font="mono:bold");
          translate([39.2,52.3,pheight]) rotate([0, 0, 180]) 
          linear_extrude(height=0.4) 
          text("8 ~9~10~11 12 13 GND AREF", size=1.1, valign="center", halign="left", font="mono:bold");
        }
      }
      // Loecher
      union() {
        translate([lALx1,lALy3,0])
        cylinder(pheight,lALd/2,lALd/2,$fs=0.1);
        translate([lALx1,lALy4,0])
        cylinder(pheight,lALd/2,lALd/2,$fs=0.1);
        translate([lALx2,lALy1,0])
        cylinder(pheight,lALd/2,lALd/2,$fs=0.1);
        translate([lALx2,lALy2,0])
        cylinder(pheight,lALd/2,lALd/2,$fs=0.1);
      }
      if (phole == 1) { // normal
        // Pins
        union() {
          for (x=[1:lAPn1]) {
            color("red")
            translate([lAPx3-lAPx*(x-1),lAPy1,0])
            cylinder(pheight,lAPd/2,lAPd/2,$fs=0.1);
          }
          for (x=[1:lAPn3]) {
            color("blue")
            translate([lAPx1-lAPx*(x-1),lAPy1,0])
            cylinder(pheight,lAPd/2,lAPd/2,$fs=0.1);
          }
          for (x=[1:lAPn2]) {
            color("blue")
            translate([lAPx2-lAPx*(x-1),lAPy2,0])
            cylinder(pheight,lAPd/2,lAPd/2,$fs=0.1);
            color("red")
            translate([lAPx3-lAPx*(x-1),lAPy2,0])
            cylinder(pheight,lAPd/2,lAPd/2,$fs=0.1);
          }
        }
        // Lochraster
        for (x=[1:lARnx]) for (y=[1:lARny]) {
            translate([lARx1-lARx*(x-1),lARy1+lARy*(y-1),0])
            cylinder(pheight,lARd/2,lARd/2,$fs=0.1);
        }
      }
      if (phole == 2) { // optimiert fuer kleinen GCode und schnellen Druck
        // Pins
        union() {
          for (x=[1:lAPn1+1]) {  // V03: Extraloch
            color("red") 
            translate([lAPx3-lAPx*(x-1),lAPy1,0]) rotate(45)
            cylinder(pheight,lAPd/2*1.2,lAPd/2*1.2,$fn=4);
          }
          for (x=[1:lAPn3]) {
            color("blue")
            translate([lAPx1-lAPx*(x-1),lAPy1,0]) rotate(45)
            cylinder(pheight,lAPd/2*1.2,lAPd/2*1.2,$fn=4);
          }
          for (x=[1:lAPn2]) {
            color("blue") 
            translate([lAPx2-lAPx*(x-1),lAPy2,0]) rotate(45)
            cylinder(pheight,lAPd/2*1.2,lAPd/2*1.2,$fn=4);
            color("red") 
            translate([lAPx3-lAPx*(x-1),lAPy2,0]) rotate(45)
            cylinder(pheight,lAPd/2*1.2,lAPd/2*1.2,$fn=4);
          }
        }
        // Lochraster
        for (x=[1:lARnx]) for (y=[1:lARny]) {
            translate([lARx1-lARx*(x-1),lARy1+lARy*(y-1),0])
            rotate(45)
            cylinder(pheight,lARd/2*1.2,lARd/2*1.2,$fn=4);
        }
      }
      // verkleinern
      if (plength < 68.8) {
        translate([-enlarge_mm/2-0.1,-enlarge_mm/2-0.1,-0.1])
        cube([68.8-plength+enlarge_mm+0.2,lABy6+enlarge_mm+0.2,pheight+0.2+10]);
      }
      
    }
    // Pin-Kabel
    if (pcablepin==1) {
      difference() {
        union() {
          translate([lAPx1-lARx*lAPn3,lAPy1+lAPd/2+lAPHa,0])
          cube([lARx*(lAPn3+1)+.5,lAPHy,pheight+lAPHh]);
          translate([lAPx3-lARx*lAPn1,lAPy1+lAPd/2+lAPHa,0])
          cube([lARx*(lAPn1+1),lAPHy,pheight+lAPHh]);
        }
        for (x=[1:lAPn1]) {
          color("red")
          translate([lAPx3-lAPx*(x-1),lAPy1+lAPd/2+lAPHa,pheight+lAPHh/2-lAPd/2])
          rotate([-90,0,0])
          cylinder(lAPHy,lAPd/2,lAPd/2,$fn=6);
        }
        for (x=[1:lAPn3]) {
          color("blue")
          translate([lAPx1-lAPx*(x-1),lAPy1+lAPd/2+lAPHa,pheight+lAPHh/2-lAPd/2])
          rotate([-90,0,0])
          cylinder(lAPHy,lAPd/2,lAPd/2,$fn=6);
        }
      }
      difference() {
        union() {
          translate([lAPx2-lARx*lAPn2,lAPy2-lAPd/2-lAPHa-lAPHy,0])
          cube([lARx*(lAPn2+1)+.9,lAPHy,pheight+lAPHh]);
          translate([lAPx3-lARx*lAPn2,lAPy2-lAPd/2-lAPHa-lAPHy,0])
          cube([lARx*(lAPn2+1),lAPHy,pheight+lAPHh]);
        }
        for (x=[1:lAPn2]) {
          color("blue")
          translate([lAPx2-lAPx*(x-1),lAPy2-lAPd/2-lAPHa-lAPHy,pheight+lAPHh/2-lAPd/2])
          rotate([-90,0,0])
          cylinder(lAPHy,lAPd/2,lAPd/2,$fn=6);
          color("red")
          translate([lAPx3-lAPx*(x-1),lAPy2-lAPd/2-lAPHa-lAPHy,pheight+lAPHh/2-lAPd/2])
          rotate([-90,0,0])
          cylinder(lAPHy,lAPd/2,lAPd/2,$fn=6);
        }
      }
    }
  }
}