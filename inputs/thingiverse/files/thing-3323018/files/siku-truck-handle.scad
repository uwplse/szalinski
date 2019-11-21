// distance plate diameter
dd = 20;
// distance plate depth
distance = 12;

// thumb wheel diameter
thumb = 35;
// thumb wheel depth
td = 10;
// notches
notches = 5;
// notch diameter
nd = 12;

tolerance=0.1;

// parameters from the connector

// diameter of the outer hole
outer = 17.5;

// inset of the current handle
inset = 1.5;
// diameter of the current handle
pin = 6;
// length of the current handle
plen = 10;

// diameter of the center plug
plug = 10;
// depth of the center plug
h_plug = 4;
// sides of the center plug x 2
sides = 3;

translate([0,0,-h_plug+tolerance]) {
  rotate([0,0,30])
    cylinder(r=plug/2-tolerance, h=h_plug, $fn=sides);
  rotate([0,0,-30])
    cylinder(r=plug/2-tolerance, h=h_plug, $fn=sides);
}

difference() {
  cylinder(r=dd/2, h=distance);
  translate([outer/2-inset, 0, 0])
    cylinder(r=pin/2, h=plen, $fn=16);
}

minkowski() {
  translate([0,0,distance])
    difference() {  
      cylinder(r=thumb/2, h=td);
  
      for(i=[0 : 360/notches : 360]) 
        rotate([0,0,i])
          translate([thumb/2,0,0])
            cylinder(r=nd/2, h=td);
    }
  sphere(1);
}