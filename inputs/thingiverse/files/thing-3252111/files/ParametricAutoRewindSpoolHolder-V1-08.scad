/*
    Auto-rewind spool spring generator
    Vincent Groenhuis
    
    Example spool sizes
    Fillamentum: D53 x W55; Prusa 1kg: D50 x W88; Excelfil: D32 x W58
    
    Version history
    * V1.08 Jan 4, 2019
        - Added hubSpringSupportEnable and hubSpringSupportCount to stabilize hub springs during printing
        - Split bearingDiameter into topBearingDiameter and bottomBearingDiameter
        - Improved bottom bearing cavity shape for easier printing
    * V1.07 Dec 8, 2018
        - Changed default value of hubSpringTopOffset to -3 to make insertion of spools with internal cavities easier
    * V1.06 Dec 7, 2018 with full credits to PeteThings
        - Added slots in axle for more stability with matching stands
        - Added parameters axleSlotPosition, axleSlotHeight, axleSlotWidth
    * V1.05 Dec 6, 2018
        - Fixed overlapping parts in print layout when specifying large axle diameter
        - Added parameter useFlatSideInsert
    * V1.04 Dec 5, 2018
        - Fixed incorrect axle length calculation in case of wider 2nd spool
        - Added parameter axleGrooveForSpacer
        - Added parameter spacerClearance
    * V1.03 Dec 5, 2018
        - Added parameter hubSpringTopOffset
        - Modified a couple of formulas for better consistency
    * V1.02 Dec 2, 2018
        - Changed default output to "print"
        - Fixed bug in spring's axle mount height
        - Calculation of hubSpringContactExtension capped to 3mm
    * V1.01 Dec 2, 2018
        - Added big stop block option
        - Fixed incorrect error message
        - Changed default hubSpringStart to 1 to avoid issues with clip gaps in certain configurations
    * V1.0 Dec 1, 2018
        - First version
*/

//preview[view:north west, tilt:top diagonal]

// "assembly": gives assembly view; "print": STL output with all parts; "printAllExceptSpring": leaves spring out due to relatively long rendering/slicing time; "spring", "hub", "adapter", "protector", "axle", "spacer" output specific part only
output = "print";//[assembly,print,printAllExceptSpring,spring,hub,adapter,protector,axle,spacer]

// Hole diameter of primary spool
referenceSpoolInnerDiameter = 30;

// Width of primary spool
referenceSpoolWidth = 45;

// Hole diameter of secondary spool, set to zero to disable adapter generation
secondSpoolInnerDiameter = 53;

// Width of second spool
secondSpoolWidth = 55;

// The hub spring applies pressure to the spool and keeps it in place
hubSpringEnable = "yes";//[yes,no]

// If yes, then space is saved by making the hub flush with the spool, but at the cost of a change in spring behaviour (if used)
hubFlushWithReferenceSpool = "no";//[yes,no]

// Nominal axle diameter; printed axle is slightly thinner and axle holes are slightly wider
axleDiameter = 8;

// Total length of axle; set to 0 for automatic length
axleSetLength = 0;

// Length of anti-rotation block on axle, and also the excess axle length at the other end
axleRotationStopLength = 12;

// A value 0 means same width as axle, and only extending upwards
axleRotationStopWidth = 0;

// Height as measured from the flat bottom side of the axle
axleRotationStopHeight = 11;

// Outer diameter of the spring; set 0 to use spring as hub shaft and set diameter equal to it
setSpringDiameter = 100;

// Spring blade width, higher is stiffer
springBladeWidth=10;

// 608zz has diameter 22, so use 22.2 to get a good fit
topBearingDiameter = 22.2;

// Bottom bearing diameter, can be different from top diameter if necessary to get an optimal fit
bottomBearingDiameter = 22.2;

// 608zz bearing has width 7
bearingWidth = 7;

// Size of chamfered edges around bearing to make insertion easier
bearingChamferSize = 0.4;

// Spacer to define distance from top bearing and/or spring protector to frame
spacerHeight = 3;

axleGrooveForSpacer = "no";//[yes,no]

// Horizontal support of hub springs for stability during printing, to be removed afterwards
hubSpringSupportEnable = "yes";//[yes,no]

// Number of hub spring supports, evenly distributed across length of hub springs
hubSpringSupportCount = 2;

// Higher = smoother circular segments but also longer rendering time
$fn=80;






/*[Advanced Parameters]*/

