// preview[view:south west tilt:top diagonal]

// Length of shed (exteral body) in mm
LEN = 2200; // [1000:10000]
// Width of shed (external body) in mm
WID = 1800; // [1000:10000]
// Height of shed (inside at lowest point) in mm
HEIGHT = 1800;  // [1000:10000]
// Roof pitch in degrees
ROOF_PITCH = 30; // [0:89]
// Roof overhang in mm
ROOF_OVERHANG = 100; // [0:1000]
// Show the inside walls
interior_walls = 1; // [0,1]
// Show the eaves boards
eaves_boarding = 1; // [0,1]
// Show the roof panels
roof_panels = 1; // [0,1]
// Show the outside walls
cladding = 1; // [0,1]
// Max height of the door
DOOR_H = 2032; // [100:10000]
// Width of door
DOOR_W = 914; // [100:10000]
// Smaller stud cross-section in mm
STUD_S = 38; // [1:1000]
// Stud spacing in mm
STUD_SPACE = 600; // [10:10000]
// Target skid spacing in mm
SKID_SPACE = 800; // [10:10000]
// Target noggin spacing in mm
NOGGIN_SPACE = 800; // [10:10000]
// Larget stud cross-section in mm
STUD_L = 89; // [1:1000]
// Smaller roof-beam cross section in mm
BEAM_S = 38; // [1:1000]
// Larget roof-beam cross section in mm
BEAM_L = 144; // [1:1000]
// OSB/Ply thickness in mm
OSB_T = 11; // [1:100]
// OSB/Ply length available
OSB_L = 2440; // [100:10000]
// OSN/Ply width available
OSB_W = 1220; // [100:10000]
// Cladding board thickness in mm
FB_T = 11; // [1:100]
// Cladding board height in mm
FB_H = 100; // [1:1000]
// Cladding overlap in mm
FB_O = 10; // [1:100]

// frame & floorboards
base();
translate([0,STUD_L,STUD_L + OSB_T]) rotate([90,0,0]) side();
translate([0,WID,0]) mirror([0,1,0])
    translate([0,STUD_L,STUD_L + OSB_T]) rotate([90,0,0]) side();
translate([0,STUD_L,STUD_L + OSB_T]) rotate([90,0,90]) end(door=true);
translate([LEN,0,0]) mirror([1,0,0])
    translate([0,STUD_L,STUD_L + OSB_T]) rotate([90,0,90]) end();
translate([0,0,STUD_L + OSB_T + HEIGHT]) roof();

module roof() {
    // beam
    translate([
            -ROOF_OVERHANG,
            (WID - BEAM_S) / 2,
            (tan(ROOF_PITCH) * WID / 2) - BEAM_L + STUD_L / cos(ROOF_PITCH) - tan(ROOF_PITCH) * BEAM_S / 2 - STUD_L / 3
        ]) beam(LEN + 2 * ROOF_OVERHANG);
    
    // trusses
    for (i = [0:STUD_SPACE:LEN-STUD_S]) {
        translate([i,0,0]) truss();
    }
    translate([LEN - STUD_S,0,0]) truss();
    translate([0,WID,0]) mirror([0,1,0])
        for (i = [0:STUD_SPACE:LEN-STUD_S]) {
            translate([i,0,0]) truss();
    }
    translate([0,WID,0]) mirror([0,1,0])
        translate([LEN - STUD_S,0,0]) truss();
    
    // truss eaves
    translate([-ROOF_OVERHANG,0,0]) truss(notch=false);
    translate([0,WID,0]) mirror([0,1,0])
        translate([-ROOF_OVERHANG,0,0]) truss(notch=false);
    translate([LEN + ROOF_OVERHANG - STUD_S,0,0]) truss(notch=false);
    translate([0,WID,0]) mirror([0,1,0])
        translate([LEN + ROOF_OVERHANG - STUD_S,0,0]) truss(notch=false);
    
    // flat eaves
    translate([
            -ROOF_OVERHANG,
            -cos(ROOF_PITCH) * ROOF_OVERHANG,
            -sin(ROOF_PITCH) * ROOF_OVERHANG - STUD_L / 3
        ]) rotate([ROOF_PITCH,0,0])
            stud(LEN + 2 * ROOF_OVERHANG);
    translate([0,WID,0]) mirror([0,1,0]) translate([
            -ROOF_OVERHANG,
            -cos(ROOF_PITCH) * ROOF_OVERHANG,
            -sin(ROOF_PITCH) * ROOF_OVERHANG - STUD_L / 3
        ]) rotate([ROOF_PITCH,0,0])
            stud(LEN + 2 * ROOF_OVERHANG);
    
