 //PSU
d=20;
dh=7;

difference()
{
    color("pink") //box
    union()
    {
        translate([215/2+28/2-10.75-d/2,-113/2-19-20,-5])
        {
        difference()
        {
            cube([71.5+d,113+4,50+4], center=true);
            translate([-1.001,0,0])
            cube([71.5-2+d,113+0,50+0], center=true);
        };
        
        
        
    };
        translate([131.5,0,116.5])
        rotate([0,90,0])
        {
            translate([215/2+28/2-20,-113/2-19-20,10])
            cylinder(h=10, d=8, center=true, $fn=96);
            
            translate([215/2+28/2+20,-113/2-19-20,10])
            cylinder(h=10, d=8, center=true, $fn=96);
        };
        
        translate([215/2+28/2+23,-113/2+2.25,-5])
        rotate([0,90,0])
        rotate_extrude(convexity = 10, $fn = 96)
        translate([dh/2+2, 0, 0])
        circle(d = 4, $fn = 64);
         
    };
    
    difference() //12V cable feedthrough
    {
        translate([215/2+28/2+23+0.001,-113/2+2.25,-5])
        rotate([0,90,0])
        rotate_extrude(convexity = 10, $fn = 96)
        translate([dh/2+1.99, 0, 0])
        square(size = 4, $fn = 64, center=true);
        
        translate([215/2+28/2+23+0.001,-113/2+2.25,-5])
        rotate([0,90,0])
        rotate_extrude(convexity = 10, $fn = 96)
        translate([dh/2+2, 0, 0])
        circle(d = 4, $fn = 64);
        
        translate([215/2+28/2+23+0.001,-113/2+2.25,-5])
        rotate([0,90,0])
        rotate_extrude(convexity = 10, $fn = 96)
        translate([dh/2+4, 0, 0])
        square(size = 4, $fn = 64, center=true);
            
        translate([215/2+28/2+23-1.999,-113/2+2.25,-5])
        rotate([0,90,0])
        rotate_extrude(convexity = 10, $fn = 96)
        translate([dh/2+2, 0, 0])
        square(size = 4, $fn = 64, center=true);
    };
    translate([123,0,116.5])
    rotate([0,90,0])
    translate([215/2+28/2,-113/2+2.25,10])
    cylinder(h=30, d=dh, center=true, $fn=48);
    
    color("grey") //switch
    translate([123,0,116.5])
    rotate([0,90,0])
    {
        difference()
        {
            translate([215/2+28/2,-113/2-19-20,10])
            cube([28,48,30], center=true);
            translate([215/2+28,-113/2-14,10])
            rotate([0,0,45])
            cube([10,10,32], center=true);
            translate([215/2,-113/2-14,10])
            rotate([0,0,45])
            cube([10,10,32], center=true);
        };
        
        translate([215/2+28/2-20,-113/2-19-20,10])
        cylinder(h=30, d=2.5, center=true, $fn=48);
        
        translate([215/2+28/2+20,-113/2-19-20,10])
        cylinder(h=30, d=2.5, center=true, $fn=48);
    };
    
        translate([215/2+28/2+23-8,-113/2+2.25,-5])
        rotate([0,90,0])
        rotate_extrude(convexity = 10, $fn = 96)
        translate([dh/2+2, 0, 0])
        circle(d = 4, $fn = 64);
    
    color("red") //M3 holes
    translate([0,-113/2-20-19,-5])    
    {
        translate([75,113/2,12.5])
        rotate([90,0,0])
        cylinder(h=20, d=5, center=true, $fn=64);
        
        #translate([75,113/2+2,-4.5])
        rotate([90,0,0])
        cube([21,60,5], center=true);

        translate([75,113/2,-12.5])
        rotate([90,0,0])
        cylinder(h=20, d=5, center=true, $fn=360);
        
        #translate([75,113/2-1.5,-25.5])
        rotate([0,0,0])
        cube([21,60,5], center=true);
        
        #translate([75,113/2-31.5,-25])
        rotate([0,0,0])
        cylinder(h=20, d=21, center=true, $fn=64);
        
        translate([75,113/2-81.5,-25])
        rotate([0,0,0])
        cylinder(h=20, d=4, center=true, $fn=64);
        
        translate([75,113/2-113,-12.5])
        rotate([90,0,0])
        cylinder(h=20, d=4, center=true, $fn=64);
    };
    
    color("green")
    {
        translate([74-31/2,-120.5-31.5+21.5+25/2,21])
        rotate([0,0,0])
        cylinder(h=3, d=40, center=true, $fn=360);
        translate([74-31/2,-120.5-31.5+21.5+25/2+46,21])
        rotate([0,0,0])
        cylinder(h=3, d=40, center=true, $fn=360);
    };
    
    for (a =[5.5:5.5:30])
    translate([145.5,-153+a,15])
    rotate([0,90,0])
    linear_extrude(height = 3, center = true, convexity = 10, twist = 0)
    hull() 
    {
        translate([40,0,0]) 
        circle(d=2,$fn=32);
        circle(d=2,$fn=32);
    };
    
    for (a =[0:5.5:40])
    translate([145.5-6,-38-115,14.5-a])
    rotate([0,90,90])
    linear_extrude(height = 3, center = true, convexity = 10, twist = 0)
    hull() 
    {
        translate([0,21,0]) 
        circle(d=2,$fn=32);
        circle(d=2,$fn=32);
    };

    for (a =[0:5.5:40])
    translate([145.5-6,-38,14.5-a])
    rotate([0,90,90])
    linear_extrude(height = 3, center = true, convexity = 10, twist = 0)
    hull() 
    {
        translate([0,21,0]) 
        circle(d=2,$fn=32);
        circle(d=2,$fn=32);
    };
    
    for (a =[5.5:5.5:114])
    translate([145.5-6,-38-115+a,21])
    rotate([0,0,90])
    linear_extrude(height = 3, center = true, convexity = 10, twist = 0)
    hull() 
    {
        translate([0,21,0]) 
        circle(d=2,$fn=32);
        circle(d=2,$fn=32);
    };
    
    for (a =[5.5:5.5:114])
    translate([145.5-6,-38-115+a,-31])
    rotate([0,0,90])
    linear_extrude(height = 3, center = true, convexity = 10, twist = 0)
    hull() 
    {
        translate([0,21,0]) 
        circle(d=2,$fn=32);
        circle(d=2,$fn=32);
    };

    *translate([-1,2.043-2.25,-40.81+2]) //right mount
    import("C:/Users/wpno2/OneDrive/3D Printing/Enclosure_for_MKS_1.4_Kingprint_and_RepRapDiscount_Full_Graphic_Smart_Controller/files/PSU_Mount_4040_Right v181212c resize.stl", convexity=3);
    
};   

difference() //support
{
    union()
    {
        translate([91.0+29.25/2+0.4/2,-54+6/2,-4.6-3.5/2-6/2])
        cube([52.5+29.25-0.4,34+6,51.5+6],center=true);
        translate([75-0.37,-31.5-39,-31])
        rotate([0,0,0])
        cylinder(h=2, d=19, center=true, $fn=64);
    };

translate([91.0+29.25/2+0.4/2+19,-54+6/2-5,-4.6-3.5/2-6/2+5])
cube([52.5+29.25-0.4,34+6,51.5+6],center=true);

translate([91.0+29.25/2+0.4/2-1,-54+6/2-8.1,-4.6-3.5/2-6/2+8.099])
cube([52.5+29.25-0.4,34+6,51.5+6],center=true);
};