// Spring blade thickness; use 0.7 (two print traces) for soft spring, 1.1 (three print traces) for stiff spring
springBladeThickness=0.7; 

// Inside clearance in axle holes
axleClearance = 0.15;

// Clearance in printed axle
printedAxleClearance = 0.1;

// Clearance for spacer, enter negative number for a thighter fit
spacerClearance = -0.1;

// Spring twists left and then right about this angle. This strengthens the spring attachment to the hub and rim, and also makes the spring a bit stiffer. OpenSCAD does not like linear extrusion of spirals wit twist, so disabled for now until a custom twisted spiral spring function is created
//springTwistAngle = 0;

// Pattern spacing of the spring blade, 2 to 3 is a good value
springBladePitch=3;

// Thickness of spring's outer ring with clips
springRimThickness=2;

// Thickness of spring's inner ring on the axle
springAxleThickness=1.5;

// Extra rim height to give spring additional space to move
springExtraRim=1;

// The extra clearance in the spring clips in case spring is used as shaft, as no slits can be used here
springClipExtraClearanceIfSpringAsShaft=0.3;

// Distance that the spring clip points extend outwards; higher values make the clip attachments stronger
springClipPointExtension=0.3;

// The thickness of the hub's backplate that the spring is attached to
hubBackPlateThickness=3;

// Number of clips to attach the spring to the hub
hubClipCount=8;

// Minimum rim thickness, actual thickness may be larger depending on spool width difference
adapterRimThickness = 2;

// Relative length of slits, 0=no slits, 1=maximum length slits (up to hub)
hubSlitRelativeLength = 0.8;

// Clearance between hub and reference spool
hubClearance = 0.5;

// 0 = solid, 1 = wheel spokes, 2 = circular holes
springProtectorStyle = 1;

springProtectorThickness = 2;

// Only for wheel spokes style protector
springProtectorSpokeCount = 5;

// Only for wheel spokes style protector
springProtectorSpokeWidth = 2;

// Thicker means tighter
spacerWall = 1.5;

// Only for visualization in assembly view
referenceSpoolOuterDiameter = 150;

// Only for visualization in assembly view
secondSpoolOuterDiameter = 200;

// Distance between hub backplate and start of hub spring
hubSpringStart = 1;

// Offset of top edge of hub spring blade, positive makes spring blades extend beyond hub, negative makes hub top side flat
hubSpringTopOffset = -3;

// Number of hub spring blades, 0 = auto-calculated based on available space
setHubSpringCount = 0;

// Wider is stiffer
hubSpringWidth = 8;

// Distance from hub surface to blade, needed because blades are straight while surface is circular
hubSpringBladeOffset = 0.5;

// Thickness of the hub spring blade at the bottom, set to 0 for auto
setHubSpringBladeInitialThickness = 0;

// Thickness of the hub spring blade at the top (exluding curved contacter), set to 0 for auto
setHubSpringBladeFinalThickness = 0;

// The radius of the curved contacter at end of the blade
hubSpringContactRadius = 10;

// The distance between the center of the curvature from the end of the blade
hubSpringContactPositionOffset = 7.5;

// Distance that the spring contact extends beyond the hub cylinder, this is the distance that the blade has to be pressed in when fitting the spool or adapter; a good value is 2 to 3; set to 0 for auto based on hub spring length
setHubSpringContactExtension = 0;

// Minimum difference in spool inner diameters to get full adapter, if below threshold then walls are left away and 2nd spool sits directly on hub
adapterDiameterDifferenceThreshold = 5;

// A negative offset puts the top bearing deeper in the hub, useful for thin hubs in which the hub spring blades have little room around the contact
bearingTopOffset = 0;

// If set to "yes" then the holes for spring and spacer have a flat part matching the 3d printed axle shape to restrict rotation
useFlatSideInsert = "yes";//[yes,no]

// Distance of axle-slots from ends of axle. 0 = set to center of anti-rotation block, any other value specifies distance from either end of axle
axleSlotPosition=0;

//Height of axle-slots. 0 = no slots, recommended value is 3
axleSlotHeight=0;

//Width of of axle-slots
axleSlotWidth=3;


// Derived variables

useSpringAsShaft = (setSpringDiameter == 0);

hubDiameter = referenceSpoolInnerDiameter - 2*hubClearance;

// Width of the space for the spool on the hub
hubSpringLength = (useSpringAsShaft?referenceSpoolWidth-springBladeWidth-springExtraRim+adapterRimThickness-hubBackPlateThickness:referenceSpoolWidth)+(hubFlushWithReferenceSpool=="yes" || hubSpringEnable == "no"?0:12) - hubSpringStart;;

