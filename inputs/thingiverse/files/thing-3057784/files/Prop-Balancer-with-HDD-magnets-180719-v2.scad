$fn=200;

hc=80;
in=10;
le=13;
di=40;
d2=60;
w2=25;
h2=5;
d3=75;
w3=40;
h3=3;

translate([0,0,165])
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

        linear_extrude(height = 165, center = false, convexity = 10, scale=[1,3], $fn=100)
             translate([0, 0, 0])
                circle(r = le/2); 
        linear_extrude(height = 165, center = false, convexity = 10, scale=[1,3], $fn=100)
             translate([di, 0, 0])
                circle(r = le/2); 
    };
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

        linear_extrude(height = 165, center = false, convexity = 10, scale=[1,3], $fn=100)
             translate([0, 0, 0])
                circle(r = le/2); 
        linear_extrude(height = 165, center = false, convexity = 10, scale=[1,3], $fn=100)
             translate([di, 0, 0])
                circle(r = le/2); 
    };
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

difference()
{
    translate([-le/2,0,0])
        cube([le,58,165]);
    translate([-le/2-0.01,29,0])
        rotate([90,0,90])
            scale([1,5,1])
                cylinder(h=le+0.02,d=58);
};
difference()
{
    translate([-le/2+di,0,0])
        cube([le,58,165]);
    translate([-le/2+di-0.01,29,0])
        rotate([90,0,90])
            scale([1,5,1])
                cylinder(h=le+0.02,d=58);
};
}