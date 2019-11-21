
// inner diameter ( equals the lens outer diameter to fit this cap)
INNER_DIAMETER = 73;

// inner height of this cap
INNER_HEIGHT = 8;

// inner offset of this cap. must be larger than THICKNESS.
INNER_OFFSET = 2.5;

// thickness. must be smaller than INNER_OFFSET. the multiple of extruder's nozzle diamiter is good.
THICKNESS = 2.4;

// $fs is the minimum size of a fragment. The default value is 2. If you don't know exactly what you do, just leave the default value.
FS = 0.1;

// $fa is the minimum angle for a fragment. The default value is 12. If you don't know exactly what you do, just leave the default value.
FA = 0.5;


module round_cube (h, w, r)
{
    translate([w/2-r/2 + r ,0,h/2 - r/2])
    rotate ([-90,0,0])
    difference () {
        difference () {
            minkowski()
            {
                cube ( size = [ w - r, h - r, r - 0.0 ], center = true );
                cylinder( r = r, h = 0.00001);
            }
            translate ([w+(w+r)/2 - r ,0, 0]) cube ( size = [ w *2, h*2 , r*2 ], center = true );
        }
        translate ([0, h+(h+r)/2 - r , 0]) cube ( size = [ w *2, h*2 , r*2 ], center = true );
    }
}



outer_h = INNER_HEIGHT + THICKNESS;
outer_d = (INNER_DIAMETER / 2) + INNER_OFFSET + THICKNESS;
inner_h = INNER_HEIGHT;
inner_d = INNER_DIAMETER / 2 + INNER_OFFSET;

outer_trans = (outer_h / 2);
inner_trans = (inner_h / 2) + (outer_h-inner_h);

$fs = FS;
$fa = FA;

union ()
{
    
    for ( i = [0:5] )
    {
        rotate ([0,0,60*i]) translate ([INNER_DIAMETER/2,0,THICKNESS]) round_cube ( INNER_HEIGHT, INNER_OFFSET, THICKNESS );
    }
    

    difference() 
    {
        translate([0,0, outer_trans]) cylinder( h = outer_h, r = outer_d , center = true );
        translate([0,0, inner_trans + 100/2]) cylinder( h = inner_h + 100, r = inner_d , center = true );
    }

}











