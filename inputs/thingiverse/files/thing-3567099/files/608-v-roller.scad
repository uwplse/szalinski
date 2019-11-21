//Segments in the circles (Higher numbers produce smoother curve, but take longer to render)
segments = 64;
//Thickness of bearing
w = 7;
//Outer Diameter of roller
outer_d   = 30;
//Diameter of V-Trough
inner_d   = 25.5;
//Diameter of bearing
bearing_d = 22.05;
//Amount to cut off flanges to produce flat circumference (0 - 2 works well at default diameters)
cut = 0.75; // [0:0.01:10]

difference(){
    difference(){
        union(){
            cylinder(h=w/2, r1=outer_d/2+cut, r2=inner_d/2, $fn=segments);
            translate([0,0,w/2-0.0001])
            cylinder(h=w/2, r1=inner_d/2, r2=outer_d/2+cut, $fn=segments);
        }
        translate(0,0,-1)
        cylinder(h=w+2, r1=bearing_d/2, r2=bearing_d/2, $fn=segments);
    }
    difference(){
        
        cube(outer_d+5+cut*2, center=true);
        translate([0,0,-1])
        cylinder(h=w+2, r1=outer_d/2, r2=outer_d/2, $fn=segments);
    }
}