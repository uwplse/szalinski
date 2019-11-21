/* [Stepper Mount] */

// width of the motor mount
bracketWidth = 80;

// space from the edge of the extrusion to the center of the motor mount
distanceToMotorCenter = 30; // [22:100]

// extrusion profile base in mm (e.g. 20 for V-Slot 2020 or 2040, 15 for Misumi 1515)
profileSize=20;

// number of extrusion slots (width)
sectionCountWidth = 2;

// number of extrusion slots (depth)
sectionCountDepth = 1;

// extrusion slot outside width (9 for 20xx V-Slot, 6 for 20xx T-Slot)
indentWidthOutside = 9;

// extrusion slot inside width (7 for 20xx V-Slot, 6 for 20xx T-Slot)
indentWidthInside = 7;

// extrusion slot depth
vslotIndentHeight = 1;

// bolt head diameter in mm
boltHeadDiameter = 10;

// bolt thread diameter in mm
boltThreadDiameter = 5;

// thickness of outside walls in mm
wallWidth=5;

// tolerance in mm
tolerance=0.7;

// distance between screw head and interiou
screwHeight = 6;

/* [Hidden] */

// ------------ Constants ------------------------
tolerance=0.7;
oversize = 0.7;
lengthHoleSpacing=20;
wallWidth=5;
extrusionWidth=profileSize*sectionCountWidth;
extrusionDepth=profileSize*sectionCountDepth;
nema17Width = 42.3;
nema17HoleRadius = 11.05 + tolerance/2;
nema17Height = 3.5*extrusionWidth;
nema17BoltSpacing = 31;
nema17BeltHoleHeight = 8;
nema17BeltOffsetFromTopExtrusion = 8;
nema17BeltHeightWidth = 15;
wallSpacing=5;
largeHoleIndent = screwHeight-screwOffset;
// ---------------------------------------------
// ------------ VSlot ------------------------

module extrusionIndent(_indentWidthInside, _indentWidthOutside, _indentHeight) {
    polygon(points=[
            [0,0], 
            [(_indentWidthOutside-_indentWidthInside)/2, _indentHeight], 
            [_indentWidthInside + (_indentWidthOutside-_indentWidthInside)/2, _indentHeight],
            [_indentWidthOutside, 0]
        ]);
};

module VSlot2dProfile(
    extrusionLength,
    profileSize = 20,
    indentHeight = vslotIndentHeight,
    sectionCountWidth,
    sectionCountDepth,
    topIndent = true,
    bottomIndent = true,
    leftIndent = true,
    rightIndent = true,
    oversize = 0
)
{
    translate([-oversize/2,-oversize/2,-oversize/2])
    resize([
        profileSize*sectionCountWidth+oversize,
        profileSize*sectionCountDepth+oversize,
        extrusionLength+oversize
    ]) difference() {
        
            square(
                size=[
                    profileSize*sectionCountWidth, 
                    profileSize*sectionCountDepth
                ]
            );
        for(i = [0:sectionCountWidth]) {
            // bottom indents
            if (bottomIndent) 
                translate([i * profileSize + (profileSize-indentWidthOutside)/2, 0, 0])
                extrusionIndent(indentWidthInside,indentWidthOutside,indentHeight);
            
            // top indents
            if (topIndent)
                translate([
                    i * profileSize + (profileSize-indentWidthOutside)/2, 
                    profileSize*sectionCountDepth, 
                    0
                ])
                rotate([180,0,0])
                extrusionIndent(indentWidthInside,indentWidthOutside,indentHeight);
        }
        for(i = [0:sectionCountDepth]) {
            // left side indent
            if (leftIndent)
                translate([0, (i+1) * profileSize - (profileSize-indentWidthOutside)/2, 0])
                rotate([0,0,-90]) 
                extrusionIndent(indentWidthInside,indentWidthOutside,indentHeight);
            
            // right side inden
            if (rightIndent)
                translate([
                    profileSize*sectionCountWidth, 
                    i * profileSize + (profileSize-indentWidthOutside)/2, 
                    0
                ])
                rotate([0,0,90]) 
                extrusionIndent(indentWidthInside,indentWidthOutside,indentHeight);
        }
    }
};


module negativeSpaceHole(
    largeHoleIndent = largeHoleIndent,
    fullIndentHeight = wallSpacing+vslotIndentHeight,
    largeHoleRadius = boltHeadDiameter/2,
    smallHoleRadius = boltThreadDiameter/2,
    )
{ 
    cylinder(h=largeHoleHeight,r=largeHoleRadius,center=false, $fn=90);
    cylinder(h=fullIndentHeight,r=smallHoleRadius,center=false, $fn=90);
}

