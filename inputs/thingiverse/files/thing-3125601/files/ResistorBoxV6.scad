//STACKABLE RESISTOR STORAGE BOX [Customizable]
//Created by Bram Vaessen 2018


// preview[view:south, tilt:top diagonal]

// Which one would you like to see?
part = "single"; //[single:Single Box <no stacking>), drawer: Drawer, customDrawer: Custom Drawer, topLeft:Box Top Left, topMiddle:Box Top Middle, topRight:Box Top Right, middleLeft:Box Middle Left, middleMiddle:Box Middle Middle, middleRight:Box Middle right, bottomLeft:Box Bottom Left, bottomMiddle:Box Bottom Middle, bottomRight:Box Bottom Right,  topSC:Box Top <Single Column Stacking>, middleSC:Box Middle <Signle Column Stacking>, bottomSC:Box Bottom <Signle Column Stacking>, leftSR:Box Left <Single Row Stacking>, middleSR:Box Middle <Single Row Stacking>, rightSR:Box Right <Single Row Stacking>, connector:Connector <for stacking>, info:INFO <Show Box/Drawer/Label sizes>]


/* [Basic Setup] */
//The width (mm) of a single compartment in a drawer (ignored with 'Custom Sized Box')
compartWidth = 20;
//The depth (mm) of a single compartment in a drawer (ignored with 'Custom Sized Box')
compartDepth = 62;
//The height (mm) of a single compartment in a drawer (ignored with 'Custom Sized Box')
compartHeight = 15;

//The number of compartments in the drawer next to each other
compartXCount = 3;
//The numberof compartments in the drawer behind each other
compartYCount = 1;

//The number of drawers on top of each other
drawRows = 4;
//The number of columns of drawers next to eachother
drawCols = 1;

//The style of the handle on the drawers
handleStyle = 0; //[0:Normal, 1:Thin Handle]

//Add holes to the back of the box for mounting it on a wall or panel?
mountHoles=0; //[0:No, 1:Yes]


/* [Custom Drawer] */
//The number of compartments in the drawer next to each other (custom drawer)
cdrawXCount=1;
//The number of compartments in the drawer behind each other (custom drawer)
cdrawYCount=1;

/* [Custom Sized Box] */
//Provide a custom size for the box? Overrides/ignores compartment size!
useCustomBox = 0; //[0:No, 1:Yes]
//the width (mm) of the box
customBoxWidth = 73.06;
//the depth (mm) of the box
customBoxDepth = 67.2;
//the height (mm) of the box
customBoxHeight = 74.64;

/* [Tolerances] */
//the amount of extra space (mm) on the side of the drawers, on each side (reprint box after changing, unless using 'custom sized box', then reprint drawer)
drawHorSpace = 0.25;
//the amount of extra space (mm) on top and bottom of drawers, on each side (reprint box after changing, unless using 'custom sized box', then reprint drawer)
drawVertSpace = 0.35;
//the amount of extra space (mm) on the behind the drawer (reprint box after changing, unless using 'custom sized box', then reprint drawer)
drawBackSpace = 0.2;
//the amount  (mm) to shrink the drawer in height and width to fit more easily (reprint drawer after changing). TOLERANT drawers use 0.2mm.
drawShrink = 0.0;


/* [Your Printer Settings] */
//the layer width that you print with (0.48 is normal for 0.4 nozzle)
layerWidth=0.48;
//the layer height that you print with 
layerHeight=0.2;


///////////////////////////////////////////////////


/* [Hidden] */
grooveHeight = 5;
grooveDepth = 1* layerWidth;
smoothRadius=1.5;
smoothQuality=16;

boxColumnSpace = layerWidth*2;

drawDividerWidth = 2*layerWidth;
drawOutsideWidth = 4*layerWidth;
drawBottomHeight = 4*layerHeight;

drawFrontExtraWidth=1;
drawFrontExtraHeight = 2*layerHeight;

drawFrontExtra = max(0, smoothRadius - drawOutsideWidth);

boxOutsideWidth = 5*layerWidth;
boxDividerWidth = 2*layerWidth;
boxBackDepth = (mountHoles==1)?CorrectedHeight(3):CorrectedHeight(1);


