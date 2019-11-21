// The *interior* length of the jaw covers in mm.  This should be the size of your vise.  The walls will be added to this size.
interiorLength = 115;

// The width of the jaw covers as measured from the front of the face - this goes over the top of the vise and includes the jaw thickness.
totalWidth = 16;

// The height of the jaws as measured from the bottom of the jaw to the top
totalHeight = 20;

// The thickness of the gripping portion of the jaws.  Subtracted from the total width to determine how much goes over the top of the vise
jawThickness = 6;

// The thickness of all other walls aside from the jaws
wallThickness = 4;

// Number of magnets to put in the top of the jaws.  These will be equalled distributed across the length
numberOfMagnets = 4;

// Size of the magnets in mm.  If the magnets are square this will be the sides of the cube, otherwise this will be the diameter of the circle
magnetSize = 6;

// Height of the magnets in mm.  Make sure that your wall thickness is greater than this value
magnetDepth = 1;

// Set to 1 for square magnets or 0 for round magnets
squareMagnets = 0;

// Jaw face spacing between grip lines
gripSpacing = 10;

// Angle of the grip lines.  Values over 75 don't work so well.
gripAngle = 45;

// Number of round stock holder grooves.  If this is set to one, then the round stock holder position below is where it'll be placed.   
roundStockHolderCount = 1;

// Round stock holder groove.  Make sure the jaw thickness is enough that this won't go through the face
roundStockHolderGrooveSize = 4;

// Position of the stock holder groove as a percentage of the face - 0 to 100.  Keep in mind that 0 and 100 are going to be off the ends.  I recommend 10 and 90 as end stops but I'm not going to stand in your way.  If you specify multiple round stock holders the first will be placed here and all others will be placed based on this one.
roundStockHolderPosition = 10;

// Whether or not the round stock holder is horizontal or vertical.  Set to 0 for vertical and 1 for horizontal
roundStockHolderHorizontal = 0;

// Scaling value for the round stock holder.  Use this to make it wider without making it deeper - i.e. change the angle of the holder.  At 1 it creates a 45 degree angle. Values less than one make smaller angles and values greater than one make larger angles.  Setting this to zero effectively removes the round stock holder
roundStockHolderWidthScale = 1;

// How far apart to place the round stock holders.  This only takes effect if you have multiple round stock holders.  The first one will be placed at the initial position and all others will be placed this far away from it.  This distance should be greater than the round stock holder groove size * the round stock holder width scale.  If not, they're going to overlap.
gapBetweenRoundStockHolders = 30;

// The angle to face the jaws.  Set to 90 to face them down, 0 to face out, 180 to face in, 270 to face up, or 45 if you're feeling particularly adventurous
printingAngle = 90;

// Whether or not to print two jaws.  Set to 1 to get two jaws and 0 (or anything else really) to get a single jaw
printTwoJaws = 1;

// Create the first jaw
rotate ([printingAngle,0,0])
{
    CreateJaw();
}

// Create the second jaw if requested
if (printTwoJaws == 1)
{
    // The translation amount depends heavily on the angle.  Without this they end up
    // a long way apart or overlapping
    if (printingAngle < 45)
    {
        CreateSecondJaw(-3);
    }
    else if (printingAngle < 90)
    {
        CreateSecondJaw(-2);
    }
    else if (printingAngle < 200)
    {
        CreateSecondJaw(-1);
    }
    else
    {
        CreateSecondJaw(1);
    }
}

module CreateSecondJaw(translationSize)
{
    mirror([0,1,0])
    {
        // Move over a little and create a second jaw
        translate([0,totalWidth * translationSize,0])
        {
            rotate ([printingAngle,0,0])
            {
                CreateJaw();
            }
        }
    }
}