module negativeSpaceHolePoints(
    largeHoleIndent = 1,
    largeHoleRadius = boltHeadDiameter/2,
    smallHoleRadius = boltThreadDiameter/2,
    fullIndentHeight,
    points = []
    )
{
    for (i=[0:len(points)-1]){
        translate([points[i][1],0,points[i][0]]) {
            rotate([-90,0,0]) {
                echo(points[i][0], points[i][1]);
                negativeSpaceHole(
                    largeHoleHeight=largeHoleIndent,
                    fullIndentHeight=fullIndentHeight,
                    largeHoleRadius=largeHoleRadius,
                    smallHoleRadius=smallHoleRadius);
            };
        }
    }
}

module negativeSpaceHoles(
    largeHoleIndent = 1,
    largeHoleRadius = boltHeadDiameter/2,
    smallHoleRadius = boltThreadDiameter/2,
    widthHoleSpacing = profileSize,
    fullIndentHeight,
    lengthHoleSpacing,
    extrusionLength,
    firstIndentOffset,
    widthSections
    ) 
{
    
    negativeSpaceHolePoints(
        largeHoleIndent = largeHoleIndent,
        largeHoleRadius = largeHoleRadius,
        smallHoleRadius = smallHoleRadius,
        fullIndentHeight = fullIndentHeight,
        lengthHoleSpacing = lengthHoleSpacing,
        widthSections = widthSections,
        points=[ 
            for (p = [lengthHoleSpacing/2+firstIndentOffset:lengthHoleSpacing:extrusionLength-firstIndentOffset-lengthHoleSpacing/2]) 
            for (s = [firstIndentOffset+widthHoleSpacing/2:widthHoleSpacing:widthHoleSpacing*widthSections]) 
            [p,s]
         ]
            
    );
}


module drawVslotExtrusion(
    height, 
    sectionCountWidth, 
    sectionCountDepth, 
    topIndent=true, 
    rightIndent=true, 
    leftIndent=true, 
    bottomIndent=true, 
    oversize=0,
    screwHeight=screwHeight,
    screwOffset=0,
    leftScrewPoints = [],
    rightScrewPoints = [], 
    topScrewPoints = [],
    bottomScrewPoints = [],
    backScrewPoints = []
    ) 
{
    linear_extrude(height=height) 
        VSlot2dProfile(
            sectionCountWidth=sectionCountWidth,
            sectionCountDepth=sectionCountDepth,
            topIndent=topIndent,
            bottomIndent= bottomIndent,
            leftIndent=leftIndent,
            rightIndent=rightIndent,
            oversize=oversize);
    
    if (len(topScrewPoints) > 0) {
        points = [ 
            for(i = [0:len(topScrewPoints)-1])
            for(j=[profileSize/2:profileSize:sectionCountWidth*profileSize])
            [topScrewPoints[i],j]
        ];
            translate([0,-screwHeight+vslotIndentHeight,0])
        negativeSpaceHolePoints(
            largeHoleIndent = screwHeight-screwOffset,
            fullIndentHeight=screwHeight,
            points = points
        );
    };
    if (len(bottomScrewPoints) > 0) {
        points = [ 
            for(i = [0:len(bottomScrewPoints)-1])
            for(j=[profileSize/2:profileSize:sectionCountWidth*profileSize])
            [height-bottomScrewPoints[i],j]
        ];
            translate([0,screwHeight+sectionCountDepth*profileSize-vslotIndentHeight,height])
            rotate([180,0,0])
        negativeSpaceHolePoints(
            largeHoleIndent = screwHeight-screwOffset,
            fullIndentHeight=screwHeight+oversize,
            points = points
        );
    };
    if (len(leftScrewPoints) > 0) {
        points = [ 
            for(i = [0:len(leftScrewPoints)-1])
            for(j=[profileSize/2:profileSize:sectionCountDepth*profileSize])
            [leftScrewPoints[i],j]
        ];
            translate([-screwHeight+vslotIndentHeight,sectionCountDepth*profileSize,0])
            rotate([0,0,-90])
        negativeSpaceHolePoints(
            largeHoleIndent = screwHeight-screwOffset,
            fullIndentHeight=screwHeight+oversize,
            points = points
        );
    };
    if (len(rightScrewPoints) > 0) {
        points = [ 
            for(i = [0:len(rightScrewPoints)-1])
            for(j=[profileSize/2:profileSize:sectionCountDepth*profileSize])
            [rightScrewPoints[i],j]
        ];
            translate([sectionCountWidth*profileSize+screwHeight-vslotIndentHeight,0,0])
            rotate([0,0,90])
        negativeSpaceHolePoints(
            largeHoleIndent = screwHeight-screwOffset,
            fullIndentHeight=screwHeight+oversize,
            points = points
        );
    };
    if (len(backScrewPoints) > 0) {
        points = [ 
            for(i = [0:len(backScrewPoints)-1])
            for(j=[profileSize/2:profileSize:sectionCountWidth*profileSize])
            [backScrewPoints[i],j]
        ];
            translate([0,sectionCountDepth*profileSize,-screwHeight+vslotIndentHeight])
            rotate([90,0,0])
        negativeSpaceHolePoints(
            largeHoleIndent = screwHeight-screwOffset,
            fullIndentHeight=screwHeight,
            points = points
        );
    };
    /*
        translate([profileSize/2,0,0])
        for(i = [0:len(leftScrewPoints)])
        for(j=[0:profileSize:sectionCountDepth*profileSize]) {
            translate([0,leftScrewPoints[i]],j) 
                negativeSpaceHole(largeHoleHeight = screwHeight-screwOffset, fullIndentHeight = screwHeight);
            }
    */
}


        