//if custom box size, reverse calculations
customBoxColumnWidth = (customBoxWidth +boxOutsideWidth*(drawCols-1) -  boxOutsideWidth + boxDividerWidth)/drawCols;
customBoxDrawSpaceX = customBoxColumnWidth - drawFrontExtraWidth*2 - boxOutsideWidth - boxColumnSpace;

customBoxDrawSpaceY = customBoxDepth - boxBackDepth - drawFrontExtra;
customBoxDrawSpaceZ = (customBoxHeight - boxOutsideWidth*2)/drawRows - boxDividerWidth;

customDrawWidth = customBoxDrawSpaceX - drawHorSpace*2;
customDrawDepth = customBoxDrawSpaceY - drawBackSpace;
customDrawHeight = customBoxDrawSpaceZ - drawVertSpace*2;

customCompartWidth = (customDrawWidth - drawOutsideWidth*2 - drawDividerWidth*(compartXCount-1)) / compartXCount;
customCompartDepth = (customDrawDepth - drawOutsideWidth*2 -drawDividerWidth*(compartYCount-1))/compartYCount;
customCompartHeight = customDrawHeight-drawBottomHeight;

compartWidthF = useCustomBox ? customCompartWidth : compartWidth;
compartDepthF = useCustomBox ? customCompartDepth : compartDepth;
compartHeightF = useCustomBox ? customCompartHeight : compartHeight;


drawWidth = drawOutsideWidth*2 + drawDividerWidth*(compartXCount-1) + compartWidthF*compartXCount;
drawDepth = drawOutsideWidth*2 + drawDividerWidth*(compartYCount-1) + compartDepthF*compartYCount;

//check differences between desired drawer height and corrected drawer height and add to spacer
drawHeight = CorrectedHeightDown(drawBottomHeight + compartHeightF);
drawHeightU = drawBottomHeight + compartHeightF;
drawHeightD = (drawHeightU - drawHeight) / 2;
drawVertSpaceC = drawVertSpace+drawHeightD;




boxDrawSpaceX = drawWidth + drawHorSpace*2;
boxDrawSpaceY = drawDepth + drawBackSpace;
boxDrawSpaceZ = drawHeight + drawVertSpaceC*2;

boxColumnWidth = boxDrawSpaceX + drawFrontExtraWidth*2 + boxOutsideWidth + boxColumnSpace;

boxWidth = boxColumnWidth * drawCols - boxOutsideWidth*(drawCols-1) + boxOutsideWidth - boxDividerWidth;
boxDepth = CorrectedHeight(boxBackDepth + boxDrawSpaceY + drawFrontExtra);
boxHeight = drawRows*(boxDrawSpaceZ + boxDividerWidth)+ boxOutsideWidth*2;




////



drawFrontWidth = drawWidth + drawFrontExtraWidth*2;
drawFrontHeight = drawHeight + drawFrontExtraHeight;

handleWidth = lerp(max(15,drawFrontWidth/3.5), drawFrontWidth/12, handleStyle);
handleHeight1 = min(drawFrontHeight - smoothRadius*2,handleWidth) ;
handleHeight2 = drawFrontHeight - smoothRadius*2;
handleHeight = handleStyle ? handleHeight2 : handleHeight1;


handleDepth = handleHeight*0.5;
handleThickness = layerWidth*4;

labelFrameWidth = (drawFrontWidth - handleWidth - smoothRadius*4)/2;
labelFrameHeight = drawFrontHeight - smoothRadius*2;
labelFrameDist = -drawFrontWidth / 2 + smoothRadius + labelFrameWidth/2;
labelFrameThickness = 2*layerWidth;
labelFrameEdgeSize = 2.5;
labelFrameSpace = 0.8;
labelFrameDepth = labelFrameThickness+labelFrameSpace;

connectorWidth = 4;
connectorMid = 3* layerHeight;
connectorSide = 5*layerHeight;
connectorLength = boxDepth/3*2;
connectorSpacer = 0.35;
connectorDist = 0.5/5*3.25;

stopperDepth = CorrectedHeight(1.2);
stopperSteps = stopperDepth / layerHeight;
stopperHeight = layerWidth*stopperSteps*0.8;
stopperWidth = stopperHeight*1.5;
stopperStart = 2;



mountholeSize1=4;
mountholeSize2=8;
mountholeDepth1 = 2.5;
mountholeDepth2 = 5;

print_part();

