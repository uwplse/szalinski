// Yet an other die

/* [ Global ] */

// Width
W=20;

// Margin
M=2;

// Rounded corner (added to width)
R=2;

// Font height
FT=1.2;

module side(n)
{
    difference()
    {
        hull()
        {
            translate([0,W/2+R+1,0])
            cube([W-M,2,W-M],center=true);
            translate([0,M*2.5,0])
            cube([M,M,M],center=true);
        }
        for(a=[0:90:359])
        rotate([-90,0,0])
        translate([0,0,W/2+R])
        rotate([0,0,a])
        rotate([-45,0,0])
        translate([0,0,-sqrt(2)*W/4])
        rotate([0,0,180])
        translate([0,M,-FT])
        minkowski()
        {
            cylinder(r1=FT,r2=0,h=FT,$fn=4);
            linear_extrude(height=FT)
            text(n,size=(W-M)/3,halign="center",valign="center");
        }
    }
}

difference()
{
    minkowski()
    {
        sphere(R,$fn=100);
        cube([W,W,W],center=true);
    }
    rotate([0,0,0])side("1");
    rotate([0,0,90])side("2");
    rotate([90,0,0])side("3");
    rotate([-90,0,0])side("4");
    rotate([0,0,-90])side("5");
    rotate([0,0,180])side("6");
 }