// Parametric Watercolor Palette for standard half-pan watercolors
// Created by Michael S. Scherotter 
// Copyright (c) 2019 Michael S. Scherotter
// Use wire construction flags for hinge pins

// watercolor pan width
panWidth = 15.7; // [15:17]

// watercolor pan height
panHeight = 19;  // [18:20]

// watercolor pan depth
panDepth = 9.5;  // [9:11]

// number of columns
panColumns = 3; // [1:10]

// number of rows
panRows = 3;    // [1:10]

// spacing between pans
spacing = 2;    // [1:5]

// gap between hinge pieces
hingeGap = 0.1;

hingeSegments = 5; // [3:8]
// corner fillet
filletRadius = 2; // [1:3]

// hinge thickness
hingeThickness = 1.5;

// pin diameter
pinDiameter = 2.5; 

module pan(panWidth, panHeight, panDepth){
    scale([panWidth, panHeight, panDepth])
    cube();
}

module pans(panRows, panColumns, panWidth, panHeight, panDepth){
for(r = [0: panRows-1]) 
    for (c=[0: panColumns-1]) 
        translate([c*(panWidth + spacing), r*(panHeight+spacing), 0])
            pan(panWidth, panHeight, panDepth);
}

module tray(panWidth, panHeight, panColumns, panRows, panDepth){
    echo("trays:", panWidth, panHeight, panColumns, panRows, panDepth);
    scaleX = spacing+(panWidth +spacing) * panColumns;
    scaleY = spacing + spacing+(panHeight+spacing) * panRows;
     echo("trayWidth", scaleX);
    echo("trayHeight", scaleY);
    translate([-spacing,-spacing * 2,-spacing])
        scale([scaleX, scaleY, panDepth])
        cube();
}

module fillet(length){
    
    difference()
    {
        scale([filletRadius+0.1, filletRadius+0.1, length])
            cube();
       translate([0,0,-1]) 
       cylinder(length+2, r=filletRadius, $fn=20);
    }
}

module topHinge(start, center, gap)
{
    tx = panColumns * panWidth  +15;
    ty = -spacing - pinDiameter -2;
    tz = 2;
    hinge(tx, ty, tz, start, center, gap);
}

module top(){
    echo("top");
    mixingColumns = ceil(panColumns / 2);
    mixingRows = ceil(panRows / 2);
    
    bottomWidth = spacing+(panWidth +spacing) * panColumns;
    bottomHeight = spacing+(panHeight+spacing) * panRows - (pinDiameter + 1);
    echo("bottomWidth", bottomWidth);
    echo("bottomHeight", bottomHeight);
    mixingWidth = ((bottomWidth  - spacing) / mixingColumns) - spacing;
    mixingHeight = ((bottomHeight- spacing) / mixingRows) - spacing;
    echo("mixingHeight", mixingHeight);
    translate([0,pinDiameter+2,0])
    difference()
    {
        union()
        {
            translate([panColumns * panWidth + 15,-1,0])
                buildCels(mixingWidth, mixingHeight, 4, mixingColumns, mixingRows);
            topHinge(1, true, hingeGap);
        }
        topHinge(0, false, -hingeGap);
    }
}

module bottomHinge(start, gap){
    echo("bottomHinge", start, gap);
    hinge(0,-spacing, panDepth, start, true, gap);
}

module hinge(tx, ty, tz, start, center, gap){
    echo("hinge", tx,ty,tz,start,center,gap);
    hingeSegmentSize = ((panWidth + spacing) * panColumns - spacing) / hingeSegments;
    
    translate([tx,ty,tz])
    rotate(90, [0,1,0])
    union()
    {
        difference()
        {
            union()
            {
                for(i=[start:2:hingeSegments-1])
                    translate([0,0,hingeSegmentSize * i + gap])
                    cylinder(hingeSegmentSize - (gap * 2), d=pinDiameter+hingeThickness*2, $fn=20);
            };
            if (center)
            {
                translate([0,0,-1])
                cylinder((panWidth + spacing+2) * panColumns, d=pinDiameter, $fn=20);
            }
        };
    }
}

module pinHoles()
{
for(r = [0: panRows-1]) 
    for (c=[0: panColumns-1]) 
        translate([c*(panWidth + spacing) + panWidth / 2, r*(panHeight+spacing) + panHeight/2, -3])
            cylinder(4, d=pinDiameter, $fn=20);
}

module bottom(){
    echo("bottom");
    difference()
    {
        union()
        {
            buildCels(panWidth, panHeight, panDepth, panColumns, panRows);
            bottomHinge(0, hingeGap);
        }
        pinHoles();
        bottomHinge(1, -hingeGap);
    }
}

module bottomLongEdge(panWidth, panRows, panColumns)
{
    // bottom long edge  
    rotate(-90, [1,0,0])
    translate([(panWidth + spacing)*panColumns - filletRadius,0,0-(spacing*2)])
    fillet(panWidth * (panRows + spacing) + spacing + spacing + spacing);
}
    
module buildCels(panWidth, panHeight, panDepth, panColumns, panRows)
{
    difference()
    {
        tray(panWidth, panHeight, panColumns, panRows, panDepth);    
        pans(panRows, panColumns, panWidth, panHeight, panDepth);
        rotate(180)
            translate([0,spacing,-3])
                fillet(panDepth+2);
        translate([panColumns * (panWidth + spacing) - spacing,-spacing,-3])
            rotate(-90)
                fillet(panDepth+2);
        translate([0,panRows * (panHeight + spacing) - spacing, -3])
            rotate(90)
                fillet(panDepth + 2);
       translate([panColumns * (panWidth + spacing) - spacing,panRows * (panHeight + spacing) - spacing,-3])
           fillet(panDepth+2);
        rotate(90,[1,0,0])
        rotate(180)
        translate([0,0,-panWidth * (panRows+spacing) - spacing])
        fillet(panWidth * (panRows + spacing) + spacing + spacing + spacing);

         bottomLongEdge(panWidth, panRows, panColumns);   
    }
}

bottom();
top();