module print_part()
{
	if (part == "single") 
        rotate([-90,0,0]) Box();
    if (part == "drawer") 
        Drawer();
    if (part == "customDrawer")
        CustomDrawer();
    if (part == "topLeft") 
        rotate([-90,0,0]) Box(boxRight="connector", boxBottom="connector");
    if (part == "topMiddle") 
        rotate([-90,0,0]) 
            Box(boxLeft="connector", boxRight="connector", boxBottom="connector");
    if (part == "topRight") 
        rotate([-90,0,0]) Box(boxLeft="connector", boxBottom="connector");
    if (part == "middleLeft") 
        rotate([-90,0,0]) 
            Box(boxRight="connector", boxBottom="connector", boxTop="connector");
    if (part == "middleMiddle") 
        rotate([-90,0,0]) 
            Box(boxLeft="connector", boxRight="connector", 
                boxBottom="connector", boxTop="connector");
    if (part == "middleRight") 
        rotate([-90,0,0]) 
            Box(boxLeft="connector", boxBottom="connector", boxTop="connector");
    if (part == "bottomLeft") 
        rotate([-90,0,0]) Box(boxRight="connector", boxTop="connector");
    if (part == "bottomMiddle") 
        rotate([-90,0,0]) 
            Box(boxLeft="connector", boxRight="connector", boxTop="connector");
    if (part == "bottomRight") 
        rotate([-90,0,0]) 
            Box(boxLeft="connector", boxTop="connector");
    if (part == "topSC")
        rotate([-90,0,0]) Box(boxBottom="connector");
    if (part == "middleSC")
        rotate([-90,0,0]) Box(boxBottom="connector", boxTop="connector");
    if (part == "bottomSC")
        rotate([-90,0,0]) Box(boxTop="connector");
    if (part == "leftSR")
        rotate([-90,0,0]) Box(boxRight="connector");
    if (part == "middleSR")
        rotate([-90,0,0]) Box(boxLeft="connector", boxRight="connector");
    if (part == "rightSR")
        rotate([-90,0,0]) Box(boxLeft="connector");
    if (part == "connector")
        rotate([-90,0,0]) Connector();
    if (part == "info")
        Info();
}      


module Info()
{
    
    linear_extrude(height=0.2) union()
    {
        text(str("Box Size (mm): ",boxWidth, ", ",boxDepth,", ", boxHeight));
        translate([0,-20,0])
            text(str("Drawer Size (mm): ", drawWidth,", ", drawDepth,", ",drawHeight));
        translate([0,-40,0])
            text(str("Label Size (mm): ", labelFrameWidth-labelFrameThickness*2-1,", ", labelFrameHeight-labelFrameThickness-1));
        translate([0,-60,0])
            text(str("Compartment Size (mm): ", compartWidthF,", ", compartDepthF,", ",compartHeightF));
        
    }
}


module Connector()
{
    linear_extrude(height=connectorLength-5)
        polygon(points=[
            [-connectorWidth/2+connectorSpacer, -connectorMid],
            [-connectorWidth/2+connectorSpacer, connectorMid],
            [-connectorWidth/2 -connectorSide +connectorSpacer, connectorMid+connectorSide],
            [connectorWidth/2 + connectorSide -connectorSpacer, connectorMid+connectorSide],
            [connectorWidth/2 - connectorSpacer,  connectorMid],
            [connectorWidth/2 - connectorSpacer, -connectorMid],
            [connectorWidth/2 + connectorSide - connectorSpacer, -connectorMid-connectorSide],
            [-connectorWidth/2 - connectorSide + connectorSpacer, -connectorMid-connectorSide],
            ]);
    
        translate([0,0,connectorLength-5])
        linear_extrude(height=5, scale=[0.75, 1])
        polygon(points=[
            [-connectorWidth/2+connectorSpacer, -connectorMid],
            [-connectorWidth/2+connectorSpacer, connectorMid],
            [-connectorWidth/2 -connectorSide +connectorSpacer, connectorMid+connectorSide],
            [connectorWidth/2 + connectorSide -connectorSpacer, connectorMid+connectorSide],
            [connectorWidth/2 - connectorSpacer,  connectorMid],
            [connectorWidth/2 - connectorSpacer, -connectorMid],
            [connectorWidth/2 + connectorSide - connectorSpacer, -connectorMid-connectorSide],
            [-connectorWidth/2 - connectorSide + connectorSpacer, -connectorMid-connectorSide],
            ]);
            
