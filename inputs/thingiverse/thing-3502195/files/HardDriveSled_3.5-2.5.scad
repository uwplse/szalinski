




// Overall Outter frame dimensions.  Should match that of 5.25" drive 
OHeight = 15;
OWidth = 100;
ODepth = 95;

//  Settings for internal size.  Should fit a 3.5" HDD
IWidth = 69.5;
BedThickness = 2;
WallThickness = 2;

// Settings for the depth of the outter screw holes.
OSDepth1 = 11.5;
OSDepth2 = OSDepth1 + 42;
OSHeight1 = 6.35;
OSDiamater = 4;

// Settings for the bottom screw holes of sled
BOSDepth1 = 24.28;
BOSDepth2 = BOSDepth1 + 44.45;


// Inner screw nibs
HDDepth1 = 10;
HDDepth2 = HDDepth1 + 76.6;
HDHeight = BedThickness + 3;
NubLength = 1;
NubWidth = 2;

// material saving settings
holeDiamater = 4;


//  Some caluculations used later.
Spacing = ((OWidth-IWidth)/2)-(2*WallThickness);
echo(Spacing);

// ========================================================================================
// Build the object
// ========================================================================================


difference(){
    // Primary shell
    cube([OWidth,ODepth,OHeight]);
    // Cutout for the HDD
    translate([(OWidth-IWidth)/2,-.1,BedThickness])cube([IWidth,ODepth+.2,OHeight-BedThickness+.1]);
    // Cutout for the left supports
    translate([WallThickness,-.1,BedThickness])cube([Spacing,ODepth+.2,OHeight-BedThickness+.1]);
    // Cutout for the right supports
    translate([OWidth-WallThickness-Spacing,-.1,BedThickness])cube([Spacing,ODepth+.2,OHeight-BedThickness+.1]);
    // Outer mounting holes
    translate([-.1,OSDepth1,OSHeight1])rotate([0,90,0])cylinder(d=OSDiamater, h=WallThickness+.2, $fn=20);
    translate([OWidth-WallThickness-.1,OSDepth1,OSHeight1])rotate([0,90,0])cylinder(d=OSDiamater, h=WallThickness+.2, $fn=20);
    translate([-.1,OSDepth2,OSHeight1])rotate([0,90,0])cylinder(d=OSDiamater, h=WallThickness+.2, $fn=20);
    translate([OWidth-WallThickness-.1,OSDepth2,OSHeight1])rotate([0,90,0])cylinder(d=OSDiamater, h=WallThickness+.2, $fn=20);
    // Bottom mounting holes
    translate([(WallThickness/2)+(OSDiamater/2),BOSDepth1,-.1])cylinder(d=OSDiamater, h=WallThickness+.2, $fn=20);
    translate([OWidth-(WallThickness/2)-(OSDiamater/2),BOSDepth1,-.1])cylinder(d=OSDiamater, h=WallThickness+.2, $fn=20);
    translate([(WallThickness/2)+(OSDiamater/2),BOSDepth2,-.1])cylinder(d=OSDiamater, h=WallThickness+.2, $fn=20);
    translate([OWidth-(WallThickness/2)-(OSDiamater/2),BOSDepth2,-.1])cylinder(d=OSDiamater, h=WallThickness+.2, $fn=20);
    // material saving cutout
    translate([OWidth/2,ODepth/2,-WallThickness/2])holes(BedThickness*2, IWidth-(WallThickness*4), ODepth-(WallThickness*4), holeDiamater, holeDiamater);
}
// Hard drive nubs
translate([Spacing+(2*WallThickness),HDDepth1,HDHeight])rotate([0,90,0])cylinder(d=NubWidth, h=NubLength, $fn=20);
translate([Spacing+(2*WallThickness),HDDepth2,HDHeight])rotate([0,90,0])cylinder(d=NubWidth, h=NubLength, $fn=20);
translate([IWidth+(2*WallThickness)+Spacing-NubLength,HDDepth1,HDHeight])rotate([0,90,0])cylinder(d=NubWidth, h=NubLength, $fn=20);
translate([IWidth+(2*WallThickness)+Spacing-NubLength,HDDepth2,HDHeight])rotate([0,90,0])cylinder(d=NubWidth, h=NubLength, $fn=20);


// ========================================================================================
// Modules
// ========================================================================================

module holes(height,width,depth,diam,spacing) {
    echo("columns----------------------------------------------------------------------------");
    echo("height - ", height);
    echo("width - ", width);
    echo("depth - ", depth);
    echo("diam - ", diam);
    echo("spacing - ", spacing);
    columns_wide = floor((width-diam)/(diam+spacing))+1;
    echo("columns_wide - ", columns_wide);
    real_width = (columns_wide*diam)+((columns_wide-1)*spacing);
    echo("real_width - ", real_width);
    columns_deep = floor((depth-diam)/(diam+spacing))+1;
    echo("columns_deep - ", columns_deep);
    real_depth = (columns_deep*diam)+((columns_deep-1)*spacing);
    echo("real_depth - ", real_depth);

    for (x = [0:diam+spacing:real_width]) {
        for (y = [0:diam+spacing:real_depth]) {
            translate([x-real_width/2,y-real_depth/2,0])cube([diam, diam, height]);
        }
    }
}













