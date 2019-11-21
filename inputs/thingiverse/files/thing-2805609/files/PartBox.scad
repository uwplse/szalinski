//Created by Bram Vaessen 2017

//Which one would you like to see?
part = "box"; //[box:The Box, drawer:Drawer, emptyDrawer:Drawer without compartments/dividers (optional), handle:Handle for Drawer (optional), connector:Connector for Stacking (optional)]

/* [Basic Setup] */
//The width of a single compartment in a drawer
compWidth=20;
//The depth of a single compartment in a drawer
compDepth=25;
//The height of a single compartment in a drawer
compHeight=15;

//The number of compartments in a drawer next to each other
compXCount=3;
//The number of compartments in a drawer behind each other
compYCount=2;
//Number of drawers on top of each other
drawersPerArea=3;


/* [Drawer Options] */
//should the handle be printed in-place on the drawer (requires good bridging!)
attachHandle=1; //[1:Yes, 0:No]
//Should the drawers have stoppers?
drawerStopper=1; //[1:Yes, 0:No]
//The type of holder for a label (slide-in-frame, simple canvas, or none)
labelOption = "Frame"; //[Frame, Simple, None]
//Size the handle automatically? (ignores options below)
handleAutoSize=1; //[1:Yes, 0:No]
//the width of the handle (for non-auto-sized)
handleWidth=25; 
//the height of the handle (for non-auto-sized)
handleHeight=12; 
//the depth of the handle (for non-auto-sized)
handleDepth=8; 
//the thickness of the handle (for non-auto-sized)
handleThickness=1.5; 

/* [Stacking Options] */
//Add holes for stacking on the right side
stackRight=1; //[1:Yes, 0:No]
//Add holes for stacking on the left side
stackLeft=1; //[1:Yes, 0:No]
//Add holes for stacking on the top side
stackTop=1; //[1:Yes, 0:No]
//Add holes for stacking on the bottom side
stackBottom=1; //[1:Yes, 0:No]


/* [Multiple Drawer Areas] */
//The number of areas with drawers next to each other
areasXCount=1;
//The number of areas with drawers on top of each other
areasYCount=1;


/* [Fine Tuning] */
//the width of a single layer of your 3d printer (0.48 is normal for 0.4 nozzle)
layerWidth=0.48; 
//the layer height that you use to print
layerHeight=0.2; 
//space between drawer and box, applied to box, increase this if it the drawer doesn' fit
drawerSpacer=0.25;
//the amount of smoothing to do on the corners, don' make too large
smoothRadius=1.5; 
//the quality of the smoothing, higher=slower
smoothQuality=32; 

//the size of the gap to insert a label
labelHolderSpace = 0.75; 
//the size of the edge of the label holder
labelHolderEdgeWidth = 2.5; 

//extra amount of space between boxes for stacking, applied to connector
connectorPadding = 0.2; 
//extra room for the connector for stacking, applied to connector
connectorSpacing = 0.3; 

//the size of the drawer stopper
drawerStopperSize=1.25;


print_part();

module print_part() 
{
	if (part == "box")
    	Box();
	else if (part == "drawer")
		Drawer();
	else if (part == "connector")
		rotate([0,90,0]) Connector();
    else if (part == "handle")
        rotate([-90,0,0]) Handle();
    else if (part == "emptyDrawer")
        Drawer(empty=true);

}






///////////////////////////////////////

drawOutsideThick=layerWidth*3;
drawInsideThick=layerWidth*2;
drawBottomThick=CorrectedHeight(drawOutsideThick);

drawInsideLower=CorrectedHeight(1);



boxOutSideThick=1.5+layerWidth*4;
echo("layerwidth*5",layerWidth*5);
echo("layerwidth*6",layerWidth*6);
echo("layerwidth*7",layerWidth*7);

echo("1.5+layerwidth*2",1.5+layerWidth*2);
echo("1.5+layerwidth*3",1.5+layerWidth*3);
echo("1.5+layerwidth*4",1.5+layerWidth*4);



echo("boxOutSideThick",boxOutSideThick);


boxInsideThick=layerWidth*3;
boxBackThick=CorrectedHeight(boxOutSideThick);

drawXInsideCount = compXCount-1;
drawYInsideCount = compYCount-1;