        for (z=[6,connectorLength-6])

        translate([0,0,z])
            linear_extrude(height=1)
                polygon(points=[
                    [-connectorWidth/2+connectorSpacer, -connectorMid],
                    [-connectorWidth/2+connectorSpacer, connectorMid],
                    [-connectorWidth/2 -connectorSide+connectorSpacer/2, connectorMid+connectorSide],
                    [connectorWidth/2 + connectorSide-connectorSpacer/2 , connectorMid+connectorSide],
                    [connectorWidth/2 - connectorSpacer,  connectorMid],
                    [connectorWidth/2 - connectorSpacer, -connectorMid],
                    [connectorWidth/2 + connectorSide -connectorSpacer/2, -connectorMid-connectorSide],
                    [-connectorWidth/2 - connectorSide +connectorSpacer/2, -connectorMid-connectorSide],
                    ]); 
}

module MountHole()
{
    translate([0,-0.01,0]) 
    rotate([-90,0,0]) 
    {
        cylinder(d=mountholeSize2, d2=mountholeSize1, h = mountholeDepth1, $fn=32);
        translate([0,0,mountholeDepth1])
            cylinder(d=mountholeSize1, h=mountholeDepth2, $fn=32);
    }
}

function CorrectedHeight(height) = ceil(height/layerHeight)*layerHeight;
function CorrectedHeightDown(height) = floor(height/layerHeight)*layerHeight;    

module ConnectorCutout()
{
    
    len = connectorLength + 2;
    linear_extrude(height=len) 
        polygon(points=[
            [-connectorWidth/2, -connectorMid],
            [-connectorWidth/2, connectorMid],
            [-connectorWidth/2 -connectorSide, connectorMid+connectorSide],
            [connectorWidth/2 + connectorSide, connectorMid+connectorSide],
            [connectorWidth/2,  connectorMid],
            [connectorWidth/2, -connectorMid],
            [connectorWidth/2 + connectorSide, -connectorMid-connectorSide],
            [-connectorWidth/2 - connectorSide, -connectorMid-connectorSide],
            ]);
    
        scale([2,1.25,1])
        linear_extrude(height=5, scale=[.5, 1/1.25]) 
        polygon(points=[
            [-connectorWidth/2, -connectorMid],
            [-connectorWidth/2, connectorMid],
            [-connectorWidth/2 -connectorSide, connectorMid+connectorSide],
            [connectorWidth/2 + connectorSide, connectorMid+connectorSide],
            [connectorWidth/2,  connectorMid],
            [connectorWidth/2, -connectorMid],
            [connectorWidth/2 + connectorSide, -connectorMid-connectorSide],
            [-connectorWidth/2 - connectorSide, -connectorMid-connectorSide],
            ]);
    
}
//!Grooves(100,100);

module Grooves(width,height)
{
    areaHeight = height*0.85;
    areaWidth = width*0.95;
    holeHeight = .75* grooveHeight;
    h = grooveHeight + holeHeight;
    count = ceil((areaHeight+holeHeight)/h);
    space = (areaHeight - count*grooveHeight) / (count-1);
    startZ = -areaHeight/2 + grooveHeight/2;
    stepZ = space+grooveHeight;
        
    for (z=[0:count-1]) translate([0,0,startZ + z*stepZ])
    {
        hull()
        {
            for (x=[-1,1]) translate([x*(areaWidth/2 - grooveHeight),0,0])
                rotate([90,0,0])
                    cylinder(d=grooveHeight, h=grooveDepth, center=true, $fn=32);

            for (x=[-1,1]) translate([x*(areaWidth/2 - grooveHeight),0,0])
                rotate([90,0,0])
                    cylinder(d=grooveHeight-grooveDepth*2, h=grooveDepth*2, center=true, $fn=32);
        }
        
    }
}    

