/* [General] */
// Which parts to render (CAUTION: rendering "all" parts tends to time out on thingiverse)
part = "all"; // [all: All, winding: Winding template, top: Top support structure, bottom: Bottom support structure, reflector: Reflector Base, cover: Cover, frame: All frame parts]
// Circular polarization
polarization = "right"; // [left: Left, right: Right]
// Turns of your antenna (value from calculator)
turns = 5; // [1:1:16]
// Inner Diameter of your antenna (value from calculator)
D = 17.5;
// Diameter of your antenna wire (value from calculator, but adjust for your printers tolerances)
d = 2;
// Height of your antenna (value from calculator)
L = 59.4;

/* [Reflector] */
// Shape of the reflector PCB
reflectorShape = "round"; // [square: Square, round: Round]
// Diameter or width of the Reflector (account for your printers tolerances here)
reflectorDiameter = 46.5;
// Thickness of the reflector PCB
reflectorThickness = 1.8;
// Thickness of the walls for the Reflector mounts (adjust to your liking - best a multiple of your nozzle diameter)
reflectorWalls = 2;
// Thickness of the walls of the Reflector cover (adjust to your liking - best a multiple of your nozzle diameter)
reflectorCoverWalls = 1.2;
// Brim over the reflector, how much the reflector material should be overlapped
reflectorCoverBrim = 1;
// Height of the Brim over the reflector (adjust to your linking, best a multiple of your layer height)
reflectorCoverBrimHeight = 0.6;
// Outer diameter of the coaxial cable, with shielding but without insulation  (account for your printers tolerances here)
coaxialDiameter = 4.5;
// Thickness of the reflector back cover (adjust to your linking, best a multiple of your layer height)
reflectorBackCoverHeight = 1;
// Width of the reflector back cover snaps (adjust to your liking - best a multiple of your nozzle diameter)
reflectorBackCoverSnapWidth  = 2;

/* [Tolerances] */
// Padding for the cover slits (tolearance for the top and bottom frame pieces to fit into the slits of the ring)
reflectorCoverPadding = 0.2;
// padding between the slot parts (sides)
slitPadding = 0.05;
// padding between the slot parts (joint)
slitPaddingTop = 0.2;
// Resolution of the helix (more will render longer, or timeout on thingiverse)
resolution = 64; // [1:1:256]
// Thickness of the walls (adjust to your liking - best a multiple of your nozzle diameter)
walls = 2;
// Thickness of each support piece (adjust to your liking - best a multiple of your layer height, thinner is better)
depth = 3;

/* [Hidden] */
$fn = 50;

direction = polarization;
enableReflectorMounts =  "enabled";

height = L;
innerDiameter = D;
conductorDiameter = d;
innerRadius = innerDiameter / 2;
conductorRadius = conductorDiameter / 2;
spacing = height / turns;

cutoutRadius = (spacing - (walls + conductorRadius) * 2) / 2;
cutoutY = cutoutRadius + depth / 2 + walls * 1.5;

topRadius = innerRadius + conductorRadius - cutoutRadius;
holeRadius = conductorRadius;

holeWrapperRadius = holeRadius + walls;
holeWrapperY = innerRadius + conductorRadius;
holeWrapperZ = conductorRadius + walls;
totalHeight = height + (conductorRadius + walls) * 2;

reflectorRadius = reflectorDiameter / 2;
reflectorDiameterOuter = reflectorDiameter + reflectorWalls * 2;

reflectorCoverHeight = reflectorWalls + reflectorThickness + reflectorCoverBrimHeight;
reflectorCoverDepth = depth + reflectorCoverPadding * 2;

coverWidth = reflectorDiameter + reflectorWalls * 2 + reflectorCoverWalls * 2;
reflectorWallOffset = reflectorCoverWalls + reflectorWalls;
reflectorBrimTotal = reflectorCoverBrim * 2;
widthCross = reflectorCoverPadding * 2 + reflectorDiameterOuter;
coverRadius = coverWidth / 2;

coaxialRadius = coaxialDiameter / 2;

reflectorBackCoverSnapHeight = reflectorWalls - reflectorCoverPadding;
reflectorBackCoverOuterRadius = coverRadius - reflectorCoverWalls - reflectorWalls - reflectorCoverPadding;
reflectorBackCoverOuterWidth = reflectorDiameter - reflectorCoverPadding * 2;

renderPart();

