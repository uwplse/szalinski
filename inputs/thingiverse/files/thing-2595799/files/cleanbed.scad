// shape?
buildbed = "square"; // [round,square]

// in mm
diameter = 180; // [10:10:500]

// in mm
height = 0.2; // [0.005:0.005:1]

if (buildbed=="round")
    cylinder(d=diameter, height, $fn=diameter);
else
    cube([diameter,diameter,height]);
