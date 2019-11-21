// Parametric Clasp Probe Holder
// Modified by Bill Gertz (billgertz) on 13 November 2016
// Version 0.8.13
//
// Version  Author          Change
// -------  -------------   ----------------------------------------------------------------------------
//   0.6    billgertz       Developed core clip and cap modules
//
//   0.7    billgertz       Base code base from clip parametric probe holder integrated however neither
//                          guardDepth nor buildVector yet integrated
//
//   0.8    billgertz       Integrated guardDepth and buildVector
//
//   0.8.1  billgertz       First test code working
//
//   0.8.2  billgertz       Added oversize to compensate for extrusion hole undersizing
//
//   0.8.3  billgertz       Changed code from proportional object sizing to clearance sizing
//                          Removed fillet radius from all objects (made generation too slow)
//
//   0.8.4  billgertz       Fixed clasp attachment height calculation
//                          Clarified clasp clearance wording and calculation
//
//   0.8.5  billgertz       Fixed gap on right tab by adding a bit of extra nudge to left -
//                          thanks to furicks for spotting this
//                          Fixed height assumption based on radius in partial_linear_extrude
//                          by adding height as parameter
//
//   0.8.6  billgertz       Fixed cutting radius assumption on pie_wedge module by adding
//                          thickness as a parameter, probe diameter works for sub 1mm dimensions
//
//   0.8.7  billgertz       Tweaked clasp base reforcement so it works better with small clasp radii
//                          Fixed pie_slice module to nuge in correct direction
// 
//   0.8.8  billgertz       Made mount hole optional by setting mount_hole to "no" -
//                          thanks to RobinSwa for inspiring double stick tape mount application
//
//   0.8.9  billgertz       Modified guard_width and _depth for a selection up to 20mm
//
//   0.8.10 billgertz       Added optional center tab and cleaned up customizer oversize parameter 
//                          to step in 0.1 mm. Moved tab mount creation as child for more efficent
//                          object reuse (call mount_tab once rather than three times)
//
//   0.8.11 billgertz       Added center tab auto generate if length makes the holder too flexible
//                          (length/height > 8). Force center_tab by setting to yes or no
//
//   0.8.12 billgertz       Fixed right tab nudge based on number of tabs rather than fixed nudge,
//                          fixed value had caused gap between probe body and tab
//
//   0.8.13 billgertz       Removed oversize adjument divide by 10 from 0.8.10 fix
//
// Customizer View
// preview[view:north, tilt:top diagnol]
//
// Local Variables and Calculations //////////////////////////////////////

/* [General] */
// Number of probe holders
count = 4;                  // [1:8]
// Diameter of probe clip (mm)
probe_diameter = 8.75;      // [1:20]
// Probe guard width (mm)
guard_width = 11.6;         // [0:20]
// Probe guard depth (mm)
guard_depth = 11.6;         // [0:20]
// Usually a probe guard is circualr so the same number is used for width and depth
//    but claw and SMD probes can have some odd probe guard shapes

/* [Mount Tabs] */
// Center Tab (auto/yes/no)
center_tab = "auto";        // [auto, yes, no]
// Hole (yes/no)
mount_hole = "yes";         // [yes, no]
// Mounting plate screw hole diameter (mm)
mount_hole_diameter = 3;    // [3:6]
// Fastener type (percent)
fastener_type = 200;        // [180:Hex Socket,190:Machine,200:Wood,300:Hex Head]
// Countersink mount hole (yes/no)
countersink = "yes";        // [yes, no]

/* [Advanced] */
// Height of probe clip (mm)
holder_height = 10;         // [10:30]
// Mount plate thickness (mm)
mount_thickness = 2;        // [2:Thin,3:Typical,4:Thick,5:Very Thick]
// Probe clip arc (degrees)
clasp_arc = 250;            // [190:Open,210:Loose,230:Typical,250:Tight,290:Close,360:Closed Ring]
// Clasp thickness (mm)
clasp_thickness = 2;        // [1:Thin,2:Typical,3:Thick]
// Clearance between clasps (mm)
clasp_clearance = 2;        // [1:Close,2:Typical,3:Wide]
// Line segments per full circle
resolution = 180;           // [30:Rough,60:Coarse,90:Fine,180:Smooth,360:Insane]
// Oversize for clasp and mount hole fit (mm)
oversize = 0.1;               // [0:0.1:1]

