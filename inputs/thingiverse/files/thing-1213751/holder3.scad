
// diameter of sensor hole
sensorHoleDiameter = 12.2; // [3:0.1:19]

// quality
$fn=100;

module vetrak() {
  difference() {
    linear_extrude (height=3)
    difference() {
      union() {
        difference() {
          square (32, center=true);
          circle (d=27);
        }
      }
    
      translate ([-12,-12]) circle (d=3.2);
      translate ([12,-12]) circle (d=3.2);
      translate ([-12,12]) circle (d=3.2);
      translate ([12,12]) circle (d=3.2);
    }
    
    translate ([-12,-12,1]) cylinder (d=5.5, h=2.1);
    translate ([12,-12,1]) cylinder (d=5.5, h=2.1);
    translate ([-12,12,1]) cylinder (d=5.5, h=2.1);
    translate ([12,12,1]) cylinder (d=5.5, h=2.1);
  }
}

module zaves() {
  translate ([0.5,0,0])
  difference() {
    hull() {
      translate ([11,0,0]) cylinder (h=6, d=32);
      translate ([-3,0,3]) cube ([1, 32, 6], center=true);
    }
    translate ([11,0,-0.1]) cylinder (h=6.2, d=sensorHoleDiameter); 
  }
}

module main() {
  union() {
    union() {
      vetrak();
      translate ([0,-19,1.5]) cube ([32, 6, 3], center=true);
      translate ([0,-16, 6]) rotate ([0,270,90]) zaves();
    }
    
    difference() {
      translate ([16,-8.1,3])
      rotate ([90,0,270])
      linear_extrude (height=32)
      polygon (points=[[0,0], [10, 0], [10, 5.2]]);
      
      translate ([-12,-12,1]) cylinder (d=5.5, h=12);
      translate ([12,-12,1]) cylinder (d=5.5, h=12);
      cylinder (d=27, h=12);
    }
  }
}

main();
