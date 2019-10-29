$fn = 50;
xlength = 100;
ywidth = 100;
zheight = 60;
corner = 2; // radius
wall = 2; // thickness
divisions = 3;
fudge = 43;
angle = 20;

difference()
{
    base();
    
    // trianglular cutout 
    translate([-xlength/2,-fudge,zheight/3]) rotate([angle,0,0]) cube([xlength*2, ywidth*2, zheight*2]);
}

module base()
{
    // hollow box with rounded corners
    difference()
    {
        roundedBox(xlength, ywidth, zheight, corner);
        translate([wall,wall,wall]) roundedBox(xlength-2*wall, ywidth-2*wall, zheight, corner/2);
    }

    // dividers
    for(i = [1 : 1 : divisions-1])
    {
        translate([0,ywidth/divisions*i,wall]) cube([xlength,wall,zheight-wall]);
        translate([xlength/divisions*i,0,wall]) cube([wall,ywidth,zheight-wall]);
    }
}

module roundedBox(xdim, ydim, zdim, rdim)
{
    hull()
    {
        translate([rdim,rdim,0]) cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,rdim,0]) cylinder(h=zdim,r=rdim);
        translate([rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim);
    }
}
