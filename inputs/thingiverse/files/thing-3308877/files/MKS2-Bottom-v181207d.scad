//  (Windows users must "escape" the backslashes by writing them doubled, or replace the backslashes with forward slashes.)

px1=8.25;
py1=8.25;
px2=160.15;
py2=95.34;
dp=7.63;

x1=16.605;
x2=151.805;
dx1=x2-x1;

y1=10.88;
y2=86.99;
dy1=y2-y1;

z1=33.337;
z2=33.337;
z3=30.164;

d1=2.3;
d2=7.37;
d3=8;

dx3=114;
dx4=124;
dx=(dx4-dx1)/2;
dy3=64;
dy4=64;
dy=(dy1-dy3)/2;

h1=9.523;
h2=10;
hr=1.5;

ds=3.385;
hs=20.83;
ts=3.176;
ts2=3.2;

dxs=30.45-17.75-0.6;

mx=168.399;
my=103.584;
rb=12.7;
rim=7.3;


*color("purple") //pilars
{
    translate([px1,py1,z1])
    cylinder(h=h1,d=dp,center=true, $fn=60);
    translate([px2,py1,z1])
    cylinder(h=h1,d=dp,center=true, $fn=60);
    translate([px2,py2,z1])
    cylinder(h=h1,d=dp,center=true, $fn=60);
    translate([px1,py2,z1])
    cylinder(h=h1,d=dp,center=true, $fn=60);
};
*color("red") //original mount - holes
{
    translate([x1,y1,z1])
    cylinder(h=h1,d=d1,center=true, $fn=60);
    translate([x2,y1,z1])
    cylinder(h=h1,d=d1,center=true, $fn=60);
    translate([x2,y2,z1])
    cylinder(h=h1,d=d1,center=true, $fn=60);
    translate([x1,y2,z1])
    cylinder(h=h1,d=d1,center=true, $fn=60);
};
*color("blue") //original mount - mounts
{
    translate([x1,y1,z2])
    cylinder(h=h1,d=d2,center=true, $fn=60);
    translate([x2,y1,z2])
    cylinder(h=h1,d=d2,center=true, $fn=60);
    translate([x2,y2,z2])
    cylinder(h=h1,d=d2,center=true, $fn=60);
    translate([x1,y2,z2])
    cylinder(h=h1,d=d2,center=true, $fn=60);
};

