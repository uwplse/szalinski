// Bosta paramétrica
// Customized poop
// By Patola
// 31 oct 2016

// How many turns the poop will have
turns=5; // [1:50]

// Definition (number of polygons) for each element
definition=30; // [10:100]

// Resolution of each turn (number of plots by turn, the bigger the rounder)
resolution=64; // [3:100]

// Distance of the turns from the center. The bigger the wider.
distance=80; // [-30:200]

// Counterclockwise (default) or clockwise.
clockwise=1; // [-1:clockwise,1:counterclockwise]

/* [Hidden] */
radius=30*5/turns; // greater turns, smaller sphere
rate=10*5/turns*clockwise; // every turn decreases by this much;
zlift=160;
angle=turns*360*clockwise;
interval=360/resolution*clockwise;

difference() {
  for (i=[interval:interval:angle]) {
    echo (zlift*(i/angle));
    hull() {
      rotate([0,0,i-interval]) translate([distance-rate*(i/360),0,zlift*((i-interval)/angle)]) sphere(r=radius*sqrt(sqrt((angle-i+interval)/angle)),$fn=definition);
      rotate([0,0,i]) translate([distance-rate*(i/360),0,zlift*(i/angle)]) sphere(r=radius*sqrt(sqrt(((angle-i)/angle))),$fn=definition);
    }
  }
  translate([-2*distance,-2*distance,-distance]) cube([4*distance,4*distance,distance]);
}