module renderPart() {
    if(part == "all") {
        spacing = 5;

        translate([0, 0, depth / 2])
            renderTop();

        translate([coverWidth+ spacing, 0, depth / 2])
            renderBottom();
     
        if(direction == "right") {
            translate([0, -coverWidth / 2 -  reflectorThickness - reflectorWalls -spacing, 0])
                template(cw = false);
        }
        else {
            translate([0, -coverWidth / 2 -  reflectorThickness - reflectorWalls -spacing, 0])
                template(cw = true);  
        }
        
        if(reflectorShape == "square") {
            translate([-coverWidth / 2, -coverWidth -  reflectorThickness - reflectorWalls -spacing, 0])
                reflector();
        }
        
        if(reflectorShape == "round") {
            translate([-coverWidth / 2, -coverWidth -  reflectorThickness - reflectorWalls -spacing, 0])
                roundReflector();
        }
        
        if(reflectorShape == "square") {
            translate([coverWidth / 2 + spacing, -coverWidth -  reflectorThickness - reflectorWalls -spacing, 0])
                cover();
        }

        if(reflectorShape == "round") {
            translate([coverWidth / 2 + spacing, -coverWidth -  reflectorThickness - reflectorWalls -spacing, 0])
                coverRound();
        }
    }


    if(part == "frame") {
        spacing = 5;

        translate([0,0, depth / 2])
            renderTop();

        translate([coverWidth+ spacing, 0, depth / 2])
            renderBottom();
        
        if(reflectorShape == "square") {
            translate([-coverWidth / 2, -coverWidth -  reflectorThickness - reflectorWalls -spacing, 0])
                reflector();
        }
        
        if(reflectorShape == "round") {
            translate([-coverWidth / 2, -coverWidth -  reflectorThickness - reflectorWalls -spacing, 0])
                roundReflector();
        }        

        if(reflectorShape == "square") {
            translate([coverWidth / 2 + spacing, -coverWidth -  reflectorThickness - reflectorWalls -spacing, 0])
                cover();
        }

        if(reflectorShape == "round") {
            translate([coverWidth / 2 + spacing, -coverWidth -  reflectorThickness - reflectorWalls -spacing, 0])
                coverRound();
        }
    }

    if(part == "winding") {
        if(direction == "right") {
            template(cw = false);
        }
        else {
            template(cw = true);
        }
        
    }

    if(part == "top") {
        renderTop();
    }

    if(part == "bottom") {
        renderBottom();
    }
    if(part == "reflector") {
        if(reflectorShape == "square") {
            reflector();
        }
        
        if(reflectorShape == "round") {
            roundReflector();
        }
    }

    if(part == "cover") {
        if(reflectorShape == "square") {
            cover();
        }

        if(reflectorShape == "round") {
            coverRound();
        }
    }
}

module roundReflector() {
    translate([coverRadius, coverRadius, 0]) {
        group() {
            difference() {
                cylinder(r = coverRadius, h = reflectorCoverHeight);

                translate([0, 0, reflectorCoverBrimHeight])
                    cylinder(r = reflectorRadius, h = reflectorCoverHeight);

                translate([0, 0, -1])
                    cylinder(r = reflectorRadius - reflectorCoverBrim, h = reflectorCoverHeight + 2);

                translate([-widthCross / 2, -reflectorCoverDepth / 2, -1])
                    cube([widthCross, reflectorCoverDepth, reflectorCoverHeight + 2]);
            
                translate([-reflectorCoverDepth / 2, 0, -1])
                    cube([reflectorCoverDepth, widthCross / 2, reflectorCoverHeight + 2]);
            }
        }
    }
}

module reflector() {
    difference() {
        cube([coverWidth, coverWidth, reflectorCoverHeight]);
        
        translate([reflectorWallOffset, reflectorWallOffset, reflectorCoverBrimHeight])
            cube([reflectorDiameter, reflectorDiameter, reflectorWallOffset + reflectorThickness + 2]);
        
        translate([reflectorWallOffset + 1, reflectorWallOffset + 1, -1])
            cube([reflectorDiameter - reflectorBrimTotal, reflectorDiameter - reflectorBrimTotal, reflectorWallOffset + reflectorThickness + 2]);

        group() { 
            translate([reflectorCoverWalls - reflectorCoverPadding, coverWidth / 2 -reflectorCoverDepth / 2, -1])
                cube([widthCross, reflectorCoverDepth, reflectorCoverHeight + 2]);
            
            translate([coverWidth / 2 -reflectorCoverDepth / 2, reflectorCoverWalls - reflectorCoverPadding + widthCross / 2, -1])
                cube([reflectorCoverDepth, widthCross / 2, reflectorCoverHeight + 2]);
        }
    }
}