    // vertical supports
    translate([STUD_L,(WID - STUD_S) / 2,0]) rotate([0,-90,0])
        stud((tan(ROOF_PITCH) * WID / 2) - BEAM_L + STUD_L / cos(ROOF_PITCH) - tan(ROOF_PITCH) * BEAM_S / 2 - STUD_L / 3);
    translate([LEN,(WID - STUD_S) / 2,0]) rotate([0,-90,0])
        stud((tan(ROOF_PITCH) * WID / 2) - BEAM_L + STUD_L / cos(ROOF_PITCH) - tan(ROOF_PITCH) * BEAM_S / 2 - STUD_L / 3);
    
    // eaves boarding
    if (eaves_boarding) {
        for (i = [0:STUD_SPACE:LEN-STUD_SPACE-STUD_S]) {
            translate([i,0,0]) eaves_board(STUD_SPACE - STUD_S);
        }
        translate([0,WID,0]) mirror([0,1,0])
            for (i = [0:STUD_SPACE:LEN-STUD_SPACE-STUD_S]) {
            translate([i,0,0]) eaves_board(STUD_SPACE - STUD_S);
        }
        translate([LEN - (LEN - STUD_S) % (STUD_SPACE) - STUD_S,0,0]) eaves_board((LEN - STUD_S) % (STUD_SPACE) - STUD_S);
        translate([0,WID,0]) mirror([0,1,0])
            translate([LEN - (LEN - STUD_S) % (STUD_SPACE) - STUD_S,0,0]) eaves_board((LEN - STUD_S) % (STUD_SPACE) - STUD_S);
    }
    
    if (roof_panels) {
        roof_panel();
        translate([0,WID,0]) mirror([0,1,0])
            roof_panel();
    }
}

module roof_panel() {
    translate([
            -ROOF_OVERHANG,
            0,
            STUD_L / cos(ROOF_PITCH) - STUD_L / 3
        ])
        rotate([ROOF_PITCH,0,0]) translate([
                0,
                -ROOF_OVERHANG - tan(ROOF_PITCH) * STUD_L,
                0
            ]) osb(
                LEN + 2 * ROOF_OVERHANG,
                WID / 2 / cos(ROOF_PITCH) + ROOF_OVERHANG + tan(ROOF_PITCH) * STUD_L
            );
}

module eaves_board(l) {
    if (ROOF_OVERHANG < (STUD_L/cos(ROOF_PITCH) - STUD_L/3) / tan(ROOF_PITCH) - OSB_T / tan(ROOF_PITCH)) {
        translate([
                    STUD_S,
                    -(tan(ROOF_PITCH) * STUD_L / 3) - ((ROOF_OVERHANG -STUD_S) / sin(90 - ROOF_PITCH)),
                    0
                ]) osb(
                    l,
                    (tan(ROOF_PITCH) * STUD_L / 3) + ((ROOF_OVERHANG -STUD_S) / sin(90 - ROOF_PITCH) + STUD_L
                ));
    } else {
        translate([
                    STUD_S,
                    -(STUD_L/cos(ROOF_PITCH)-STUD_L/3)/tan(ROOF_PITCH)+OSB_T/tan(ROOF_PITCH),
                    0
                ]) osb(l, (STUD_L/cos(ROOF_PITCH)-STUD_L/3)/tan(ROOF_PITCH)-OSB_T/tan(ROOF_PITCH)+STUD_L);
    }
}

module truss(notch=true) {
    translate([STUD_S,0, -STUD_L / 3]) rotate([0,-ROOF_PITCH,90])
        translate([-ROOF_OVERHANG+STUD_S,0,0]) difference() {
            stud((WID - BEAM_S) / 2 / cos(ROOF_PITCH) + tan(ROOF_PITCH) * STUD_L + ROOF_OVERHANG - STUD_S);
            if (notch) {
                translate([ROOF_OVERHANG-STUD_S,0,0]) rotate([0,ROOF_PITCH,0]) cube([STUD_L / 3 / tan(ROOF_PITCH),STUD_S,STUD_L / 3]);
            }
            translate([
                    (WID - BEAM_S) / 2 / cos(ROOF_PITCH)  + ROOF_OVERHANG - STUD_S,
                    0,
                    0
                ]) rotate([0,ROOF_PITCH,0]) cube([sin(ROOF_PITCH) * STUD_L,STUD_S,STUD_L / cos(ROOF_PITCH)]);
        }
}

module end(door=false) {
    // top
    translate([0,HEIGHT - STUD_S,0]) stud(WID - STUD_L * 2);
    