hubSpoolWidth = hubSpringLength + hubSpringStart - hubSpringTopOffset;

// Total width of the hub, including backplate
hubTotalWidth = hubSpoolWidth + hubBackPlateThickness;

hubSpringHoleWidth = hubSpringWidth + 2;

hubSpringContactExtension = (setHubSpringContactExtension==0?min(3,3*hubSpringLength/60):setHubSpringContactExtension);

// Depth of the hub spring holes
hubSpringHoleDepth = hubSpringContactExtension+(setHubSpringBladeFinalThickness==0?2*hubSpringLength/60:setHubSpringBladeFinalThickness)+2;

hubHoleDepthCircumference = 2*PI*(hubDiameter/2-hubSpringHoleDepth);

// Calculation of the number of hub springs
hubSpringCount = (setHubSpringCount==0?floor(hubHoleDepthCircumference/(hubSpringHoleWidth+hubDiameter/30)):setHubSpringCount);

hubSpringHoleLength = hubSpringLength + 1.5;

hubSpringBladeInitialThickness = (setHubSpringBladeInitialThickness==0?2*hubSpringLength/60:setHubSpringBladeInitialThickness);

hubSpringBladeFinalThickness = (setHubSpringBladeFinalThickness==0?1.5*hubSpringLength/60:setHubSpringBladeFinalThickness);

// The actual adapter width is two mm less
adapterWidthBeforeCut = max(referenceSpoolWidth,secondSpoolWidth+adapterRimThickness);

springDiameter = (useSpringAsShaft?referenceSpoolInnerDiameter-2*hubClearance+0.01:setSpringDiameter);

// Radius of the clips
hubPinRadius=springDiameter/(2*hubClipCount);

// Height where adapter indent starts
adapterIndentHeight = (useSpringAsShaft?springBladeWidth+springExtraRim-adapterRimThickness+hubBackPlateThickness:0)+hubSpringStart+hubSpringLength-hubSpringContactPositionOffset-5;

axleLength = (axleSetLength==0?springBladeWidth+springExtraRim+max(hubTotalWidth,(secondSpoolInnerDiameter>0?secondSpoolWidth+adapterRimThickness:0))+2*axleRotationStopLength+2*spacerHeight:axleSetLength);

maxDiameter = max(referenceSpoolOuterDiameter,secondSpoolOuterDiameter,springDiameter);

totalThingWidth = springProtectorThickness+springBladeWidth+springExtraRim+hubTotalWidth+max(0,bearingTopOffset);

hubSpringSupportSpacing = hubSpringLength/(hubSpringSupportCount+1);

// Some sanity checks

if (referenceSpoolOuterDiameter <= referenceSpoolInnerDiameter) {
    error("Outer diameter of primary spool must be larger than inner diameter!");    
}

if (secondSpoolInnerDiameter > 0) {
    if (secondSpoolInnerDiameter < referenceSpoolInnerDiameter) {
        error("Secondary spool cannot have smaller inner diameter than primary spool!");
    }
    if (secondSpoolOuterDiameter <= secondSpoolInnerDiameter) {
        error("Outer diameter of secondary spool must be larger than inner diameter!");    
    }
}

if (setSpringDiameter>0) {
    if (referenceSpoolInnerDiameter>springDiameter){
        error("Spring diameter should not be smaller than primary spool inner diameter!");
    }
}

if(secondSpoolInnerDiameter > 0 && secondSpoolInnerDiameter-referenceSpoolInnerDiameter<adapterDiameterDifferenceThreshold && secondSpoolWidth>referenceSpoolWidth) {
    error("Secondary spool cannot be wider than primary spool if its inner diameter is too close to that of the primary spool!");
}

if (hubSpringCount * hubSpringHoleWidth >= 2*PI*(hubDiameter/2-hubSpringHoleDepth)) {
    error("No space between hub spring holes! Please decrease setHubSpringCount or set to 0 (=auto)");
}





// Output interesting derived values

echo(str("<b>Total hub+spring+protector width = ",totalThingWidth," mm</b>"));

echo(str("<b>Axle length = ",axleLength," mm</b>"));

echo(str("hubSpringLength = ",hubSpringLength," mm"));

echo(str("hubSpringContactExtension = ",hubSpringContactExtension," mm"));

