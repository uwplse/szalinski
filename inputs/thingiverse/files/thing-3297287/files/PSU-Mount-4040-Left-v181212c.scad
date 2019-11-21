//  Windows users must "escape" the backslashes by writing them doubled, or replace the backslashes with forward slashes.

// optimum slicing of round edges:
// for a 0.2mm layer height $fn= 16 * d
// 16 = roundup ( 1mm * pi / 0.2mm )





    difference()
    {
        color("aqua") //support x 4040
        union() 
        {
            *translate([75,-20-9,0])
            cube([20,20,40],center=true);
                
            translate([-75,-20-9,0])
            cube([20,20,40],center=true);
            
            rotate([90,0,0])
            *translate([75,-20-9,0])
            cube([20,20,40],center=true);
            
            rotate([90,0,0])
            translate([-75,-20-9,0])
            cube([20,20,40],center=true);
            
            *translate([75,-20-8.5,-28.5])
            cube([20,21,21],center=true);
            
            translate([-75,-20-8.5,-28.5])
            cube([20,21,21],center=true);
            
            difference()
            {
                *translate([75,-88.999+18.5,-30])
                rotate([-90,0,90])
                linear_extrude(height =20, center = true, convexity = 10, twist = 0)
                polygon(points=[
                    [0,2],
                    [0,0],
                    [31.5,0],
                    [31.5,9]
                    ]);
                    
                *translate([75,-70.5,-34])
                cylinder(h=4, d=20, center=true, $fn=320);
            };
            *translate([75,-70.5,-31])
            cylinder(h=2, d=20, center=true, $fn=320);

            difference()
            {
                translate([-75,-88.999+18.5,-30])
                rotate([-90,0,90])
                linear_extrude(height =20, center = true, convexity = 10, twist = 0)
                polygon(points=[
                    [0,2],
                    [0,0],
                    [31.5,0],
                    [31.5,9]
                    ]);
                    
                translate([-75,-70.5,-34])
                cylinder(h=4, d=20, center=true, $fn=320);
            };
            translate([-75,-70.5,-31])
            cylinder(h=2, d=20, center=true, $fn=320);
                        
        };
        
        #color("lightgrey") //4040 profile
        translate([0,0,0])
        rotate([0,0,90])
        resize([40,200,40])
        import("C:/Users/wpno2/OneDrive/3D Printing/4040 Profile 8 Stabilizer & End Cap/files/item_0002633_Profile 8 40x40 light_L=20_1.stl", convexity=3);

        color("orangered") //m5 mounting holes
        {
            *translate([75,-29,0])
            rotate([90,0,0])
            cylinder(h=21,d1=6,d2=6,center=true,$fn=96);
            
            *translate([-75,-29,0])
            rotate([90,0,0])
            cylinder(h=21,d1=6,d2=6,center=true,$fn=96);

            *translate([75+1,-21,0])
            rotate([90,90,0])
            linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,15,0]) 
                circle(d=6,$fn=96);
                circle(d=6,$fn=96);
            };
            
            translate([-75-16,-21,0])
            rotate([90,90,0])
            linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,15,0]) 
                circle(d=6,$fn=96);
                circle(d=6,$fn=96);
            };
        };
       
        color("orange") //m5 mounting holes
        rotate([90,0,0])
        {
            *translate([75,-39,0])
            rotate([90,0,0])
            cylinder(h=21,d1=9,d2=9,center=true,$fn=144);
            
            translate([-75,-39,0])
            rotate([90,0,0])
            cylinder(h=21,d1=9,d2=9,center=true,$fn=144);
            
            *translate([75,-29,0])
            rotate([90,0,0])
            cylinder(h=21,d1=6,d2=6,center=true,$fn=144);
            
            translate([-75,-29,0])
            rotate([90,0,0])
            cylinder(h=21,d1=6,d2=6,center=true,$fn=144);
            
            *translate([75-14,-21,0])
            rotate([90,90,0])
            linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,15,0]) 
                circle(d=6,$fn=96);
                circle(d=6,$fn=96);
            };
            
            *translate([-75-16,-21,0])
            rotate([90,90,0])
            linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,15,0]) 
                circle(d=6,$fn=96);
                circle(d=6,$fn=96);
            };
        };  
        
        color("olivedrab") //nut void
        {
            *translate([75,-29.5,-20.5])
            rotate([90,0,90])
            linear_extrude(height = 30, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,31,0]) 
                circle(d=11,$fn=60);
                circle(d=11,$fn=60);
            };
            translate([-75,-29.5,-20.5])
            rotate([90,0,90])
            linear_extrude(height = 30, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,31,0]) 
                circle(d=11,$fn=60);
                circle(d=11,$fn=60);
            };
        };
        
        color("purple") //nut void
        rotate([90,0,0])
        {
            *translate([75,-29.5,-10.5])
            rotate([90,0,90])
            linear_extrude(height = 30, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,27,0]) 
                circle(d=11,$fn=60);
                circle(d=11,$fn=60);
            };
            translate([-75,-29.5,-10.5])
            rotate([90,0,90])
            linear_extrude(height = 30, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,27,0]) 
                circle(d=11,$fn=60);
                circle(d=11,$fn=60);
            };
        };
        
        color("blue") //extra void
        //rotate([90,0,0])
        {
            *translate([75,-32.0,-32.0])
            rotate([90,90,90])
            //cylinder(h=21,d=6,center=true,$fn=60);
            linear_extrude(height = 30, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,4,0]) 
                circle(d=6,$fn=60);
                circle(d=6,$fn=60);
            };
            
            translate([-75,-32.0,-32.0])
            rotate([90,90,90])
            //cylinder(h=21,d=6,center=true,$fn=60);
            linear_extrude(height = 30, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,4,0]) 
                circle(d=6,$fn=60);
                circle(d=6,$fn=60);
            };
            
            *translate([75,20,-39])
            difference()
            {
                cube(size=20.001,center=true);
                translate([0,-10,10])
                rotate([0,90,0])
                cylinder(h=20.01, d=20, center=true, $fn=320); 
            };
            
            translate([-75,20,-39])
            difference()
            {
                cube(size=20.001,center=true);
                translate([0,-10,10])
                rotate([0,90,0])
                cylinder(h=20.01, d=20, center=true, $fn=320); 
            };
        };
        
       
     
#color("grey") //PSU
difference()
{
    translate([0,-113/2-20-19,-5])
    union()
    {
        minkowski()
        {
            cube([215-2,113-2,50-2],center=true);
            sphere(d=2,center=true,$fn=30);
        };

        *translate([75,113/2,12.5])
        rotate([90,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);

        *translate([75,113/2,-12.5])
        rotate([90,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);
        
        translate([-75,113/2,12.5])
        rotate([90,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);

        translate([-75,113/2,-12.5])
        rotate([90,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);
        
        *translate([75,113/2-31.5,-25])
        rotate([0,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);
        
        *translate([75,113/2-81.5,-25])
        rotate([0,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);
        
        translate([-75,113/2-31.5,-25])
        rotate([0,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);
        
        translate([-75,113/2-81.5,-25])
        rotate([0,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);
        
        *translate([75,113/2-113,-12.5])
        rotate([90,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);
        
        translate([-75,113/2-113,-12.5])
        rotate([90,0,0])
        cylinder(h=20, d=4, center=true, $fn=30);

    };
    
    translate([98+0.001,-113/2-19-20.25,7.001])
    cube([19,113-2*2,26],center=true);
    
};


        
};



    

//