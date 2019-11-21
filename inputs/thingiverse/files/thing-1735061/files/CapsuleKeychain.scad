//Resolution
$fn = 30;
/* [Capsule size] */
//the length of the inside of the capsule
insideLength = 82;
//the inside diameter of the capsule
insideWidth = 17;
//sets how thick the walls of the capsule will be
wallThickness = 1;
//how much the two halves overlap to connect together
overlap = 2;

/* [Loop Dimensions] */
//change to false if you do not want the loop on the keychain
loop = "yes"; //[yes, no]
//How big do you want the inside of the loop to be (how thick is keyring)
loopDiameter = 4;
//How thick do you want the walls of the loop to be
loopThickness = 2;

/* [Top and Bottom] */
//if true, the top will render
top = "true"; //[true, false]
// if true the bottom will rendered
bottom = "true"; //[true, false]
//allows you to separate the two halfs when both are rendered (leave at 0 if rendering 1 half)
separate = 20;

module keychain(){
  //makes the top half of the keychain
  if(top == "true") translate([0,0,separate/2]){
    difference(){
        union(){
          resize([insideWidth+wallThickness*2,insideWidth+wallThickness*2,insideLength/2+wallThickness])
          capsuleHalf();
          //makes the loop that holds the keychain on the keyring
          if(loop == "yes"){
            translate([0,0,(insideLength)/2+loopDiameter/2+wallThickness])
              rotate([0,90,0])
               rotate_extrude()
                translate([loopDiameter/2+loopThickness/2,0,0])
                  circle(r = loopThickness/2);
          }
        }
      union(){
        capsuleHalf();
        cylinder(r = (insideWidth+wallThickness)/2, h = overlap);
      }
    }
  }
  //makes the bottom half of the keychain
  if(bottom == "true") translate([0,0,-separate/2]){
    rotate([180,0,0]){
      difference(){
        union(){
          resize([insideWidth+wallThickness*2,insideWidth+wallThickness*2,insideLength/2+wallThickness])
            capsuleHalf();
          cylinder(r = insideWidth/2+wallThickness/2, h = wallThickness*2);
        }
        capsuleHalf();
      }
    }
    difference(){
      cylinder(r = (insideWidth+wallThickness)/2, h = overlap);
      cylinder(r = insideWidth/2, h = overlap);
    }
  }
}
module capsuleHalf(){
  cylinder(r = insideWidth/2, h = (insideLength-insideWidth)/2);
    translate([0,0,(insideLength-insideWidth)/2])
      sphere(r = insideWidth/2);
}

keychain();