module cover() {
    difference() {
        group() {
            cube([coverWidth, coverWidth, reflectorBackCoverHeight]);
            
            translate([reflectorWallOffset + reflectorCoverPadding, reflectorWallOffset + reflectorCoverPadding , 0])
                cube([reflectorBackCoverOuterWidth, reflectorBackCoverOuterWidth, reflectorBackCoverHeight + reflectorBackCoverSnapHeight]);
        }
        translate([coverRadius, coverRadius - innerRadius, -1])
            cylinder(r = coaxialRadius, h = reflectorBackCoverHeight + 2);

        translate([reflectorWallOffset + reflectorCoverPadding +  reflectorBackCoverSnapWidth, reflectorWallOffset + reflectorCoverPadding +  reflectorBackCoverSnapWidth, reflectorBackCoverHeight])
                cube([reflectorBackCoverOuterWidth - reflectorBackCoverSnapWidth * 2, reflectorBackCoverOuterWidth - reflectorBackCoverSnapWidth * 2, reflectorBackCoverHeight + reflectorBackCoverSnapHeight]);

        group() { 
            translate([reflectorCoverWalls - reflectorCoverPadding, coverWidth/2 -reflectorCoverDepth, reflectorBackCoverHeight])
                cube([widthCross, reflectorCoverDepth * 2, reflectorCoverHeight + 2]);
            
            translate([coverWidth / 2 -reflectorCoverDepth, reflectorCoverWalls - reflectorCoverPadding, reflectorBackCoverHeight])
                cube([reflectorCoverDepth * 2, widthCross, reflectorCoverHeight + 2]);
        }
    }
}

module coverRound() {        
    difference() {
        translate([coverRadius, coverRadius, 0]) {
            group(){
                cylinder(r = coverRadius, h = reflectorBackCoverHeight);
                difference() {
                    cylinder(r = reflectorBackCoverOuterRadius, h = reflectorBackCoverHeight + reflectorBackCoverSnapHeight);
                    cylinder(r = reflectorBackCoverOuterRadius - reflectorBackCoverSnapWidth, h = reflectorBackCoverHeight + reflectorBackCoverSnapHeight + 1);
                }
            }
        }

        translate([coverRadius, coverRadius - innerRadius, -1])
            cylinder(r = coaxialRadius, h = reflectorBackCoverHeight + 2);

        group() { 
            translate([reflectorCoverWalls - reflectorCoverPadding, coverWidth/2 -reflectorCoverDepth, reflectorBackCoverHeight])
                cube([widthCross, reflectorCoverDepth * 2, reflectorCoverHeight + 2]);
            
            translate([coverWidth / 2 -reflectorCoverDepth, reflectorCoverWalls - reflectorCoverPadding, reflectorBackCoverHeight])
                cube([reflectorCoverDepth * 2, widthCross, reflectorCoverHeight + 2]);
        }
    }
}

module renderTop() {
    rotate([0, 270, 270])
        top();
}

module renderBottom() {
    rotate([0, 270, 270])
        bottom();
}
    
module top() {
    slitHeight = (height) / 2 + slitPaddingTop;
    turnOffset = 0;

    difference() {
        if(enableReflectorMounts == "enabled") {
            support(turnOffset = turnOffset);
        }
        else {
            support(turnOffset = turnOffset, mounts = false);
        }

        translate([-depth, -depth / 2 - slitPadding, -1])
            cube([depth + 2, depth + slitPadding * 2, slitHeight + 1]);
        
        hull() {
            rotate([0,90,0]) {
                translate([-holeWrapperZ - (spacing * turns) - turnOffset, -innerDiameter, -depth + 1])
                    cylinder(r = cutoutRadius, h = depth + 2);
                
                translate([-holeWrapperZ - (spacing * turns) - turnOffset, -cutoutY, -depth + 1])
                    cylinder(r = cutoutRadius, h = depth + 2);

                translate([-holeWrapperZ - (spacing * (turns + 1)) - turnOffset, -innerDiameter, -depth + 1])
                    cylinder(r = cutoutRadius, h = depth + 2);
                
                translate([-holeWrapperZ - (spacing * (turns + 1)) - turnOffset, -cutoutY, -depth + 1])
                    cylinder(r = cutoutRadius, h = depth + 2);
            }
        }
    }
}

module bottom() {
    slitOffset = (height / 2) - slitPaddingTop;
    turnOffset = spacing / 4;

