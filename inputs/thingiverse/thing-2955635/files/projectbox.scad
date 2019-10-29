$fn = 50;
wall = 2.5; // thickness
corner_r = 4; // radius
box_x = 74; // length
box_y = 43; // width
box_z = 21; // height
rim_multi = 1.5; // rim depth as multiple of wall

box();
lid();

module box()
{
    difference()
    {
        // outer box
        roundedBox(box_x+2*wall, box_y+2*wall, box_z+2*wall, corner_r);

        // inner box
        translate([wall,wall,wall]) roundedBox(box_x, box_y, box_z+wall+1, corner_r*0.66);

        // grooves
        translate([(box_x+2*wall)/4,wall,box_z+wall*1.5]) groove();
        translate([(box_x+2*wall)/4,box_y+wall,box_z+wall*1.5]) groove();
    }
}

module lid()
{
    translate([-10,0,wall]) rotate([0,180,0])
    {
        roundedBox(box_x+2*wall, box_y+2*wall, wall, corner_r);

        difference()
        {
            // outer rim
            translate([wall,wall,-(rim_multi*wall)])
                roundedBox(box_x, box_y, rim_multi*wall, corner_r*0.66);

            // inner rim
            translate([wall*1.5,wall*1.5,-(wall*rim_multi)-0.5])
                roundedBox(box_x-wall, box_y-wall, rim_multi*wall, corner_r*0.66);
        }

        // lips
        translate([(box_x+2*wall)/4,wall,-wall/2]) groove();
        translate([(box_x+2*wall)/4,box_y+wall-0.5,-wall/2]) groove();
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

module groove()
{
    hull()
    {
        translate([0,0,-1]) sphere(r=0.5);
        translate([box_x/2,0,-1]) sphere(r=0.5);
    }
}