module CreateJaw()
{
    difference()
    {
        // The full jaw size
        cube([AddWalls(interiorLength, 2), totalWidth, totalHeight], false);

        // Subtract the "interior" of the jaws
        translate([wallThickness, jawThickness, wallThickness])
        {
            cube([interiorLength, SubtractJawWidth(totalWidth), AddWalls(totalHeight, -1)], false);
        }
        
        if (numberOfMagnets > 0)
        {
            // Subtract holes for the magnets
            translate([wallThickness, AddJawWidth(totalWidth)/2, wallThickness - magnetDepth])
            {
                CreateMagnetHoles(numberOfMagnets, interiorLength, magnetSize, magnetDepth, squareMagnets);
            }
        }
        
        // Subtract lines for the face "grip" pattern
        CreateGrip(gripSpacing, AddWalls(interiorLength, 2), totalHeight, gripAngle);

        for(moveCount = [1:roundStockHolderCount])
        {
            roundStockHolderCurrentOffset = gapBetweenRoundStockHolders * (moveCount - 1);
            // Create round stock groove
            if (roundStockHolderHorizontal == 0)
            {
                translate([(AddWalls(interiorLength, 2) * (roundStockHolderPosition / 100)) + roundStockHolderCurrentOffset, 0, 0])
                {
                    CreateRoundStockHolderGroove(roundStockHolderGrooveSize, roundStockHolderHorizontal, totalHeight);
                }
            }
            else
            {
                translate([0, 0, (totalHeight * (roundStockHolderPosition / 100)) + roundStockHolderCurrentOffset])
                {
                    rotate([0,90,0])
                    {
                        CreateRoundStockHolderGroove(roundStockHolderGrooveSize, roundStockHolderHorizontal, AddWalls(interiorLength, 2));
                    }
                }
            }
            
        }
    }
}

function AddWalls(length, numberWalls) = length + (wallThickness * numberWalls);

function AddJawWidth(length) = length + jawThickness;

function SubtractJawWidth(length) = length - jawThickness;

module CreateMagnetHoles(magnetCount, length, size, depth, magnetType)
{
    movementSize = length / (magnetCount + 1);
    for(moveCount = [1:magnetCount])
    {
        // Cubes are created at the corner of the existing location where
        // cylinders are not.  So for magnet type 1 (cube) we need to move 
        // by half the magnet size to get back to the right spot.  For round
        // magnets we multiply by the magnet type (0) and the translation vanishes
        // We can center the cube but then it's off vertically since it centers in all 
        // dimensions
        translate([moveCount * movementSize, -magnetType * (size/2), 0])
        {
            if (magnetType == 0)
            {
                cylinder(depth, d=size, center=false);
            }
            else
            {
                cube([size, size, depth], false);
            }
        }
    }
}

module CreateGrip(spacing, length, height, angle)
{
    // Since this is a random angle given by the user and I don't feel like working 
    // out the angles to get the precise length for each I'm just going for a big 
    // distance.  4x the length works great up until about 80 degrees at which point other things
    // start falling apart and I suddenly start caring less.
    extendedLength = length * 4;
    horizontalMovementCount = extendedLength / spacing;
    
    // First pass at the given angle
    CreateGripLines(angle, horizontalMovementCount, spacing, height, length, extendedLength);
    // Second pass at the opposite of that angle
    CreateGripLines(-angle, horizontalMovementCount, spacing, height, length, extendedLength);
}

module CreateGripLines(angle, movementCount, spacing, height, extendedLength)
{
    // If we're going to do an angle movement we have to 
    // back off a bit so that the angles intersect the main cube
    translate([-extendedLength, 0, 0])
    {
        for(moveCount = [1:movementCount])
        {
            translate([moveCount * spacing, 0, 0])
            {
                // Rotate to the grip angle that the user specified
                rotate ([0, angle, 0])
                {
                    // Turn so that the grip is nicely beveled and easier to print
                    // than square edges.  We're rotating separately here because if you 
                    // put both values in the same rotation it rotates first one way
                    // then the other and you really don't end up where you wanted to be
                    rotate([0, 0, 45])
                    {
                        cube([1, 1, height * 5], true);
                    }
                }
            }
        }
    }
}

module CreateRoundStockHolderGroove(size, horizontal, length)
{
    // Rotate so that we get a V groove that round stock fits in nicely
    scale([roundStockHolderWidthScale * 1, 1, 1])
    {
        rotate([0, 0, 45])
        {
            // Long length to make sure that we don't miss any edges
            cube([size, size, length * 2], true);
        }
    }
}