// Jotunheim 3D Print'n'Play Pieces
//   by Michael Van Biesbrouck, (c) 2019.
//   License: Attribution-NonCommercial 4.0 International
//            http://creativecommons.org/licenses/by-nc/4.0/
//
// Rules and cards available online.
//
// Site: https://sites.google.com/site/mlvanbie/jotunheim
// BGG:  https://www.boardgamegeek.com/boardgame/267571/jotunheim
//
// This file can generate many different outputs.
//
// If you are printing an entire 3D set you will need to generate
// STL files for each of the following part settings:
//   * 'frame': optional but recommended board
//   * 'blocks24': print once in brown, twice in white
//   * 'caps16': print in white
//   * 'pawns' or 'pawns_and_stand': print twice in different colours, possibly with different settings for 'facets'
//   * 'rescuer': once in blue for Hel (or twice in the previous colours but with a different number of facets)
// Before you print blocks and caps you should print 'block_test' and
// 'cap_test' to make sure that you have good settings.  (Also handy
// for replacing lost pieces.)
//
// If you are printing a frame to use with stone blocks (e.g. mosaic
// tile instead of 3D-printed blocks) then set 'size' to be the block
// width (there will be 'frame_gap' extra space) and 'height' to the
// block height.  Set the part to 'frame_test' to print out a 2x2
// matrix for a fit test.  If that works, set part to 'frame'.

// What do you want to build?
part = "block_test";            // [block_test, cap_test, frame_test, block_section, blocks24, blocks12, caps16, pawns, rescuer, frame, stand, pawns_and_stand]

// Configurable constants.
// Block width/height in mm
size = 24;                      // [20:51]
// Thickness of block wall in mm, affects bevel height.
thickness = 2.5;                // [1:0.5:3]
bevel_height = 2 * thickness;   // (2 .. 3) * thickness
// Height of pieces in mm excluding bevel.
height = 9;     // [4:30]
piece_height = height - bevel_height;              // 5 .. size/2
cap_height = height * 3 / 4;    // bevel_height+2 .. size * 3/8
// Number of sides for various pawn types.
facets = 4;                     // [4, 8, 75]
// Extra space in mm around blocks in frame.
frame_gap = 1;                  // [1:0.25:2]
// Height of frame trace in mm.
frame_height = 2;               // [1:0.5:3]
// Width of frame trace in mm.
frame_width = 2;                // [1:0.5:4]
wall_width = thickness;         // 1 .. 5; thickness is consistent if you are printing blocks 
wall_height = height;           // Change for stone blocks; 0 for no wall.
// Thickness of floor in mm, 0 for no floor.
floor_thickness = 0.6;		// [0:0.2:2]
// Width of card in mm; 66 works for 2.5in card in Maydat Perfect Fit sleeve.
stand_card_width = 66;          // [100]
// Thickness of card slot in mm, okay to leave extra space.
stand_card_thickness = 1;       // [0.6:0.2:2.0]
// Space to overlap card and stand in mm.
stand_grip = 2;                 // [1:5]
// Should there be a slot in the stand base?
stand_slot = true;

// Constants that should only be computed.
inner_size = size - 2 * thickness;
hole_size = size - 4 * thickness - frame_gap;
hole_width = size + frame_gap;
skip = frame_width+hole_width;
big = size * 10;
bar_length = hole_width+frame_width+wall_width;
eps = 0 + 0.0000000001;
board_cells = [6, 6, 4, 2];

module pyramid (hs)
{
    polyhedron(
    points=[ [hs,hs,0],[hs,-hs,0],[-hs,-hs,0],[-hs,hs,0], // the four points at base
           [0,0,hs]  ],                                 // the apex point 
    faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
              [1,0,3],[2,1,3] ]                         // two triangles for square base
 );
}

module block () {
    difference () {
        cube ([size, size, height], center = true);
        translate ([0, 0, -height/2]) pyramid (size/2);
        cube ([inner_size, inner_size, height], center = true);
        cube ([hole_size, hole_size, 2*height], center = true);
    }
    translate ([0, 0, height / 2])
    difference () {
        intersection () {
            cube ([size, size, bevel_height], center = true);
            translate ([0, 0, 0]) pyramid (size/2);
        }
        translate ([0, 0, -thickness]) 
            fustrum(size/2, bevel_height - thickness);
    }
}

module cap_old () {
    intersection () {
        difference () {
            cube ([size, size, cap_height], center=true);
            translate ([0, 0, -cap_height/2]) pyramid (size/2);
            cylinder (d=size-thickness*2, h=height, center=true);
        }
    }
    translate ([0, 0, cap_height/2])
        difference () {
            sphere(d=size, center=true, $fn=75);
            sphere(d=size-thickness*2, center=true);
            translate ([0, 0, -size/2])
                cube([size, size, size], center=true);
        }
}

module fustrum (fs, fh) {
    difference () {
        pyramid (fs);
        translate ([0, 0, fh]) pyramid (fs);
    }
}

module hollow_fustrum (fs, fh) {
    difference () {
        fustrum (fs, fh);
        translate ([0, 0, -thickness]) fustrum (fs, fh);
    }
}