// ---------------------------------------------



wallWidth=5;
screwOffset=5;
screwDiameter=5;
tolerance=.8;
bracketWidth = 80;
bracketDepth = sectionCountDepth * profileSize + wallWidth;
    
nema17BoltOffset = (nema17Width - nema17BoltSpacing)/2;
        
// from Carl Feniak's drawing..  
nema17BeltHoleCenterOffsetX = profileSize/2 + 12;//-5;// was -1, deviating from the description based on visual assessment
nema17BeltHoleCenterOffsetZ = 14;
nema17BeltHoleWidth = 16;
nema17BeltHoleHeight = 8;
m3HoleRadius = 1.5;
nemaZOffset = (bracketWidth - nema17Width - wallWidth)/2;

module ZStepperBracket(hOffset = distanceToMotorCenter-nemaZOffset)
{
    xExtrusionScrewPoints = [wallWidth+screwDiameter/2,bracketWidth-wallWidth-screwDiameter/2];
    difference() {
        hull() {
            cube([bracketWidth,hOffset+bracketDepth,sectionCountWidth*profileSize + wallWidth]);
            translate([nemaZOffset, -nema17Width, 0])
            {
                linear_extrude(height=wallWidth) 
                    square([nema17Width+wallWidth,nema17Width]);
            }
        };
        translate([0,hOffset+wallWidth,wallWidth+sectionCountWidth*profileSize])
                color("red")
                rotate([0,90,0])
                drawVslotExtrusion(
                    height=bracketWidth,
                    sectionCountWidth=sectionCountWidth, 
                    sectionCountDepth=sectionCountDepth, 
                    topIndent=false, 
                    bottomIndent=true,
                    rightIndent=true, 
                    leftIndent=false,  
                    oversize=tolerance,
                    screwDiameter=screwDiameter,
                    screwHeight=bracketWidth,
                    screwOffset=screwOffset,
                    topScrewPoints = xExtrusionScrewPoints,
                    rightScrewPoints = xExtrusionScrewPoints
            ); 
        translate([nemaZOffset, -nema17Width, 0])
        {
            translate([wallWidth/2-tolerance/2,0, wallWidth])
                linear_extrude(height=bracketWidth) 
                    square([nema17Width,nema17Width]);
            translate([nema17Width/2+wallWidth/2, nema17Width/2, 0])
                linear_extrude(height=extrusionWidth)
                offset(r=extrudeOffsetVal) 
                circle(r=nema17HoleRadius+tolerance, center=true);
            translate([nema17BoltOffset+wallWidth/2,nema17BoltOffset,0])
                for(i = [0,1], j = [0,1]) {
                    translate([i*nema17BoltSpacing, j*nema17BoltSpacing, 0]) 
                        linear_extrude(height=extrusionWidth+wallWidth)
                        circle(r=m3HoleRadius, center=true, $fn=90);
                }
        } 
    }
                
            
    
}

ZStepperBracket();