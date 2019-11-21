testPiece = false;
xExtrusionWidthSections = 2;
xExtrusionDepthSections = 1;
xExtrusionLength = 70;
xEndClosed = true;
yExtrusionWidthSections = 2;
yExtrusionDepthSections = 1;
yExtrusionLength = 70;
yEndClosed = true;
zExtrusionWidthSections = 2;
zExtrusionDepthSections = 1;
zExtrusionLength = 70;
zEndClosed = true;
tolerance=0.8;
lengthHoleSpacing=30;
wallWidth=5;
vslotIndentHeight=1;
sectionWidth=20;

if (testPiece) {
    difference() {
        linear_extrude(height=zExtrusionLength)
            square([
                sectionWidth*zExtrusionWidthSections+wallWidth*2,
                sectionWidth*zExtrusionDepthSections+wallWidth*2
            ]);
        translate([wallWidth, wallWidth, 0]) {
            linear_extrude(height=zExtrusionLength)
            VSlot2dProfile(
                sectionCountWidth=zExtrusionWidthSections, 
                sectionCountDepth=zExtrusionDepthSections,
                indentHeight=vslotIndentHeight,
                tolerance=tolerance
            );
        };  
        negativeSpaceHoles(
            extrusionLength=zExtrusionLength,
            fullIndentHeight=wallWidth+vslotIndentHeight,
            firstIndentOffset=wallWidth,
            widthSections=zExtrusionWidthSections,
            lengthHoleSpacing=lengthHoleSpacing
        );
    };
}
else {
    ThreeCornerVslot(
        sectionWidth = sectionWidth,
        wallWidth = wallWidth,
        vslotIndentHeight = vslotIndentHeight,
        xExtrusionWidthSections = xExtrusionWidthSections,
        xExtrusionDepthSections = xExtrusionDepthSections,
        xExtrusionLength = xExtrusionLength,
        xEndClosed = xEndClosed,
        yExtrusionWidthSections = yExtrusionWidthSections,
        yExtrusionDepthSections = yExtrusionDepthSections,
        yExtrusionLength = yExtrusionLength,
        yEndClosed = yEndClosed,
        zExtrusionWidthSections = zExtrusionWidthSections,
        zExtrusionDepthSections = zExtrusionDepthSections,
        zExtrusionLength = zExtrusionLength,
        zEndClosed = zEndClosed,
        tolerance = tolerance,
        lengthHoleSpacing = lengthHoleSpacing
    );
}

module extrusionIndent(_indentWidthInside, _indentWidthOutside, _indentHeight) {
    polygon(points=[
            [0,0], 
            [(_indentWidthOutside-_indentWidthInside)/2, _indentHeight], 
            [_indentWidthInside + (_indentWidthOutside-_indentWidthInside)/2, _indentHeight],
            [_indentWidthOutside, 0]
        ]);
};

module VSlot2dProfile(
    extrusionLength = 50,
    sectionWidth = 20,
    indentWidthOutside = 9,
    indentWidthInside = 7,
    indentHeight = 1,
    sectionCountWidth = 3,
    sectionCountDepth = 1,
    topIndent = true,
    bottomIndent = true,
    leftIndent = true,
    rightIndent = true,
    tolerance = 0.8
)
{
    translate([-tolerance/2,-tolerance/2,0]) difference() {
        
            square(
                size=[
                    sectionWidth*sectionCountWidth+tolerance, 
                    sectionWidth*sectionCountDepth+tolerance
                ]
            );
        for(i = [0:sectionCountWidth]) {
            // bottom indents
            if (bottomIndent) 
                translate([i * sectionWidth + (sectionWidth-indentWidthOutside)/2, 0, 0])
                extrusionIndent(indentWidthInside,indentWidthOutside,indentHeight);
            
            // top indents
            if (topIndent)
                translate([
                    i * sectionWidth + (sectionWidth-indentWidthOutside)/2, 
                    sectionWidth*sectionCountDepth+tolerance, 
                    0
                ])
                rotate([180,0,0])
                extrusionIndent(indentWidthInside,indentWidthOutside,indentHeight);
        }
        for(i = [0:sectionCountDepth]) {
            // left side indent
            if (leftIndent)
                translate([0, (i+1) * sectionWidth - (sectionWidth-indentWidthOutside)/2, 0])
                rotate([0,0,-90]) 
                extrusionIndent(indentWidthInside,indentWidthOutside,indentHeight);
            
            // right side inden
            if (rightIndent)
                translate([
                    sectionWidth*sectionCountWidth + tolerance, 
                    i * sectionWidth + (sectionWidth-indentWidthOutside)/2, 
                    0
                ])
                rotate([0,0,90]) 
                extrusionIndent(indentWidthInside,indentWidthOutside,indentHeight);
        }
    }
};

module negativeSpaceHoles(
    largeHoleIndent = 1,
    largeHoleRadius = 5,
    smallHoleRadius = 2.5,
    widthHoleSpacing = 20,
    lengthHoleSpacing,
    extrusionLength,
    fullIndentHeight,
    firstIndentOffset,
    widthSections
    ) 
{
    for (p = [lengthHoleSpacing/2+firstIndentOffset:lengthHoleSpacing:extrusionLength-firstIndentOffset-lengthHoleSpacing/2]) {
        translate([0,0,p]) 
        for (s = [firstIndentOffset+widthHoleSpacing/2:widthHoleSpacing:widthHoleSpacing*widthSections]) {
            translate([s,0,0])
            rotate([-90,0,0]) {
                cylinder(h=largeHoleIndent,r=largeHoleRadius,center=false, $fn=90);
                cylinder(h=fullIndentHeight,r=smallHoleRadius,center=false, $fn=90);
            };
        }
    };
}