module Box(boxLeft="grooves", boxRight="grooves", boxTop="solid", boxBottom="solid")
{
    startX = -boxWidth/2 + boxOutsideWidth + drawFrontExtraWidth+ boxDrawSpaceX/2;
    stepX = boxColumnWidth - boxOutsideWidth;
    startZ = boxOutsideWidth;
    stepZ = boxDrawSpaceZ + boxDividerWidth;
    y= -boxBackDepth - boxDrawSpaceY/2;
    frontPanelWidth = boxDrawSpaceX+drawFrontExtraWidth*2;
    fontPanelHeight = drawRows*(boxDrawSpaceZ+boxDividerWidth);
    stopperY = CorrectedHeight(-boxDepth + smoothRadius + stopperStart);
    frontPanelInset = smoothRadius + drawFrontExtra + labelFrameDepth;
    stopperDist = drawWidth /2 -drawOutsideWidth - stopperWidth;
    insideCutWidth = (stopperDist -stopperWidth) * 2;
    insideCutHeight = stepZ * drawRows - smoothRadius*2;
    difference()
    {
        //main body of the box
        translate([0,0,boxHeight/2]) rotate([90,0,0])
            SmoothCube2([boxWidth, boxHeight, boxDepth]);
        
        //for each column
        for (x=[0:drawCols-1])
        {
            //cut out the drawer parts
            for (z=[0:drawRows-1])
                translate([startX+x*stepX,y-1,startZ + z*stepZ])
                    SmoothCube([boxDrawSpaceX, boxDrawSpaceY+2, boxDrawSpaceZ]);
            //cut out front part
            translate([startX+x*stepX,,-boxDepth-1,boxOutsideWidth+fontPanelHeight/2]) 
                SmoothPanel([frontPanelWidth, CorrectedHeight(frontPanelInset)+1, fontPanelHeight]);
        
            //cut out inside
            translate([startX+x*stepX, -boxBackDepth-smoothRadius,boxOutsideWidth]) 
                YMinCube([insideCutWidth, boxDepth, insideCutHeight]);
            
            //cutout mounting holes
            if (mountHoles)
            {
                for (x2=[-1,1])
                    translate([startX+x*stepX + x2*(boxDrawSpaceX/2-mountholeSize2*1.5), 
                           -boxBackDepth,
                           startZ + (drawRows-0.5)*stepZ])
                        MountHole();
                
                translate([startX+x*stepX, 
                           -boxBackDepth,
                           startZ + 0.5*stepZ])
                        MountHole();
            }
                
                
        }
        
        //add stuff like connectors
        if (boxLeft=="connector")
            for (z=[-1,1]) translate([-boxWidth/2, 0.0001, boxHeight/2 + z*boxHeight*connectorDist])
                rotate([90,90,0]) ConnectorCutout();
        else if (boxLeft=="grooves")
            translate([-boxWidth/2, -boxDepth/2, boxHeight/2])
                rotate([0,0,90]) Grooves(boxDepth-smoothRadius/2, boxHeight-smoothRadius/2);
        
        if (boxRight=="connector")
            for (z=[-1,1]) translate([boxWidth/2, 0.0001, boxHeight/2 + z*boxHeight*connectorDist])
                rotate([90,90,0]) ConnectorCutout();
        else if (boxRight=="grooves")
            translate([boxWidth/2, -boxDepth/2, boxHeight/2])
                rotate([0,0,90]) Grooves(boxDepth-smoothRadius/2, boxHeight-smoothRadius/2);
        
        if (boxBottom=="connector")
            for (x=[-1,1]) translate([x*boxWidth*connectorDist, 0.0001, 0])
                rotate([90,0,0]) ConnectorCutout();
        
        if (boxTop=="connector")
            for (x=[-1,1]) translate([x*boxWidth*connectorDist, 0.0001, boxHeight])
                rotate([90,0,0]) ConnectorCutout();
            
        
        
    }
    
    //add stoppers
    for (x=[0:drawCols-1]) for (z=[0:drawRows-1]) for (x2=[-1,1])
        translate([startX+x*stepX + x2*stopperDist,
                   stopperY,
                   startZ + z*stepZ + boxDrawSpaceZ])
            Stopper();
            
        
    
    //*for (x=[0:drawCols-1]) for (z=[0:drawRows-1])
    //    translate([startX+x*stepX,y - drawBackSpace/2 ,startZ + drawVertSpace + z*stepZ])
    //        Drawer();
    
}

module CustomDrawer()
{
    y = -drawDepth/2 + drawFrontExtra;
    z = drawHeight/2;
    

    indentWidth = drawWidth - drawOutsideWidth*2;
    indentDepth = drawDepth - drawOutsideWidth*2;
    