echo(str("hubSpringHoleDepth = ",hubSpringHoleDepth," mm"));

echo(str("hubSpringBladeInitialThickness = ",hubSpringBladeInitialThickness," mm"));

echo(str("hubSpringBladeFinalThickness = ",hubSpringBladeFinalThickness," mm"));

if(useSpringAsShaft){
    echo("Using spring as shaft!");
}

// Yay! Let's start!
generateOutput();

module generateOutput(){
    if(output=="assembly") {
        color("green")translate([0,0,-0.01])spring();
        color("red")translate([0,0,springBladeWidth+springExtraRim])hubSection();
        color("blue")translate([0,0,-springProtectorThickness-0.4])springProtector();
        color("yellow")translate([0,0,-springProtectorThickness-0.5-spacerHeight])spacer();
        color("yellow")translate([0,0,springBladeWidth+springExtraRim+hubTotalWidth+bearingTopOffset])spacer();
        color("yellow")translate([0,0,(useSpringAsShaft?adapterRimThickness:springBladeWidth+springExtraRim+hubBackPlateThickness)+0.1])referenceSpoolSection();
        color("white")translate([0,0,-springProtectorThickness-0.6-spacerHeight-axleRotationStopLength])axle();
        color("gray")translate([0,0,springBladeWidth+springExtraRim])bearing(bottomBearingDiameter);
        color("gray")translate([0,0,springBladeWidth+springExtraRim+hubTotalWidth-bearingWidth+bearingTopOffset])bearing(topBearingDiameter);
        if(secondSpoolInnerDiameter>0){
            color("blue")translate([0,0,(useSpringAsShaft?adapterRimThickness:springBladeWidth+springExtraRim+hubBackPlateThickness)+0.07])secondSpoolAdapterSection();
            color("orange")translate([0,0,(useSpringAsShaft?adapterRimThickness:springBladeWidth+springExtraRim+hubBackPlateThickness)+0.05])secondSpoolSection();
        }
    } else {
        // print layout
        biggestDiameter = max(springDiameter,max(referenceSpoolInnerDiameter,secondSpoolInnerDiameter)+20);
        patternSpacing = max(biggestDiameter,(biggestDiameter+axleDiameter+2*spacerWall)/sqrt(2))+4;
        
        if (output == "print" || output == "spring")
            translate([patternSpacing,0,0])spring();
        if(output == "print" || output == "printAllExceptSpring" || output == "protector") {
            translate([0,patternSpacing,0])springProtector();
        }
        if(output == "print" || output == "printAllExceptSpring" || output == "spacer") {
            translate([patternSpacing/2,patternSpacing/2]){
                iRange=((output=="spacer") || axleDiameter+2*spacerWall>12)?0:[-0.5:0.5];
                jRange=0;
                for (i=iRange) {
                    for (j=jRange)
                        translate([axleDiameter*2*i,axleDiameter*2*j,0])spacer();
                }
            }
        }
        if(output == "print" || output == "printAllExceptSpring" || output == "hub") {
            hub();
        }
        if(output == "print" || output == "printAllExceptSpring" || output == "axle") {
            translate([patternSpacing*1.5+axleDiameter/2+4,patternSpacing/2-axleLength/2,0.5*sqrt(2)*axleDiameter/2-printedAxleClearance])rotate([-90,0,0])rotate([0,0,180])axle();
        }
        if(output == "print" || output == "printAllExceptSpring" || output == "adapter") {
            if(secondSpoolInnerDiameter>0){
                translate([patternSpacing,patternSpacing,adapterWidthBeforeCut])rotate([180,0,0])spoolAdapter();
            }
        }
    }
}

module error(text){
    echo(str("<font color='red'>",text,"</font>"));
}

module bearing(d=bottomBearingDiameter){
    difference(){
        cylinder(d=d,h=bearingWidth);
        translate([0,0,-0.1])cylinder(d=axleDiameter,h=bearingWidth+0.2);
    }           
}

module hubSection(){
    difference(){
        hub();
        translate([-maxDiameter/2-1,0,-1])cube([maxDiameter/2+0.9,maxDiameter+2,hubTotalWidth+max(0,hubSpringTopOffset)+2]);
    }
}