module ThreeCornerVslot(
    sectionWidth = 20,
    wallWidth = 5,
    vslotIndentHeight = 1,
    xExtrusionWidthSections = 2,
    xExtrusionDepthSections = 1,
    xExtrusionLength = 70,
    xEndClosed = true,
    yExtrusionWidthSections = 2,
    yExtrusionDepthSections = 1,
    yExtrusionLength = 70,
    yEndClosed = true,
    zExtrusionWidthSections = 1,
    zExtrusionDepthSections = 2,
    zExtrusionLength = 70,
    zEndClosed = true,
    tolerance=0.8,
    lengthHoleSpacing = 20,
)
{
    xEndOffset = 
        xEndClosed 
        ? wallWidth+vslotIndentHeight
        : 2*wallWidth + sectionWidth*zExtrusionWidthSections;
    yEndOffset = 
        yEndClosed 
        ? vslotIndentHeight
        : wallWidth + sectionWidth*zExtrusionDepthSections;
    zEndOffset = zEndClosed ? wallWidth : 0;
    
    difference() {
        hull() { 
            linear_extrude(height=zExtrusionLength)
                square([
                    sectionWidth*zExtrusionWidthSections+wallWidth*2,
                    sectionWidth*zExtrusionDepthSections+wallWidth*2
                ]);
            rotate([0,-90,0]) 
                linear_extrude(height=xExtrusionLength)
                square([
                    sectionWidth*xExtrusionWidthSections + 2*wallWidth,
                    wallWidth
                ]);
            
            translate([sectionWidth*zExtrusionWidthSections + wallWidth,
                    sectionWidth*zExtrusionDepthSections + wallWidth,
                    0
                ])
                rotate([-90,-90,0])
                linear_extrude(height=yExtrusionLength)
                square([
                    sectionWidth*yExtrusionWidthSections + 2*wallWidth,
                    wallWidth
                ]);
        };
        
        translate([wallWidth, wallWidth, zEndOffset]) {
            linear_extrude(height=zExtrusionLength-zEndOffset)
            VSlot2dProfile(
                sectionCountWidth=zExtrusionWidthSections, 
                sectionCountDepth=zExtrusionDepthSections,
                indentHeight=vslotIndentHeight,
                tolerance=tolerance
            );
        };  
        negativeSpaceHoles(
            extrusionLength=zExtrusionLength,
            fullIndentHeight=wallWidth+vslotIndentHeight,
            firstIndentOffset=wallWidth,
            widthSections=zExtrusionWidthSections,
            lengthHoleSpacing=lengthHoleSpacing
        );

        rotate([0,-90,0]) {
            translate([wallWidth, wallWidth, -xEndOffset]) 
                linear_extrude(height=xExtrusionLength+xEndOffset)
                VSlot2dProfile(
                    sectionCountWidth=xExtrusionWidthSections, 
                    sectionCountDepth=xExtrusionDepthSections,
                    indentHeight=vslotIndentHeight,
                    tolerance=tolerance
                );
            negativeSpaceHoles(
                extrusionLength=xExtrusionLength,
                fullIndentHeight=wallWidth+vslotIndentHeight,
                firstIndentOffset=wallWidth,
                widthSections=xExtrusionWidthSections,
                lengthHoleSpacing=lengthHoleSpacing
            );
        };
            
        translate([zExtrusionWidthSections*sectionWidth+wallWidth*2,0,0])
        rotate([0,0,90])
            negativeSpaceHoles(
                extrusionLength=zExtrusionLength,
                fullIndentHeight=wallWidth+vslotIndentHeight,
                firstIndentOffset=wallWidth,
                widthSections=zExtrusionDepthSections,
                lengthHoleSpacing=lengthHoleSpacing
            );
        
        translate([
            sectionWidth*(zExtrusionWidthSections-yExtrusionDepthSections),
            sectionWidth*zExtrusionDepthSections+wallWidth-yEndOffset,
            0])
        {
            rotate([-90,-90,0]) {
                translate([wallWidth, wallWidth, 0])
                linear_extrude(height=yExtrusionLength+yEndOffset)
                VSlot2dProfile(
                    sectionCountWidth=yExtrusionWidthSections, 
                    sectionCountDepth=yExtrusionDepthSections,
                    indentHeight=vslotIndentHeight,
                    tolerance=tolerance
                );             
            };
        };
            
          
        translate([sectionWidth*zExtrusionWidthSections + wallWidth*2,
                sectionWidth*zExtrusionDepthSections + wallWidth,
                sectionWidth*yExtrusionWidthSections + wallWidth*2
            ])
            rotate([0,90,90])
            negativeSpaceHoles(
                extrusionLength=yExtrusionLength,
                fullIndentHeight=wallWidth+vslotIndentHeight,
                firstIndentOffset=wallWidth,
                widthSections=yExtrusionWidthSections,
                lengthHoleSpacing=lengthHoleSpacing
            );
          
    };   
}
        