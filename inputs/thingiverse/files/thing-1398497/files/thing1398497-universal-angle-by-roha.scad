/*
 *  Universal Angle (Winkel) by RoHa
 *  http://www.thingiverse.com/thing:1398497
 *
 *  Historiy:
 *  2016-03-07  ReleaseV1
 *
 */

Angle = 130; // [90:180]
SideA_Length = 8.5;
SideA_Width = 1.5;
SideA_Height = 2.5;
SideB_Length = 8.5;
SideB_Width = 1.5;
SideB_Height = 2.5;
Hole1A_Show = "yes"; // [yes,no]
Hole1A_Offset = 0.5;
Hole1A_Diameter = 0.7;
Hole2A_Show = "yes"; // [yes,no]
Hole2A_Offset = 4.5;
Hole2A_Diameter = 0.7;
Hole3B_Show = "yes"; // [yes,no]
Hole3B_Offset = 0.5;
Hole3B_Diameter = 0.7;
Hole4B_Show = "yes"; // [yes,no]
Hole4B_Offset = 4.5;
Hole4B_Diameter = 0.7;
Hole5A_Show = "yes"; // [yes,no]
Hole5A_Offset = 2.5;
Hole5A_Diameter = 0.5;
Hole6A_Show = "yes"; // [yes,no]
Hole6A_Offset = 5.5;
Hole6A_Diameter = 0.5;
Hole7B_Show = "yes"; // [yes,no]
Hole7B_Offset = 2.5;
Hole7B_Diameter = 0.5;
Hole8B_Show = "yes"; // [yes,no]
Hole8B_Offset = 5.5;
Hole8B_Diameter = 0.5;
Hole_Detail = 0.1;
Printer_X = 15;
Printer_Y = 15;
Printer_Z = 0;
Version = 1; // [1]
dx = Printer_X;
dy = Printer_Y;
dz = Printer_Z;
wg = Angle;
wal = SideA_Length;
wab = SideA_Width;
wah = SideA_Height;
wbl = SideB_Length;
wbb = SideB_Width;
wbh = SideB_Height;
wlg = Hole_Detail;
wl1a = Hole1A_Offset;
wl1r = Hole1A_Diameter/2;
wl2a = Hole2A_Offset;
wl2r = Hole2A_Diameter/2;
wl3a = Hole3B_Offset;
wl3r = Hole3B_Diameter/2;
wl4a = Hole4B_Offset;
wl4r = Hole4B_Diameter/2;
wl5a = Hole5A_Offset;
wl5r = Hole5A_Diameter/2;
wl6a = Hole6A_Offset;
wl6r = Hole6A_Diameter/2;
wl7a = Hole7B_Offset;
wl7r = Hole7B_Diameter/2;
wl8a = Hole8B_Offset;
wl8r = Hole8B_Diameter/2;
bugfix = 0.1;

// Skalierung von MM in CM
scale(10)
union() {
  // Druckbett visualisieren
  if (dz>0) {
    druckbett();
  }
  // fuer optimalen Druck ausrichten
  rotate([0,0,-wg/2+45]) 
  // >>> LoecherB-Innen ausschneiden
  rotate([0,0,wg]) 
  rotate([90,0,0]) 
  translate([0,wbb,-bugfix/2])
  difference() {
  translate([0,-wbb,bugfix/2])
  rotate([-90,0,0]) 
  rotate([0,0,-wg]) 
    // >>> LoecherA-Innen ausschneiden
    rotate([-90,0,0]) 
    difference() {
      rotate([90,0,0]) 
      union () {
        // >>> LoecherB-Aussen ausschneiden
        rotate([0,0,wg]) 
        difference() {
          rotate([0,0,-wg]) 
          difference() {
            // Basismodell fuer Winkel
            winkel_basis();
            // >>> LoecherA-Aussen ausschneiden
            if (Hole1A_Show == "yes") {
              color("blue")
              translate([wal-wl1a-wl1r,wah/2,0])
              cylinder(wab,wl1r,wl1r,$fs=wlg);
            }
            if (Hole2A_Show == "yes") {
              color("blue")
              translate([wal-wl2a-wl2r,wah/2,0])
              cylinder(wab,wl2r,wl2r,$fs=wlg);
            }
            // <<< LoecherA-Aussen
          }
          // LoecherB
          if (Hole3B_Show == "yes") {
            color("blue")
            translate([wbl-wl3a-wl3r,-wbh/2,0])
            cylinder(wbb,wl3r,wl3r,$fs=wlg);
          }
          if (Hole4B_Show == "yes") {
            color("blue")
            translate([wbl-wl4a-wl4r,-wbh/2,0])
            cylinder(wbb,wl4r,wl4r,$fs=wlg);
          }
        }
        // <<< LoecherB-Aussen
      }
      // LoecherA
      if (Hole5A_Show == "yes") {
        color("blue")
        translate([wal-wl5a-wl5r,-wab/2,0])
        cylinder(wah,wl5r,wl5r,$fs=wlg);
      }
      if (Hole6A_Show == "yes") {
        color("blue")
        translate([wal-wl6a-wl6r,-wab/2,0])
        cylinder(wah,wl6r,wl6r,$fs=wlg);
      }
    }
    // <<< LoecherA-Innen
    // LoecherB
    if (Hole7B_Show == "yes") {
      color("blue")
      translate([wbl-wl7a-wl7r,-wbb/2,0])
      cylinder(wbh+bugfix,wl7r,wl7r,$fs=wlg);
    }
    if (Hole8B_Show == "yes") {
      color("blue")
      translate([wbl-wl8a-wl8r,-wbb/2,0])
      cylinder(wbh+bugfix,wl8r,wl8r,$fs=wlg);
    }
  }
  // >>> LoecherB-Innen
}

// Winkel
module winkel_basis() {
  union() {
    cube([wal,wah,wab]);
    color("red") 
    translate([0,0,wbb])
    rotate([180,0,0]) 
    rotate([0,0,-wg]) 
    cube([wbl,wbh,wbb]);
  }
}

// Druckbett
module druckbett() {
  color("gray")
  translate([-dx/2,-dy/2,-1])
  cube([dx,dy,1]);
}
