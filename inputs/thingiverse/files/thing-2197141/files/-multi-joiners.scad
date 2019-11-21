// OpenSCAD file to create custom sized couplers for joining square tubes into
// various shapes.
// Setup for use with Thingiverse.com Customizer.
//
// preview[view:south west, tilt:bottom diagonal]
//
// Created Mar 22, 2017 by Allan M. Estes.
// Reuses earlier code developed for creating custom plugs and inline couplers
// (http://www.thingiverse.com/thing:1757352).
//
// Changes:
// Mar 30, 2017 Added extra length to tab parts to eliminate internal surfaces when
// joined. Simplification of place_tabs module for square tubing (originally derived
// from code supporting rectangular tube).
//
// Note: the +0 added to some assignments is to keep item from showing up in
// Thingiverse Customizer.

$fn=32+0;
// Following are parameter which are configurable through the customizer

// input_units exists to allow mm or inch values to be entered through customizer
// it is currently disabled and set to mm input;
// Units for customizer input (output is always mm)
input_units = 1+0; // [1:mm, 25.4:inch]  

// Type of connector to produce
which = 4; // [0:End, 1:I coupler, 2:Ell, 3:Tee, 4:Corner, 5:Cross, 6:I+Ell, 7:6-Way]

// Outside dimension of square tube
tube_size = 25.54;
// How thick is tube wall
tube_wall = 1.67;
// Amount of rounding to apply to edges (0=no rounding, 50=default rounding, 100=maximum rounding)
corner_rounding = 50; // [0:100]

// Add cross grooves to retaining tabs?
groove_tabs = 1; // [0:no, 1:yes]
// Add length-wise ribs to retaining tabs?
ribs = 0; // [0:no, 1:yes]
// Relief groove at base of tabs?
tab_relief = 0; // [0:no, 1:yes]
// Percent block will be hollowed (none to maximum), size of through hole in coupler
recess_pct = 100; // [0:100]

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

// list of rotation mamatrices controling the type of joiner being generated.
form = [
    [[0,0,0]],                                              // cap
    [[0,0,0],[0,180.0]],                                    // I
    [[0,0,0],[0,90.0]],                                     // ell
    [[0,0,0],[0,90.0],[0,180,0]],                           // tee
    [[0,0,0],[0,90.0],[90,0,0]],                            // corner
    [[0,0,0],[0,90.0],[0,180,0],[0,270,0]],                 // cross
    [[0,0,0],[0,90.0],[0,180,0],[90,0,0]],                  // inline ell
    [[0,0,0],[0,90,0],[0,180,0],[90,0,0],[0,270,0],[270,0,0]] // nexus
    ];

// sanitize/convert parameters:
tubeSize = abs(tube_size) * input_units;
tubeWall = abs(tube_wall) * input_units;

fillet = tubeWall * (corner_rounding/25); // 0:4, default=2 

tabThck = .7*sqrt(tubeSize);
tabLen = tubeSize/3;

// flag problems for bad data, used later to generate error "messages"
bad_wall = tubeWall<1;				// too thin
bad_ratio = tubeSize<2*tubeWall+3*tabThck;	// internal dimensions too small
bad_over = tubeSize>800 || tubeSize>800;	// really determined by build plate
									// it won't break the program but why bother 
bad_input = tubeSize==undef || tubeSize==undef || tubeWall==undef || tubeSize==undef;

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

// Modules to deal with exposed/visible portion of the coupler (the block) -
// Block is generated from a cube with optionally rounded corners which can be
// hollowed; the amount is controllable and can be reduced down to
// zero (none).

// generate 2d outline used at base of tabs
module block_outline() {
    if (2*fillet>tubeSize) {
        circle(fillet);
    } else if (fillet>0) {
        minkowski() {
            square([tubeSize-(2*fillet),tubeSize-(2*fillet)], true);
            circle(fillet);
        }
    } else
        square([tubeSize,tubeSize], true);
}

// Hollow block by difference with a scaled down clone - maximum hollow must
// fit within tabs and will match with opening(s) created in  final assembly.
module hollow() {
    // keep recess within tabs (2.0* would be flush with tabs, 2.1* adds a tiny edge) 
    hpct = (tubeSize-2.1*(tubeWall+tabThck))/tubeSize;  //max
    rhpct =  hpct * recess_pct/100;                     //user adjustment
    difference() {
        children();
        scale(v=[rhpct,rhpct,rhpct]) children();
    }
}

// create block - generated by combining cubes, cylinders, and spheres
module build_block(sz,r) {
    myX = sz-2*r;
    hollow()
    union() {
        for (i=[[0,0,0],[0,90,0],[90,0,0]])
            rotate(i) {
                cube([myX,myX,sz],center=true);
                for (j=[-1,1],k=[-1,1])
                    translate([j*myX/2,k*myX/2,0])
                        cylinder(h=myX,r=r,center=true);
            }
        for (j=[-1,1],k=[-1,1],l=[-1,1])
            translate([j*myX/2,k*myX/2,l*myX/2])
                sphere(r); 
        for (j=[-1,1],k=[-1,1])
            translate([j*myX/2,k*myX/2,0])
                cylinder(h=myX,r=r,center=true);
    }
}

// Modules to deal with retaining tabs - 
// Grooved tabs are created by building a 2D profile and extruding to "width".
// Ribbed tabs are created from a cube + cylinders. Ribs and grooves are optional.
// The tab tip is beveled to ease insertion into the tube. The tip bevel is only
// generated in the tab_grooves module, but an intersection of the two tab design
// preserves the tip bevel while allowing the groove and rib options to be
// combined. The resulting combined tab has the ends beveled for clearance. Tabs
// for X and Y directions are created, duplicated and moved into position

