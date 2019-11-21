//  Windows users must "escape" the backslashes by writing them doubled, or replace the backslashes with forward slashes.

// optimum slicing of round edges:
// for a 0.2mm layer height $fn= 16 * d
// 16 = roundup ( 1mm * pi / 0.2mm )
difference()
{
union()
{
    translate([0,-113/2-20-19,-5])
    {
        translate([-75,113/2+1,-12.5])
        rotate([90,0,0])
        linear_extrude(height = 2, center = true, convexity = 10, twist = 0)
        hull()
        {
            translate([0,37.5+1,0])
            circle(17, $fn=360);
            circle(10, $fn=360);
        };
        translate([-75,-113/2-1,-12.5])
        rotate([90,0,0])
        linear_extrude(height = 2, center = true, convexity = 10, twist = 0)
        hull()
        {
            translate([0,37.5+1,0])
            circle(17, $fn=360);
            circle(10, $fn=360);
        };
        
        translate([-75-3.5+20,113/2-81.5-3.5+9,26])
        linear_extrude(height = 2, center = true, convexity = 10, twist = 0)
        hull()
        {
            translate([0,39,0])
            circle(d=78, $fn=360);
            circle(d=78, $fn=360);
        };
        
        translate([-75-3.5-4.25-49.5/2,113/2-56.5-117/2,25])
        cube([49.5,117,2],center=false); 
    
        translate([-75-3.5-4.25-49.5/2+2/sqrt(2),113/2-56.5-117/2,25+0.58])
        rotate([0,-45,0])
        cube([57,117,2],center=false);   
     
        translate([-215/2,-185,51/2-5.5+2])
        rotate([0,-45,0]) 
        {
            translate([60.54,223.50,2.53])
            cylinder(h=2, d=40, center=true, $fn=360);
            translate([60.54,223.50-77,2.53])
            cylinder(h=2, d=40, center=true, $fn=360); 
        };  
        
    };  
    translate([-215/2,-37,22])
    rotate([90,0,0])
    linear_extrude(height = 2, convexity = 10)
    polygon(points=[
        [0,0],
        [50,0],
        [41,40]]);

    translate([-215/2,-37-115,22])
    rotate([90,0,0])
    linear_extrude(height = 2, convexity = 10)
    polygon(points=[
        [0,0],
        [50,0],
        [41,40]]);    
};


translate([0,-113/2-20-19,-5])
{
    #translate([-215/2,-185,51/2-5.5+2])
    rotate([0,-45,0]) 
    {
        translate([60.54,223.50-77/2,2.53])
        cylinder(h=2.1, d=37, center=true, $fn=360);
    };
    #translate([-75-3.5+20,113/2-81.5-1.5+9,26])
    linear_extrude(height = 2.01, center = true, convexity = 10, twist = 0)
    hull()
    {
        translate([0,35,0])
        circle(d=60, $fn=360);
        circle(d=60, $fn=360);
    };
};


color("grey") //PSU
difference()
{
    translate([0,-113/2-20-19,-5])
    union()
    {
        minkowski()
        {
            cube([215-2,113-2,50-2],center=true);
            sphere(d=2,center=true,$fn=48);
        };

        translate([-75,113/2,12.5])
        rotate([90,0,0])
        cylinder(h=20, d=4, center=true, $fn=48);

        translate([-75,113/2,-12.5])
        rotate([90,0,0])
        cylinder(h=20, d=4, center=true, $fn=48);
        
        translate([-75,113/2-31.5,-25])
        rotate([0,0,0])
        cylinder(h=20, d=4, center=true, $fn=48);
        
        translate([-75,113/2-81.5,-25])
        rotate([0,0,0])
        cylinder(h=20, d=4, center=true, $fn=48);
        
        translate([-75,113/2-113,-12.5])
        rotate([90,0,0])
        cylinder(h=20, d=4, center=true, $fn=48);

    };
    
    translate([98+0.001,-113/2-19-20.25,7.001])
    cube([19,113-2*2,26],center=true);
    
};


color("blue") //display mock up
translate([-215/2,-185,51/2-5.5+2])
rotate([0,-45,0])
union()
{
    cube([82,179,3]);

    translate([6,5,0])
    cylinder(h=20, d=4, center=true, $fn=64);
    translate([76,5,0])
    cylinder(h=20, d=4, center=true, $fn=64);
    translate([6,174,0])
    cylinder(h=20, d=4, center=true, $fn=64);
    translate([76,174,0])
    cylinder(h=20, d=4, center=true, $fn=64);

    translate([57,128,0])
    cylinder(h=20, d=5, center=true, $fn=80);
    translate([57,51,0])
    cylinder(h=20, d=5, center=true, $fn=80);
    translate([25,128,0])
    cylinder(h=20, d=5, center=true, $fn=80);
    translate([25,51,0])
    cylinder(h=20, d=5, center=true, $fn=80);
};  

};


//