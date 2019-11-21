/* [Clip Parameters] */
// Adjust to suit your PVC pipe diameter, and desired tightness of fit and ease of rotation
clip_inner_diameter = 22.1;
// Height of the hinge (top to bottom)
clip_height = 10;
// Thickness of clip wall. 5mm is a good value - thicker is stronger and will provide more aggressive snap on/off
clip_wall_thick = 5;
// How far around the pipe the clip should wrap. 220 is secure, but easily removable. Larger value is more secure, but will make it harder (or impossible) to snap on/off the pipe. Set to 360 for fully-enclosed hinge that would need to slide over end of pipe.
clip_wraparound_degrees = 220; // [180:360]

/* [Clip Ramp Parameters] */
// Optional ramp to prevent panel edge from catching on other side edges as the hinged panel is opened. Ramp Offset is distance in mm from center line of pipe/hinge to edge the ramp. Zero puts it in the middle of the clip, larger values move it toward the outside of the hinge. Set to 0 if no ramp desired.
ramp_offset = 8; // [0:25]
// Optional protective edge at end of ramp, to provide a smoother transition to edge of panel, if needed. Set to thickness of panel, or set to 0 if no additional ramp height needed. (Can also be useful for consistently aligning hinges relative to edge of panel...)
ramp_height = 3; // [0:25]

/* [Mounting Block Parameters] */
// The mounting block length *past the the outer diameter of the clip* (to allow space for a nut on the rear of the mounting block, if needed)
mounting_block_length = 25;
// Thickness of mounting block (front to rear)
mounting_block_thick = 10; // [0:25]

/* [Mounting Hole Parameters] */
// The diameter of the mounting hole(s) - recommend printing just slightly smaller than needed, then drill out to final desired size for through-hole or tapping. Holes will be vertically centered on the mounting block.
mouting_hole_diameter = 4.1;
// Horizontal distance *from the end of the mounting block farthest from the clip* at which to center the first mounting hole (no hole will be made, if set to zero)
mounting_hole_1_inset = 5;
// Horizontal distance *from the end of the mounting block farthest from the clip* at which to center the second mounting hole (no hole will be made, if set to zero)
mounting_hole_2_inset = 20;

/* [Hidden] */
//internal variables used by the program - feel free to play, but change at your own risk :-)
clipID = clip_inner_diameter;
clipWallThick = clip_wall_thick;
clipHt = clip_height;
clipWrapDeg = clip_wraparound_degrees;

connLen = mounting_block_length;       //length of connector block *beyond back-side contact point of block with clip OD*
connThick = mounting_block_thick;

rampHt = ramp_height;
rampOffset = ramp_offset;     //distance past tangent point connector contact, that ramp should start

mountHoleDia = 4.1;  //set appropriately to drill out and/or tap for desired bolt size

holeLocs = [mounting_hole_1_inset, mounting_hole_2_inset];

clipOD = clipID + 2*clipWallThick;

connBaseOffset = clipOD/2;//sqrt(pow(clipOD/2, 2) - pow(clipOD/2 - connThick, 2));

totconnLen = connBaseOffset + connLen;

connWrapDeg = .5*clipWrapDeg;

rampTotRad = clipOD/2 + rampHt;
    
diffTol = .005;

$fn=60;

rampStartX = rampTotRad*cos(connWrapDeg);
rampStartY = rampTotRad*sin(connWrapDeg);
    
rampOffsetX = rampOffset*sin(connWrapDeg);
rampOffsetY = rampOffset*cos(connWrapDeg);

rampEndX = rampStartX - rampOffsetX;
rampEndY = rampStartY + rampOffsetY;
    
rampStartDeg = 180 + rotFromXY(rampEndX, rampEndY);
rampStartRad = radFromXY(rampEndX, rampEndY);
rampRotDeg = clipWrapDeg - rampStartDeg;

clip();
connector();
ramp();

function radFromXY(x, y)  = sqrt(pow(x, 2) + pow(y, 2));
function rotFromXY(x, y) = atan(y/x);
function xFromRadRot(rad, rot) = rad*cos(rot);
function yFromRadRot(rad, rot) = rad*sin(rot);

module ramp() {
    rampRadDiff = rampStartRad - clipOD/2;
    rampRadDegDiff = rampRadDiff/rampRotDeg;
    clipWrapODPt = [xFromRadRot(clipOD/2, connWrapDeg), yFromRadRot(clipOD/2, connWrapDeg)];
    rampBasePt = [rampOffset*cos(connWrapDeg + 90) + clipWrapODPt[0], rampOffset*sin(connWrapDeg + 90) + clipWrapODPt[1]];
    

    rampArcPts = concat([[0, 0]], [clipWrapODPt], [rampBasePt],
        [for (r=[0:.1:rampRotDeg])
            let (rad = rampStartRad - r*rampRadDegDiff, rot = rampStartDeg + r)
            [xFromRadRot(rad, rot), yFromRadRot(rad, rot)]
        ]);


    difference() {
        linear_extrude(height=clipHt)
            polygon(rampArcPts);
        
        translate([0, 0, -diffTol])
            cylinder(d=clipID, h=clipHt + 2*diffTol);
    }
}

module clip() {
    difference() {
        //clip walls
        rotate_extrude(angle=clipWrapDeg) {
            translate([clipID/2, 0, 0])
                square([clipWallThick, clipHt]);
        }
        
        //Thingiverse Customizer runs an old version of OpenSCAD, which doesn't support rotate_extrude below 360 degrees, so chop out a chunk, if OpenSCAD version doesn't support proper rotate_extrude
        if (version_num() <= 20150399) {
            translate([0, 0, -diffTol])
                hull() {
                    for (r=[0, -(360-clipWrapDeg)/2, -(360-clipWrapDeg)])
                        rotate([0, 0, r])
                            cube([clipOD, .001, clipHt + 2*diffTol]);
                    
                }
        }
    }

    //clip rounded ends
    for (r=[0, clipWrapDeg]) {
        rotate([0, 0, r])
            translate([clipID/2 + clipWallThick/2, 0, 0])
                cylinder(d=clipWallThick, h=clipHt);
    }
}

module connector() {
    rotate([0, 0, connWrapDeg]) {
        difference() {
            translate([clipOD/2 - connThick, -totconnLen, 0])            
                cube([connThick, totconnLen, clipHt]);
            translate([0, 0, -diffTol])
                cylinder(d=clipID, h=clipHt + 2*diffTol);
            
            for (hl=holeLocs) {
                if (hl > 0)
                    translate([clipOD/2 - connThick - diffTol, -totconnLen + hl, clipHt/2])
                        rotate([0, 90, 0])
                            cylinder(d=mountHoleDia, h=connThick + 2*diffTol);
            }
        }
    }
}
