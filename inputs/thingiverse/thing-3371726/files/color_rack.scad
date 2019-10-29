// Customizeable Color-Bottle-Stand
// by rieses3d - License: CC BY-SA

// v2 - Changes: Side Plate calculation error fixed

// Generate
mychoice = 4; // [0: "Stop Plate", 1: "Bottom Plate", 2: "Side Plate", 3: "Supports", 4: "Preview"]

//Bottle Diameter
 bottleDiameter = 38.5; 
//bottleDiameter = 35; // vallejo pigments

// Bottle count for each row
cols = 5;  
// Number of rows
rows = 4; 
// Elevation for each row
stepSize = 20;
// Height from bottle bottom to stop plate in each row
stopPlateHeight = 25;
// Space between the bottles (col)
spaceBetweenBottles = 3;
// Space between the bottles (row)
spaceBetweenBottlesRow = 5;
// Plate Height = Slot Height
plateHeight = 2;
slotHeight = plateHeight;
// Size of the Slots (should be < 1)
slotWidthFactor = 0.8;
tw = cols * (bottleDiameter + spaceBetweenBottles);
// Add this to the slotsize
delta = 0.15;
// Angle of cut on side plates - 90 for no cut
angle = 25;

//Hidden
$fn=50*1;
lb=0.02*1;
lm=0.01*1;

if(mychoice == 0) {
    sorter();
}

if(mychoice == 1) {
    baseplate();
}

if (mychoice == 2) {
    rotate([0,90,0]) {
        sideplate(-plateHeight);
    }
}

if (mychoice == 3) {
    for (i = [0 : rows - 2])
    { 
        translate([i*(bottleDiameter*0.75+5),0,0]) {
           cube([bottleDiameter*0.75,(i+1)*stepSize,plateHeight]);
            translate([(bottleDiameter*0.75-bottleDiameter*0.75*slotWidthFactor)/2,(i+1)*stepSize,0])
              cube([bottleDiameter*0.75*slotWidthFactor,slotHeight/2,plateHeight]);
        }
    }
}

if (mychoice == 4) {
    sideplate(-plateHeight);
    sideplate(tw);
    for( i = [0 : rows-1]) {      
           translate([0,i*(bottleDiameter+spaceBetweenBottlesRow),(i*stepSize)+stopPlateHeight])
               sorter(delta);
           if (i > 0)
               translate([0, i*(bottleDiameter+spaceBetweenBottlesRow)-bottleDiameter/2.25,i*stepSize])
                  baseplate(delta,1);
    }
}
  
module sorter(delta=0) {
    slots(tw,bottleDiameter/2+spaceBetweenBottles,delta);
    difference() {    
        cube([tw,bottleDiameter/2+spaceBetweenBottles,plateHeight],center=false);
        for (i = [0 : cols - 1 ]) {
            translate([(bottleDiameter+spaceBetweenBottles)/2+i*(bottleDiameter+spaceBetweenBottles),0,-lm]) {
                cylinder(d=bottleDiameter,h=plateHeight+lb,center=false);
            }
        }
    }
}

module baseplate(delta = 0, noslot = 0) {
    slots(tw,bottleDiameter*0.75,delta);
    difference(tw,bottleDiameter*0.75) {
        cube([tw,bottleDiameter*0.75,plateHeight],center=false);
        if (noslot == 0) {
            for(i = [0 : cols - 1]) {
                translate([(bottleDiameter+spaceBetweenBottles)/2+i*(bottleDiameter+spaceBetweenBottles),(bottleDiameter*0.75-slotWidthFactor*bottleDiameter*0.75)/2,plateHeight/2]) {
                    cube([slotHeight, slotWidthFactor*bottleDiameter*0.75, plateHeight]);
                }
            }
        }
    }
}

module slots(x,y,delta) {
    for(a = [[-slotHeight,(y-slotWidthFactor*y)/2,0],[x,(y-slotWidthFactor*y)/2,0]]) {
        translate(a) {
            cube([slotHeight,slotWidthFactor*y+delta,plateHeight+delta]);
        }
    }
}


module sideplate(offset) {
    difference() { 
        translate([offset,0,0]) {
            cube([plateHeight,(rows-1)*(bottleDiameter+spaceBetweenBottlesRow)+bottleDiameter/2+2*spaceBetweenBottles,rows*20+25]);
        }    
        for( i = [0 : rows-1]) {      
            translate([0,i*(bottleDiameter+spaceBetweenBottlesRow),(i*stepSize)+stopPlateHeight])
                sorter(delta);
            if (i > 0)
                translate([0, i*(bottleDiameter+spaceBetweenBottlesRow)-bottleDiameter/2.25,i*stepSize])
                    baseplate(delta);
        }
    
       translate([offset-lm,0,stopPlateHeight+spaceBetweenBottlesRow])
    rotate([angle,0,0])
        cube([plateHeight+lb,(rows+1)*(bottleDiameter+spaceBetweenBottlesRow),rows*stepSize+stopPlateHeight]);
    }
 }