drawWidth = compWidth*compXCount + drawXInsideCount*drawInsideThick + drawOutsideThick*2;
drawDepth = compDepth*compYCount + drawYInsideCount*drawInsideThick + drawOutsideThick*2;
drawHeight = compHeight + drawBottomThick;

drawXStart = -drawWidth/2 + drawOutsideThick + compWidth/2;
drawXStep = compWidth + drawInsideThick;

drawYStart = -drawDepth/2 + drawOutsideThick + compDepth/2;
drawYStep = compDepth + drawInsideThick;

////

areaWidth = drawWidth+drawerSpacer*2;
areaHeight = drawersPerArea*drawHeight + (drawersPerArea+1)*drawerSpacer + (drawersPerArea-1)*drawerSpacer;

boxXInsideCount = areasXCount-1;
boxYInsideCount = areasYCount-1;

boxWidth = areaWidth*areasXCount +  boxXInsideCount*boxInsideThick + boxOutSideThick*2;
boxHeight = areaHeight*areasYCount + boxYInsideCount*boxInsideThick + boxOutSideThick*2;
boxDepth = drawDepth + drawerSpacer + boxBackThick;

boxXStart = -boxWidth/2 + boxOutSideThick + areaWidth/2;
boxXStep = areaWidth + boxInsideThick;

boxYStart = -boxHeight/2 + boxOutSideThick + areaHeight/2;
boxYStep = areaHeight + boxInsideThick;

///

slidercut = sqrt(pow(drawBottomThick,2)/2)*1.5;


function CorrectedHeight(height) = ceil(height/layerHeight)*layerHeight;

/////////////////////////////////////



module Connector()
{
    linear_extrude(height=boxDepth/3*2-1)
    offset(r=-connectorSpacing/2) union()
    {
        square([layerWidth*2+connectorPadding, boxOutSideThick], center=true);
        for (x=[0,1]) mirror([x,0,0]) translate([connectorPadding/2,0,0])  
            polygon(points=[[layerWidth,boxOutSideThick/2],
                            [3*layerWidth,boxOutSideThick], 
                            [3*layerWidth,-boxOutSideThick],
                            [layerWidth,-boxOutSideThick/2]]);
        
    }
    
}

module ConnectorHole()
{
    linear_extrude(height=boxDepth/3*2+1)
    union()
    {
        square([layerWidth*2, boxOutSideThick], center=true);
        for (x=[0,1]) mirror([x,0,0])
            polygon(points=[[layerWidth,boxOutSideThick/2],
                            [3*layerWidth,boxOutSideThick], 
                            [3*layerWidth,-boxOutSideThick],
                            [layerWidth,-boxOutSideThick/2]]);
    }
}


module LabelHolder(width, height, opening)
{
    if (labelOption=="Frame") 
        LabelHolderFrame(width, height, opening);
    else if (labelOption=="Simple")
        LabelHolderSimple(width, height);
}


module LabelHolderSimple(width, height)
{
    difference()
    {
        translate([0,-layerWidth/2,0]) CenterCube([width,layerWidth,height]);
        translate([0,0,height/2]) 
            cube([width-labelHolderEdgeWidth, layerWidth*3, height - labelHolderEdgeWidth], 
                  center=true);
    }
    
}

module LabelHolderFrame(width, height)
{
    outideDepth = layerWidth*2;
    totalDepth = layerWidth*2 + labelHolderSpace;
    
    difference()
    {
        translate([0,-totalDepth/2,0]) CenterCube([width,totalDepth,height]);
        translate([0,0,labelHolderEdgeWidth]) 
            CenterCube([width-labelHolderEdgeWidth*2, totalDepth*3, height ]);
        translate([0,0,height/2]) 
            cube([width-labelHolderEdgeWidth, labelHolderSpace*3, height+1 ], center=true);
    }
    
    rotate([0,90,180]) 
        Triangle(totalDepth,totalDepth, width);
    
    
    
}    

