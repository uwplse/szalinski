circlesize = 10; // [0:100]
circletranslate = 40; // [0:100]

rotate_extrude(convexity=10)
    translate([circletranslate, 0]) circle(circlesize);
