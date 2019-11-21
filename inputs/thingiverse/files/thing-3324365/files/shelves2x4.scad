/* [Parameters] */
parts = 1; // [1:preview, 2:plated, 3: sides_only, 4: shelf_only]

width = 55;
height = 40;
depth = 25;
numShelves = 2;

/* [Hidden] */
boardWidth = 4.8;
boardThick = 1.2;

boardGap = 0.8;

nozzleWidth = 0.4;

clearance = 0;

function getShelfSpacing(h, num) = floor((h - boardWidth)/num);
 

module side(w, h, num)
{
    w2 = w - ((boardGap+boardWidth)*2);
    h2 = h - ((boardGap+boardWidth)*2);
    
    shelfSpacing = getShelfSpacing(h, num);
    
    union() {
        // vertical sides 
        cube([h, boardWidth, boardThick*2]);
        
        translate([0, w-boardWidth, 0])
        cube([h, boardWidth, boardThick*2]);

        // horizaontal sides
        translate([0, boardWidth+boardGap, 0])
        cube([boardWidth, w2, boardThick*2]);
        cube([boardWidth, w, boardThick]);

        translate([h-boardWidth, boardWidth+boardGap, 0])
        cube([boardWidth, w2, boardThick*2]);
        translate([h-boardWidth, 0, 0])
        cube([boardWidth, w, boardThick]);
        
        theta = -atan(w/h);
        
        intersection() {
            translate([h/2, w/2, boardThick])
            rotate([0,0,theta])
            cube([h*2, boardWidth, boardThick*2], center=true);
            
            translate([h/2, w/2, 0])
            cube([h2, w2, boardThick * 5], center=true); 
        }
        
        intersection() {
            translate([h/2, w/2, boardThick])
            rotate([0,0,theta])
            cube([h*2, boardWidth, boardThick*2], center=true);
            
            translate([h/2, w/2, 0])
            cube([h2, w, boardThick], center=true); 
        }
        

        for (i=[1:num]) {
            translate([(i*shelfSpacing)-boardThick*2-clearance,0,-boardThick*2])
            cube([boardThick,boardWidth,boardWidth]);
            
            translate([(i*shelfSpacing)+boardThick*2+clearance,0,-boardThick*2])
            cube([boardThick,boardWidth,boardWidth]);

            translate([(i*shelfSpacing)-boardThick*2-clearance,w-boardWidth,-boardThick*2])
            cube([boardThick,boardWidth,boardWidth]);
            translate([(i*shelfSpacing)+boardThick*2-clearance,w-boardWidth,-boardThick*2])
            cube([boardThick,boardWidth,boardWidth]);
        }
        
    }
}

module single_shelf(w, d) {
    numFullBoards = floor(d/(boardWidth+boardGap));
    
    leftOver = d - (boardWidth*numFullBoards) - (boardGap*(numFullBoards));
    
    finalBoardWidth = floor(leftOver/nozzleWidth) * nozzleWidth;

    totalRealDepth = numFullBoards * (boardWidth + boardGap) + finalBoardWidth - boardGap;
        
    union() {
        for (i=[0:numFullBoards-1]) {
            translate([0, i*(boardWidth+boardGap), 0])
            cube([w, boardWidth, boardThick*2]);
        }
        
        translate([0, numFullBoards*(boardWidth+boardGap), 0])
        cube([w, finalBoardWidth, boardThick*2]);
        
        
        // supports
        translate([0,0,-boardThick+0.01])
        cube([boardWidth, totalRealDepth, boardThick*2]);

        translate([w-boardWidth,0,-boardThick+0.01])
        cube([boardWidth, totalRealDepth, boardThick*2]);
    }
}

module shelves(w, h, d, num)
{
    translate([0,0,0])
    rotate([0,-90,0])
    
    side(d, h, num);
    
    translate([w,0,0])
    rotate([0,-90,0])
    scale([1,1,-1])
    side(d,h, num);
    
    shelfSpacing = getShelfSpacing(h, num);
    
    for (i=[1:num])
    {
        translate([0,0,i*shelfSpacing])
        single_shelf(w,d);
    }
}

module shelf_plated(w, h, d, num)
{
    translate([w*1.2,0,0])
    sides_plated(w,h,d,num);
    
    off = ((num * d) + (num-1)*(d*0.2))/2;
    
    for (i=[0:num-1]) 
    {
        translate([0,i*1.2*d-off+d,0])
        single_shelf_plated(w,h,d);
    }
}

module sides_plated(w, h, d, num)
{
    translate([0,0,boardThick*2])
    rotate([180,0,0])
    side(d,h,num);
    
    translate([0,d*0.2,boardThick*2])
    rotate([180,0,0])
    scale([1,-1,1])
    side(d,h,num);  

}

module single_shelf_plated(w, h, d)
{
    translate([0,0,boardThick*2])
    rotate([180,0,0])
    single_shelf(w,d);
}

// preview
if (parts == 1) {
    translate([-width/2, -depth/2, 0])
    shelves(width, height, depth, numShelves);
}

// plated
if (parts == 2) {
    moveby = (width*1.2 + height)/2;
    translate([-moveby, 0, 0])
    shelf_plated(width, height, depth, numShelves);
}

// just sides
if (parts == 3) {
    sides_plated(width, height, depth, numShelves);
}

// just shelf
if (parts == 4) {
    single_shelf_plated(width, height, depth);
}


