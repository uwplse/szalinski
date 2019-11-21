$fn=200;

hc=80;
in=10;
le=13;      //support thickness
di=40;
d2=60;
w2=25;
h2=5;
d3=75;
w3=40;
h3=3;
ed=0.6;     //extruder diameter
hi=165;     //height

translate([0,0,hi])
rotate([0,180,0])
{
difference()
{
    union()
    {
        difference()
        {
            translate([0,-le/2,0])
                cube([di,le,hc+di]);
            translate([di/2,0,hc+di-0.01])
                rotate([90,0,0])
                    scale([0.7,2,1])
                        cylinder(h=le+0.02,d=di,center=true);
            translate([(di-w2)/2,le/2-h2,0])
                cube([w2,h2+0.01,d2]);
        };

        linear_extrude(height = hi, center = false, convexity = 10, scale=[1,3], $fn=100)
             translate([0, 0, 0])
                circle(r = le/2); 
        
        linear_extrude(height = hi, center = false, convexity = 10, scale=[1,3], $fn=100)
             translate([di, 0, 0])
                circle(r = le/2); 
        
         difference()
        {
            translate([-le/2,0,0])
                cube([le,58,hi]);
            translate([-le/2-0.01,29,0])
                rotate([90,0,90])
                    scale([1,5,1])
                        cylinder(h=le+0.02,d=58);
        };
        
    };
    translate([0,-h3/2,0])
        cube([w3,h3,d3]);
    translate([40,58,0])
        rotate([0,0,180]) 
            translate([0,-h3/2,0])
                cube([w3,h3,d3]);
};
  
translate([40,58,0])
rotate([0,0,180]) 
difference()
{
    union()
    {
        difference()
        {
            translate([0,-le/2,0])
                cube([di,le,hc+di]);
            translate([di/2,0,hc+di-0.01])
                rotate([90,0,0])
                    scale([0.7,2,1])
                        cylinder(h=le+0.02,d=di,center=true);
            translate([(di-w2)/2,le/2-h2,0])
                cube([w2,h2+0.01,d2]);
        };

        linear_extrude(height = hi, center = false, convexity = 10, scale=[1,3], $fn=100)
             translate([0, 0, 0])
                circle(r = le/2); 
        
        linear_extrude(height = hi, center = false, convexity = 10, scale=[1,3], $fn=100)
             translate([di, 0, 0])
                circle(r = le/2); 
        
        difference()
        {
            translate([-le/2,0,0])
                cube([le,58,hi]);
            translate([-le/2-0.01,29,0])
                rotate([90,0,90])
                    scale([1,5,1])
                        cylinder(h=le+0.02,d=58);
        };
        
    };
    translate([0,-h3/2,0])
        cube([w3,h3,d3]);
    translate([40,58,0])
        rotate([0,0,180]) 
            translate([0,-h3/2,0])
                cube([w3,h3,d3]);
};

//color("Red") //magnets and axle
//{
//    translate([0,-1.0,-1])
//        cube([40,2.5,10]);
//    translate([7.5,1.5,-1])
//        cube([25,2,10]);
//    translate([0,56.5,-1])
//        cube([40,2.5,10]);
//    translate([7.5,54.5,-1])
//        cube([25,2,10]);
//    translate([20,54.5,5])
//        rotate([90,0,0])
//            cylinder(h=51,d=10);
//};

};

//scaffolding
difference()
{
    translate([le/2, 0, hi/2])
        rotate([180,0,180])
            linear_extrude(height = hi/2, center = false, convexity = 10, scale=20,twist = 0)
                translate([-1, 0, 0])
                    circle(r = 1,$fn=3);

    translate([le/2+2, 0, 0.9*hi/2])
        rotate([180,0,180])
            linear_extrude(height = 0.9*hi/2, center = false, convexity = 10, scale=18,twist = 0)
                translate([-1, 0, 0])
                    circle(r = 1,$fn=3);
};

translate([0,58,0])
{
    difference()
    {
        translate([le/2, 0, hi/2])
            rotate([180,0,180])
                linear_extrude(height = hi/2, center = false, convexity = 10, scale=20,twist = 0)
                    translate([-1, 0, 0])
                        circle(r = 1,$fn=3);

        translate([le/2+2, 0, 0.9*hi/2])
            rotate([180,0,180])
                linear_extrude(height = 0.9*hi/2, center = false, convexity = 10, scale=18,twist = 0)
                    translate([-1, 0, 0])
                        circle(r = 1,$fn=3);
    };
};

difference()
{
    translate([-di-le/2, 0, hi/2])
        rotate([180,0,0])
            linear_extrude(height = hi/2, center = false, convexity = 10, scale=20,twist = 0)
                translate([-1, 0, 0])
                    circle(r = 1,$fn=3);

    translate([-di-le/2-2, 0, 0.9*hi/2])
        rotate([180,0,0])
            linear_extrude(height = 0.9*hi/2, center = false, convexity = 10, scale=18,twist = 0)
                translate([-1, 0, 0])
                    circle(r = 1,$fn=3);
};
translate([-di-le/2-9,-ed/2,0])
    cube([71,ed,hi/2+3]);

translate([0,58,0])
{
    difference()
    {
        translate([-di-le/2, 0, hi/2])
            rotate([180,0,0])
                linear_extrude(height = hi/2, center = false, convexity = 10, scale=20,twist = 0)
                    translate([-1, 0, 0])
                        circle(r = 1,$fn=3);

        translate([-di-le/2-2, 0, 0.9*hi/2])
            rotate([180,0,0])
                linear_extrude(height = 0.9*hi/2, center = false, convexity = 10, scale=18,twist = 0)
                    translate([-1, 0, 0])
                        circle(r = 1,$fn=3);
    };
    translate([-di-le/2-9,-ed/2,0])
        cube([71,ed,hi/2+3]);
    
};
translate([-77,-20,0])
minkowski()
{
    cube([114,98,1.5]);
    cylinder(1.5,r1=10,r2=2);
};