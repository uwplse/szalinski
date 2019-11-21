$fn = 90;
height = 2;

module s()
{
    linear_extrude(height = height, center = false, convexity = 10, twist = 0)
    {
        polygon(points = [[0,0],[31,0],[31,6],[6,6],[6,20],[31,20],[31,26],[0,26]]);
    }
}

module l()
{
    linear_extrude(height = height, center = false, convexity = 10, twist = 0)
    {
        polygon(points = [[0,0],[6,0],[16,19],[26,0],[32,0],[19,26],[13,26]]);
    }
}

module o()
{
    linear_extrude(height = height, center = false, convexity = 10, twist = 0)
    {
        polygon(points = [[5,0],[16,0],[16,21]]);
        polygon(points = [[19,0],[30,0],[19,21]]);
        polygon(points = [[5,7],[16,26],[5,26]]);
        polygon(points = [[19,26],[30,26],[30,7]]);
    }
    for(i=[-2:2:26])
    {
        translate([0,i,0])
            cube([2,1,height]);
    }
    for(i=[-2:2:26])
    {
        translate([33,i,0])
            cube([2,1,height]);
    }
    for(i=[4:2:30])
    {
        translate([i,-5,0])
            cube([1,2,height]);
    }
    for(i=[4:2:30])
    {
        translate([i,29,0])
            cube([1,2,height]);
    }
}
module t()
{
    linear_extrude(height = height, center = false, convexity = 10, twist = 0)
    {
        polygon(points = [[13,0],[19,0],[19,20],[32,20],[32,26],[0,26],[0,20],[13,20]]);
    }
}


module ktn()
{
    difference()
    {
        union()
        {
            hull()
            {
                translate([13,14,0])
                    cylinder(d=3,h=height);
                translate([13,-14,0])
                    cylinder(d=3,h=height);
                translate([5,-4,0])
                    cylinder(d=3,h=height);
                translate([5,4,0])
                    cylinder(d=3,h=height);
            }
            hull()
            {
                translate([0,4,0])
                    cylinder(d=3,h=height);
                translate([0,-4,0])
                    cylinder(d=3,h=height);
                translate([4,-4,0])
                    cylinder(d=3,h=height);
                translate([4,4,0])
                    cylinder(d=3,h=height);
            }
        }
        union()
        {
            hull()
            {
                translate([0,4,0])
                    cylinder(d=1,h=height);
                translate([0,-4,0])
                    cylinder(d=1,h=height);
                translate([4,-4,0])
                    cylinder(d=1,h=height);
                translate([4,4,0])
                    cylinder(d=1,h=height);
            }
            hull()
            {
                translate([13,14,0])
                    cylinder(d=1,h=height);
                translate([13,-14,0])
                    cylinder(d=1,h=height);
                translate([6,-4,0])
                    cylinder(d=1,h=height);
                translate([6,4,0])
                    cylinder(d=1,h=height);
            }
        }
    }
    intersection()
    {
        union()
        {
            difference()
            {
                translate([16,0,0])
                    cylinder(d=10,h=height);
                translate([16,0,0])
                    cylinder(d=8,h=height);
            }
            difference()
            {
                translate([16,0,0])
                    cylinder(d=19,h=height);
                translate([16,0,0])
                    cylinder(d=17,h=height);
            }
            difference()
            {
                translate([16,0,0])
                    cylinder(d=28,h=height);
                translate([16,0,0])
                    cylinder(d=26,h=height);
            }
        }
        translate([33,0,0])
            rotate([0,0,45])
                cube([30,30,30],center=true);
    }
}

module v1()
{
    difference()
    {
        union()
        {
            hull()
            {
                translate([0,150,0])
                    cylinder(d=80,h=height,center=false);
                translate([0,10,0])
                    cylinder(d=80,h=height,center=false);
            }
        }
        union()
        {
            hull()
            {
                translate([0,150,0.6])
                    cylinder(d=76,h=height,center=false);
                translate([0,10,0.6])
                    cylinder(d=76,h=height,center=false);
            }
        }
    }
    translate([0,150,0])
    {
        translate([4,0,0])
            ktn();
        mirror([1,0,0])
            translate([4,0,0])
                ktn();
    }
    translate([-16,93,0])
        s();
    translate([-16,61,0])
        l();
    translate([-17.5,25.5,0])
        o();
    translate([-16,-10,0])
        t();
}

module v2()
{
    difference()
    {
        union()
        {
            hull()
            {
                translate([0,115,0])
                    cylinder(d=45,h=height,center=false);
                translate([0,0,0])
                    cylinder(d=45,h=height,center=false);
            }
        }
        union()
        {
            hull()
            {
                translate([0,115,0.6])
                    cylinder(d=42,h=height,center=false);
                translate([0,0,0.6])
                    cylinder(d=42,h=height,center=false);
            }
        }
    }
    translate([-16,93,0])
        s();
    translate([-16,61,0])
        l();
    translate([-17.5,25.5,0])
        o();
    translate([-16,-10,0])
        t();
}

//v1();
v2();