module Box()
{
    difference()
    {
        SmoothCube([boxWidth, boxHeight, boxDepth]);
        for (x=[0:areasXCount-1]) for (y=[0:areasYCount-1])
        {
            translate([boxXStart+x*boxXStep, boxYStart+y*boxYStep-drawerSpacer,0])
            {
                translate([0,0,boxBackThick+boxDepth/2])
                    rotate([-90,0,0]) translate([0,0,-areaHeight/2])
                        SmoothCube([areaWidth, boxDepth+drawerSpacer, areaHeight]);                         
                
                if (drawerStopper)
                    for (x2=[0,1]) mirror([x2,0,0]) for (y=[0:drawersPerArea-1])
                        translate([areaWidth/2, 
                               -areaHeight/2 + drawerSpacer + y*(drawHeight+drawerSpacer),
                                boxBackThick])
                            translate([-0.01,drawHeight-1.25,0]) cube([1.5, 1.5, drawDepth-1]);
                
            }
        }
        
        //connector holes for stacking
        if (boxWidth>=30)
        {
            for (x=[0,1]) for (y=[0,1]) mirror([x,0,0]) mirror([0,y,0]) 
                if ((stackTop && y==0) || (stackBottom && y==1))
                    translate([boxWidth/2-10, boxHeight/2, -1]) rotate([0,0,90]) 
                        ConnectorHole();
        }
        else
        {
            for (y=[0,1])  mirror([0,y,0]) 
                if ((stackTop && y==0) || (stackBottom && y==1))
                    translate([0, boxHeight/2, -1]) rotate([0,0,90]) 
                        ConnectorHole();
        }
        if (boxHeight>=30)
        {
            for (x=[0,1]) for (y=[0,1]) mirror([x,0,0]) mirror([0,y,0]) 
                if ((stackRight && x==0) || (stackLeft && x==1))
                    translate([boxWidth/2, boxHeight/2-10, -1])  
                        ConnectorHole();
        }
        else
        {
            for (x=[0,1]) mirror([x,0,0]) 
                if ((stackRight && x==0) || (stackLeft && x==1))
                    translate([boxWidth/2, 0, -1])  
                        ConnectorHole();
        }
        
    }
    
    for (x=[0:areasXCount-1]) for (y=[0:areasYCount-1])
    {
        for (x2=[0,1]) mirror([x2,0,0])
        {
            translate([boxXStart+x*boxXStep, boxYStart+y*boxYStep,boxBackThick])
            {
                if (drawersPerArea>1)
                    for (y=[1:drawersPerArea-1])
                        translate([areaWidth/2+0.01, 
                                   -areaHeight/2 + drawerSpacer + y*(drawHeight+drawerSpacer*2),0])
                            Slider();
                
            }
        }
        
    }
}




module Slider()
{
    diag = slidercut-drawerSpacer;
    dist = sqrt(pow(diag,2)*2);
    
    linear_extrude(height=drawDepth-smoothRadius) 
        polygon(points=[[0,0], [-dist,0], [0,dist]]);
}




module Drawer(empty=false)
{
    difference()
    {
        SmoothCube([drawWidth, drawDepth, drawHeight]);
        if (empty)
        {
            translate([0, 0, drawBottomThick])
                SmoothCube([drawWidth-drawOutsideThick*2, drawDepth-drawOutsideThick*2, compHeight+1]);
        }
        else
        {
            for (x=[0:compXCount-1]) for (y=[0:compYCount-1])
            {
                translate([drawXStart+x*drawXStep, drawYStart+y*drawYStep, drawBottomThick])
                {
                    SmoothCube([compWidth, compDepth, compHeight+1]);
                }
            }
            translate([0,0,drawHeight-drawInsideLower]) 
                SmoothCube([drawWidth-drawOutsideThick*2, drawDepth-drawOutsideThick*2, compHeight+1]);
        }
        for (x=[0,1]) mirror([x,0,0]) 
            translate([drawWidth/2,smoothRadius,0]) rotate([0,45,0]) 
                cube([slidercut*2, drawDepth, slidercut*4], center=true);
        
        if (!attachHandle) 
            translate([0,-drawDepth/2,drawHeight/2])
                minkowski()
                {
                    Handle();
                    cube([0.25,0.25,0.25],center=true);
                }
        
    }
    
    if (attachHandle) 
        translate([0,-drawDepth/2+0.01,drawHeight/2]) Handle();
    
    
    if (drawerStopper)
        for (x=[0,1]) mirror([x,0,0]) 
            translate([drawWidth/2-0.01, 
                   drawDepth/2-smoothRadius-drawOutsideThick/2, 
                   drawHeight]) 
                Nook();
            


