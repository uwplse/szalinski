// Created by Ryman08

// Values changable in Thingiverse
// Width of the gift tag
TagWidth = 40;

// Length of the gift tag
TagLength = 80;

// Size of the hole used for the ribbon/string
RibbonSize = 5; //[3:10]

// Size of the text on the gift tag. I found that text under 8 was too small for Slic3r and my nozzle.
TextSize = 8; //[5:15]

// First line on the `To` field
ToTextLine1 = "Father";

// Second line on the `To` field, if necessary
ToTextLine2 = "";

// First line on the `From` field
FromTextLine1 = "Your";

// Second line on the `From` field, if necessary
FromTextLine2 = "Son";

// Default values not to be available in Thingiverse
/* [Hidden] */
TagHeight = 1;
TagBorderHeight = 2;
TagBorderThickness = 2;

// Create the base tag object
difference()
{
    CreateBaseTag(TagWidth, TagLength, TagHeight);
    CreateRibbonHole(TagWidth, TagLength, TagHeight, RibbonSize);
};

// Create the outline tag object
difference()
{
    CreateBaseTag(TagWidth, TagLength, TagBorderHeight);
    CreateBaseTag(TagWidth-TagBorderThickness, TagLength-TagBorderThickness, TagBorderHeight);
};

// Create the outline of the RibbonHole
difference()
{
    CreateRibbonHole(TagWidth, TagLength, TagBorderHeight, RibbonSize, TagBorderThickness);
    CreateRibbonHole(TagWidth, TagLength, TagBorderHeight, RibbonSize);
}

// Append To/From Text
CreateToFromText(TagWidth-TagBorderThickness, TagLength-TagBorderThickness, TagBorderHeight, TextSize);
CreateToNameText(TagWidth-TagBorderThickness, TagLength-TagBorderThickness, TagBorderHeight, TextSize, ToTextLine1, ToTextLine2);
CreateFromNameText(TagWidth-TagBorderThickness, TagLength-TagBorderThickness, TagBorderHeight, TextSize, FromTextLine1, FromTextLine2);

module CreateBaseTag(TagWidth, TagLength, Height)
{
    linear_extrude(Height)
    {
        difference() {
            // inital rectangle
            square([TagWidth,TagLength], true);
            
            // Set offset origin
            Y_ZeroOffset = TagLength/2;
            X_ZeroOffset = TagWidth/2;
            
            // bottom cut triangle
            polygon(points=[[0-X_ZeroOffset,0-Y_ZeroOffset],[(TagWidth/3)-X_ZeroOffset,0-Y_ZeroOffset],[0-X_ZeroOffset,(TagWidth/3)-Y_ZeroOffset]], paths=[[0,1,2]],convexity=10);
            
            // top cut triangle
            polygon(points=[[TagWidth-(TagWidth/3)-X_ZeroOffset,0-Y_ZeroOffset],[TagWidth-X_ZeroOffset,0-Y_ZeroOffset],[TagWidth-X_ZeroOffset,TagWidth/3-Y_ZeroOffset]], paths=[[0,1,2]],convexity=10);
        };
    };
};

module CreateRibbonHole(TagWidth, TagLength, Height, holeSize, TagBorderThickness = 0)
{
    translate([0,(-TagLength/2) + holeSize])
    {
        cylinder(d=holeSize + TagBorderThickness, h=Height, $fn=100);
    };
}

module CreateToFromText(TagWidth, TagLength, Height, TextSize)
{
    // TagWidth is 20
    // Height of text is 5
    // midpoint of text is 2.5 and the surrounding area is 10
    // midpoint of text should be moved to 5
    // adjust midpoint by 2.5 (10/2-2.5)
    // 18/2 = 9/2 = 4.5 - 1.5 = 3
    translate([-TagWidth/4,(-TagLength/2) + 10])
    {
        rotate(90)
        {
            linear_extrude(Height)
            {
                text(text="To:", size=TextSize, halign="left", valign="center");
            };
        };
    };
    
    translate([TagWidth/4,(-TagLength/2) + 10])
    {
        rotate(90)
        {
            linear_extrude(Height)
            {
                text(text="From:", size=TextSize, halign="left", valign="center");
            };
        };
    };
};

module CreateToNameText(TagWidth, TagLength, Height, TextSize, ToTextLine1, ToTextLine2)
{
    HorPosition = (TagLength/2) - 2;
    if (ToTextLine2 == "")
    {
        VertPosition = -(TagWidth/4 - TextSize/2) ;
        PositionAndWriteText(VertPosition, HorPosition, Height,  ToTextLine1, TextSize, "right");
    }
    else
    {
        VertPosition1 = -(TagWidth/4 - TextSize/2) - TextSize/1.75;
        PositionAndWriteText(VertPosition1, HorPosition, Height,  ToTextLine1, TextSize, "right");
        VertPosition2 = -(TagWidth/4 - TextSize/2) + TextSize/1.75;
        PositionAndWriteText(VertPosition2, HorPosition, Height,  ToTextLine2, TextSize, "right");
    };
};

module CreateFromNameText(TagWidth, TagLength, Height, TextSize, FromTextLine1, FromTextLine2)
{
    HorPosition = (TagLength/2) - 2;
    if (FromTextLine2 == "")
    {
        VertPosition = (TagWidth/4 + TextSize/2) ;
        PositionAndWriteText(VertPosition, HorPosition, Height,  FromTextLine1, TextSize, "right");
    }
    else
    {
        VertPosition1 = (TagWidth/4 + TextSize/2) - TextSize/1.75;
        PositionAndWriteText(VertPosition1, HorPosition, Height,  FromTextLine1, TextSize, "right");
        VertPosition2 = (TagWidth/4 + TextSize/2) + TextSize/1.75;
        PositionAndWriteText(VertPosition2, HorPosition, Height,  FromTextLine2, TextSize, "right");
    };
};

module PositionAndWriteText(Vert, Hor, Height, TextString, TextSize, TextAlign)
{
    translate([Vert, Hor])
    {
        rotate(90)
        {
            linear_extrude(Height)
            {
                text(text=TextString, size=TextSize, halign=TextAlign);
            };
        };
    };
};