// OpenSCAD file to create custom bracket adapters for tripods and other devices
// using an angled wedge/"shoe" base.
//
// Setup for use with Thingiverse.com Customizer.
//
// preview[view:south east, tilt:top diagonal]
//
// Original code created November-December, 2016 by Allan M. Estes, Dearborn, MI
// Uploaded to Thingiverse December 4, 2016, all rights reserved.
//
// to do:
//      More/better parameter validation for Customizer.
//      Either strip out or fix build platform code.
//
// Note: the +0 added to some assignments is to keep item from showing up in 
// Thingiverse Customizer.

// Following are parameter which are configurable through the customizer

/* [Display/Printing] */

// Smoothness of generated surfaces/curves
$fn=36;
// Orientation for viewing or printing
orientation = 0; // // [0:print, 1:view]

/* [Bracket Pivot] */

// - radius of pivot joint at tip of bracket/clamp (determines bracket thickness)
Tip_Radius = 7.5;
// - width of bracket at pivot
Tip_Width = 20.24;
// - long side of bracket from base to center of pivot
Bracket_Length = 25.4;
// - width of non-pivot portion of bracket
Bracket_Width = 14;
// - length of opening/slot in bracket
Slot_Length = 21.8;
// - width of opening/slot in bracket
Slot_Width = 5.7;

/* [Pivot Bolt] */

// - hex size to use for pivot nut/bolt recess
Nut_Size = 7.9;
// - amount to recess hexagonal opening into bracket
Nut_Depth = 3.5;
// - size of pivot bolt hole through bracket
Bolt_Diameter = 4.8;
// - size for flat/post or recess where pivot fastener bolt/nut/handle touches bracket
Bolt_Neck_Diameter = 11;
// - depth/height of recess or post for fastener (recess < 0 < post)
Bolt_Neck_Depth = -3;    

/* [Base] */

// - exterior width (X dimension) of base/mount "shoe"
Base_X = 38.3;
// - exterior length (Y dimension) of base/mount: 0 = same as X (square base)
Base_Y = 0;
// - amount of rounding to apply to corners (0=no rounding, 100=maximum rounding)
Corner_Rounding = 30; // [0:100]
// Height of base/mount
Base_Z = 6.3;
// Angle of base/mount  
Wedge_Angle = 35; // [5:45]
// Base height where angle starts, must be less than base_Z
Wedge_Start = 1;

/* [Hidden] */

// Percent base will be recessed underneath (none to maximum)
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

// sanitize/convert parameters:

baseY = abs((Base_Y==0) ? Base_X : Base_Y);
baseX = abs(Base_X);
baseZ = abs(Base_Z);
shorter = min(baseX,baseY);
taperpct = 1 - (Wedge_Start/baseZ);
taper = Wedge_Angle;

bad_binput = baseX==undef || baseY==undef || baseZ==undef || taperpct==undef; 
bad_brange = baseZ<2 || baseZ>shorter ||    // too short/long (long is a bit arbitrary)
             baseX<10 || baseX>100 || 
             baseX<10 || baseY>100;
bad_bconflc = Wedge_Start>=baseZ;

pivot_r = abs(Tip_Radius);
pivot_w = abs(Tip_Width);
post_h = abs(Bracket_Length);
post_w = abs(Bracket_Width);
slot_h = abs(Slot_Length);
slot_w = abs(Slot_Width) + 0.5; // Do I really want to add this?

bad_pinput = pivot_r==undef || pivot_w==undef || post_h==undef ||
             post_w==undef || slot_h==undef || slot_w==undef; 
bad_pconflc = post_w>=pivot_w || slot_w>=post_w;
bad_prange = pivot_r<2 || pivot_r>shorter/2 ||
             post_h<pivot_r || post_h>100;

nut_s = abs(Nut_Size) + 0.3;
nut_t = abs(Nut_Depth);
bolt_d = abs(Bolt_Diameter) + 0.3;
bneck_d = Bolt_Neck_Diameter;    
bneck_t = Bolt_Neck_Depth < 0 ? Bolt_Neck_Depth - 0.3 : Bolt_Neck_Depth;

bad_ninput = nut_s==undef || nut_t==undef || bolt_d==undef ||
             bneck_d==undef || bneck_t==undef;
bad_nconflc = (nut_s>=(pivot_r*2) || bolt_d >= nut_s || bneck_d >= (pivot_r*2));
             
bad_input = bad_binput || bad_pinput || bad_ninput;
bad_range = bad_brange || bad_prange;
bad_conflc = bad_bconflc || bad_pconflc || bad_nconflc;

fillet = Corner_Rounding*shorter/4/100;

// flag problems for bad data, used later to generate error "messages"

final_rot = orientation ? -taper : 90;
final_y_tran = orientation ? -baseX/2 : post_h;
final_z_tran = orientation ? -post_h/2 : 7.5;

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

// Modules to deal with the bse - 
// Base is generated from a flat square/rectangle with optionally rounded
// corners which is extruded into the final shape. The base is taperred by
// extruding with scaling. By default the underside is recessed, but the
// amount is controllable and can be reduced down to zero.

// generate 2d outline used to build base
module base_outline(Xdim,Ydim,Fillet) {
    if (Fillet>0) {
        minkowski() {
            square([Xdim-(2*Fillet),Ydim-(2*Fillet)], true);
            circle(Fillet);
        }
    } else
        square([Xdim,Ydim], true);
}

// hollow/recess shape by difference with a scaled down clone
module hollow(Pct) {
    hpctz = .85 * Pct/100;
    hpctxy = hpctz * (.75 + .25*recess_pct/100);
    difference() {
        children();
        translate([0,0,-.001]) scale(v=[hpctxy,hpctxy,hpctz]) children();
    }
}

