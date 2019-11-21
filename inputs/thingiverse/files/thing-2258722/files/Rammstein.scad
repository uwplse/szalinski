// Scale-factor for the Logo. (1 = 2cm) (Does not scale the plate-parameters.)
scale = 2;

// Be carefull: without a plate you get loose parts! (leave this 1)
plate = 1; // [1,0]

// Width of the plate (mm)
plateWidth = 1;

// Add (mm) to the plate on each side
plateAddLength = 1;

// 1 = the plate has round corners, 0 = the plate has NO round corners
plateRoundCorners = 1; // [1,0]

// radius for the round corners (mm)
plateRadius = 1;

// XPos for hole (mm)
plateHoleX = 3.5;

// YPos for hole (mm)
plateHoleY = 15;

// mm
plateHoleRadius = 2;

// Hidden
internalScale=0.01*1;
internalPlateWidth = plateWidth / internalScale / scale;
internalplateAddLength = plateAddLength / internalScale / scale;
internalPlateRadius = plateRadius / internalScale / scale;
internalPlateHoleX = plateHoleX / internalScale / scale;
internalPlateHoleY = plateHoleY / internalScale / scale;
internalPlateHoleRadius = plateHoleRadius / internalScale / scale;

width = 105*1;

base = 473*1;
biggerBase = base+width;
smallerBase = base-width;

rBase = biggerBase*1;

rShift = 121*1;

scale(scale*internalScale, scale*internalScale, scale*internalScale)
    rammstein();


module rammstein() {
        
    half();
    translate([0,-width,0]) 
        mirror([0,1,0]) 
            half();
    
    r();
    plate();
}

module plate() {
    length = base * 4 + width + internalplateAddLength*2 - (internalPlateRadius * 2 * plateRoundCorners);
   
    
    if (plate) {
        difference() {
            
            translate([-internalplateAddLength + (plateRoundCorners * internalPlateRadius),-length / 2 - width / 2,-internalPlateWidth]) {
                minkowski() {
                    cube([length,length,internalPlateWidth]);
                    if (plateRoundCorners) {
                        cylinder(r=internalPlateRadius);
                    }
                    
                };
            
            }
            translate([internalPlateHoleX, internalPlateHoleY])
                cylinder(h=internalPlateWidth*3, r=internalPlateHoleRadius, center=true);
        }
    }
}

module r() {
    // top
    translate([biggerBase-width,base,0])
        rotate([0,0,-90]) cube([width,biggerBase+width*0.5,width]);
    
    // left \
    difference() {
    
        translate([biggerBase + rShift,-biggerBase,0])
            rotate(20,0,0)cube([width,rBase,width]);
        
        translate([base,width * 0.5 ,-1])
                rotate([0,0,-90]) cube([width,width*2,width+2]); 
    };
    
    
     
    // right \
    difference() {
    
        translate([base * 2 + width*0.5,-width,0])
            rotate(20,0,0)translate([0,-biggerBase,0]) cube([width,biggerBase,width]);
        
        translate([biggerBase + rShift+ base / 2,-base-width,-1])
                rotate([0,0,-90]) cube([width,biggerBase,width+2]);  
    };
    
    
    // left
    translate([base,-biggerBase,0])
            cube([width,base+width*0.5,width]);
 
    
    //bottom
    translate([biggerBase + rShift,-base,0])
            rotate([0,0,-90]) cube([width,biggerBase-width,width]);
    
    // right
    translate([biggerBase*2-width*0.5-width,-width,0])
            cube([width,biggerBase,width]);
}

module half() {
    cube([width,base,width]);
    
    translate([0,base,0])
        rotate([0,0,-90]) cube([width,biggerBase,width]);
    
    translate([base,biggerBase,0])
        cube([width,smallerBase,width]);
    
    translate([base,base*2,0])
        rotate([0,0,-90]) cube([width,base,width]);
    
    translate([base*2+width,base*2,0])
        rotate([0,0,-90]) cube([width,base,width]);
    
    translate([base*3,smallerBase,0])
        cube([width,biggerBase,width]);
    
    translate([base*3,base,0])
        rotate([0,0,-90]) cube([width,biggerBase,width]);
    
    translate([base*4,0,0])
        cube([width,base,width]);
        
    translate([base*4,-biggerBase,0])
        cube([width,base,width]);
    
}