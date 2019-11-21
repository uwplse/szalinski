
//  Windows users must "escape" the backslashes by writing them doubled, or replace the backslashes with forward slashes.

// $fn ratio = diameter * 8

hc=16; //cube height
dc=8; //thickness
wc=16; //elliptoid center diameter
sr=2; //elliptoid ratio
sc=5.5; //wedge scale

an=atan((sc)/(wc+dc/2)); //wedge angle
//echo(an);
as=sin(an); 
echo(as, as*wc);


difference()
{
    color("grey")
    translate([0,0,8+hc/2])
    //cube([8,20,hc], center=true);
    
    linear_extrude(height = hc, center = true, convexity = 10, twist = 0)
    hull() 
    {
        translate([0,wc/2,0]) 
        scale([sr,1,1])
        circle(d=dc/sr, $fn=96);
        translate([0,-wc/2,0])
        scale([sr,1,1])
        circle(d=dc/sr, $fn=96);
    };

    union()
    {
        for (a=[0:15:90])
        rotate([0,0,a])
        import("C:/Users/rekerda/Downloads/item_0002633_Profile 8 40x40 light_L=20_1.stl", convexity=3);
    };
};


difference()
{
    color("green")
    translate([0,0,24+wc/2-dc/2/sr])
    rotate([0,90,0])
    rotate_extrude(convexity = 10, $fn=wc*8)
    translate([wc/2, 0, 0])
    scale([1,sr,1])
    circle(d = dc/sr, $fn = dc*8);

    difference()
    {
        translate([0,0,24+wc/2-dc/4+dc/4])
        linear_extrude(height = wc/2, center = false, convexity = 10, scale=[1,sc], $fn=100)
        square([dc+.001,1], center=true);

        color("fuchsia")
        translate([0,0,24+wc/2-dc/2/sr])
        {
        rotate([an,0,0])
        translate([0,0,wc/2])
        scale([sr,1,1])
        sphere(d = dc/sr+0.001, $fn = dc*16);
            
        rotate([-an,0,0])
        translate([0,0,wc/2])
        scale([sr,1,1])
        sphere(d = dc/sr+0.001, $fn = dc*16);
        };
    };
};