module axle(){
    difference(){
        union(){
            difference(){
                cylinder(d=axleDiameter-2*printedAxleClearance,h=axleLength);
                translate([-axleDiameter/2,-axleDiameter/2-1,-1])
                    cube([axleDiameter,axleDiameter/2*(1-0.5*sqrt(2))+1+printedAxleClearance,axleLength+2]);
                // spacer grooves
                if(axleGrooveForSpacer=="yes"){
                    translate([0,0,axleRotationStopLength])
                    difference(){
                        cylinder(d=axleDiameter+1,h=spacerHeight+1);
                        translate([0,0,-0.1])cylinder(d=axleDiameter-1,h=spacerHeight+1.2);
                    }
                    translate([0,0,springProtectorThickness+0.5+spacerHeight+axleRotationStopLength+springBladeWidth+springExtraRim+hubTotalWidth+bearingTopOffset])
                    difference(){
                        cylinder(d=axleDiameter+1,h=spacerHeight+1);
                        translate([0,0,-0.1])cylinder(d=axleDiameter-1,h=spacerHeight+1.2);
                    }
                }      
            }
            if (axleRotationStopWidth == 0) {
                translate([-axleDiameter/2+printedAxleClearance,0,0])
                    cube([axleDiameter-2*printedAxleClearance,axleRotationStopHeight-axleDiameter/4*sqrt(2),axleRotationStopLength]);
            } else {
                translate([-axleRotationStopWidth/2,-axleDiameter/4*sqrt(2),0])
                    cube([axleRotationStopWidth,axleRotationStopHeight,axleRotationStopLength]);
            }
        }
    
        if (axleSlotHeight > 0) {  
            if (axleSlotPosition == 0) {
                translate([-axleDiameter/2, -axleDiameter/4*sqrt(2),axleRotationStopLength/2+axleSlotWidth/2])
                rotate(a=90, v=[0, 1, 0])
                sym_prism(axleSlotWidth , axleSlotHeight, axleDiameter, 1);
                translate([-axleDiameter/2, -axleDiameter/4*sqrt(2),axleLength-axleRotationStopLength/2+axleSlotWidth/2])
                rotate(a=90, v=[0, 1, 0])
                sym_prism(axleSlotWidth , axleSlotHeight, axleDiameter, 1);
            } else {
                translate([-axleDiameter/2, -axleDiameter/4*sqrt(2), axleSlotPosition+axleSlotWidth])
                rotate(a=90, v=[0, 1, 0])
                sym_prism(axleSlotWidth , axleSlotHeight, axleDiameter, 1);
                translate([-axleDiameter/2, -axleDiameter/4*sqrt(2), axleLength-axleSlotPosition])
                rotate(a=90, v=[0, 1, 0])
                sym_prism(axleSlotWidth , axleSlotHeight, axleDiameter, 1);
            }
        }
    }
}

module sym_prism(b , h, ht, sc){
    linear_extrude(height=ht, scale=sc)
    polygon(points = [[0,0],[b,0],[b/2,h]]);
}

module referenceSpoolSection(){
        intersection(){
        spool(d1=referenceSpoolInnerDiameter+0.01,d2=referenceSpoolOuterDiameter,w=referenceSpoolWidth);
        translate([0,0,-2])cube([maxDiameter/2+1,maxDiameter/2+1,referenceSpoolWidth+3]);
    }
}

module secondSpoolSection(){
    intersection(){
        spool(d1=secondSpoolInnerDiameter,d2=secondSpoolOuterDiameter,w=secondSpoolWidth);
        translate([0.01,-maxDiameter/2-1,-2])cube([maxDiameter/2+1,maxDiameter/2+1,secondSpoolWidth+3]);
    }
}

module secondSpoolAdapterSection(){
    intersection(){
        spoolAdapter();
        translate([0,-maxDiameter/2-1,-1])cube([maxDiameter/2+1,maxDiameter/2+1.01,max(totalThingWidth,secondSpoolWidth+2*adapterRimThickness)+2]);
    }
}