    ccompWidth = (indentWidth - (cdrawXCount-1)*drawDividerWidth) / cdrawXCount;
    ccompDepth = (indentDepth - (cdrawYCount-1)*drawDividerWidth) / cdrawYCount;
    
    startX = -drawWidth/2 + drawOutsideWidth + ccompWidth/2;
    startY = -drawDepth/2 + drawOutsideWidth + ccompDepth/2;
    stepX = ccompWidth + drawDividerWidth;
    stepY = ccompDepth + drawDividerWidth;
    
    difference()
    {
        DrawerBase();
        //cut out compartments
        for (x=[0:cdrawXCount-1]) for (y=[0:cdrawYCount-1])
            translate([startX + x*stepX, startY + y*stepY, drawBottomHeight])
                SmoothCube([ccompWidth, ccompDepth, compartHeightF+1]);
        //top indent for dividers
        translate([0,0,drawHeight-stopperHeight]) 
            SmoothCube([indentWidth, indentDepth, smoothRadius+1]);
    }
        
    if (handleStyle==0)
        translate([0,y,z]) Handle();
    if (handleStyle==1)
        translate([0,y,0]) HandleThin();
    for (x=[-1,1])
        translate([x*labelFrameDist,y,smoothRadius]) LabelFrame();
    
    
}

module Drawer()
{
    y = -drawDepth/2 + drawFrontExtra;
    z = drawHeight/2;
    
    echo(drawHeight);
    
    startX = -drawWidth/2 + drawOutsideWidth + compartWidthF/2;
    startY = -drawDepth/2 + drawOutsideWidth + compartDepthF/2;
    stepX = compartWidthF + drawDividerWidth;
    stepY = compartDepthF + drawDividerWidth;
    indentWidth = drawWidth - drawOutsideWidth*2;
    indentDepth = drawDepth - drawOutsideWidth*2;
    
    
    difference()
    {
        DrawerBase();
        //cut out compartments
        for (x=[0:compartXCount-1]) for (y=[0:compartYCount-1])
            translate([startX + x*stepX, startY + y*stepY, drawBottomHeight])
                SmoothCube([compartWidthF, compartDepthF, compartHeightF+2]);
        //top indent for dividers
        translate([0,0,drawHeight-stopperHeight]) 
            SmoothCube([indentWidth, indentDepth, smoothRadius+1]);
    }
        
    if (handleStyle==0)
        translate([0,y,z]) Handle();
    if (handleStyle==1)
        translate([0,y,0]) HandleThin();
    for (x=[-1,1])
        translate([x*labelFrameDist,y,smoothRadius]) LabelFrame();
    
    
}


module DrawerBase()
{
    translate([0,-drawFrontExtra/2,0])
                SmoothCube([drawWidth-drawShrink, drawDepth+drawFrontExtra, drawHeight-drawShrink]);
                //the front panel
            translate([0, -drawDepth/2 -drawFrontExtra , drawHeight/2+drawFrontExtraHeight/2])
                SmoothPanel([drawFrontWidth, smoothRadius, drawFrontHeight]);                
}



module Handle()
{
    for (x=[0,1]) mirror([x,0,0]) 
        translate([handleWidth/2-handleThickness,0]) rotate([90,0,90])
            linear_extrude(height=handleThickness)
            polygon(points=[[.01,-handleHeight/2-.01], [-handleDepth,0],[.01,handleHeight/2+.01]]);
    
    a = atan(handleDepth / (handleHeight/2));
    a2 = 90-a;
    
    d = handleThickness / sin(a);
    d2 = handleThickness / sin(a2);
    

    
    rotate([90,0,90])
        linear_extrude(height=handleWidth-0.01, center=true)
            polygon(points=[[-handleDepth,0],[.01,handleHeight/2+.01],[.01,handleHeight/2-d],
                         [-handleDepth+layerWidth*2,0]]); 
}

//!HandleThin(5);


module HandleThin()
{
    startDiam = handleWidth;
    endDiam = 0.85 * handleWidth;
    middleDiam = 0.4 * handleWidth;
    length = 2 * handleWidth;
    height = handleHeight - endDiam/3;

