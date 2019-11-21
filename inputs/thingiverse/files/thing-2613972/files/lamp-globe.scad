// Lamp Globe
// by HarlemSquirrel
// harlemsquirrel@gmail.com
// http://www.thingiverse.com/HarlemSquirrel


// *** Variables ***
// *****************

// Globe outside diameter
globe_d = 180; //[8:256]
// Opening diameter
opening_d = 85; //[2:128]
// Thickness
thickness = 4; //[1:16]
// Resolution
$fn = 128; //[4:1024]

// *** Modules ***
// *****************

module basic_globe() {
  difference() {
    sphere(d=globe_d);
    sphere(d=globe_d - (thickness*2));
  }
}

module opening_cuttout() {
  cylinder(d1=opening_d+thickness, d2=opening_d-thickness, h=globe_d/2, center=true);
}

module lamp_globe() {
  translate([0, 0, globe_d/2]) {
    difference() {
      basic_globe();
      translate([0,0,globe_d/2])
        opening_cuttout();
    }
  }
}

lamp_globe();