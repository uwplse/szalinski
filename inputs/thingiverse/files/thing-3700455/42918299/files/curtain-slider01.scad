$fs = 0.5;
$fa = 5;

gutter = 2;
height = 6;
width = 6;
cwidth = 3;
length = 8;
loop = 8;
loopThick = 2.5;
cdepth = 2;

    union() {
        linear_extrude ( height = length, center = true)
        difference() {
            scale ([1.7,1,1]) circle(height/2);
            
            translate([height/2 + width / 2,0,0]) square (height, true);
            translate([-height/2 - width / 2,0,0]) square (height, true);
            
            translate([ cwidth / 2 + gutter/2 ,0,0]) square (gutter, true);
            translate([ -cwidth / 2 - gutter/2 ,0,0]) square (gutter, true);
            
            // chop the top off
             translate([0, height + width /2  - cdepth * 1.75 , 0 ]) square (width, true);
        }
        
        translate ([0, height / 2, 0])
        rotate ([0, 90, 0])
        linear_extrude (height=cdepth, center = true) 
        difference() { 
            circle (loop / 2);
            circle (loop / 2 - loopThick / 2);
        }
    }

