part = "bottom"; // [top: Box Top, bottom: Box Bottom, both: Both Pieces]

cableSet = "both"; // [base: Just HDK, audio: Add Audio, USB: Add USB, both: Add Both]

// Diameter of screwholes
screwSize = 3.2;

// Thickness of material
thickness = 2.5;

/* [Hidden] */
$fn=30;
baseDepth = 15; // how thick the cable pack is
baseWidth = 80.1 - baseDepth; // how wide the centers of the radii are
baseHeight = 75; // height of the cable pack (no cables installed)
cableClearance = 43; // clearance needed at both ends for the cables

xHDK = 3;
cableWidthHDK = 40;
cableHeightHDK = 41;
cableDepthHDK = 11.7;
cableDiamHDK = 5.6; // cable thickness for headset

xHDMI = 0;
cableWidthHDMI = 30.5;
cableHeightHDMI = 42.75;
cableDepthHDMI = 10.8;
cableDiamHDMI = 5; // cable thickness for HDMI cable

xUSBin = 23.5;
cableWidthUSBin = 24;
cableHeightUSBin = 34.5;
cableDepthUSBin = 8;
cableDiamUSBin = 3.5; // cable thickness for USB cable

xPower = -19.5;
cableWidthPower = 11.2;
cableHeightPower = 32.2;
cableDepthPower = 11.2;
cableDiamPower = 6; // cable thickness for Power cables

xUSBout = -24.75;
cableWidthUSBout = 24.5;
cableHeightUSBout = 36;
cableDepthUSBout = 8.5;
cableDiamUSBout = 5; // cable thickness for USB cable

xAudio = 28;
cableWidthAudio = 11.2;
cableHeightAudio = 35;
cableDepthAudio = 11.2;
cableDiamAudio = 4.5;


boxDepth = baseDepth + 2*thickness;
boxWidth = baseWidth;
boxHeight = baseHeight + 2*cableClearance + 2*thickness; // added size for the cables.

if (part == "top")
    boxTop();
else if (part == "bottom")
    boxBot();
else
{
    translate([-(boxWidth/2+5*thickness),0,0]) boxTop();
    translate([(boxWidth/2+5*thickness),0,0]) boxBot();
}


module boxTop()
{
    difference()
    {
        translate([0,0,boxDepth/2]) fullBox();
        translate([0,0,boxDepth]) cube([boxWidth+boxDepth+.1,boxHeight+.1,boxDepth], center=true);
    }
}

module boxBot()
{
    difference()
    {
        translate([0,0,boxDepth/2]) rotate([0,180,0]) fullBox();
        translate([0,0,boxDepth]) cube([boxWidth+boxDepth+.1,boxHeight+.1,boxDepth], center=true);
    }
}

module fullBox()
{
    difference()
    {
        rotate([90,0,0]) 
        hull() // exterior of box
        {
            translate([-boxWidth/2,0,0]) cylinder(d=boxDepth, h=boxHeight, center=true);
            translate([boxWidth/2, 0,0]) cylinder(d=boxDepth, h=boxHeight, center=true);
        }
        
        rotate([90,0,0]) 
        hull() // room for base box
        {
            translate([-baseWidth/2,0,0]) cylinder(d=baseDepth+.4, h=baseHeight+.4, center=true);
            translate([baseWidth/2,0,0]) cylinder(d=baseDepth+.4, h=baseHeight+.4, center=true);
        }
             
        // remove space for top cables
        translate([0,baseHeight/2,0])
        rotate([-90,0,0])
        {
            translate([xHDK,0,0]) cableSpace(cableWidthHDK,cableHeightHDK,cableDepthHDK,cableDiamHDK);
            if (cableSet == "audio" || cableSet == "both") translate([xAudio,0,0]) cableSpace(cableWidthAudio,cableHeightAudio,cableDepthAudio,cableDiamAudio);
            if (cableSet == "USB" || cableSet == "both") translate([xUSBout,0,0]) cableSpace(cableWidthUSBout,cableHeightUSBout,cableDepthUSBout,cableDiamUSBout);
        }
        
        // remove space for bottom cables
        translate([0,-baseHeight/2,0])
        rotate([90,0,0])
        {
            translate([xPower,0,0]) cableSpace(cableWidthPower,cableHeightPower,cableDepthPower,cableDiamPower);
            translate([xHDMI,0,0]) cableSpace(cableWidthHDMI,cableHeightHDMI,cableDepthHDMI,cableDiamHDMI);
            translate([xUSBin,0,0]) cableSpace(cableWidthUSBin,cableHeightUSBin,cableDepthUSBin,cableDiamUSBin);
        }
        
        // window for belt clip
        translate([0,0,baseDepth/2]) cube([30,baseHeight,thickness*3], center=true);
        
        // add screws
        translate([0,0,-boxDepth/2])
        {
            translate([-(boxWidth/2),-(boxHeight/2-thickness-screwSize),0])
            {
                counterSunk(screwSize,boxDepth/2);
                cylinder(d=screwSize*.8,h=boxDepth-2*thickness);
            }
            translate([-(boxWidth/2),(boxHeight/2-thickness-screwSize),0])
            {
                counterSunk(screwSize,boxDepth/2);
                cylinder(d=screwSize*.8,h=boxDepth-2*thickness);
            }
            translate([(boxWidth/2),-(boxHeight/2-thickness-screwSize),0])
            {
                counterSunk(screwSize,boxDepth/2);
                cylinder(d=screwSize*.8,h=boxDepth-2*thickness);
            }
            translate([(boxWidth/2),(boxHeight/2-thickness-screwSize),0])
            {
                counterSunk(screwSize,boxDepth/2);
                cylinder(d=screwSize*.8,h=boxDepth-2*thickness);
            }
        }
    }
    
    
}
module cableSpace(width,height,depth,cable)
{
    hull()
    {
        translate([-(width-depth)/2,0,0]) cylinder(d=depth,h=height);
        translate([(width-depth)/2,0,0]) cylinder(d=depth,h=height);
    }
    translate([0,0,height-.1]) cylinder(d=cable,h=height*2);
}

module counterSunk(holeSize = screwSize, length = 10)
{
    hull()
    {
        translate([0,0,-1]) cylinder(d=holeSize*2,h=2,center=true);
        translate([0,0,holeSize/2]) cylinder(d=holeSize,h=.1,center=true);
    }     
    cylinder(d=holeSize,h=length);
}