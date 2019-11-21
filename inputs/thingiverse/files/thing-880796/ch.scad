// electrical outlet width
plug_side = 70;
// electrical outlet height
plug_h = 70;

// thickness of wall outside the outlet
plug_gap = 8;

// depth of wall outside the outlet
plug_depth = 13;
e =0.1;

tray_w = plug_side + plug_gap*2;

module receptible()
{
    rotate([90, 0, 0]) difference() {
        cube([tray_w, plug_h + plug_gap*2, plug_depth]);
        translate([plug_gap, plug_gap, -e])
            cube([plug_side, plug_h, plug_depth + 2*e]);
    }
}

// length of tray
tray_len = 70;
tray_side_bend_h = 7.5;
tray_side_bend_w = 10;

module triangle(len1, len2, h)
{
	linear_extrude(height = h)
	{
		polygon(points=[[0,0], [len1, 0], [0, len2]]);
	}
}

// tray
module tray() 
{
    cube([tray_w, tray_len, plug_gap]);

    translate([0, tray_len, plug_gap])
        rotate ([180, 0, 0]) rotate([0, 90, 0])
            triangle(tray_side_bend_h, tray_side_bend_w, tray_w);
}

slit_depth = 18;

// cable radius
cable_r = 2.2;
slit_open_l = 7.5*2;

module slit(pos)
{
    translate([pos-cable_r, tray_len-slit_depth/sqrt(2), 0])
        translate([0, 0, -e])
        {
            cube([
                cable_r*2,
                slit_depth,
                plug_gap + tray_side_bend_h + 2*e]);
            translate([cable_r, 0, 0])
            {
                cylinder(r = cable_r*1.1, h = slit_depth);
                translate([0, slit_open_l/2+e, 0])
                    rotate([0, 0, 45])
                        cube([slit_open_l/2,slit_open_l/2, slit_depth]);
            }
        }    
}


// number of cables
slit_count = 4;

rotate([90, 0, 0])
{
    difference()
    {
        tray();
        for (i = [0 : slit_count])
        {
            slit((tray_w/(slit_count+2))*(i+1));
        }
    }

    receptible();
}