// extrude a tapering shape using a specified angle
module extrude_taper(Deg,Zdst,Base,Pct) {
    union() {
        if (Pct>0) {
            translate([0,0,Zdst*(1-Pct)])
            // scale is determined from angle using height change vs base 
            linear_extrude(height=Zdst*Pct, center=false,
                           convexity=10,
                           scale = 1-tan(Deg)*(Zdst*Pct)/(Base/2)
//                           scale = (Base-(Zdst*Pct*tan(Deg)*2))/Base
            )
            children();
        }
        if (Pct!=1) { 
            linear_extrude(height=Zdst*(1-Pct), center=false, convexity=10)
            children();
        }
    }
}


module nut(sides,size,depth) {
    th = sqrt(3)*size/2;
    hr = sqrt(3)*size/3;
    difference() {
        linear_extrude(height=depth+.1,scale=1.0)
        if (sides == 4)
            square(size,center=true);
        else if (sides == 3)
            translate([-size/2,-th/3,0])
            polygon([[0,0],[size/2,th],[size,0]]);
        else
            polygon([[-hr,0],[-hr/2,size/2],[hr/2,size/2],
                     [hr,0],[hr/2,-size/2],[-hr/2,-size/2]]);
    }
}

// End of Modules

// Main "code" starts here, first portion deals with customizer errors. To be a little
// more user friendly, generate a "stop sign" with text describing error. In the event
// of multiple errors, just give a single most significant error. 

if (bad_input || bad_range || bad_conflc) {
    s = 10 + 0; r=s*1.414+s; // points to create octagon
    rotate([90,0,0]) {
        color("red")
        translate([0,0,-.01])
        polygon([[r,s],[s,r],[-s,r],[-r,s],[-r,-s],[-s,-r],[s,-r],[r,-s]]);
        text("Bad Parameters",halign="center",valign="bottom");
        if (bad_input) {
            text("Missing or non-numeric data",halign="center",valign="top");
        } else if (bad_brange) {
            text("Bad dimensions for base",halign="center",valign="top");
        } else if (bad_prange) {
            text("Bad dimensions in bracket/pivot",halign="center",valign="top");
        } else if (bad_bconflc) {
            text("Conflicting value in base wedge",halign="center",valign="top");
        } else if (bad_pconflc) {
            text("Conflicting value in pivot/post",halign="center",valign="top");
        } else if (bad_nconflc) {
            text("Bolt/nut sizes exceed available space",halign="center",valign="top");
        } else {
            text("Errors in inputs",halign="center",valign="top");
        }
    }
} else translate([0,final_y_tran,final_z_tran]) rotate([final_rot,0,0]){ 

    // If all is well, build the item ... 
    
    if (display_build_plate) 
        build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

    // base
    extra = (1-taperpct)*baseZ*tan(taper); // so rotation will be flush    
    translate([0,-pivot_r,0])
    rotate([taper,0,0])
    translate([0,baseX/2+extra,0]) {
        // wedge
        hollow(recess_pct)
        extrude_taper(taper,baseZ,shorter,taperpct)
        base_outline(baseX,baseY,fillet);

        // flange (shrunk and shifted for printing w/o supports)
        // widened for specific tripod
        adj = tan(taper)*baseZ*taperpct + tan(taper)*2;
        translate([0,adj/2,baseZ])
        linear_extrude(height=2)
        base_outline(baseX+adj,baseY-adj,fillet);
        }

    // bracket
    dome_r = (pivot_w-post_w)/2; 
    rotate([0,90,0])
    translate([-post_h-(baseZ/cos(taper)),0,0]) {

        difference() {
            // basic bracket shape
            union() {
                translate([post_h/2,0,0])
                cube([post_h,pivot_r*2,post_w], center=true);   // post
                cylinder(r=pivot_r,h=post_w,center=true);       // rounded top
                duplicate_r([180,0,0]) 
                translate([0,0,post_w/2])
                rotate_extrude(angle=360) {
                    square([pivot_r-dome_r,dome_r]);
                    translate([pivot_r-dome_r,0,0])
                    circle(r=dome_r);                           // domes
                }
                if (bneck_t > 0)
                    translate([0,0,-pivot_w/2-bneck_t])
                    cylinder(d=bneck_d,h=bneck_t+dome_r);   // post for bolt base/neck 
            }

            // "subtract" negative space
            if (bneck_t < 0)
                translate([0,0,-pivot_w/2])
                cylinder(d=bneck_d,h=-bneck_t);         // recess for bolt base/neck 
            translate([0,0,pivot_w/2-nut_t])
            rotate([0,0,90])
            nut(6,nut_s,nut_t);                         // recess for nut
            cylinder(d=bolt_d,h=2*pivot_w,center=true); // bolt threads
            translate([(slot_h-2*pivot_r)/2,0,0])       // slot for device "tab"
            cube([slot_h,pivot_r*2+.1,slot_w], center=true);
    
            translate([post_h,-pivot_r,-baseX/2])      // trim for anngled base
            rotate([0,0,taper])
            cube([baseZ*2,baseX,baseY]);
    
        }
        
        // put "teeth" on pivot surface
        duplicate_r([180,0,0])
        translate([0,0,slot_w/2])
        rotate([0,90,0])
        for (i=[0:17])
           rotate([i*20,0,0])
           rotate([0,0,45])
           translate([-.5,-.5,bolt_d/2])
           cube([1,1,pivot_r-bolt_d/2]);
    }
}