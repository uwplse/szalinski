// City Builder
// Copyright (c) 2019 Michael S. Scherotter
// synergist@outlook.com
// Version 0.1

// Number of avenues (x)
numAvenues = 5; // [2:10]

// Number of streets (y)
numStreets = 4; // [2:10]

// Street width in meters
streetWidth = 16; // [6:20]

// Sidewalk width in meters
sidewalkWidth = 3;

// Block width in meters (x)
blockWidth = 20; // [12:60]

// Block height in meters (y)
blockHeight = 40; // [12:60]

// Maximum car length in meters
maxCarLength = 4; // [3,6]

// Wall thickness for buildings 
wallThickness = 2; //[4,8]

city();

module city(){
    buildingHeights = rands(0,100,(numStreets - 1) * (numAvenues-1));
    echo(buildingHeights, " heights");
    union()
    {
        difference() {
            union(){
                ground();
                buildings(buildingHeights);
            //buildingHollows(buildingHeights);
            }
            streets();
            avenues();
            buildingHollows(buildingHeights);
        }
        cars();

    }
}

module cars(){
    
    blocks = 10 * (numStreets) * (numAvenues);
    carCount = rands(blocks * .9, blocks, 1)[0];
    
    for (i=[0:carCount])
    {
        onAvenue = round(rands(0,1,1)[0]);
        
        lane = round(rands(0,3,1)[0]);
        
        laneSize = (streetWidth - (sidewalkWidth * 2) - 0.5) / 4;
        
        if (onAvenue == 0){
            avenue = round(rands(0, numAvenues-1, 1)[0]);
            streetDim = rands(0, streetWidth + (numStreets-1) * (blockHeight + streetWidth) - maxCarLength, 1)[0];
            translate([1.5 + avenue * (blockWidth + streetWidth) - streetWidth / 2, streetDim, 1.9])
            translate([-laneSize * lane, -streetWidth, 0])
                car();
        } else {
            street = round(rands(0, numStreets-1, 1)[0]);
            avenueDim = rands(0, streetWidth + (numAvenues-1) * (blockWidth + streetWidth) - maxCarLength, 1)[0];
            translate([avenueDim, street *(blockHeight + streetWidth) - streetWidth / laneSize*2, 1.9])
                translate([-streetWidth + maxCarLength,laneSize * lane, 0])
                    rotate(a=90, v=[0,0,1])
                car();
        }
    }
}

module car(){
    scale([2, rands(2,maxCarLength,1)[0], rands(1,2.5, 1)[0]])
        cube ();
}

module streets(){
    c=0;
    translate([-streetWidth-1,-streetWidth-1,2])
    for (r=[0:numStreets])
        //for (c=[0:numAvenues])
            translate([c*(blockWidth + streetWidth),
                       r *(blockHeight + streetWidth) + sidewalkWidth,
                        0])
            scale([(numAvenues) * (streetWidth + blockWidth) + streetWidth + 2,
                   streetWidth - (sidewalkWidth * 2), 3])
            cube();
}

module avenues(){
    r=0;
    translate([-streetWidth-1,-streetWidth-1,2])
        for (c=[0:numAvenues + 1])
            translate([c*(blockWidth + streetWidth) + sidewalkWidth,
                       0,
                        0])
            scale([streetWidth - (sidewalkWidth * 2), (numStreets + 1) * (streetWidth + blockHeight) + streetWidth + 2,
                   , 3])
            cube();
}

module ground(){
    translate([-streetWidth, -streetWidth, 0])
        scale([(numAvenues-1) * (streetWidth + blockWidth) + streetWidth,
            (numStreets-1) * (streetWidth + blockHeight) + streetWidth, 3])
            cube();
}

module buildings(buildingHeights){

    for (r=[0:numStreets-2])
        for (c=[0:numAvenues-2])
            translate([c*(blockWidth + streetWidth),
                        r*(blockHeight + streetWidth),
                        1])
        {
            index = r*(numStreets-2) + c;
            echo ("row ", r, " col ", c, " index", index);
                building(buildingHeights[index]);
        }
}

module building(height){
    //height = rands(0, 100, 1)[0];
    
    if (height > 50) {
        difference()
        {
            buildingMass(height);
            mullions(height);
            
        }
    } else {
        buildingMass(height);
    }
}


module buildingMass(height){
    scale([blockWidth, blockHeight, height])
        cube();
}

module buildingHollow(height){
    echo("Building height: ", height);
    innerWidth = blockWidth - (wallThickness * 2);
    innerHeight = blockHeight - (wallThickness * 2);
    innerCubeHeight = height - wallThickness - innerHeight / 2;

    translate([wallThickness, wallThickness, -2])
        scale([innerWidth, innerHeight, 1+ innerCubeHeight])
        cube();
    translate([ wallThickness+innerWidth/2,wallThickness+innerHeight/2,innerCubeHeight])
        rotate(a=90, v=[0,1,0])
            cylinder(h=innerWidth, r1 = innerHeight / 2, r2 = innerHeight/2, center=true);
}

module buildingHollows(buildingHeights){
    for (r=[0:numStreets-2])
        for (c=[0:numAvenues-2])
            translate([c*(blockWidth + streetWidth),
                        r*(blockHeight + streetWidth),
                        1])
            {
                index = r*(numStreets-2) + c;
                
                buildingHollow(buildingHeights[index]);
            }
}
    
module mullions(height){
    cladding =  round(rands(0,1,1)[0]);
    windowWidth = rands(2,5,1)[0];
    floorHeight = rands(2,5,1)[0];
    
    translate([0,-1.5,0])
    if (cladding == 0){
        mullion(height, blockWidth, windowWidth);
    }else{
        translate([0,0.4,0])
        floors(height, blockWidth, floorHeight);
    };
    
    rotate(a=90, v=[0,0,1])
        translate([0,0,0])
        if (cladding == 0){
            mullion(height, blockHeight, windowWidth);
        } else         {
           //translate([0,0,0])
              floors(height, blockHeight, floorHeight);
        }
        
    translate([0, blockHeight,0])
        if (cladding == 0) {
            mullion(height, blockWidth, windowWidth);
        } else {
            floors(height, blockWidth, floorHeight);
        };
        
    rotate(a=90, v=[0,0,1])
            translate([0, -blockWidth-1.5,0])
        if (cladding == 0){
            mullion(height, blockHeight, windowWidth);
        } else {
            translate([0,0.4,0])
            floors(height, blockHeight, floorHeight);
        }
}

module mullion(height, width, windowWidth){
    mullionWidth = 0.25;
    numWindows = floor((width - mullionWidth) / (windowWidth + mullionWidth));
    windowArea = numWindows * windowWidth;
    diff = width - windowArea;
    modifiedMullionWidth = diff / (numWindows + 1);

    for (r=[0: numWindows-1])
        translate([modifiedMullionWidth +( windowWidth + modifiedMullionWidth) * r, -.2, 0])
        scale([windowWidth, 2, height + 1])
        cube();
}

module floors(height, width, floorHeight){
    floorThickness = 1;
    numFloors = floor(height/(floorHeight + floorThickness));
    floorArea = numFloors * floorHeight;
    diff = height - floorArea;
    modifiedFloorThickness = diff / (numFloors + 1);
    for (h=[0:numFloors - 1])
        translate([0,-0.2, 
            modifiedFloorThickness + (floorHeight + modifiedFloorThickness) * h])
            scale([width, 1.5, floorHeight])
            cube();
}    