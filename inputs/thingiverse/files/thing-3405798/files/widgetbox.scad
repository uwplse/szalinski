// mm (inside size)
box_width = 70; // [50:5:150]
// mm (inside size)
box_length = 110; // [50:5:150]
// mm (inside size)
box_height = 34; // [20:1:50]

// Use a grid as the base of the box?
base_grid = 1; // [1:Yes, 0:No]
// Trianglular cutouts near the corners of the walls?
wall_triangles = 1;// [1:Yes, 0:No]
// Walls have low cut "windows"?
wall_windows = 1; // [1:Yes, 0:No]

boxsz = [ box_width, box_length, box_height+1 ] * 1;

linew = 0.48 /1;
lineh = 0.2  /1;
towersz = linew*8;

interface_z = lineh * 20;

gridw = linew*2;
gridsp = 5 /1;
base_z = lineh * 4;

triangle_sz = gridsp * 4;

wallw = linew*2;
ifch = interface_z - (lineh * 4);
uih = interface_z - (lineh * 8);
zf = 0.01/1;
zf2 = zf*2;


module Walls(sz, w) {
    translate([-w, -w, 0]) {
        cube([sz.x + w*2, w, sz.z]);
        cube([w, sz.y + w*2, sz.z]);
    }
    translate([sz.x, -w, 0]) {
        cube([w, sz.y + w*2, sz.z]);
    }
    translate([-w, sz.y, 0]) {
        cube([sz.x + w*2, w, sz.z]);
    }
}

module CenterWalls(sz, w, bigw) {
    wextra = bigw - w;
    translate( [ -wextra/2, -wextra/2, 0 ] ) 
        Walls([sz.x + wextra, sz.y + wextra, sz.z], w);
}

module WindowCut(upw, lw, h, d) {
    wd = (upw - lw) / 2;
    pts = [ [ 0, 0 ],
            [ upw, 0 ],
            [ upw - wd, -h ],
            [ wd, -h ]
        ];
    linear_extrude(height = d, convexity= 10) polygon(pts);
}

module Corner(cut) {
    translate([-cut.x, -cut.x, 0]) {
        cube([cut.x, cut.y, cut.z]);
        cube([cut.y, cut.x, cut.z]);
    }
}

module WallCenterCorner(cut, wsz) {
    wextra = wsz - cut.x;
    translate( [ -wextra/2, -wextra/2, 0 ] ) 
        Corner(cut);
}
module WallCenterCorners(cut, wsz, box) {
    WallCenterCorner(cut, wsz);
    translate([0, box.y, 0]) rotate([0,0,-90]) 
        WallCenterCorner(cut, wsz);
    translate([box.x, box.y, 0]) rotate([0,0,180]) 
        WallCenterCorner(cut, wsz);
    translate([box.x, 0, 0]) rotate([0,0,90]) 
        WallCenterCorner(cut, wsz);

}

module CornerTri(sz) {
    pts = [ 
            [ 0, 0 ],
            [ sz.x, 0 ],
            [ 0, sz.y ]
        ];
    linear_extrude(height = sz.z, convexity=10) polygon(pts);
}
module BoxCornerTris(trisz, box) {
    CornerTri(trisz);
    translate([0, box.y, 0]) rotate([0,0,-90]) 
        CornerTri(trisz);
    translate([box.x, box.y, 0]) rotate([0,0,180]) 
        CornerTri(trisz);
    translate([box.x, 0, 0]) rotate([0,0,90]) 
        CornerTri(trisz);
}    