module spoolAdapter(){
    indentDepth=min(2,(secondSpoolInnerDiameter-2*hubClearance-referenceSpoolInnerDiameter)/2-1);
    difference(){
        union(){
            cylinder(d=secondSpoolInnerDiameter-2*hubClearance,h=adapterWidthBeforeCut-0.1);
            // adapter rim
            translate([0,0,secondSpoolWidth])cylinder(d=secondSpoolInnerDiameter+20,h=adapterWidthBeforeCut-secondSpoolWidth);
        }
        // center hole
        translate([0,0,-1])cylinder(d=referenceSpoolInnerDiameter,h=adapterWidthBeforeCut+2);
        translate([0,0,adapterIndentHeight])cylinder(d1=referenceSpoolInnerDiameter-0.01,d2=referenceSpoolInnerDiameter+indentDepth*2,h=2.01);
        translate([0,0,adapterIndentHeight+2])cylinder(d=referenceSpoolInnerDiameter+indentDepth*2,h=adapterWidthBeforeCut);
        translate([0,0,-1])cylinder(d=secondSpoolInnerDiameter,h=3);
        if(secondSpoolInnerDiameter-referenceSpoolInnerDiameter<adapterDiameterDifferenceThreshold){
            translate([0,0,-1])cylinder(d=secondSpoolInnerDiameter,h=secondSpoolWidth+1);
        }
        translate([0,0,1.9])cylinder(d1=referenceSpoolInnerDiameter+4,d2=referenceSpoolInnerDiameter-0.01,h=2);
    }
}

module spool(d1,d2,w){
    intersection(){
        difference(){
            union(){
                cylinder(d=d2,h=5);
                cylinder(d=(d1+d2)/2,h=w);
                translate([0,0,w-5])cylinder(d=d2,h=5);
            }
            translate([0,0,-1])cylinder(d=d1,h=w+2);
        }
    }
}

module spacer(){
    union(){
        difference(){
            cylinder(d=axleDiameter+spacerWall*2,h=spacerHeight);
            translate([0,0,-1])cylinder(d=axleDiameter+spacerClearance,h=spacerHeight+2);
            translate([-1,0,-1])cube([2,axleDiameter,spacerHeight+2]);
        }
        if (useFlatSideInsert=="yes")
            intersection(){
                translate([-axleDiameter,-axleDiameter,0])
                cube([axleDiameter*2,axleDiameter-0.25*sqrt(2)*axleDiameter,spacerHeight]);
                translate([0,0,-1])cylinder(d=axleDiameter,h=spacerHeight+2);
            }
    }
}

module springProtector(){
    union(){
        ring(r=axleDiameter/2+axleClearance,R=axleDiameter/2+springAxleThickness,h=springProtectorThickness+0.4);
        if (springProtectorStyle == 0) {
            // solid
            ring(axleDiameter/2+axleClearance,springDiameter,springProtectorThickness);
        } else if (springProtectorStyle == 1) {
            intersection(){
            // wheel spokes
            union(){
                ring(r=springDiameter/2-springRimThickness,R=springDiameter/2,h=springProtectorThickness);
                ring(r=axleDiameter/2+axleClearance,R=axleDiameter/2+springAxleThickness,h=springProtectorThickness);
                
                for(i=[0:springProtectorSpokeCount-1])
                    rotate([0,0,i*360/springProtectorSpokeCount])
                        translate([axleDiameter/2+axleClearance,-springProtectorSpokeWidth/2])
                            cube([springDiameter/2,springProtectorSpokeWidth,springProtectorThickness]);
                    
            }
            translate([0,0,-1])
                cylinder(d=springDiameter,h=springProtectorThickness+1.1);
            }
        } else if (springProtectorStyle == 2) {
            // circular holes
            difference(){
                ring(axleDiameter/2+axleClearance,springDiameter,springProtectorThickness);
                for(i=[0:3])
                    rotate([0,0,i*360/4])
                        if (springProtectorStyle == 2) {
                            translate([springDiameter/2*0.55,0,-1])
                                cylinder(r=springDiameter/2*0.35,h=springProtectorThickness+2);
                        }
            }
        }
    }
}

module springPolygon(){
    loops=(springDiameter/2-springBladeThickness-axleDiameter/2)/springBladePitch;
    r0=axleDiameter/2+axleClearance;
    polygon(points = concat(
    [for(t = [0:360/$fn:360*loops]) 
        [(r0+springBladePitch*t/360)*sin(t),(r0+springBladePitch*t/360)*cos(t)]],
    [for(t = [360*loops:-360/$fn:0]) 
        [(r0+springBladeThickness+springBladePitch*t/360)*sin(t),(r0+springBladeThickness+springBladePitch*t/360)*cos(t)]]
        ));
}

