
// diameter of the center plug
plug = 10;
// depth of the center plug
h_plug = 10;
// sides of the center plug
sides = 3;
// tolerance 
tolerance = 0.1;

// distance plate diameter
dd = 40;
// distance plate depth
distance = 10;

// handle diameter
handle = 10;
// thumb wheel depth
hd = 20;

translate([0,0,-h_plug])
  rotate([0,0,60])
    cylinder(r=plug/2-tolerance, h=h_plug, $fn=sides);

cylinder(r=dd/2, h=distance);

minkowski() {
translate([(dd-handle)/2,0,distance/2])
  cylinder(r=handle/2-1, h=hd+distance/2, $fn=32);
sphere(1);
}