    difference() {
        if(enableReflectorMounts == "enabled") {
            support(turnOffset = turnOffset, mounts = true, both = false);
        }
        else {
            support(turnOffset = turnOffset, mounts = false);
        }
        

        translate([-depth, -depth / 2 - slitPadding, slitOffset])
            cube([depth + 2, depth + slitPadding * 2, height]);
        
        hull() {
            rotate([0,90,0]) {
                translate([-holeWrapperZ - (spacing * turns) + spacing / 2 - turnOffset, innerDiameter, -depth + 1])
                    cylinder(r = cutoutRadius, h = depth + 2);
                
                translate([-holeWrapperZ - (spacing * turns) + spacing / 2 - turnOffset, cutoutY, -depth + 1])
                        cylinder(r = cutoutRadius, h = depth + 2);

                translate([-holeWrapperZ - (spacing * (turns + 1)) + spacing / 2 - turnOffset, innerDiameter, -depth + 1])
                    cylinder(r = cutoutRadius, h = depth + 2);
                
                translate([-holeWrapperZ - (spacing * (turns + 1)) + spacing / 2 - turnOffset, cutoutY, -depth + 1])
                    cylinder(r = cutoutRadius, h = depth + 2);
            }
        }
    }
}

module support(turnOffset = 0, mounts = true, both = true) {
    difference() {
        group() {
            difference() {
                group() {
                    for(i=[0:1:turns]) {
                        rotate([0,90,0])
                            translate([-holeWrapperZ - spacing * i - turnOffset, holeWrapperY, -depth / 2])
                                cylinder(r = holeWrapperRadius, h = depth);
                    }
                    
                    for(i=[0:1:turns -1]) {
                        rotate([0,90,0])
                            translate([-holeWrapperZ - spacing * i  - spacing / 2 - turnOffset, -holeWrapperY, -depth / 2])
                                cylinder(r = holeWrapperRadius, h = depth);
                    }
                    
                    translate([-depth / 2, -holeWrapperY, 0]) {
                        cube([depth, holeWrapperY * 2, turns * spacing + holeWrapperRadius * 2]);
                    }
                }

                for(i=[0:1:turns]) {
                    rotate([0,90,0]) {
                        hull() {
                            translate([-holeWrapperZ - spacing * (i + 1) + spacing / 2 - turnOffset, holeWrapperY, -depth + 1])
                                cylinder(r = cutoutRadius, h = depth + 2);

                            translate([-holeWrapperZ - spacing * (i + 1) + spacing / 2 - turnOffset, cutoutY, -depth + 1])
                                cylinder(r = cutoutRadius, h = depth + 2);
                        }
                    }
                }
                
                for(i=[0:1:turns - 1]) {
                    rotate([0,90,0]) {
                        hull() {
                            translate([-holeWrapperZ - spacing * i - spacing / 2 - spacing / 2 - turnOffset, -holeWrapperY, -depth + 1])
                                cylinder(r = cutoutRadius, h = depth + 2);

                            translate([-holeWrapperZ - spacing * i - spacing/2- spacing / 2 - turnOffset, -cutoutY, -depth + 1])
                                cylinder(r = cutoutRadius, h = depth + 2);
                        }
                    }
                }

                rotate([0,90,0]) {
                    hull() {
                        translate([-holeWrapperZ - spacing * -1 - spacing/2- spacing / 2 - turnOffset, -cutoutY, -depth + 1])
                            cylinder(r = cutoutRadius, h = depth + 2);
                        
                        translate([-holeWrapperZ - spacing * -1 - spacing/2- spacing / 2 - turnOffset, -cutoutY * 2, -depth + 1])
                            cylinder(r = cutoutRadius, h = depth + 2);
                    
                        translate([-holeWrapperZ - spacing * -2 - spacing/2- spacing / 2 - turnOffset, -cutoutY, -depth + 1])
                            cylinder(r = cutoutRadius, h = depth + 2);
                        
                        translate([-holeWrapperZ - spacing * -2 - spacing/2- spacing / 2 - turnOffset, -cutoutY * 2, -depth + 1])
                            cylinder(r = cutoutRadius, h = depth + 2);
                    }
                
                    hull() {
                        translate([-holeWrapperZ + spacing / 2 - turnOffset, holeWrapperY, -depth + 1])
                            cylinder(r = cutoutRadius, h = depth + 2);

                        translate([-holeWrapperZ + spacing / 2 - turnOffset, cutoutY, -depth + 1])
                            cylinder(r = cutoutRadius, h = depth + 2);
                    
                        translate([-holeWrapperZ - spacing * -1 + spacing / 2 - turnOffset, holeWrapperY, -depth + 1])
                            cylinder(r = cutoutRadius, h = depth + 2);

                        translate([-holeWrapperZ - spacing * -1 + spacing / 2 - turnOffset, cutoutY, -depth + 1])
                            cylinder(r = cutoutRadius, h = depth + 2);
                    }
                }
            }

            // Full mount
            if(mounts && both) {
                difference() {
                    translate([-depth / 2,-reflectorDiameterOuter / 2, -reflectorWalls - reflectorThickness])
                        cube([depth, reflectorDiameterOuter, reflectorWalls * 2 + reflectorThickness]);
                    
                    translate([-depth / 2 - 1,-reflectorRadius, -reflectorThickness])
                        cube([depth + 2, reflectorDiameter, reflectorThickness]);
                    
                    translate([-depth / 2 - 1, -reflectorRadius + reflectorWalls, -reflectorWalls - reflectorThickness - 1])
                        cube([depth + 2, reflectorDiameter - reflectorWalls * 2, reflectorWalls + 2]);
                }
            }

            // Half mount
            if(mounts && !both) {
                difference() {
                    translate([-depth / 2, 0, -reflectorWalls - reflectorThickness])
                        cube([depth, reflectorDiameterOuter / 2, reflectorWalls * 2 + reflectorThickness]);
                    
                    translate([-depth / 2 - 1,-reflectorRadius, -reflectorThickness])
                        cube([depth + 2, reflectorDiameter, reflectorThickness]);
                    
                    translate([-depth / 2 - 1, -reflectorRadius + reflectorWalls, -reflectorWalls - reflectorThickness - 1])
                        cube([depth + 2, reflectorDiameter - reflectorWalls * 2, reflectorWalls + 2]);
                }
            }
        }

        // Holes left
        for(i=[0:1:turns - 1]) {
            rotate([0,90,0]) {
                translate([-holeWrapperZ - spacing * i - spacing / 2 - turnOffset, -holeWrapperY, -depth + 1])
                    cylinder(r = holeRadius, h = depth + 2);
            }
        }

        // Holes right
        for(i=[0:1:turns]) {
            rotate([0,90,0]) {
                translate([-holeWrapperZ - spacing * i - turnOffset, holeWrapperY, -depth + 1])
                    cylinder(r = holeRadius, h = depth + 2);
            }
        }
    }
}

