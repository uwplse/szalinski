//*************************************************
// VARIABLES
//*************************************************

// part to generate ( 0: box ; 1: top ; 2: all )
part = 0; // [0:box,1:top,2:all]

// wall thickness
wt = 2;

// lower support (x,y,z) thickness
lss = [ 2, 2, 2 ];

// internal object x,y,z size ( must consider required margins )
is = [ 71.5, 50.5, 10 ];

// object count
oc = 1;

// top interlock margin
tim = .5;

// top grid airflow ( >0 to enable or 0 to disable )
tg = 0;

// top grid airflow wall thickness
tgwt = 5;

// hole (width, height, xcenter, xcenter_percent, zbottom)
// notes: if xcenter_percent true when pos represent position 0..1 inside
// zbottom is the distance from bottom to the begin of hole

// left holes ( array of [width, height, xcenter, xcenter_percent, zbottom] )
lh = [];

// right holes ( array of [width, height, xcenter, xcenter_percent, zbottom] )
rh = [];

// front holes ( array of [width, height, xcenter, xcenter_percent, zbottom] )
fh = [ [ 18, 12, 60.5, false, wt + lss[2] ] ];

// bottom holes ( array of [width, height, xcenter, xcenter_percent, zbottom] )
bh = [];
//bh = fh;

//*************************************************
//
//*************************************************

// total size
ts = [
    wt + oc * ( is[0] + wt ),
    is[1] + 2 * wt,
    wt + lss[2] + is[2] + 2 * wt
];

someholes = (len(lh) + len(rh) + len(fh) + len(bh)) > 0;

//======================================
// part: 0 ( BOX and HOLES )
//======================================
module box()
{
    wt3 = [wt, wt, wt];
    
    // box size
    bs = [ ts[0], ts[1], ts[2] - wt ];
    
    color("DarkGray", alpha=.5)
    {
        union()
        {    

            // main box
            difference()
            {
                cube(bs);
                translate(wt3)
                    cube([ts[0] - 2 * wt, bs[1] - 2 * wt, bs[2]]);
            }
            
            // pcb support
            translate(wt3)
            {
                difference()
                {
                    cube([
                        bs[0] - 2 * wt,
                        bs[1] - 2 * wt,
                        lss[2]
                    ]);
                    translate([lss[0], lss[1], 0])
                        cube([
                            bs[0] - 2 * wt - 2 * lss[0],
                            bs[1] - 2 * wt - 2 * lss[1],
                            lss[2]
                        ]);
                }
            }
            
            // objs sep walls with lower support
            if (oc > 1)
            {
                for (i = [1:oc-1])
                {
                    // wall
                    translate([i * (wt + is[0]), 0, 0])
                        cube([wt, bs[1], wt + lss[2] + is[2]]);
                    
                    // near support
                    translate([i * (wt + is[0]) - lss[0], 0, wt])        
                        cube([lss[0], bs[1], lss[2]]);
                    
                    // far support
                    translate([i * (wt + is[0]) + wt, 0, wt])        
                        cube([lss[0], bs[1], lss[2]]);
                }
            }
        }
    }
}

module holes()
{
    // front holes
    if (len(fh) > 0)
    {
        for (i = [0 : len(fh)-1])
        {    
            hole = fh[i];        
            
            w = hole[0];
            h = hole[1];        
            
            xpos = wt + i * (is[0] + wt) + 
                (hole[3] ? is[0] * hole[2] : hole[2]) - w/2;
            zpos = hole[4];
                    
            translate([xpos, 0, zpos])
                cube([w, wt + lss[1], h]);                
        }
    }
    
    // back holes
    if (len(bh) > 0)
    {
        for (i = [0 : len(bh)-1])
        {    
            hole = bh[i];        
            
            w = hole[0];
            h = hole[1];        
            
            xpos = wt + i * (is[0] + wt) + 
                (hole[3] ? is[0] * hole[2] : hole[2]) - w/2;
            zpos = hole[4];
                    
            translate([xpos, ts[1] - wt - lss[1], zpos])
                cube([w, wt + lss[1], h]);                
        }
    }
    
    // left holes
    if (len(lh) > 0)
    {
        for (i = [0 : len(lh)-1])
        {    
            hole = lh[i];                
            
            w = hole[0];
            h = hole[1];        
            
            ypos = wt + 
                (hole[3] ? is[1] * hole[2] : hole[2]) - w/2;
            zpos = hole[4];
                    
            translate([0, ypos, zpos])
                cube([wt + lss[1], w, h]);                
        }
    }
    
    // right holes
    if (len(rh) > 0)
    {
        for (i = [0 : len(rh)-1])
        {    
            hole = rh[i];                
            
            w = hole[0];
            h = hole[1];        
            
            ypos = wt + 
                (hole[3] ? is[1] * hole[2] : hole[2]) - w/2;
            zpos = hole[4];
                    
            translate([ts[0] - wt - lss[1], ypos, zpos])
                cube([wt + lss[1], w, h]);                
        }
    }
}

if (part == 0 || part == 2)
{
    difference()
    {
        box();
        if (someholes) holes();
    }
}

//======================================
// part: 1 ( TOP )
//======================================
module topGrid()
{
    if (tg > 0)
    {                
        // avx,y space after required margin
        avx = ts[0] - 4 * wt;
        avy = ts[1] - 4 * wt;
        
        dimx = tg + tgwt;
        dimy = tg + tgwt;
                                
        kx = floor(avx / dimx);
        offx = (ts[0] - kx * dimx) / 2 + tgwt / 2;
                
        ky = floor(avy / dimy);
        offy = (ts[1] - ky * dimy) / 2 + tgwt / 2;
        
        echo(ts[0]/oc);
        
        for (ix = [0:kx-1])
        {
            for (iy = [0:ky-1])
            {                                                
                tx = offx + ix * dimx;
                ty = offy + iy * dimy;
                
                if ((tx + dimx/2) % (ts[0]/oc) > wt + dimx/2)
                {                
                    translate([tx, ty, ts[2] - 2 * wt])
                        cube([tg, tg, 2 * wt]);
                }
            }
        }
    }
}

module top_()
{
    color("Coral", alpha=.5)    
    {
        // top
        translate([0, 0, ts[2]-wt])
            cube([ts[0], ts[1], wt]);
        
        // top interlock
        translate([wt + tim, wt + tim, ts[2] - 2 * wt])
            cube([ts[0] - 2 * wt - 2 * tim, ts[1] - 2 * wt - 2 * tim, wt]);
    }
}

module top()
{
    difference()
    {
        top_();
        topGrid();
    }    
}
if (part == 1 || part == 2)
{
    top();
}