/* [Hidden] */
// Build to create probe holder with different probe sizes
//    Uses a vector of probe vectors, probe vector defined as:
//        index [0]: number of clips to be made with dimensions in the rest of row (see next three lines)
//        index [1]: probe shaft diameter
//        index [2]: probe guard diameter (circular probe guard), or probe guard width (oblong probe guard)
//        index [3]: undefined (circular probe guard), or probe guard depth (oblong probe guard); see example below
//    Obviously overrides count, probe_diameter as well as guard_width and guard_depth variables above
//
//    Remove comment and edit as needed to use. Example below are for my specific probes, edit for yours!
//
//
// build_vector = [
//                   [2, 8.6, 13.7],        // two at 8.6 mm with 13.7 mm circular probe guard (DMM Fixed Wire Factory Probe)
//                   [2, 9.2, 13.2],        // two at 9.2 mm with 13.2 mm circular probe guard (DMM Standard Probe)
//                   [2, 11.3, 15.7],       // two at 11.3 mm with 15.7 mm circular probe guard (DMM SMD Probe)
//                   [2, 14.7, 15.0, 36.6]  // two at 14.7 mm with 15.0 mm and 36.6 mm oblong probe guard (DMM Claw Probe)
//                ];

// nudge for artifact reduction and complete manifolds (mm)
nudge = .05;
// probe clip radius (mm)
probeRadius = probe_diameter/2;
// mount plate hole radius (mm)
mountRadius = mount_hole_diameter/2;
// fastener sizing (ratio)
fastenerRatio = fastener_type/100;
// clearance buffer around clasp (mm)
claspBuffer = clasp_clearance/2;
// number used to invert ratio for depth clearance on countersink (1 is not deep enough)
fastener_ratio_offset = .8;
// length to height ratio where holder is deemed to flexible
too_flexible_ratio = 8;

// Notify if build_vector will be used instead of input variables count, clip_diameter, and buffer!
if (build_vector != undef) {
    echo(str("WARNING - Detected build_vector defined, building tailored probe holder; INPUT PROBE COUNT, DIAMETER AND GUARD SIZING IGNORED"));
}

if ((build_vector != undef) && (!ValidGuards(build_vector))) {
    echo(str("ERROR - Bad build_vector defined, check guard width and depth elements; CANNOT CONTINUE PROGRAM ABORTING"));
} else {
    probeHolder(
        count,            // number of probe clasps to make (1-8)
        probeRadius,      // radius of probe shank (mm)
        clasp_arc,        // arc of probe clasp without caps (degrees)
        clasp_thickness,  // probe clasp wall thickness (mm)
        claspBuffer,      // added width between clasp cells (mm)
        holder_height,    // height of the clip (mm)
        mount_thickness,  // mounting plate thickness (mm)   
        guard_width,      // probe guard diameter (circular guard), probe guard width (oblong guard)
        guard_depth,      // not used (circualr guard), probe guard width (oblong guard)
        center_tab,       // create a center mount tab (auto/yes/no)
        build_vector      // tailored probe vector (see above)   
    ) mountTab(holder_height, mount_thickness, mount_hole, mountRadius, fastenerRatio, countersink);        
}

// Recursive Fuction to validate guard widths and depths
function ValidGuards(buildVector, i=0) = 
    i < len(buildVector) ? 
    (buildVector[i][2] >= buildVector[i][1]) && (GuardDepth(buildVector,i) >= buildVector[i][1]) && ValidGuards(buildVector, i+1) : true;

// Function to return best cell width
function CellWidth(buildVector, thickness, clearance, i) = 
    max(buildVector[i][1] + thickness*2, buildVector[i][2]) + clearance*2;

// Recusive fuction to derive the offset for the right side mount cap
function Offset(buildVector, thickness, clearance, i=0) = 
    i < len(buildVector) ? 
    buildVector[i][0]*CellWidth(buildVector, thickness, clearance, i) + Offset(buildVector, thickness, clearance, i+1) : 0;

// Recursive function to derive offset for index one less than current index into the build vector 
function OffsetRest(buildVector, thickness, clearance, i) = 
    i > 0 ?
    buildVector[i-1][0]*CellWidth(buildVector, thickness, clearance, i-1) + OffsetRest(buildVector, thickness, clearance, i-1) : 0;

// Fuction to return circular depth or oblong probe guard depth
function GuardDepth(buildVector, i) =
    buildVector[i][3] == undef ?
    buildVector[i][2] : buildVector[i][3];

module pie_slice(radius, height, angle, step) {
    
    translate(v=[0, 0, -nudge]) for(theta = [0:step:angle-step]) {
        linear_extrude(height = height + nudge*2)
           polygon( points = [[0, 0], [radius*cos(theta+step), radius*sin(theta+step)], [ radius*cos(theta), radius*sin(theta)]]);
    }

}

module partial_rotate_extrude(angle, radius, thickness, height, convexity, resolution) {
    
    intersection () {
        rotate_extrude(convexity=convexity,$fn=resolution) translate([radius, 0, 0]) children(0);
        translate(v=[0, 0, 0]) pie_slice(radius + thickness*2, height, angle, angle/10);
    }
    
}

