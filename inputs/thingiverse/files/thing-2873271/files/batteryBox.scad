// tolerance between printed elements
tolerance = 0.3;
// tolerance for the battery size
batteryTolerance = 1;
// diameter of the battery. AA: 14.5, AAA: 10.5, 18650: 18
batteryDiameter = 14.5;
// length of the battery. AA: 50.5, AAA: 44.5, 18650: 65-70
batteryLength = 50.5;
// width of the walls
thinWallWidth = 1.5;

nRows = 4;
nColumns = 2;

// make notch for easier lid opening
fingerGrooves = 1; // [0:False,1:True]

// What object should be rendered
part = "boxAndLid_"; // [boxAndLid_:Both the box and the lid,box_:Only the box,lid_:Only the lid]

/* [Hidden] */

fingerDia = 10;
fingerAngle = -15;


//$fn = 50;

// Calculations with tolerances
batteryR = batteryDiameter/2 + batteryTolerance;
batteryL = batteryLength + batteryTolerance;
normalWallWidth = thinWallWidth*2;
//spacing = batteryR*2+normalWallWidth;
spacing = batteryR*2+thinWallWidth;

lidTaperHeight = batteryL/4-normalWallWidth;

module batteryHole()
{
    cylinder(h = batteryL+1, r = batteryR);
    translate([0,0,batteryL/2])
    {
        cube([batteryR, 2*batteryR+5*normalWallWidth, batteryL/2], true);
        cube([2*batteryR+5*normalWallWidth, batteryR, batteryL/2], true);
    }
}

module holes()
{
    for (r = [0:nRows-1])
    {
        for (c = [0:nColumns - 1])
        {
            translate([r*spacing, c*spacing])
            {
                batteryHole();
            }
        }
    }
}

originX = -batteryR - normalWallWidth;
originY = originX;

totalWidth = (nRows)*spacing-thinWallWidth+2*normalWallWidth;
totalDepth = (nColumns)*spacing-thinWallWidth+2*normalWallWidth;

module box(h)
{
    cubeSmallWidth = (nRows-1)*spacing; // cube goes from center of first battery to center of last battery
    cubeSmallDepth = (nColumns-1)*spacing;
    
    //cubeLargeWidth = (nRows)*spacing+normalWallWidth;
    cubeLargeWidth = totalWidth; //(nRows)*spacing-thinWallWidth+2*normalWallWidth;
    cubeLargeDepth = totalDepth; //(nColumns)*spacing-thinWallWidth + 2*normalWallWidth;
    
    cornerCylR = batteryR + normalWallWidth;
    
    boxHeight = h;
    

    // inner cubes of the box
    translate([batteryR + normalWallWidth,0,0])
    {
        cube([cubeSmallWidth, cubeLargeDepth, boxHeight]);
    }
    translate([0,batteryR + normalWallWidth,0])
    {
        cube([cubeLargeWidth, cubeSmallDepth, boxHeight]);
    }
    // rounded corners
    translate([batteryR+normalWallWidth,batteryR+normalWallWidth,0])
    {
        cylinder(boxHeight, r = cornerCylR);
    }
    translate([batteryR+normalWallWidth+spacing*(nRows-1),batteryR+normalWallWidth,0])
    {
        cylinder(boxHeight, r = cornerCylR);
    }
    translate([batteryR+normalWallWidth+spacing*(nRows-1),batteryR+normalWallWidth+spacing*(nColumns-1),0])
    {
        cylinder(boxHeight, r = cornerCylR);
    }
    translate([batteryR+normalWallWidth,batteryR+normalWallWidth+spacing*(nColumns-1),0])
    {
        cylinder(boxHeight, r = cornerCylR);
    }
}

taperWidth = (nRows)*spacing - thinWallWidth + 2*normalWallWidth - 2*thinWallWidth;
taperDepth = (nColumns)*spacing - thinWallWidth + 2*normalWallWidth - 2*thinWallWidth;

module taperedBox()
{
    newWidth = taperWidth;
    newDepth = taperDepth;
    newHeight = lidTaperHeight;
    intersection()
    {
        translate([thinWallWidth+tolerance/4, thinWallWidth+tolerance/4,batteryL+thinWallWidth-newHeight])
        {
            resize([newWidth-tolerance/2, newDepth-tolerance/2, newHeight])
            {
                box(newHeight);
            }
        }
        box(batteryL+thinWallWidth);
    }
    box(batteryL+thinWallWidth-newHeight);
}

module lid()
{
    lidHeight = lidTaperHeight + thinWallWidth;
    difference()
    {
        box(lidHeight);
        translate([thinWallWidth-tolerance/4, thinWallWidth-tolerance/4, thinWallWidth])
        {
            resize([taperWidth+tolerance/2, taperDepth+tolerance/2, lidHeight])
            {
                box(lidHeight);
            }
        }
    }
}

module fingerGroove(alpha, d)
{
    translate([-d*sin(alpha),0,-d*cos(alpha)])
    {
        rotate(a=alpha, v=[0,1,0])
        {
            translate([d/2,0,0])
            {
                cylinder(r=d/2, h=d);
            }
        }
    }
}

module grooves()
{
    translate([originX, originY, batteryL+thinWallWidth-lidTaperHeight-thinWallWidth])
    {
        translate([totalWidth-thinWallWidth, totalDepth/2, 0])
        {
            fingerGroove(fingerAngle, fingerDia);
        }
        translate([thinWallWidth, totalDepth/2, 0])
        {
            rotate(a=180, v=[0,0,1])
            {
                fingerGroove(fingerAngle, fingerDia);
            }
        }
        translate([totalWidth/2, totalDepth-thinWallWidth, 0])
        {
            rotate(a=90, v=[0,0,1])
            {
                fingerGroove(fingerAngle, fingerDia);
            }
        }
        translate([totalWidth/2, thinWallWidth, 0])
        {
            rotate(a=270, v=[0,0,1])
            {
                fingerGroove(fingerAngle, fingerDia);
            }
        }
    }
}

module boxWithHoles()
{
    difference()
    {
        translate([-batteryR-normalWallWidth, -batteryR-normalWallWidth, -thinWallWidth])
        {
            taperedBox();
        }
        holes();
        if (fingerGrooves)
        {
            grooves();
        }
    }
}
if (part == "boxAndLid_" || part == "box_")
{
    boxWithHoles();
}

if (part == "boxAndLid_" || part == "lid_")
{
    if (part == "boxAndLid_")
    {
        translate([-batteryR-normalWallWidth, -batteryR-normalWallWidth + (nColumns+1)*spacing, -thinWallWidth])
        {
            lid();
        }
    }
    else
    {
        lid();
    }
}
//holes();