module template(cw = true) {
    additionalHeight = height / turns;
    difference() {
        cylinder(h=height + additionalHeight, r = innerRadius + conductorRadius / 3);

        translate([0, 0, conductorRadius * 3 + 2]) {
            helix(
                turns = turns + 1,
                innerRadius = innerRadius + conductorRadius,
                radius = conductorRadius,
                height = height + additionalHeight,
                cw = cw,
                slices = resolution
            );
            
            rotate([90,0,90])
                cylinder(r=conductorRadius, h = innerRadius + conductorRadius);
        }
    }
}

module helix(turns = 5, innerRadius = 8.75, radius = 0.5, height = 59.4, cw = true, slices = 50) {
    if(cw) {
        rotate([0, 180, 180]) {
            elliptic_spring(
                turns = turns,
                R = innerRadius,
                r = radius,
                height = height * -1,
                slices = 50);
        }
    }
    else {
        elliptic_spring(
            turns = turns,
            R = innerRadius,
            r = radius,
            height = height,
            slices = 50);
    }
}

module elliptic_ring(R = 10, r = 2, slices = 50, h = 0, w = 360) {
    dz = h / slices;
    dwx = atan(h / (R * 2) / PI);
	for (i = [0:slices-1]) {
        hull() {
            translate([R * cos((i + 1) * w / slices), R * sin((i + 1) * w / slices), (i + 1) * dz])
                rotate([90 + dwx, 0, (i + 1) * w / slices])
                    cylinder(r = r, h = 0.01);
            
             translate([R * cos((i) * w / slices), R * sin((i) * w / slices), i * dz])
                rotate([90 + dwx, 0, i * w / slices])
                    cylinder(r = r, h = 0.01);
        }
    }
}

module elliptic_spring(turns = 5, R = 20, r = 1, height = 20, slices = 50) {
    turnHeight = height / turns;
    for(i = [0:turns - 1])
        translate([0, 0, turnHeight * i])
            elliptic_ring(R, r, slices, turnHeight);
}