    difference()
    {
        cylinder(d=startDiam, h=height, $fn=32);
        translate([0,handleWidth+.01,0]) 
            cube([handleWidth*2, handleWidth*2, height*2.1], center=true);
    }
    difference()
    {
        union()
        {
            translate([0,-length,0]) cylinder(d=endDiam, h=height, $fn=32);
            translate([0,-length/2,0]) CenterCube([middleDiam, length,height]);
        }
        translate([0,-length-endDiam/2-handleWidth*.5,0]) rotate([45,0,0])
            cube([height,height,height*1.5], center=true);
    }
   
    translate([0,-length,height]) sphere(d=endDiam, $fn=32);
     
}
    


module LabelFrame()
{
    depth = labelFrameThickness + labelFrameSpace;
    
    difference()
    {
        translate([0,-depth/2+.01,0])
            CenterCube([labelFrameWidth, depth+.02, labelFrameHeight]);
        translate([0,0,labelFrameEdgeSize])
            CenterCube([labelFrameWidth-2*labelFrameEdgeSize, depth*3, labelFrameHeight]);
        translate([0,0,labelFrameThickness])
            CenterCube([labelFrameWidth-labelFrameThickness*2, labelFrameSpace*2, labelFrameHeight]);  

        
    }
    
    for (x=[0,1]) mirror([x,0,0]) 
    translate([0,-labelFrameSpace,0]) rotate([90,0,0]) linear_extrude(height=labelFrameThickness)
        polygon(points=[[-labelFrameWidth/2+labelFrameEdgeSize-0.01, labelFrameEdgeSize*2],
                        [-labelFrameWidth/2+labelFrameEdgeSize*2, labelFrameEdgeSize],
                        [-labelFrameWidth/2+labelFrameEdgeSize-0.01, labelFrameEdgeSize]]);
    
    ratio = layerHeight/ layerWidth;
    
    rotate([90,0,-90]) linear_extrude(height =labelFrameWidth, center=true) 
        polygon(points=[[0,0],[depth,0], [0,-depth*ratio*1.5]]);
}



module Stopper()
{
    for (i=[1:stopperSteps])
        translate([0,stopperDepth-(i-1)*layerHeight, 0]) rotate([90,0,0])
            linear_extrude(height=layerHeight)
                polygon(points=[[-stopperWidth*(i/stopperSteps),0],
                                [-stopperWidth/2*(i/stopperSteps),-stopperHeight*(i/stopperSteps)],
                                [stopperWidth/2*(i/stopperSteps),-stopperHeight*(i/stopperSteps)],
                                [stopperWidth*(i/stopperSteps),0]]);
    
}  

module CenterCube(size)
{
    translate([0,0,size[2]/2]) 
        cube(size=size,center=true);
}

module YMinCube(size)
{
    translate([0,-size[1]/2,0]) CenterCube(size);
}

module SmoothCube(size)
{
    sr2 = smoothRadius*2;
    hull()
    {
        
        translate([0,0,size[2]/2])
        {
            cube([size[0], size[1]-sr2, size[2]-sr2], center=true);
            cube([size[0]-sr2, size[1], size[2]-sr2], center=true);
            cube([size[0]-sr2, size[1]-sr2, size[2]], center=true);
        }
        
        for (x=[-1,1]) for (y=[-1,1])
        {
            translate([x*(size[0]/2-smoothRadius), y*(size[1]/2-smoothRadius), smoothRadius])
                sphere(r=smoothRadius, $fn=smoothQuality);
        }
        for (x=[-1,1]) for (y=[-1,1])
        {
            translate([x*(size[0]/2-smoothRadius), y*(size[1]/2-smoothRadius), size[2]-0.01])
                cylinder(r=smoothRadius, h=0.01, $fn=smoothQuality);
        }
        
    }
}

module SmoothCube2(size)
{
    sr2 = smoothRadius*2;
    hull()
    {

        for (x=[-1,1]) for (y=[-1,1])
        {
            translate([x*(size[0]/2-smoothRadius), y*(size[1]/2-smoothRadius), 0])
                cylinder(r=smoothRadius, h=size[2], $fn=smoothQuality);
        }
        
    }
}


module SmoothPanel(size)
{
    hull()
    {
        for (x=[-1,1]) for (z=[-1,1])
            translate([x*(size[0]/2-smoothRadius),0,  z*(size[2]/2-smoothRadius)])
                rotate([-90,0,0]) 
                    cylinder(r=smoothRadius, h=size[1], $fn=smoothQuality);
    }
}

function lerp(v1, v2, a) = (1-a)*v1 + a*v2;
