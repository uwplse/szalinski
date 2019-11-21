//  Windows users must "escape" the backslashes by writing them doubled, or replace the backslashes with forward slashes.

// optimum slicing of round edges:
// for a 0.2mm layer height $fn= 16 * d
// 16 = roundup ( 1mm * pi / 0.2mm )

f1=30; // use 30 for modelling and 360 for rendering
f2=10; // use 10 for modelling and 120 for rendering

dc=104; // back rounding negative
d2=130; // front rounding negative

s=113.6/112.4; // s is fitting factor: 
     // use caliper to exact measure PSU width. 
     // replace numerator with measured value.

translate([-25,95.5,91.75])
scale([1,s,1])
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
                circle(17, $fn=f1);
                circle(10, $fn=f1);
            };
            translate([-75,-113/2-1,-12.5])
            rotate([90,0,0])
            linear_extrude(height = 2, center = true, convexity = 10, twist = 0)
            hull()
            {
                translate([0,37.5+1,0])
                circle(17, $fn=f1);
                circle(10, $fn=f1);
            };
            
            translate([-75-3.5+20,113/2-81.5-3.5+9,26])
            linear_extrude(height = 2, center = true, convexity = 10, twist = 0)
            hull()
            {
                translate([0,39,0])
                circle(d=78, $fn=f1);
                circle(d=78, $fn=f1);
            };
            
            translate([-75-3.5-4.25-49.5/2,113/2-56.5-117/2,25])
            cube([49.5,117,2],center=false); 
        
            translate([-75-3.5-4.25-49.5/2+2/sqrt(2),113/2-56.5-117/2,25+0.58])
            rotate([0,-45,0])
            cube([50*sqrt(2),117,2],center=false);   
         
            *translate([-215/2,-185,51/2-5.5+2])
            rotate([0,-45,0]) 
            {
                translate([60.54,223.50,2.53])
                cylinder(h=2, d=40, center=true, $fn=f1);
                translate([60.54,223.50-77,2.53])
                cylinder(h=2, d=40, center=true, $fn=f1); 
            };  
            
        };  
        translate([-215/2,-37,22]) // left support
        rotate([90,0,0])
        linear_extrude(height = 2, convexity = 10)
        polygon(points=[
            [0,-2],
            [22.5,-40.5],
            [49.5,-2],
            [50+sqrt(2),50-sqrt(2)]
            ]);  

        translate([-215/2,-37-115,22]) // right support
        rotate([90,0,0])
        linear_extrude(height = 2, convexity = 10)
        polygon(points=[
            [0,-2],
            [22.5,-40.5],
            [49.5,-2],
            [50+sqrt(2),50-sqrt(2)]
            ]);  
      
        // fan hole support
        translate([-58.5,-113,21])
        difference()
        {
            union()
            {
                difference()
                {
                    linear_extrude(height = 52, center = false, convexity = 10, twist = 0)
                    hull()
                    {
                        translate([0,35,0])
                        circle(d=64, $fn=f1);
                        circle(d=64, $fn=f1);
                    };
                    linear_extrude(height = 52, center = false, convexity = 10, twist = 0)
                    hull()
                    {
                        translate([0,35,0])
                        circle(d=60, $fn=f1);
                        circle(d=60, $fn=f1);
                    };            
                };
                translate([0,-2,0])
                difference()
                {
                    linear_extrude(height = 52, center = false, convexity = 10, twist = 0)
                    hull()
                    {
                        translate([0,39,0])
                        circle(d=78, $fn=f1);
                        circle(d=78, $fn=f1);
                    };
                    linear_extrude(height = 52, center = false, convexity = 10, twist = 0)
                    hull()
                    {
                        translate([0,39,0])
                        circle(d=74, $fn=f1);
                        circle(d=74, $fn=f1);
                    };
                };
            };
            
            // back rounding negative
            translate([dc/2+1+sqrt(2)-0.014,76,dc/2-1.34])
            rotate([90,0,0])
            cylinder(h=120,d=dc,$fn=f1);
            
            translate([-108,-43,52.31])
            rotate([0,45,0])
            cube([80,120,80]);
            
        };  
    };
    
    // front rounding negative
    translate([-107.5-41.435,-35.5,20-50.05])
    rotate([90,0,0])
    cylinder(h=120, d=d2, center=false, $fn=f1);
    
    // fan hole
    translate([-58.5,-113,21])
    linear_extrude(height = 2.02, center = true, convexity = 10, twist = 0)
    hull()
    {
        translate([0,35,0])
        circle(d=60, $fn=f1);
        circle(d=60, $fn=f1);
    };
    
    translate([-57.5,-95.5,36])
    rotate([0,0,0])
    cylinder(h=40,d=60,$fn=f1);

    color("grey") //PSU
    difference()
    {
        translate([0,-113/2-20-19,-5])
        union()
        {
            minkowski()
            {
                cube([215-2,113-2,50-2],center=true);
                sphere(d=2,center=true,$fn=f2);
            };

            translate([-75,113/2,12.5])
            rotate([90,0,0])
            cylinder(h=20, d=4, center=true, $fn=f2);

            translate([-75,113/2,-12.5])
            rotate([90,0,0])
            cylinder(h=20, d=4, center=true, $fn=f2);
            
            translate([-75,113/2-31.5,-25])
            rotate([0,0,0])
            cylinder(h=20, d=4, center=true, $fn=f2);
            
            translate([-75,113/2-81.5,-25])
            rotate([0,0,0])
            cylinder(h=20, d=4, center=true, $fn=f2);
            
            translate([-75,113/2-113,-12.5])
            rotate([90,0,0])
            cylinder(h=20, d=4, center=true, $fn=f2);

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
        cylinder(h=20, d=4, center=true, $fn=f2);
        translate([76,5,0])
        cylinder(h=20, d=4, center=true, $fn=f2);
        translate([6,174,0])
        cylinder(h=20, d=4, center=true, $fn=f2);
        translate([76,174,0])
        cylinder(h=20, d=4, center=true, $fn=f2);

        translate([57,128,0])
        cylinder(h=20, d=4, center=true, $fn=f2);
        translate([57,51,0])
        cylinder(h=20, d=4, center=true, $fn=f2);
        translate([25,128,0])
        cylinder(h=10, d=4, center=true, $fn=f2);
        translate([25,51,0])
        cylinder(h=10, d=4, center=true, $fn=f2);
        translate([25,128,-12])
        cylinder(h=20, d=6, center=true, $fn=f2);
        translate([25,51,-12])
        cylinder(h=20, d=6, center=true, $fn=f2);
        
        translate([8,140,-10])
        cylinder(h=20, d=10, center=true, $fn=f2);
        translate([8,39,-10])
        cylinder(h=20, d=10, center=true, $fn=f2);
    };  

};









//