// tab w/tip bevel and (optional) cross grooves
module tab_grooves(size) {
//    sp = (tabLen-.75*tabThck-tabThck/2.5 )/3; // spacing for grooves
    sp = (tabLen-.75*tabThck-tabThck/5 )/3; // spacing for grooves

    linear_extrude(height=size,center=false) 
    difference() {
        polygon([ [-.01,0], [tabLen-.75*tabThck,0], [tabLen,.6*tabThck],
                  [tabLen,tabThck], [-.01,tabThck] ]);
        if (groove_tabs) {
            for (i=[0:2]) {
                translate([tabLen-.75*tabThck-sp/2-i*sp,-sp/3.0])
                circle(sp*.6);
            }
        }
    }
}

// tab w/(optional) vertical ribs. .01 is added to tabLen to prevent
// internal surfaces when joined with main part.
module tab_ribs(size) {
    cnt=floor(size/tabThck/2) + 1;  // how many ribs to produce
    sp = (size-tabThck*2/3)/cnt; // spacing for ribs
    
    translate([tabLen,tabThck/3,0])
    rotate([0,-90,0]) {
        cube([size,tabThck*2/3,tabLen+.01]);
        if (ribs) {
            for (i=[0:cnt]) {
                translate([tabThck/3+i*sp,0,0])
                cylinder(h=tabLen+.01,r=tabThck/3);
            }
        } else {
            translate([0,-tabThck*2/3,0]) 
            cube([size,tabThck*2/3,tabLen+.01], center=false);
        }
    }
}

// Module to produce base/reinforcement for tabs. Base is simplification of
// a ribbed tab which is not beveled at ends/edges allowing the bases to
// join in the corners for extra strength. .01 is added to baseLen to prevent
// internal surfaces when joined with main part.
module tab_base(baseLen,size) {
    cnt=floor(size/tabThck/2) + 1;  // how many ribs to produce
    sp = (size-tabThck*2/3)/cnt; // spacing for ribs
    
    translate([baseLen,tabThck/3+.01,0]) // .01 offset for looser fit
    rotate([0,-90,0]) {
        cube([size,tabThck*2/3,baseLen+.01]);
        for (i=[0:cnt]) { // columns/ribs
            translate([tabThck/3+i*sp,0,0])
            cylinder(h=baseLen+.01,r=tabThck/3);
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
    tabWid = tubeSize-2*tubeWall-(tabThck*1.25);
    for (rot=[0,90,180,270]) rotate([0,0,rot])
    translate([tabWid/-2,tubeSize/-2+tubeWall,-base])
    rotate([0,90,0]) {
        if (base) {
            translate([-base,0,0])
            tab_base(base,tabWid);
        }
        build_tab(tabWid);
    }
}

// Create shapes to "subtract" from corner formed by cap and base/tab. The
// intent here is to allow the cap/coupler to sit better against tube even if
// there is some irregularity in the cap printing and/or tube end.
module plug_relief_shapes() {
    cDia = tabThck/4;
    cLen = tubeSize-2*tubeWall-(tabThck*1.25); //+.01;
   for (i=[0,90,180,270])
       rotate(i) 
             translate([0,tubeSize/2-tubeWall,0]) {
                rotate([0,90,0])
                    cylinder(h=cLen,d=cDia,center=true);
                           translate([cLen/2-cDia/4,-(tubeSize-cLen)/4-cDia/2,0])
    rotate_extrude(angle=90)
             translate([(tubeSize-cLen)/4+cDia/2,0,0])
                 circle(d=cDia);
                       }
}

module reduce_opening() {
    // trimmed down copy of hollow(), used to reduce shape for creating opening
    // from tabs into block.
    hpctxy = (tubeSize-2.1*(tubeWall+tabThck))/tubeSize * recess_pct/100;
    scale(v=[hpctxy,hpctxy,1]) children();
}


// End of Modules

// Main "code" starts here, first portion deals with customizer errors. To be a little
// more user friendly, generate a "stop sign" with text describing error. In the event
// of multiple errors, just give a single most significant error. 

s = 10 + 0; r=s*1.414+s; // points to create octagon
if (bad_input || bad_wall || bad_ratio || bad_over) {
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
        } else if (bad_over) {
            text("Overly large Tube dimensions",halign="center",valign="top");
            //echo("Overly large Tube dimensions");
        }
    }
} else { 

    // If all is well, build the joiner ... 
    
    if (display_build_plate) 
        build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
    
        translate([0,0,tubeSize/2+tabLen*2]) // position object on build plate
        difference() {
            union() {
                for (i=form[which]) // loop through rotation matrix
                    rotate(i)       // a rotation for each side with tabs
                        translate([0,0,-tubeSize/2]) {
                            // following creates "collar" to eliminate round edges
                            linear_extrude(height=fillet, center=false, convexity=10)
                                block_outline();
                            place_tabs(tabLen); // makes the actual joiner part
                        }
                        build_block(tubeSize,fillet); // block at "core" of coupler
            }
            // the following creates the opening into the block for each side w/tabs
            for (i=form[which])
                rotate(i)
                    translate([0,0,-tubeSize/2-.01]) {
                        reduce_opening()
                            linear_extrude(height=tubeSize/2, center=false)
                                    block_outline();
                       if (tab_relief) plug_relief_shapes();
                    }
        } 
}