module cap () {
    difference () {
        cube ([size, size, thickness], center=true);
        translate ([0, 0, -thickness/2]) pyramid (size/2);
        cube ([size-2*thickness, size-2*thickness, thickness*2], center=true);
    }
    translate ([0, 0, thickness/2])
        hollow_fustrum (size/2, cap_height);
}

module matrix (x, y) {
    for (i = [0:x-1]) {
        for (j = [0:y-1]) {
            translate ([i*(size+2), j*(size+2), 0]) children ();
        }
    }
}

module diamond (radius) {
    cylinder (r1=radius, r2=0, h=radius, $fn=facets, center=true);
}

module bead (s) {
    translate ([0, 0, s/4]) diamond(s/2);
    translate ([0, 0, -s/4]) rotate ([180, 0, 0]) diamond(s/2);
}

module piece (offset, flatten)
{
    bead_size = size * 3 / 4;
    difference () {
        union () {
            translate ([0, 0, thickness/2]) cylinder (d=size*3/4, h=thickness, $fn=facets, center=true);
            translate ([0, 0, thickness+offset*bead_size]) bead (bead_size);
            translate ([0, 0, thickness+(offset+0.5)*bead_size]) difference () {
                bead (bead_size);
                if (flatten) {
                    translate ([0, 0, (3/8)*bead_size+size/2]) cube (size, center=true);
                }
            }
            translate ([0, 0, thickness+(offset+1)*bead_size]) children ();
        }
        translate ([0, 0, -size/2]) cube (size, center=true);
    }
}

module rescuer () {
  piece (0, false);
}

module prize () {
    piece (0.3, true)
    translate ([0, 0, -size/8]) rotate ([180, 0, 0]) difference () {
        diamond (size/4);
        translate ([0, 0, -thickness/2]) diamond (size/4-thickness);
    }
}

module make4(radius)
{
    for (a = [0 : 3]) {
        angle = a * 90;
        translate(radius * [sin(angle), -cos(angle), 0])
            rotate([0, 0, angle])
                children();
    }
}

module bar(delta)
{
    height_change = (wall_height-floor_thickness-frame_height)/2;
    translate([delta,0,height_change]) cube([bar_length, wall_width, wall_height+floor_thickness], center=true);
}

module barPair(offset)
{
    delta = bar_length/2 + skip * offset + frame_width/2;
    bar(delta);
    bar(-delta);
}

module frame(pattern)
{
    for (i = [0:len(pattern)-1]) {
        make4(i * skip) cube([frame_width+pattern[i]*skip, frame_width, frame_height], center=true);
    }
}

module floor(pattern, thickness, tweak)
{
    for (i = [0:len(pattern)-1]) {
        make4(i * skip)
        translate ([0, 0.5*skip, 0]) cube([frame_width+pattern[i]*skip+tweak, frame_width+skip, thickness], center=true);
    }
}

module stand()
{
    difference () {
        union () {
            difference () {
                union() {
                    translate ([stand_card_width/2-stand_grip, 0, 0]) prize();
                    translate ([-stand_card_width/2+stand_grip, 0, 0]) prize();
                }
                cube ([stand_card_width-stand_grip*2-eps, big, big], center=true);
                translate ([0, 0, big/2+thickness])
                    cube ([stand_card_width, stand_card_thickness, big], center=true);
            }
            translate ([0, 0, thickness/2])
                cube ([stand_card_width-stand_grip*2, size*3/4, thickness], center=true);
        }
        if (stand_slot) cube ([stand_card_width, stand_card_thickness, thickness*2], center = true);
    }
}

if (part == "block_test") {
    translate ([size+2, 0, (height+thickness)/2])
        rotate ([180, 0, 0]) block ();
    translate ([0, 0, (height+thickness)/2])
        rotate ([180, 0, 0]) block ();
} else if (part == "cap_test") {
    translate ([0, 0, cap_height+thickness/2]) rotate ([180, 0, 0]) cap ();
} else if (part == "block_section") {
    intersection () {
       block ();
       translate ([size/2, 0, 0]) cube (size, center=true);
    }
} else if (part == "caps16") {
    matrix (4, 4) translate ([0, 0, cap_height+thickness/2]) rotate ([180, 0, 0]) cap ();
} else if (part == "blocks12" || part == "blocks24") {
    matrix (4, part == "blocks12" ? 3 : 6) translate ([0, 0, (height+thickness)/2]) rotate ([180, 0, 0]) block ();
} else if (part == "rescuer") {
    rescuer ();
} else if (part == "pawns") {
    matrix (1, 3) rescuer ();
    translate ([0, -size, 0]) prize();
} else if (part == "pawns_and_stand") {
    matrix (1, 3) rescuer ();
    translate ([0, -size, 0]) prize();
    translate ([size, 0, 0]) rotate ([0, 0, 90]) stand();
} else if (part == "frame") {
    frame(board_cells);
    if (floor_thickness > 0) translate ([0, 0, eps-(floor_thickness+frame_height)/2]) floor(board_cells, floor_thickness, 0);
    if (wall_height > 0) {
        make4(skip*3+(wall_width+frame_width)/2)  bar(0);
        for (i = [1:3]) {
            make4(skip*i+(wall_width+frame_width)/2)  barPair(3-i);
        }
    }
} else if (part == "frame_test") {
    frame([2, 2]);
} else if (part == "stand") {
    stand();
}
