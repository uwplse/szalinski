// OpenSCAD file to create custom sized plugs/caps or couplers for square and rectangular tubes.
// Setup for use with Thingiverse.com Customizer.
//
// preview[view:south west, tilt:bottom diagonal]
//
// Original code created Aug 14, 2016 by Allan M. Estes
// Rewritten to clean up, add options, and to allow production of joiners
// Rewrite "completed" Sep 6, 2016, other changes:
//      revised tab grooves and implemented bottom groove/relief differently
//      thicker and wider tabs 
//      tab angle varies with tab length,
//      optional vertical/horizontal build positions
//      option to put "ribs" on tabs (& combine with grooves)
//      revision on recess calculation
//      clean up typos and small error where tubeX was used instead of tubeY
//      some differences tweaked to reduce false surfaces in preview
//      more meaningful message for bad_ratio error: interior dimensions too small
//          (generated because desired tab size is too large for opening)
//
// to do:
//   [x]keep constant angle on cap taper
//   (allow control of taper angle?)
//   [x]display on build surface w/on-off option
//   [x]control view
//   [x]more sanity checks?
//   [x]possibly angle retaining tabs out a degree or two
//   [x]adjust tilt on long tabs
//   (allow control of tab angle?)
//   [x]base tab size on tube size (like 2/3*sqrt((x+y)/2) )
//
//   [x]adapt to optionally create couplers:
//      taper does not apply
//      hollow(recess) goes through (hpctz = 1.01 or so)
//      (future: hollow could always be rounded - possibly in both cap and coupler)
//      tabs are effectively generated on both sides of cap
//      reinforcement/base for tabs (future: optional/adjustable?)
//
//   future: may want option to enter tube inside dimension and "add" wall thickness
//
// Note: the +0 added to some assignments is to keep item from showing up in Thingiverse 
// Customizer.

$fn=36+0;

// Following are parameter which are configurable through the customizer

// input_units exists to allow mm or inch values to be entered through customizer
// it is currently disabled and set to mm input;
// Units for customizer input (output is always mm)
input_units = 1+0; // [1:mm, 25.4:inch]  

// What to produce?
build_item = 0; // [1:cap/plug, 0:coupler]

// Outside measurement of tube end (X direction)
tube_x = 25.54;
// Outside measurement of tube end (Y direction) 0 = same as X (square tube)
tube_y = 0;
// How thick is tube wall
tube_wall = 1.67;
// Amount of rounding to apply to corners (0=no rounding, 50=default rounding, 100=maximum rounding)
corner_rounding = 50; // [0:100]

// Length of external portion of cap/coupler 
cap_length = 3;
// Portion of plug with straight sides (percentage), does not affect coupler 
straight_pct = 50; // [0:100]
// Add cross grooves to retaining tabs?
groove_tabs = 1; // [0:no, 1:yes]
// Add length-wise ribs to retaining tabs?
ribs = 0; // [0:no, 1:yes]
// Percent cap will be recessed underneath (none to maximum), size of through hole in coupler
recess_pct = 100; // [0:100]
// Build orientation, vertical cap won't need supports, horizontal might make stronger piece
orientation = 1; // [0:vertical, 1:horizontal]

// user control of viewable build plate in Customizer:
// Turn on viewable build plate?
display_build_plate = 0; // [0:no, 1:yes]
use <utils/build_plate.scad>
// For display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
// When Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
// When Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]


// sanitize/convert parameters:
cap = build_item;
horz = orientation;

tubeY = abs((tube_y==0) ? tube_x : tube_y) * input_units;
tubeX = abs(tube_x) * input_units;
tubeWall = abs(tube_wall) * input_units;
capLen = abs(cap_length) * input_units;

fillet = tubeWall * (corner_rounding/25); // 0:4, default=2 
taperpct = cap ? 1 - (straight_pct/100) : 0 ;

shorter = min(tubeX,tubeY);
tabThck = .7*sqrt((tubeX+tubeY)/2);
tabLen = (tubeX+tubeY)/2/3;

// flag problems for bad data, used later to generate error "messages"
bad_cap = capLen<2 || capLen>shorter;	// too short or long (long is a bit arbitrary)
bad_wall = tubeWall<1;				// too thin
bad_ratio = shorter<2*tubeWall+3*tabThck;	// internal dimensions too small
bad_over = tubeX>800 || tubeY>800;	// really determined by build plate
									// it won't break the program but why bother 
bad_input = tubeX==undef || tubeY==undef || tubeWall==undef || capLen==undef;

// Module definitions start here

// generic modules to copy and move (translate) an object or to copy and rotate 
module duplicate_t(v) {
    children();
    translate(v) children();
}
module duplicate_r(v1,v2) {
    children();
    rotate(v1,v2) children();
}
// prism routine straight out of OpenSCAD online manual
module prism(l, w, h) {
   polyhedron(
           points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
           faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
           );
}

