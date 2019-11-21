h=68 ; // height of cube
w=45; // width of cube
d=36; // depth of cube 

tw=0.8; // wall thickness
m=0.2; // margin


    color("green") // inner cube
    translate([h+2*m+2*tw,-d-2*m-2*tw-5,0])
    rotate([0,-90,0])
    difference()
    {
        cube([w+2*m,d+2*m+2*tw,h+2*m+2*tw]);
        translate([-m,tw,tw])
        cube([w+4*m,d+2*m,h+2*m]);
    };

    color("red") // outer cube
    difference()
    {
        cube([w+4*m+2*tw,d+4*m+4*tw,h+2*m+2*tw]);
        translate([tw,tw,-m])
        cube([w+4*m,d+4*m+2*tw,h+4*m+2*tw]);
    };
    
