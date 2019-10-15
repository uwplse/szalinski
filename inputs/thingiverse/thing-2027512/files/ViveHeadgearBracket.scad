//HMD attachment bracket
//HTC VIVE
//
//7*4 @ 1.5mm

length = 80; // [50:120]

/* [Hidden] */
armLength = length - 39;

$fn=50;

module _Ring(){
  difference(){
      cylinder(d=25.5,h=7.75,center=true);
      cylinder(d=13.25,h=8,center=true);
      translate([0,0,3.3])cylinder(d=15.4,h=1.5,center=true);
      translate([0,0,4])cylinder(d=23,h=.5,center=true);
      for (n = [1:28]){
          rotate([0,0,n*(360/28)] ){  
              rotate([0,90,0])translate([-3.5,0,9.6])cylinder(d=1.75,h=4.25,center=true);
          }
      }
      difference(){
        translate([0,0,3])cylinder(d=19, h=2,center=true);
        translate([10,0,0])cube([20,20,20],center=true);
      }
  }
}

module _Arm() {
  translate([0,10,0])
  difference(){
    union(){
      hull(){
        translate([0,armLength+5,0])cube([25,11,5]);
        translate([0,armLength+15,0])cube([25,14,10]);
      }
      translate([0,5,0])cube([25,armLength,5]);
     }

     // cutouts
     translate([0,armLength+27,1.5])cube([25,2,7]);
     translate([0,armLength+19,4])cube([25,10,2]);

     // holes
     translate([7.5,armLength+24.5,0])cylinder(d=3,h=10);
     translate([17.5,armLength+24.5,0])cylinder(d=3,h=10);
     translate([12.5,2.5,0])cylinder(d=13.25,h=5);
  }
}

module _Bracket() {
  translate([25.5/2-0.25,25.5/2-0.25,7.75/2])_Ring();
  _Arm();
}

_Bracket();
translate([55,0,0])mirror([90,0,0])_Bracket();
