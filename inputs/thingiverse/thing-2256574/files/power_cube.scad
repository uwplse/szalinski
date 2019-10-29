/* [General] */
part = "bottom"; // [bottom, top]
// Size of your nozzle, multiples of this are used for wall widths
nozzle = 0.4;
// Clearance between top and bottom part
clearance = 0.05;
// Roundness of the corners
roundness = 2; // [0.1:0.1:3]

/* [5V PCB] */
boardLength = 33.5;
boardWidth = 29;
usbHeight = 7.7;
usbWidth = 15.5;
boardOffsetZ = 7;
boardHeight = 1.5;
boardScrewBase = 5;
screwOffsetX = 28.3;
screwOffsetY = 2.3;
screwRadius = 1;

usbOffset = 0.75;

/* [Battery Buzzer] */
pinOffsetZ = 5;
pinOffsetX = 0.5;
pinHeight = 3;
pinLength = 23;

displayLength = 22;
displayWidth = 12;
displayOffsetY = 6.5;
displayOffsetX = 0.25;

/* [XT60] */
xt60Wall = 0.5;
xt60Width = 8.6;
xt60Height = 16.1;
xt60TopWidth = 3;
xt60TopHeight = 3.4;
xt60Length = 16;

/* [Hidden] */
$fn=50;
side = boardLength;
walls = nozzle * 4;
sideOuter = side + walls * 2;

if(part == "bottom") {
    bottom();
}

if(part == "top") {
    top();
}

module xt60() {
    group() {
        hull() {
            cube([xt60Width, xt60Length, xt60Height - xt60TopHeight]);
        
            translate([(xt60Width - xt60TopWidth) /2,0, xt60Height - 0.1])
                cube([xt60TopWidth, xt60Length, 0.1]);
        }
        
        translate([xt60Wall, -10, xt60Wall])
        hull() {
        cube([xt60Width - xt60Wall *2, xt60Length, xt60Height - xt60TopHeight - xt60Wall * 2]);
    
        translate([(xt60Width - (xt60TopWidth - xt60Wall * 2)) / 2 - xt60Wall, 0, xt60Height - 0.1 -  xt60Wall * 2])
            cube([xt60TopWidth - xt60Wall * 2, xt60Length, 0.1]);
    }
    }
}

module top() {
    clearance = 0.1;
    connectorWidth = 0.4;
    connectorHeight = 1;

    difference() {
        baseTop(sideOuter / 2 + 2, connectorHeight);
        
        translate([walls + pinOffsetX, -1, walls + pinOffsetZ])
            cube([pinLength, walls+2, pinHeight]);
        
        translate([walls + displayOffsetX + pinOffsetX, displayOffsetY, -1])
            cube([displayLength, displayWidth, walls + 2]);
        
        translate([side + walls - xt60Width, walls/2, walls])
            xt60();
    }
    
    translate([side + walls - xt60Width, walls/2 + xt60Length, walls])
        cube([xt60Width, 2, 1.5]);
}

module baseTop(height, connectorHeight) {
    base(height);
    
    difference() {
        group() {
            translate([walls, walls, walls])
                cube([side, side, height - walls]);

            translate([nozzle * 3, nozzle * 3, walls])
                cube([side + nozzle * 2, side + nozzle * 2, height + connectorHeight - walls]);
        }

        translate([walls, walls, walls])
            cube([side, side, height + connectorHeight + 1]);
        
        translate([-1, -1, height])
            cube([5, 5, connectorHeight + 1]);
        
        translate([sideOuter - 5 + 1, -1, height])
            cube([5, 5, connectorHeight + 1]);
        
        translate([sideOuter - 5 + 1, sideOuter - 5 + 1, height])
            cube([5, 5, connectorHeight + 1]);
        
        translate([-1, sideOuter - 5 + 1, height])
            cube([5, 5, connectorHeight + 1]);
    }
}

module base(height) {
    difference(){
        hull() {
            translate([roundness, roundness, roundness])
                sphere(r=roundness);
                
            translate([sideOuter - roundness, roundness, roundness])
                sphere(r=roundness);

            translate([sideOuter - roundness, sideOuter - roundness, roundness])
                sphere(r=roundness);

            translate([roundness, sideOuter - roundness, roundness])
                sphere(r=roundness);

            translate([roundness, roundness, height])
                sphere(r=roundness);
                
            translate([sideOuter - roundness, roundness, height])
                sphere(r=roundness);

            translate([sideOuter - roundness, sideOuter - roundness, height])
                sphere(r=roundness);

            translate([roundness, sideOuter - roundness, height])
                sphere(r=roundness);
        }

        translate([walls, walls, walls])
            cube([side, side, side]);

        translate([-1, -1, height])
            cube([sideOuter + 2, sideOuter + 2, sideOuter]);
    }
}

module bottom() {
    height = sideOuter / 2 - 2;
    difference(){
        base(height);

        // USB cutouts
        translate([walls + usbOffset, walls - 2, walls])
            cube([usbWidth, walls + 2, usbHeight]);
        
        translate([walls + side - usbWidth - usbOffset, walls - 2, walls])
            cube([usbWidth, walls + 2, usbHeight]);
        
        translate([nozzle * 3 - clearance, nozzle * 3 - clearance, height-1.5])
            cube([side + (nozzle + clearance) * 2, side + (nozzle + clearance) * 2, side]);
    }
    translate([walls, walls + boardWidth, walls])
        cube([side, side-boardWidth, boardOffsetZ + boardHeight]);

    difference() {
        group() {
            translate([walls, walls + boardWidth-boardScrewBase, walls])
                cube([boardScrewBase, boardScrewBase, boardOffsetZ]);

            translate([walls + side - boardScrewBase, walls + boardWidth - boardScrewBase, walls])
                cube([boardScrewBase, boardScrewBase, boardOffsetZ]);
        }
        
        translate([walls + screwOffsetY, screwOffsetX, walls])
            cylinder(r=screwRadius, h = boardOffsetZ + 1);

        translate([walls + side - screwOffsetY, screwOffsetX, walls])
            cylinder(r=screwRadius, h = boardOffsetZ + 1);
    }
}