// Modules to deal with exposed/visible portion of the cap/plug -
// Cap is generated from a flat square/rectangle with optionally rounded corners which is
// extruded into the final shape. A portion (from none to all) of the cap can be tapered
// by extruding with scaling (the angle is currently fixed at 45 degrees). By default
// the underside is recessed, but the amount is controllable and can be reduced down to
// zero.

// generate 2d outline used to build cap
module cap_outline() {
    if (2*fillet>shorter) {
        circle(fillet);
    } else if (fillet>0) {
        minkowski() {
            square([tubeX-(2*fillet),tubeY-(2*fillet)], true);
            circle(fillet);
        }
    } else
        square([tubeX,tubeY], true);
}

// hollow/recess cap by difference with a scaled down clone - hollow should fit within
// tabs and not make the cap too thin to support itself (though if doing a coupler the 
// hollow goes all the way through and percentage controls size of opening). 
module hollow() {
    // keep recess within tabs (2.0* would be flush with tabs, 2.1* adds a tiny edge) 
    hpctx = (tubeX-2.1*(tubeWall+tabThck))/tubeX;
    hpcty = (tubeY-2.1*(tubeWall+tabThck))/tubeY;
    // recess along Z axis - maximum should be 85% or whatever percent keeps the thickness 
    // greater than or equal to 1.25 mm 
    hpct = (capLen-max(.15*capLen,1.25))/capLen*(recess_pct/100);
    hpctz = cap ? hpct : 1.01;    
    xyreduce =  cap ? .75 + .25*recess_pct/100 : recess_pct/100;
    difference() {
        children();
        translate([0,0,-.001]) scale(v=[hpctx*xyreduce,hpcty*xyreduce,hpctz]) children();
    }
}

// create cap
module build_cap() {
    hollow()
    union() {
        if (taperpct>0) {
            translate([0,0,capLen*(1-taperpct)-.001])
            // scale is based on length to maintain a 45 deg angle - could be adjustable 
            linear_extrude(height=capLen*taperpct, center=false,
                           convexity=10, scale=1-(capLen*taperpct/(shorter/2)))
            children();
        }
        if (taperpct!=1) { 
            linear_extrude(height=capLen*(1-taperpct), center=false, convexity=10)
            children();
        }
    }
}

// Modules to deal with retaining tabs - 
// Grooved tabs are created by building a 2D profile and extruding to "width". Ribbed tabs
// are created from a cube + cylinders. Ribs and grooves are optional. The tab tip is
// beveled to ease insertion into the tube. The tip bevel is only generated in the tab_grooves
// module, but an intersection of the two tab design preserves the tip bevel while allowing
// the groove and rib options to be combined. The resulting combined tab has the ends beveled
// for clearance. Tabs for X and Y directions are created, duplicated and moved into position

// tab w/tip bevel and (optional) cross grooves
module tab_grooves(size) {
//    sp = (tabLen-.75*tabThck-tabThck/2.5 )/3; // spacing for grooves
    sp = (tabLen-.75*tabThck-tabThck/5 )/3; // spacing for grooves

    linear_extrude(height=size,center=false) 
    difference() {
        polygon([ [0,0], [tabLen-.75*tabThck,0], [tabLen,.6*tabThck],
                  [tabLen,tabThck], [0,tabThck] ]);
        if (groove_tabs) {
            for (i=[0:2]) {
                translate([tabLen-.75*tabThck-sp/2-i*sp,-sp/3.0])
                circle(sp*.6);
            }
        }
    }
}

// tab w/(optional) vertical ribs
module tab_ribs(size) {
    cnt=floor(size/tabThck/2) + 1;  // how many ribs to produce
    sp = (size-tabThck*2/3)/cnt; // spacing for ribs
    
    translate([tabLen,tabThck/3,0])
    rotate([0,-90,0]) {
        cube([size,tabThck*2/3,tabLen]);
        if (ribs) {
            for (i=[0:cnt]) {
                translate([tabThck/3+i*sp,0,0])
                cylinder(h=tabLen,r=tabThck/3);
            }
        } else {
            translate([0,-tabThck*2/3,0]) 
            cube([size,tabThck*2/3,tabLen], center=false);
        }
    }
}

// Module to produce base/reinforcement for tabs (currently only used for couplers).
// Base is simplification of a ribbed tab which is not beveled at ends/edges allowing the
// bases to join in the corners for extra strength
module tab_base(baseLen,size) {
    cnt=floor(size/tabThck/2) + 1;  // how many ribs to produce
    sp = (size-tabThck*2/3)/cnt; // spacing for ribs
    
    translate([baseLen,tabThck/3+.01,0]) // .01 offset for looser fit
    rotate([0,-90,0]) {
        cube([size,tabThck*2/3,baseLen]);
        for (i=[0:cnt]) { // columns/ribs
            translate([tabThck/3+i*sp,0,0])
            cylinder(h=baseLen,r=tabThck/3);
        }
        translate([0,-tabThck/3,0])
        prism(size, tabThck/3, tabThck/3);
    }
}

