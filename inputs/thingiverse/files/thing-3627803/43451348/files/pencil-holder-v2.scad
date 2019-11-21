//!OpenSCAD

/*[dimensions - dimensioni]*/

// x direction
larg = 80;
// y direction
lungh = 148;
// z direction
h = 22;

/*[thickness - spessore]*/

// faces thickness - spessore pareti
sp = 3;
// top thickness - spessore coperchio
sp_coperc = 2.5;

/*[font]*/
font_text="Roboto"; //["Roboto","Barriecito"]

difference() {
  // volume esterno astuccio - whole cube volume
  cube([larg, lungh, h], center=false);

  // vuoto interno - hole inside
  color([1,0.8,0]) {
    translate([sp, sp, sp]){
      cube([(larg - sp * 2), (lungh - sp * 2), h], center=false);
    }
  }
  // apertura frontale - frontal hole for insering top
  color([0.93,0,0]) {
   translate([sp, 0, (h - 7)]){
      cube([(larg - sp * 2), sp, 15], center=false);
    }
  }
  // spessore coperchio - top thickness
  color([1,0.8,0]) {
    translate([(sp / 2), 0, (h - 7)]){
      cube([(larg - sp), (lungh - sp / 2), (sp_coperc + 0.5)], center=false);
    }
  }
}
  // coperchio - top
color([0.2,0.8,0]) {
  difference() {
    translate([(larg + 20), 0, 0]){
      cube([(larg - sp), (lungh - sp / 2), sp_coperc], center=false);
    }
  // scritta - text
    translate([(larg + 25), 0, 0]){
      translate([((larg - sp) / 2), 4, 0]){
        rotate([0, 0, 90]){
          // size is multiplied by 0.75 because openScad font sizes are in points, not pixels
          linear_extrude( height=10, twist=0, center=false){
            text("PASTELLI", font= font_text, size = 30*0.75);
          }
        }
      }
  
  /// sottolineatura - square under text
    translate([((larg - sp) / 2+2), 5, 0]) cube([15,lungh-sp/2-10,sp]);
}
}
}