module spring(){
    r0=axleDiameter/2+axleClearance;
    r1=springDiameter/2;
    union(){
        linear_extrude(height=springBladeWidth-0.01)springPolygon();
        ring(r=r0,R=r0+springAxleThickness,h=springBladeWidth+springExtraRim);
        if (useFlatSideInsert=="yes")
            intersection(){
            translate([-r0*2,-r0*2,0])cube([r0*4,r0*2-0.5*sqrt(2)*r0,springBladeWidth+2]);
                cylinder(r=r0+springAxleThickness,h=springBladeWidth+springExtraRim);
            }
        ring(r=r1-springRimThickness,R=r1,h=springBladeWidth+springExtraRim);
        // spring clips
        translate([0,0,springBladeWidth+springExtraRim])
            for (i=[0:hubClipCount-1]){
                rotate([0,0,360*i/hubClipCount])
                intersection(){
                    ring(r=r1-springRimThickness,R=r1,h=hubBackPlateThickness+1);
                    translate([r1-springRimThickness/2,0,0])
                    union(){
                        cylinder(r=hubPinRadius,h=hubBackPlateThickness/2);
                        translate([0,0,hubBackPlateThickness/2])
                            cylinder(r1=hubPinRadius,r2=hubPinRadius+springClipPointExtension,h=hubBackPlateThickness/4);
                        translate([0,0,hubBackPlateThickness*3/4])
                            cylinder(r1=hubPinRadius+springClipPointExtension,r2=hubPinRadius-springClipPointExtension,h=hubBackPlateThickness/4-0.001);
                    }
                }
            }
        if(useSpringAsShaft){
            difference(){
                cylinder(d=max(referenceSpoolInnerDiameter,secondSpoolInnerDiameter)+20,h=adapterRimThickness);
                translate([0,0,-0.5])cylinder(d=springDiameter-2*springRimThickness,h=adapterRimThickness+1);                
            }            
        }
    }
}

