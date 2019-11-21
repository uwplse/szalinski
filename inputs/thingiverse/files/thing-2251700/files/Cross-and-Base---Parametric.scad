// Parametric Cross

/* [1 General Parameters] */
// Error (mm/100)
toleranceAmt = 5; // [1:1:100]
// Object
object = 3;  // [0:Cross,1:Base,2:Both,3:Display]
// Resolution
resolution = 75; // [15:15:150]

/* [2 Cross Parameters] */
// Height of Cross (mm)
crossHeight=130; // [15:5:150]
// Width Percentage of Height
crossWidthPct = 60; // [40:5:75]
// Depth Percentage of Width
crossDepthPct = 17; // [10:5:25]
// Display Color
crossColor = "SaddleBrown";
// Cross distance(mm) from wall of base. 
crossOffset = 8; // [0:1:50]

/* [3 Base Parameters] */
// Display Color
baseColor = "DarkKhaki";
// Width Percentage of Cross Width
baseWidthPct = 180; // [50:10:250]
baseTopAngle = 5;

/* [4 Text Parameters] */
// Space from top to first line
lineOffsetTop = 30; // [5:1:70]
// Space between lines
lineOffset = 9; // [0:1:40]
// Display Color
textColor = "MediumSlateBlue";
textFont = "Arial Rounded MT Bold";
textSize = 5; // [3:12]

/* [5 Message Text] */
message0 = "For God so loved the world that";
message1 = "He gave His only begotten Son";
message2 = "that whosoever believeth in Him should";
message3 = "not perish, but have everlasting life.";
message4 = "";
message5 = "";
message6 = "";
message7 = "";
message8 = "";
message9 = "";

message = [message0,message1,message2,message3,message4,message5,message6,message7,message8,message9];

// Calculations
$fn=resolution;
tolerance = toleranceAmt / 100; // Tolerance unit:  mm/100
crossWidth = crossHeight * (crossWidthPct / 100);
crossDepth = crossWidth * (crossDepthPct / 100);
horizontalHeight = crossDepth;
verticalOffset = (crossHeight / 4) - (horizontalHeight / 2);
baseWidth = crossWidth * (baseWidthPct / 100);
baseDepth = crossDepth * 5;
baseCutout = crossDepth + tolerance;
baseHeight = crossDepth;

// Determine which object is requested and call the appropriate module.
if(object)
{
    if(object==1) // 1 = Base
        base();
    else
        if(object==2) // 2 = Both
            translate([0,-crossHeight/2,0])
            {
                rotate([-90,0,0])
                {
                    display(); // 3 (False) = Display model.
                } // End rotate()
            } // End translate()
        else
            translate([0,baseDepth/2,0])
                display();
}
else
    cross(); // 0 (False) = Cross

/* display() - Display the cross in the base.
- Call the module to draw the cross.
- Rotate the cross to an upright orientation.
- Move the cross into position.
- Call the module to draw the base.
*/
module display()
{
    base();
    translate([0,-((crossDepth/2)+crossOffset),crossHeight/2+1])
        rotate([90,0,0])
            cross();
} // End display()

/* cross() - Create the cross.
- Create the vertical spar of the cross.
- Create the horizontal spar of the cross.
- Move the horizontal spar into place.
- Color the cross for display visibility.
*/
module cross()
{
    color(crossColor)
    {
        cube([crossDepth,crossHeight,crossDepth], center=true);
        translate([0,verticalOffset,0])
            cube([crossWidth,crossDepth,horizontalHeight], center=true);
    } // End color();
} // End cross()

/* base() - Create the base.
- Create the bottom cube of the base.  Using a 3D object instead of a square to allow for the hull() function.
- Create the top cube and add it to a sphere to get rounded corners.
- Rotate the top cube to create a pitched top to the base.
- Move the top cube into place.
- Merge the top and bottom cubes to form the shape of the base.
- Center the base on the X/Y axis.
- Cut out the hole (cube) for the cross from the base.
- Move the cutout into place on the base.
- Call the module to add the message to the top of the base.
- Color the base for display visibility.
*/
module base()
{
    color(baseColor)
    difference()
    {
        translate([-baseWidth/2,-baseDepth,0])
        {
            hull()
            {
                cube([baseWidth,baseDepth,.1]);
                translate([2,2,baseHeight-(4+(baseDepth*tan(baseTopAngle)))])
                    rotate([baseTopAngle,0,0])
                        minkowski()
                        {                    
                            cube([baseWidth-4,(baseDepth/cos(baseTopAngle))-4,.1]);
                            sphere(2);
                        } // End minkowski()
            } // End hull()
        } // End translate()
        if(object!=2)
            translate([0,-((baseCutout/2)+crossOffset),baseHeight+1])
                cube([baseCutout,baseCutout,baseHeight*2], center=true);
    } // End difference()
    message();
} // End base()

/* message() - Create the message text for the base.
- Loop through the message array spacing the text as it is printed.
- Rotate the text to match the pitch of the top of the base.
- Move the text so it sits on top of the base.
- Color the text for display readability.
*/
module message()
{
    color(textColor)
    {
        translate([0,0,(baseHeight+3.5)-((baseDepth*tan(baseTopAngle)))])
            rotate([baseTopAngle,0,0])
            {
                for(i=[0:1:len(message)-1])
                    translate([0,-((lineOffset*i)+lineOffsetTop),0])
                        linear_extrude(.5)
                            text(message[i], size=textSize, font=textFont, valign="top", halign="center", center=true);
            } // End rotate()
    } // End color()
}// End message()