    if (door) {
        // bottom
        stud((WID - STUD_L * 2) / 2 - DOOR_W / 2);
        translate([WID - STUD_L * 2,0,0]) mirror([1,0,0]) 
            stud((WID - STUD_L * 2) / 2 - DOOR_W / 2);
               
        if (HEIGHT > DOOR_H + STUD_S) {
            // studding
            studs(WID / 2 - STUD_L - DOOR_W / 2 - STUD_S, HEIGHT);
            translate([WID - STUD_L * 2,0,0]) mirror([1,0,0])
                studs(WID / 2 - STUD_L - DOOR_W / 2 - STUD_S, HEIGHT);
            
            // lintel
            translate([WID / 2 - STUD_L - DOOR_W / 2 - STUD_S,DOOR_H,STUD_L]) rotate([-90,0,0])
                stud(DOOR_W + STUD_S * 2);
            translate([WID / 2 - STUD_L - DOOR_W / 2 - STUD_S,DOOR_H,STUD_L/2]) rotate([-90,0,0])
                stud(DOOR_W + STUD_S * 2);
            
            // vertical support in door
            translate([(WID - STUD_L * 2) / 2 - DOOR_W / 2,STUD_S,0]) rotate([0,0,90]) stud(DOOR_H - STUD_S);
            translate([WID - STUD_L * 2,0,0]) mirror([1,0,0])
                translate([(WID - STUD_L * 2) / 2 - DOOR_W / 2,STUD_S,0]) rotate([0,0,90]) stud(DOOR_H - STUD_S);
            
            // vertical support over door
            translate([WID / 2 - STUD_S * 1.5,DOOR_H + STUD_L,0]) rotate([0,0,90]) stud(HEIGHT - DOOR_H - STUD_S - STUD_L);
            
            // cladding
            if (cladding) {
                rotate([0,180,0]) translate([STUD_L-WID,0,0]) difference() {
                    clad(WID, HEIGHT + tan(ROOF_PITCH) * WID / 2);
                    translate([0,HEIGHT,- 10]) rotate([0,0,ROOF_PITCH]) cube([WID/2/cos(ROOF_PITCH),WID/2/cos(ROOF_PITCH),FB_T * 2 + 20]);
                translate([WID,0,0]) mirror([1,0,0])
                    translate([0,HEIGHT,- 10]) rotate([0,0,ROOF_PITCH]) cube([WID/2/cos(ROOF_PITCH),WID/2/cos(ROOF_PITCH),FB_T * 2 + 20]);
                    translate([(WID - DOOR_W) / 2,0,-10]) cube([DOOR_W,DOOR_H,FB_T * 2 + 20]);
                }
            }
        } else {
            // studding
            studs(WID / 2 - STUD_L - DOOR_W / 2, HEIGHT);
            translate([WID - STUD_L * 2,0,0]) mirror([1,0,0])
            studs(WID / 2 - STUD_L - DOOR_W / 2, HEIGHT);
            
            // cladding
            if (cladding) {
                rotate([0,180,0]) translate([STUD_L-WID,0,0]) difference() {
                    clad(WID, HEIGHT + tan(ROOF_PITCH) * WID / 2);
                    translate([0,HEIGHT,- 10]) rotate([0,0,ROOF_PITCH]) cube([WID/2/cos(ROOF_PITCH),WID/2/cos(ROOF_PITCH),FB_T * 2 + 20]);
                translate([WID,0,0]) mirror([1,0,0])
                    translate([0,HEIGHT,- 10]) rotate([0,0,ROOF_PITCH]) cube([WID/2/cos(ROOF_PITCH),WID/2/cos(ROOF_PITCH),FB_T * 2 + 20]);
                    translate([(WID - DOOR_W) / 2,0,-10]) cube([DOOR_W,HEIGHT - STUD_S,FB_T * 2 + 20]);
                }
            }
        }
    } else {
        // bottom
        stud((WID - STUD_L * 2));
        
        // studs
        studs(WID - STUD_L * 2, HEIGHT);
        
        // cladding
        if (cladding) {
            rotate([0,180,0]) translate([STUD_L-WID,0,0]) difference() {
                clad(WID, HEIGHT + tan(ROOF_PITCH) * WID / 2);
                translate([0,HEIGHT,- 10]) rotate([0,0,ROOF_PITCH]) cube([WID/2/cos(ROOF_PITCH),WID/2/cos(ROOF_PITCH),FB_T * 2 + 20]);
            translate([WID,0,0]) mirror([1,0,0])
                translate([0,HEIGHT,- 10]) rotate([0,0,ROOF_PITCH]) cube([WID/2/cos(ROOF_PITCH),WID/2/cos(ROOF_PITCH),FB_T * 2 + 20]);
            }
        }
    }
    
