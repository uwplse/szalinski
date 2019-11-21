cellheight = 10; // depth
rows = 8;
cols = 10;

/* [hidden] */
cellrad = 0.25*25.4/2; // quarter inch diameter
cellthick = 0.8; // wall thickness

module honeycomb(rows,cols) {
	cellsize = cellrad-cellthick/2;
	voff = cellsize*1.5;
	hoff = sqrt(pow(cellsize*2,2)-pow(cellsize,2));

    for (i=[0:rows-1])
    {
		for (j=[0:cols-1])
        {
			translate([j*hoff+i%2*(hoff/2),i*voff,0])
                rotate([0,0,30])
                    translate([0,0,-0.5]) cylinder(r=cellrad-cellthick,h=cellheight+1,$fn=6);
		}
	}
}

module roundedcube(xdim, ydim, zdim, rdim) {
    hull()
    {
        translate([rdim,rdim,0]) cylinder(h=zdim,r=rdim, $fn=64);
        translate([xdim-rdim,rdim,0]) cylinder(h=zdim,r=rdim, $fn=64);
        translate([rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim, $fn=64);
        translate([xdim-rdim,ydim-rdim,0]) cylinder(h=zdim,r=rdim, $fn=64);
    }
}

// pull it all together
difference()
{
    translate([-(cellrad+cellthick)/2-1.2,-cellrad+cellthick-1.2,-2])
        roundedcube(2+cols*cellrad+(cols/2*cellrad)+cellrad-cellthick,
            2+cellthick+rows*4.14+cellthick, cellheight+2,2);
    honeycomb(rows,cols);
}