    if (handleAutoSize)
    {
        handleWidthA = drawWidth*0.33;
        lhPos = ((drawWidth/2-smoothRadius) + handleWidthA/2+smoothRadius)/2;
        lhSpace = (drawWidth/2-smoothRadius*1.5) - (handleWidthA/2+smoothRadius*1.5);
        for (x=[-1,1])
            translate([lhPos*x, -drawDepth/2+0.01, smoothRadius*2.5]) 
                LabelHolder(lhSpace, drawHeight - smoothRadius*3, x);
    }
    else
    {    
        lhPos = ((drawWidth/2-smoothRadius) + handleWidth/2+smoothRadius)/2;
        lhSpace = (drawWidth/2-smoothRadius*1.5) - (handleWidth/2+smoothRadius*1.5);
        for (x=[-1,1])
            translate([lhPos*x, -drawDepth/2+0.01, smoothRadius*2.5]) 
                LabelHolder(lhSpace, drawHeight - smoothRadius*3, x);
    }

}




module Nook()
{
    layers = 1 / layerHeight;
    
    length = drawerStopperSize*3;
    middle1 = 1.5 *drawerStopperSize;
    middle2 = 2.5 *drawerStopperSize;
    for (i=[1:layers])
        let (perc = min(1,i/(layers*3/5)))
        translate([0,0,-1+(i-1)*layerHeight])
            linear_extrude(height=layerHeight) 
                #polygon(points=[[0,0], [0,-length], 
                                 [drawerStopperSize*perc, -middle2],
                                 [drawerStopperSize*perc, -middle1]]);
}



module Handle()
{
    if (handleAutoSize)
        HandleAutoSize();
    else HandleManual();
    
}


module HandleAutoSize()
{
    handleWidthA = drawWidth*0.3;
    handleThicknessA = sqrt(handleWidthA)/3;
    handleHeightA = drawHeight * 0.75;
    handleDepthA = handleHeightA * 0.6;
    
    for (x=[0,1]) mirror([x,0,0]) 
    translate([handleWidthA/2-handleThicknessA,0]) rotate([90,0,90])
        linear_extrude(height=handleThicknessA)
            polygon(points=[[0,-handleHeightA/2], [-handleDepthA,0],[0,handleHeightA/2]]);
    
    a = atan(handleDepthA / (handleHeightA/2));
    a2 = 90-a;
    
    d = handleThicknessA / sin(a);
    d2 = handleThicknessA / sin(a2);
    

    
    rotate([90,0,90])
        linear_extrude(height=handleWidthA-0.01, center=true)
            polygon(points=[[-handleDepthA,0],[0,handleHeightA/2],[0,handleHeightA/2-d],
                         [-handleDepthA+layerWidth*2,0]]); 
}


module HandleManual()
{
    for (x=[0,1]) mirror([x,0,0]) 
    translate([handleWidth/2-handleThickness,0]) rotate([90,0,90])
        linear_extrude(height=handleThickness)
            polygon(points=[[0,-handleHeight/2], [-handleDepth,0],[0,handleHeight/2]]);
    
    a = atan(handleDepth / (handleHeight/2));
    a2 = 90-a;
    
    d = handleThickness / sin(a);
    d2 = handleThickness / sin(a2);
    

    
    rotate([90,0,90])
        linear_extrude(height=handleWidth-0.01, center=true)
            polygon(points=[[-handleDepth,0],[0,handleHeight/2],[0,handleHeight/2-d],
                         [-handleDepth+layerWidth*2,0]]); 
}




module CenterCube(size)
{
    echo(size);
    translate([0,0,size[2]/2]) 
        cube(size=size,center=true);
}

module Triangle(width, height, depth)
{
    linear_extrude(height=depth, center=true)
        polygon(points=[[0,0], [width,0], [0,height]]);
}

module SmoothCube(size)
{
    hull()
    {
        for (x=[-1,1]) for (y=[-1,1])
        {
            translate([x*(size[0]/2-smoothRadius), y*(size[1]/2-smoothRadius), smoothRadius])
                sphere(r=smoothRadius, $fn=smoothQuality);
        }
        for (x=[-1,1]) for (y=[-1,1])
        {
            translate([x*(size[0]/2-smoothRadius), y*(size[1]/2-smoothRadius), size[2]-smoothRadius])
                cylinder(r=smoothRadius, h=smoothRadius, $fn=smoothQuality);
        }

    }
}