    // interior walls
    if (interior_walls) {
        if (door) {
            if (HEIGHT > DOOR_H + STUD_S) {
                translate([OSB_T,0,STUD_L]) osb((WID - DOOR_W) / 2 - STUD_L - OSB_T, DOOR_H);
                translate([WID - (WID - DOOR_W) / 2 - STUD_L,0,STUD_L]) osb((WID - DOOR_W) / 2 - STUD_L - OSB_T, DOOR_H);
                translate([OSB_T,DOOR_H,STUD_L]) osb(WID - 2 * (STUD_L + OSB_T), HEIGHT - DOOR_H);
            } else {
                translate([OSB_T,0,STUD_L]) osb((WID - DOOR_W) / 2 - STUD_L - OSB_T, HEIGHT);
                translate([WID - (WID - DOOR_W) / 2 - STUD_L,0,STUD_L]) osb((WID - DOOR_W) / 2 - STUD_L - OSB_T, HEIGHT);
            }
        } else {
            translate([OSB_T,0,STUD_L]) osb(WID - 2 * (STUD_L + OSB_T), HEIGHT);
        }
    }
}

module side() {
    // frame
    stud(LEN);
    translate([0,HEIGHT - STUD_S,0]) stud(LEN);
    studs(LEN, HEIGHT);
    
    // interior walls
    if (interior_walls) {
        translate([STUD_L,0,-OSB_T]) rotate([0,0,0]) osb(LEN - 2 * STUD_L, HEIGHT);
    }
    
    // cladding
    if (cladding) {
        translate([0,0,STUD_L]) clad(LEN, HEIGHT);
    }
}

module base() {
    // sides
    stud(LEN);
    translate([0,WID - STUD_S,0]) stud(LEN);
    
    studs(LEN, WID, noggins=false);
    
    // skids
    translate([0,100,-STUD_L]) for (i = [0:skid_spacing(num_skids()):WID - 200]) {
        translate([0,i,0]) stud(LEN);
    }
    
    // floor
    translate([0,0,STUD_L]) osb(LEN, WID);
}

function num_skids() = round((WID - 200) / SKID_SPACE);
echo("skids: ", num_skids() + 1);
function skid_spacing(skids) = (WID - 200 - STUD_S) / num_skids();
echo("skid spacing: ", skid_spacing());

module studs(l, h, noggins=true) {
    for (i = [0:STUD_SPACE:l-STUD_S]) {
        translate([STUD_S + i,STUD_S,0]) rotate([0,0,90]) stud(h - 2 * STUD_S);
        if (i > 0 && noggins) {
            for (j = [noggin_spacing(h):noggin_spacing(h):h - STUD_S * 2]) {
                if ((i / STUD_SPACE) % 2 == 0) { 
                    translate([i - STUD_SPACE + STUD_S,j + STUD_S / 2,0]) stud(STUD_SPACE - STUD_S);
                } else {
                    translate([i - STUD_SPACE + STUD_S,j - STUD_S / 2,0]) stud(STUD_SPACE - STUD_S);
                }
            }
        }
     }
    translate([l,STUD_S,0]) rotate([0,0,90]) stud(h - 2 * STUD_S);
    if (noggins) {
        for (i = [noggin_spacing(h):noggin_spacing(h):h - STUD_S * 2]) {
            if (ceil((l - STUD_S) / STUD_SPACE) % 2 == 0) { 
                translate([l - last_noggin(l) - STUD_S,i + STUD_S / 2,0]) stud(last_noggin(l));
            } else {
                translate([l - last_noggin(l) - STUD_S,i - STUD_S / 2,0]) stud(last_noggin(l));
            }
        }
    }
}

function num_noggins(h) = round(h / NOGGIN_SPACE);
function noggin_spacing(h) = (h - STUD_S) / num_noggins(h);
function last_noggin(l) = (l - STUD_S) % (STUD_SPACE) - STUD_S;

module stud(length) {
    echo("BOM: Stud: ", length);
    cube([length, STUD_S, STUD_L]);
}

module beam(length) {
    echo("BOM: Beam: ", length);
    cube([length, BEAM_S, BEAM_L]);
}

module osb(l, w) {
    for (i = [0:OSB_L:l]) {
        for (j = [0:OSB_W:w]) {
            if (i + OSB_L <= l) {
                if ( j + OSB_W <= w) {
                    translate([i,j,0]) _osb(OSB_L, OSB_W);
                } else {
                    translate([i,j,0]) _osb(OSB_L, w - j);
                }
            } else {
                if ( j + OSB_W <= w) {
                    translate([i,j,0]) _osb(l - i, OSB_W);
                } else {
                    translate([i,j,0]) _osb(l - i, w - j);
                }
            }
        }
    }
}

module _osb(l, w) {
    echo("BOM: OSB: ", l, w);
    cube([l, w, OSB_T]);
}

module clad(l, h) {
    for (i = [0:FB_H - FB_O:h - FB_H]) {
        translate([0,i,0]) feather_board(l);
    }
}

module feather_board(l) {
    echo("BOM: FB: ", l);
    translate([0,0,FB_T]) rotate([-asin(FB_T/(FB_H-FB_O)),0,0]) cube([l,FB_H,FB_T]);
}