//CODEflakes, (c)2019 Museum of Science and Industry, Chicago

/*[codeFlake Geometry]*/

// Number of sides in first shape?
Sides1 = 3; // [3:12]

// Number of sides in second shape?
Sides2 = 4; // [3:12]

// Size of first shape?
Rad1 = 7; // [0:12] 

// Size of second shape?
Rad2 = 6; // [0:12]

// Position of first shape?
HexPosition1 = 5; // [0:12]

// Position of second shape?
HexPosition2 = 9; // [0:12] 

  for (i = [1 : abs(1) : 15]) {           //Begin build loop
    rotate([0, 0, (30 * i)]){
      if (i % 2 == 0) {
        translate([HexPosition1, 0, 0]){  //1st polygon set
          // torus
          rotate_extrude($fn=Sides1) {
            translate([Rad1, 0, 0]) {
              circle(r=1, $fn=6);
            }
          }
        }
      } else {
        translate([HexPosition2, 0, 0]){  //2nd polygon set
          // torus
          rotate_extrude($fn=Sides2) {
            translate([Rad2, 0, 0]) {
              circle(r=1, $fn=6);
            }
          }
        }
      }

    }
  }
  