// create tab by combining optional styles, beveling ends, and tilting outward a little
module build_tab(size) {
    tabTilt  = min(tubeWall/tabLen/3, .04); // used to be sin(1.5)
    multmatrix([ [1,0,0,0], [-tabTilt,1,0,0], [0,0,1,0], [0,0,0,1] ]) // tilt
    // bevel ends by difference with rotated cubes
    difference() {
        intersection() { // combine the optional tab styles 
            tab_grooves(size);
            tab_ribs(size);
        }
        duplicate_t([0,0,size])
        translate([tabLen/2,tabThck,0])
        rotate([45,0,0])
        cube([tabLen*1.1,tabThck,tabThck], true);
    }
}

// generates and places the four retaining tabs
module place_tabs(base) {
    tabWidX = tubeX-2*tubeWall-(tabThck*1.25);
    duplicate_r(180)  
    translate([tabWidX/-2,tubeY/-2+tubeWall,-base])
    rotate([0,90,0]) {
        if (base) {
            translate([-base,0,0])
            tab_base(base,tabWidX);
        }
        build_tab(tabWidX);
    }
    
    tabWidY = tubeY-2*tubeWall-(tabThck*1.25);
    duplicate_r(180)  
    translate([tubeX/-2+tubeWall,tabWidY/2,-base])
    rotate([90,90,0]) {
        if (base) {
            translate([-base,0,0])
            tab_base(base,tabWidY);
        }
        build_tab(tabWidY);
    }
}

// Create cylinders to "subtract" from corner formed by cap and base/tab. The intent here
// is to allow the cap/coupler to sit better against tube even if there is some irregularity
// in the cap printing and/or tube end. More relief should probably be done in the corners, 
// but this is a start.
module corner_relief(zOffset) {
    sideAdj = sign(-zOffset); // if positive offset adjust for top of cap
    reliefX = tubeX-2*tubeWall-(tabThck*1.25)+.01;
    duplicate_r(180)  
    translate([reliefX/-2-tabThck/16,tubeY/-2+tubeWall,sideAdj*-tabThck/16+zOffset])
    rotate([0,90,0])
        cylinder(h=reliefX,d=tabThck/4);
    
    reliefY = tubeY-2*tubeWall-(tabThck*1.25)+.01;
    duplicate_r(180)  
    translate([tubeX/-2+tubeWall-tabThck/16,reliefY/2,sideAdj*-tabThck/16+zOffset])
    rotate([90,90,0])
        cylinder(h=reliefY,d=tabThck/4);
}

// Position object for build plate - vertical vs horizontal
// horizontal orientation has piece rotated to be on "corner" to minimize support needs.
module build_position(zShift) {
    if (horz) {
        translate([0,0,sin(45)*(tubeX+tubeY-4*fillet)/2+fillet]) rotate([90,45,0])
        children();
    } else { 
        translate([0,0,zShift])
        children();
    }
}

// End of Modules

// Main "code" starts here, first portion deals with customizer errors. To be a little
// more user friendly, generate a "stop sign" with text describing error. In the event
// of multiple errors, just give a single most significant error. 

s = 10 + 0; r=s*1.414+s; // points to create octagon
if (bad_input || bad_cap || bad_wall || bad_ratio || bad_over) {
    rotate([90,0,0]) {
        color("red")
        translate([0,0,-.01])
        polygon([[r,s],[s,r],[-s,r],[-r,s],[-r,-s],[-s,-r],[s,-r],[r,-s]]);
        text("Bad Parameters",halign="center",valign="bottom");
        if (bad_input) {
            text("Missing or non-numeric data",halign="center",valign="top");
            //echo("Missing or non-numeric data");
        } else if (bad_ratio) {
            text("Internal dimensions too small",halign="center",valign="top");
            //echo("Internal dimensions too small");
        } else if (bad_wall) {
            text("Wall too thin",halign="center",valign="top");
            //echo("Wall too thin");
        } else if (bad_cap) {
            text("Bad Cap Length",halign="center",valign="top");
            //echo("Bad Cap Length");
        } else if (bad_over) {
            text("Overly large Tube dimensions",halign="center",valign="top");
            //echo("Overly large Tube dimensions");
        }
    }
} else { 

    // If all is well, build the cap/plug or joiner ... 
    
    if (display_build_plate) 
        build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
    
    if (cap) { // building a cap/plug
        build_position(capLen) // position object for build plate
        rotate([0,180,0]) // flip over so item will be oriented cap down in vertical orientation
        difference() {
            union() {
                build_cap() cap_outline();
                place_tabs(0);
            }
           corner_relief(0); 
        }
        
    } else { // building a joiner
        // joiner is effectively cap with retaining tabs on both sides - taper does not apply,
        // "hollow" goes all the through "cap" portion, and tabs will have a "base" adding
        // length and strength.
        build_position(capLen/2+tabLen*2) // position object for build plate
        difference() {
            union() {
                translate([0,0,-capLen/2])
                build_cap() cap_outline();
                duplicate_r([0,180,0])
                translate([0,0,-capLen/2])
                place_tabs(tabLen); 
            }
           corner_relief(capLen/2); 
           corner_relief(-capLen/2); 
        }
    }
}