module probeHolder(count, claspRadius, claspArc, claspThickness, claspBuffer, height, thickness, guardWidth, guardDepth, center_tab, buildVector) {
    
    cellWidth = max((claspRadius + claspThickness)*2, guardWidth) + claspBuffer*2;
    
    // if build_array declared calculate right mount cap placement offset as well as cell depth or use input numbers if undef
    rightOffset = (buildVector != undef) ? Offset(buildVector, claspThickness, claspBuffer) : count*cellWidth;

    union() {
        
        total_clasp_length = rightOffset + height*2 - nudge*(count/2 + 1);
        //create mount tabs
        # children(0);
        translate(v=[total_clasp_length, 0, 0]) mirror() children(0);
        
        //add center tab if requested
        if ((center_tab == "yes") || ((center_tab == "auto") && (total_clasp_length/height > too_flexible_ratio))) {
            translate(v=[(total_clasp_length - height)/2, height*2 - nudge, 0]) rotate(a=[0,0,-90], v=[height*3/2, 0, 0]) children(0);
        }
        
        // create probe clips by build vector if defined otherwise use input
        if (buildVector != undef) {         
            for (i = [0:len(buildVector)-1]) {
                width = CellWidth(buildVector, claspThickness, claspBuffer, i);
                placeCopies(buildVector[i][0], height + OffsetRest(buildVector, claspThickness, claspBuffer, i) - nudge, width) 
                    probeClasp(claspArc, buildVector[i][1]/2, claspThickness, claspBuffer, GuardDepth(buildVector, i), width + nudge*2, height, thickness); 
            }    
        } else placeCopies(count, height, cellWidth - nudge) probeClasp(claspArc, probeRadius, claspThickness, claspBuffer, guardDepth, cellWidth + nudge*2, height, thickness); 
    }
    
}

module placeCopies(count, initialOffset, indexedOffset) for (i= [0:count-1]) translate(v=[initialOffset + indexedOffset*i, 0, 0]) children(0);  

module probeClasp(arc, probeRadius, claspThickness, claspBuffer, guardDepth, width, height, thickness) {
    
    claspOffset = thickness + max(probeRadius + oversize, guardDepth/2 + claspBuffer - oversize);
    widthOffset = width/2 - probeRadius;
    
    union() {
       
        // create base
        cube(size=[width, height, thickness]);

        // create clasp to base reenforcement
        difference () {
            translate(v=[widthOffset - claspThickness*3/4, 0, 0]) cube(size=[probeRadius*2 + claspThickness*3/2, height, thickness + guardDepth/2 + oversize]);
            translate(v=[width/2, height + nudge, claspOffset]) rotate(a=[90, 0, 0]) cylinder(r=probeRadius + claspThickness/2 + oversize, h=height + nudge*2);
        }   
 
        // create clasp
        translate(v=[width/2, height, claspOffset]) rotate(a=[90, 0, 0]) rotate(a=[0, 0,-(90+arc/2)])  {
            union() {
           
                // create arc of clasp
                partial_rotate_extrude(arc, probeRadius + oversize, thickness, height, 4, resolution) square([claspThickness, height]); 

                // don't put on clip end caps if the arc is too big to add them
                if (arc < 350) union() {
                        translate(v=[probeRadius + claspThickness/2 + oversize, 0, 0]) cylinder(h=height, r=claspThickness/2, $fn=resolution);
                        rotate(a=[0, 0, arc]) translate(v=[probeRadius + claspThickness/2 + oversize, 0, 0]) cylinder(h=height, r=claspThickness/2, $fn=resolution);             
                }
                
            }  
        }  
    }
    
}

module mountTab(tabDepth, tabHeight, mount_hole, mountRadius, fastenerRatio, counterSink) {
    
    clearance = mountRadius*(fastenerRatio - fastener_ratio_offset);
    
    difference () {
        union() {
            // create end tab
            translate(v=[tabDepth/2, 0, 0]) cube(size=[tabDepth/2, tabDepth, tabHeight], center=false);    
            // create round at end of tab
            translate(v=[tabDepth/2, tabDepth/2, tabHeight/2]) cylinder(r=tabDepth/2, h=tabHeight, center=true, $fn=resolution);
        }
    
        if (mount_hole == "yes") {
            // remove mounting hole
            translate(v=[tabDepth/2, tabDepth/2, tabHeight*(1+nudge)/2]) cylinder(r=mountRadius + oversize, h=tabHeight*(1+2*nudge), center=true, $fn=resolution);
            // remove countersink if countersink requested
            if (counterSink == "yes") {
                translate(v=[tabDepth/2, tabDepth/2, tabHeight + nudge]) cylinder(r1=mountRadius + oversize, r2=(mountRadius + oversize)*fastenerRatio, h=clearance, center=true, $fn=resolution);  
            }
        }   
    }    
}