module hub(){
    r1=springDiameter/2-0.01;
    union(){
        difference(){
            union(){
                cylinder(r=r1,h=hubBackPlateThickness);
                translate([0,0,0])cylinder(r=hubDiameter/2,h=hubTotalWidth);
            }
            union(){
                translate([0,0,-1])cylinder(d=axleDiameter+1,h=hubTotalWidth+2);
                // Bearing cavities
                translate([0,0,-1])cylinder(r=bottomBearingDiameter/2,h=bearingWidth+1);
                translate([0,0,bearingWidth-0.1])cylinder(r=bottomBearingDiameter/2,h=1.1,$fn=7);
                translate([0,0,bearingWidth+0.99])
                cylinder(r1=bottomBearingDiameter/2-bottomBearingDiameter/20,r2=axleDiameter/2,h=(bottomBearingDiameter-axleDiameter)/2);
                // bottom chamfer
                translate([0,0,-0.01])cylinder(d1=bottomBearingDiameter+bearingChamferSize*2,d2=bottomBearingDiameter-bearingChamferSize*2,h=2*bearingChamferSize);
                
                translate([0,0,hubTotalWidth-bearingWidth+bearingTopOffset])cylinder(r=topBearingDiameter/2,h=bearingWidth-bearingTopOffset+1);
                translate([0,0,hubTotalWidth-bearingWidth+bearingTopOffset-0.5])
                cylinder(r=topBearingDiameter/2-topBearingDiameter/20,h=1);
                // top chamfer
                translate([0,0,hubTotalWidth+bearingTopOffset-2*bearingChamferSize+0.01])
                union(){
                    cylinder(d1=topBearingDiameter-bearingChamferSize*2,d2=topBearingDiameter+bearingChamferSize*2,h=2*bearingChamferSize);
                    translate([0,0,2*bearingChamferSize])                    cylinder(d=topBearingDiameter+bearingChamferSize*2,h=abs(bearingTopOffset));
                }


                // Clip gaps in rim plate
                intersection(){
                    translate([0,0,-1])ring(r=r1-springRimThickness-0.2,R=r1+1,h=hubBackPlateThickness+2);
                    for (i=[0:hubClipCount-1]){
                        rotate([0,0,360*i/hubClipCount])
                        translate([r1-springRimThickness/2,0,0]) {
                            // Clip gaps
                            union(){
                                translate([0,0,-1])cylinder(r=hubPinRadius+(useSpringAsShaft?springClipExtraClearanceIfSpringAsShaft:0),h=hubBackPlateThickness/2+1.1);
                                translate([0,0,hubBackPlateThickness/2])cylinder(r=hubPinRadius+0.8,h=hubBackPlateThickness/2+0.1);
                            }
                        }
                    }
                }
                // Slits
                for (i=[0:hubClipCount*2-1]) {
                    rotate([0,0,360*i/(2*hubClipCount)])
                        translate([hubDiameter/2*hubSlitRelativeLength+r1*(1-hubSlitRelativeLength),-1,-1])cube([r1+2,2,hubBackPlateThickness+2]);
                }
                if (hubSpringEnable == "yes") {
                // Openings for hub springs
                for (i=[0:hubSpringCount-1])
                    rotate([0,0,360*i/hubSpringCount]){
                        translate([hubDiameter/2-hubSpringHoleDepth,-hubSpringHoleWidth/2,hubBackPlateThickness+hubSpringStart])
                            //cube([hubDiameter,hubSpringHoleWidth,hubSpringHoleLength]);
                            rotate([-90,0,0])linear_extrude(height=hubSpringHoleWidth)polygon([[hubSpringHoleDepth-hubSpringBladeInitialThickness-0.5,0],[0,-hubSpringHoleLength],[hubSpringHoleDepth+10,-hubSpringHoleLength],[hubSpringHoleDepth+10,0]]);
                        //translate([hubDiameter/2-hubSpringHoleDepth,-hubSpringHoleWidth/2,hubBackPlateThickness+hubSpringStart+hubSpringHoleLength/2])
                            //cube([hubDiameter,hubSpringHoleWidth,hubSpringHoleLength/2]);
                    }
                }
                                
                
            }
        }
        if (hubSpringEnable == "yes") {
        // Hub springs
        difference(){
            union(){
                for (i=[0:hubSpringCount-1])
                    rotate([0,0,360*i/hubSpringCount])
                            union(){
                                translate([hubDiameter/2-hubSpringBladeOffset,-hubSpringWidth/2,hubBackPlateThickness+hubSpringStart])
                                // Hub spring blade
                                rotate([-90,0,0])
                                    linear_extrude(height=hubSpringWidth)polygon([[-hubSpringBladeInitialThickness,0],[0,0],[0,-hubSpringLength+hubSpringContactPositionOffset],[-hubSpringBladeFinalThickness,-hubSpringLength+hubSpringContactPositionOffset]]);
                                
                                // Hub spring top contact
                                intersection(){
                                    translate([hubDiameter/2-hubSpringBladeOffset-hubSpringBladeFinalThickness,-hubSpringWidth/2-1,hubBackPlateThickness+1])
                                        cube([hubDiameter,hubSpringWidth+2,hubSpringLength]);
                                    translate([hubDiameter/2-hubSpringContactRadius+hubSpringContactExtension,-hubSpringWidth/2,hubSpringLength+hubBackPlateThickness+hubSpringStart-hubSpringContactPositionOffset])
                                    rotate([-90,0,0])
                                    cylinder(r=hubSpringContactRadius,h=hubSpringWidth);
                                    
                                }
                            }
                    if (hubSpringSupportEnable) {
                        for (i=[1:hubSpringSupportCount]) {
                            translate([0,0,hubBackPlateThickness+hubSpringStart+i*hubSpringSupportSpacing])
                            ring(r=hubDiameter/2-hubSpringBladeOffset-0.7,R=hubDiameter/2-hubSpringBladeOffset,h=0.2);                            
                        }                    
                    }
                }//end union()
            // Cylinder around bearing
                translate([0,0,hubTotalWidth-bearingWidth+bearingTopOffset-1])
                    cylinder(d=topBearingDiameter+2*(hubSpringContactExtension+0.5),h=bearingWidth+2);
                translate([0,0,hubTotalWidth+bearingTopOffset+1-0.01])
                    cylinder(d1=topBearingDiameter+2*(hubSpringContactExtension+0.5),d2=topBearingDiameter+2*(hubSpringContactExtension+0.5)-10,h=5);
                // Top cut-off
                translate([0,0,hubTotalWidth+max(0,hubSpringTopOffset)-0.01])
                    cylinder(d=referenceSpoolOuterDiameter,h=hubTotalWidth);
                // Contact cut-off
                difference(){
                    translate([0,0,hubBackPlateThickness+1])
                        cylinder(d=referenceSpoolOuterDiameter,h=hubTotalWidth);
                    translate([0,0,hubBackPlateThickness+0.5])cylinder(d=referenceSpoolInnerDiameter-2*hubClearance+2*hubSpringContactExtension,h=hubTotalWidth+1);
                }
            }
        }
        
    }
}

module ring(r,R,h){
    difference(){
        cylinder(r=R,h=h);
        translate([0,0,-1])cylinder(r=r,h=h+2);
    }
}
