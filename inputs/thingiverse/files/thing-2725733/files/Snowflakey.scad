//!OpenSCAD

//Number of arms
Arms = 9; //[3:20]

//Length of arms
Armlength = 40; //[10:100]

//Makes arms more interesting
InterestingArms = 1; //[1:true,0:false]

//Number of points on the endcaps
Endcount = 5; //[1:12]

//Percentage scape of the endcaps
EndcapScale = 100; //[1:200]

//Inserts a hole to hang the snowflake
HangingLoop = 1; //[1:true,0:false]


module Endcap(x) {
  translate([x, 0, 0]){
    scale([(EndcapScale / 100), (EndcapScale / 100), (EndcapScale / 100)]){
      for (i = [1 : abs(1) : Endcount]) {
        rotate([0, (i * (360 / Endcount)), 0]){
          union(){
            hull(){
              translate([0, 0, 0]){
                sphere(r=2);
              }
              translate([4, 0, 0]){
                sphere(r=2);
              }
            }
            hull(){
              translate([8, 0, 0]){
                sphere(r=1);
              }
              translate([4, 0, 0]){
                sphere(r=2);
              }
            }
          }
        }
      }

    }
  }
}

union(){
  rotate([270, 0, 0]){
    for (j = [1 : abs(1) : Arms]) {
      rotate([0, (j * (360 / Arms)), 0]){
        union(){
          {
            $fn=20;    //set sides to 20
            for (k = [1 : abs(1) : 5]) {
              rotate([(k * (360 / 5)), 0, 0]){
                hull(){
                  if (InterestingArms) {
                    // torus
                    rotate_extrude($fn=8) {
                      translate([4, 0, 0]) {
                        circle(r=1, $fn=16);
                      }
                    }
                  } else {
                    {
                      $fn=20;    //set sides to 20
                      sphere(r=4);
                    }
                  }

                  translate([Armlength, 0, 0]){
                    sphere(r=1);
                  }
                }
              }
            }

          }
          Endcap(Armlength);
        }
      }
    }

  }
  if (HangingLoop) {
    {
      $fn=20;    //set sides to 20
      translate([(Armlength + 10 * (EndcapScale / 100)), 0, 0]){
        // torus
        rotate_extrude($fn=8) {
          translate([2, 0, 0]) {
            circle(r=1, $fn=16);
          }
        }
      }
    }
  }

}