difference() {
    union() {
        /* Towers */
        for ( x = [ 0 - towersz, boxsz.x ] ) for ( y = [ 0 - towersz, boxsz.y ] ) {
            translate([x,y,0]) cube([towersz, towersz, boxsz.z]);
        }
        /* Low interface bars */
        Walls([boxsz.x, boxsz.y, interface_z], towersz);
        /* Corner buff-ups */
        WallCenterCorners([linew*3, towersz*4, ifch+lineh], towersz*2, boxsz);
        if (base_grid) {
            /* Base grid */
            for ( x = [ 0 : gridsp : boxsz.x+zf ] ) {
                translate([x - (gridw/2), -zf, lineh]) cube([gridw, boxsz.y+zf2, base_z]);
            }
            for ( y = [ 0: gridsp : boxsz.y+zf ] ) {
                olw = linew*1.2;
                translate([-zf, y - (gridw/2), lineh]) cube([boxsz.x+zf2, gridw, base_z-lineh]);
                translate([-zf, y - (olw/2), 0]) cube([boxsz.x+zf2, olw, lineh+zf]);

            }
            /* Triangles in the corners to improve attachment */
            BoxCornerTris([triangle_sz, triangle_sz, lineh*2], boxsz);
        } else {
            translate([-zf, -zf, 0]) cube([boxsz.x+zf, boxsz.y+zf2, base_z]);
        }
        /* Walls (+ upper interface) */
        CenterWalls([boxsz.x, boxsz.y, boxsz.z + uih], wallw, towersz);
        /* Sharpen the very top of the corners to make them easier to insert */
        translate([0,0,boxsz.z+uih-zf]) WallCenterCorners([linew*1.2, towersz, 2*lineh+zf], towersz, boxsz);
    }
    /* Circularize the tower corner cutouts */
    for ( x = [ 0 - towersz, boxsz.x ] ) for ( y = [ 0 - towersz, boxsz.y ] ) {
            translate([x,y,-zf])
        translate([towersz/2, towersz/2, 0 ]) 
            cylinder(r = towersz/2, h=ifch+zf, $fn=16);
    }

    /* Lower interface cutouts */
    ifcw = wallw + linew*2;
    translate([0,0,-zf]) {
        WallCenterCorners([ifcw, towersz*3, ifch+zf], towersz, boxsz);
        WallCenterCorners([ifcw+linew*2, towersz*3, lineh*2+zf], towersz, boxsz);
    }
    
    /* "Windows" aka the cutouts in the walls */
    windowh = wall_windows ? (boxsz.z/2)+uih : uih + lineh * 2;
    windowlw = wall_windows ? [ boxsz.x/2, boxsz.y/2 ] : [ boxsz.x - towersz*4, boxsz.y - towersz*4 ];
    translate([towersz, 0, boxsz.z+uih+zf]) rotate([90,0,0])
        WindowCut(boxsz.x - towersz*2, windowlw.x, windowh, towersz);
    translate([towersz, boxsz.y+towersz, boxsz.z+uih+zf]) rotate([90,0,0])
        WindowCut(boxsz.x - towersz*2, windowlw.x, windowh, towersz);
    translate([0, boxsz.y - towersz, boxsz.z+uih+zf]) rotate([90,0,-90])
        WindowCut(boxsz.y - towersz*2, windowlw.y, windowh, towersz);
    translate([boxsz.x+towersz, boxsz.y - towersz, boxsz.z+uih+zf]) rotate([90,0,-90])
        WindowCut(boxsz.y - towersz*2, windowlw.y, windowh, towersz);
    
    /* The near-corner triangle cutouts in the walls */
    if (wall_triangles) {
        trcuth = 8;
        /* Short sides */
        translate([zf,0,trcuth]) rotate([90,0,0]) CornerTri([boxsz.x/6, boxsz.z/2, towersz]);
        translate([boxsz.x-zf,-towersz,trcuth]) rotate([90, 0, 180]) CornerTri([boxsz.x/6, boxsz.z/2, towersz]);
        translate([zf,boxsz.y+towersz,trcuth]) rotate([90,0,0]) CornerTri([boxsz.x/6, boxsz.z/2, towersz]);
        translate([boxsz.x-zf,boxsz.y,trcuth]) rotate([90, 0, 180]) CornerTri([boxsz.x/6, boxsz.z/2, towersz]);
        /* Long sides */
        translate([-towersz,zf,trcuth]) rotate([90,0,90]) CornerTri([boxsz.y/6, boxsz.z/2, towersz]);
        translate([0,boxsz.y-zf,trcuth]) rotate([90,0,-90]) CornerTri([boxsz.y/6, boxsz.z/2, towersz]);
        translate([boxsz.x,zf,trcuth]) rotate([90,0,90]) CornerTri([boxsz.y/6, boxsz.z/2, towersz]);
        translate([boxsz.x+towersz,boxsz.y-zf,trcuth]) rotate([90,0,-90]) CornerTri([boxsz.y/6, boxsz.z/2, towersz]);
    }
    
}