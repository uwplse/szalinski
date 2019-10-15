//
// Scotty Pole Socket
// Designed to hold a length of 1.25" 1120 SDR PVC
// as a Fishing Pole Holder
// Andrew L. Sandoval - 18 August 2018
throughHoleDiameter = 8.0;
boltHeadDiam = 14; // hex
baseDiameter = 21.5;   // .875"
baseSlotWidth = 7.0;
baseSlotDepth = 3.2; // 1.0 
baseHeight = 8.5;
midSectionDiam = 18.8;
midSectionHeight = 17.5;
pegSectionDiam = 21.8;
pegSectionHeight = 21.0;
topSectionDiam = 46.0;
topSectionHeight = 12.0;
pvcWallThickness = 2.75;  // 2.5 is tight
pvcSocketDepth = 8.0;
pvcPipeOD = 43.0;  // 42.5
pegHeight = 9.2;
pegDiam = 2.54; // .1"

module ScottyBase()
{
    // Base with bolt head cutout
    difference()
    {
        cylinder(h=baseHeight, d=baseDiameter, $fn=720);
        cylinder(h=baseHeight, d=boltHeadDiam, $fn=6);
    // slot cutout
    translate([-(baseDiameter/2), 0, baseHeight/2])
        cube([baseSlotDepth, baseSlotWidth, baseHeight], center= true);
    }
}

module ScottyMid()
{
    // MidSection
    translate([0, 0, baseHeight])
    {
        cylinder(h=midSectionHeight, d=midSectionDiam, $fn=720);
    }
}

module ScottyPegSection()
{
    //
    // Section Three (peg section)
    translate([0, 0, (baseHeight + midSectionHeight)])
    {
        cylinder(h=pegSectionHeight, d=   pegSectionDiam, $fn=720);
    }
}

module ScottyPegs()
{
    //
    // Pegs
    // center of slot angle 0
    pegVector = [0, 30, 90, 150, 180, 210, 270, 330];
    for(a=pegVector)
    {
        x = sin(a) * (pegSectionDiam / 2);
        y = cos(a) * (pegSectionDiam / 2);
        z = (baseHeight + midSectionHeight + pegSectionHeight) - pegHeight;
        if(x > 0)
        {
            x = x + (pegDiam / 4);
        }
        else
        {
            x = x + (pegDiam / 4);
        }
        if(y > 0)
        {
            y = y - (pegDiam / 4);
        }
        else
        {
            y = y + (pegDiam / 4);
        }
        echo("Angle ", a, " x: ", x, "y: ", y, " z: ", z);
        translate([x, y, z])
        {
            cylinder(h=pegHeight, d=pegDiam, $fn=720);
        }
    }
}

module ScottyTop()
{
    //
    // Top Section
    z = (baseHeight + midSectionHeight + pegSectionHeight);
    zHolder = (z + topSectionHeight) - pvcSocketDepth;
    echo("Top z: ", z, " Holder Z: ", zHolder);
    {
        difference()
        {
            translate([0, 0, z])
            cylinder(h=topSectionHeight, d=topSectionDiam, $fn=720);
            translate([0, 0, zHolder])
            cylinder(h=pvcSocketDepth, d=pvcPipeOD, $fn=720);
        }
        translate([0, 0, zHolder])
        cylinder(h=pvcSocketDepth, d=pvcPipeOD - (2*pvcWallThickness), $fn=720);
    }
}

module ScottyOuter()
{
    union()
    {
        ScottyBase();
        ScottyMid();
        ScottyPegSection();
        ScottyTop();
        ScottyPegs();
    }
}

// Do it:
rotate([0, 180, 0])
difference()
{
    ScottyOuter();
    // Bolt Hole:
    cylinder(h = (20 + (topSectionHeight + midSectionHeight + pegSectionHeight + baseHeight)), d = throughHoleDiameter, $fn=720);
}