rotate([180,0,90])
{
union()
{
    difference()
    {
        union()
        {
            difference()
            {
                import("MKS_Case_Bottom.STL", convexity=3);
                
                color("pink")
                translate([mx/2,my/2,34.097])
                minkowski()
                {
                    cube([mx-2*rb-2*rim,my-2*rb-2*rim,10],center=true);
                    cylinder(h=1,r=rb,center=true,$fn=60);
                };
            };
            
            color("yellow")
            translate([0,0,z2+ts]) // satelite connections
            {
                linear_extrude(height = ts, center = true, convexity = 10, twist = 0)
                hull() 
                {
                    translate([px1,py1,0]) 
                    circle(d=dp,$fn=60);
                    translate([x1-dx,y1+dy,0])
                    circle(d=d2,$fn=60);
                };
                
                linear_extrude(height = ts, center = true, convexity = 10, twist = 0)
                hull() 
                {
                    translate([px1,py2,0]) 
                    circle(d=dp,$fn=60);
                    translate([x1-dx,y1+dy4+dy,0])
                    circle(d=d2,$fn=60);
                };
                
                linear_extrude(height = ts, center = true, convexity = 10, twist = 0)
                hull() 
                {
                    translate([px2,py2,0]) 
                    circle(d=dp,$fn=60);
                    translate([x1+dx4-dx,y1+dy3+dy,0])
                    circle(d=d2,$fn=60);
                };
                
                linear_extrude(height = ts, center = true, convexity = 10, twist = 0)
                hull() 
                {
                    translate([px2,py1,0]) 
                    circle(d=dp,$fn=60);
                    translate([x1+dx3-dx,y1+dy,0])
                    circle(d=d2,$fn=60);
                };
            };

            color("lightblue") // new mount - mounts
            {
                translate([x1-dx,y1+dy,z2-hr/2])
                cylinder(h=h1+hr,d=d2,center=true, $fn=60);
                translate([x1+dx3-dx,y1+dy,z2-hr/2])
                cylinder(h=h1+hr,d=d2,center=true, $fn=60);
                translate([x1+dx4-dx,y1+dy3+dy,z2-hr/2])
                cylinder(h=h1+hr,d=d2,center=true, $fn=60);
                translate([x1-dx,y1+dy4+dy,z2-hr/2])
                cylinder(h=h1+hr,d=d2,center=true, $fn=60);
            };
            
            color("blue") // ?
            {
                translate([x1,y1,z2])
                cylinder(h=h1,d=d2,center=true, $fn=60);
                translate([x2,y1,z2])
                cylinder(h=h1,d=d2,center=true, $fn=60);
                translate([x2,y2,z2])
                cylinder(h=h1,d=d2,center=true, $fn=60);
                translate([x1,y2,z2])
                cylinder(h=h1,d=d2,center=true, $fn=60);
            };
            
            color("green") //wall closures
            {
            translate([80,1.588,17])
            cube([135,ts,34],center=true);
            translate([70,101.998,7.5])
            cube([110,ts,15],center=true);
            };
            
            color("aqua") //support x 4040
            translate([17.75-2.38-2.25/2,my+15-17.173/2,19.049])
            cube([19.76,17.173+2*1,38.098],center=true);
                
            color("aqua") //support x 4040
            translate([17.75+11*dxs+2.5+2.25/2,my+15-17.173/2,19.049])
            cube([19.70,17.173+2*1,38.098],center=true);
            
        };
        
        color("pink") //new mount - holes
        {
            translate([x1-dx,y1+dy,z2-hr/2])
            cylinder(h=h2+hr,d=d1,center=true, $fn=60);
            translate([x1+dx3-dx,y1+dy,z2-hr/2])
            cylinder(h=h2+hr,d=d1,center=true, $fn=60);
            translate([x1+dx4-dx,y1+dy3+dy,z2-hr/2])
            cylinder(h=h2+hr,d=d1,center=true, $fn=60);
            translate([x1-dx,y1+dy4+dy,z2-hr/2])
            cylinder(h=h2+hr,d=d1,center=true, $fn=60);
        };
        
        color("orange") //original mount closure
        {
            translate([x1,y1,z3])
            cylinder(h=h1,d=d3,center=true, $fn=60);
            translate([x2,y1,z3])
            cylinder(h=h1,d=d3,center=true, $fn=60);
            translate([x2,y2,z3])
            cylinder(h=h1,d=d3,center=true, $fn=60);
            translate([x1,y2,z3])
            cylinder(h=h1,d=d3,center=true, $fn=60);
        };
         
        color("grey") //vent slits
        {
            for(n = [0 : 11])
            {
                translate([17.75+n*dxs,ts2/2-0.01,7.75])
                rotate([90,0,0])
                linear_extrude(height = ts2, center = true, convexity = 10, twist = 0)
                hull() 
                {
                    translate([0,hs,0]) 
                    circle(ds,$fn=60);
                    circle(ds,$fn=60);
                };
            };
            
            for(n = [1 : 10])
            {
                translate([17.75+n*(dxs),101.998,7.75])
                rotate([90,0,0])
                linear_extrude(height = ts2, center = true, convexity = 10, twist = 0)
                hull() 
                {
                    translate([0,hs,0]) 
                    circle(ds,$fn=60);
                    circle(ds,$fn=60);
                };
            };
        };
        
        color("lightgrey") //4040 profile
        translate([mx/2,my+35,18.099])
        rotate([0,0,90])
        resize([40,mx,40])
        import("item_0002633_Profile 8 40x40 light_L=20_1.stl", convexity=3);

        color("orangered")
        {
            translate([17.75-2.38-2.25/2+1,my+15-17.173/2-0.58,18.099])
            rotate([90,0,0])
            cylinder(h=20.36,d1=6,d2=7.6,center=true,$fn=60);

            
            translate([17.75+11*dxs+2.5+2.25/2,my+15-17.173/2-0.58,18.099])
            rotate([90,0,0])
            cylinder(h=20.36,d1=6,d2=7.6,center=true,$fn=60);

            translate([17.75-2.38-2.25/2-14,my+15-17.173/2-0.58+5.18,18.099])
            rotate([90,90,0])
            linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,15,0]) 
                circle(d=6,$fn=60);
                circle(d=6,$fn=60);
            };
            
            translate([17.75+11*dxs+2.5+2.25/2,my+15-17.173/2-0.58+5.18,18.099])
            rotate([90,90,0])
            linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,15,0]) 
                circle(d=6,$fn=60);
                circle(d=6,$fn=60);
            };
        }; 
        
        color("olivedrab") //nut void
        {
            translate([17.75-2.38-2.25/2-4,my+15.09-17.173/2-1,10])
            rotate([90,0,90])
            linear_extrude(height = 30, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,38.098-20,0]) 
                circle(d=11,$fn=60);
                circle(d=11,$fn=60);
            };
            translate([17.75+11*dxs+2.5+2.25/2+4,my+15.09-17.173/2-1,10])
            rotate([90,0,90])
            linear_extrude(height = 30, center = true, convexity = 10, twist = 0)
            hull() 
            {
                translate([0,38.098-20,0]) 
                circle(d=11,$fn=60);
                circle(d=11,$fn=60);
            };
        };
    };

    color("white") //mesostructured bottom
    intersection()
    {
        translate([mx/2,my/2,34.097])
        resize([mx+16,my,4])
        import("Sample_2.stl", convexity=3);

        translate([mx/2,my/2,34.097])
        minkowski()
        {
            cube([mx-2*rb,my-2*rb,10],center=true);
            cylinder(h=1,r=rb,center=true,$fn=60);
        };
    };
};

color("black") //supporting act
{
    union()
    {
        translate([9.5,119.5,17.6+0.3])
        cube([11,10,5],center=true);
        translate([9.5,122.5,17.6+0.3+11.199])
        cube([11,4,18],center=true);
    };
    union()
    {
        translate([158.9,119.5,17.6+0.3])
        cube([11,10,5],center=true);
        translate([158.9,122.5,17.6+0.3+11.199])
        cube([11,4,18],center=true);
    };
};

};
//