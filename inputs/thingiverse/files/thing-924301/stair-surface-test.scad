// You must modify the gcode you generate! (Cura has TweakAtX plugin, not sure about other slicers)
DoYouUnderstandYouMustModifyTheGCodeThisMakes=1; // [1:What?, 2:Yes I understand]

NumberOfSteps = 7;
Labels=["206","208","210","212","214","216","218"];
ReverseLabelOrder=0; //[0:False, 1:True]
Reverse=ReverseLabelOrder == 1;

NotesLine1="0.1 layer";
NotesLine2="inland purple";

// NOT guaranteed to work for all combinations (simply have not tested it)
StepSize=[10,10,2];
StepHeight=10;
Edge1Thickness=0.8;
Edge2Thickness=4;


FontFace=0;// [0:Arial Bold,1:Liberation Sans]
FontFacesInCustomizer=["Arial:style=Bold","Liberation Sans"]; //TODO add more
Font=FontFacesInCustomizer[FontFace];

FontDepth=0.5;
FontDirection=1; //[0:Horizontal, 1:Vertical]

//Increase the default facet number to produce smoother curves
fn_override = 0; //[0:Default, 24:Better (24), 50:High quality (50), 100:Super HQ (100)]
$fn = fn_override;

/* [Hidden] */

TWEAK=0.01;
TWEAK2=TWEAK*2;



$fn_override = $fn;
function getCustomFn(base) = max(base, $fn_override);



//My disclamer strategy...
if (DoYouUnderstandYouMustModifyTheGCodeThisMakes==2)
{
    for (i = [1:NumberOfSteps])
    {
        translate([0,StepSize[1]*(i-1),0])
            step(StepHeight*i, Reverse ? Labels[NumberOfBlocks-i-1] : Labels[i-1]);
    }
    //Notes lines:
    color("blue") translate([0,NumberOfSteps*StepSize[1]-StepSize[1]*.2,0]) rotate([90,0,-90])
        renderNotes([NotesLine1, NotesLine2], Font, StepSize[0] * 0.4, FontDepth+TWEAK);
}
else
{
    rotate([90,0,0])
    linear_extrude(2)
        union(){
        text("Learn/confirm you know how to modify", 10);
            translate([0,-12,0])
        text("the temp when generating the gcode", 10);}
}


module step(height, label)
{
    difference()
    {
        union()
        {
            //Step surface
            translate([0,0,height-StepSize[2]])
                cube(StepSize);
            //Edge1
            cube([Edge1Thickness, StepSize[1], height]);
            //Edge2
            translate([StepSize[1]-Edge2Thickness,0,0])
                cube([Edge2Thickness, StepSize[1], height]);
        }
        
        union()
        {
            blockWidth=StepSize[0];
            fontSizePct=0.4;
            fontXOffsetPct=0.05;
            fontZOffsetPct=0.3;
            
            if (FontDirection==1)
            {
                //Temp label, vertical
                translate([blockWidth-FontDepth, (StepSize[1]-(blockWidth * fontSizePct))/2, height]) rotate([90,90,90])
                            linear_extrude(FontDepth+TWEAK)
                            text(str(label), font=Font, size=blockWidth * fontSizePct);
            }
            if (FontDirection==0)
            {
                //Temp label, horizontal
                translate([blockWidth-FontDepth, FontDepth, height - 2*(blockWidth * fontZOffsetPct)]) rotate([90,0,90])
                            linear_extrude(FontDepth+TWEAK)
                            text(str(label), font=Font, size=blockWidth * fontSizePct);
            }
        }
    }
}

module renderNotes(textArray, fontFace, fontSize, fontDepth)
{
    length=len(textArray)-1;
    for (i = [length:-1:0])
    {
        label=textArray[i];
        
        translate([0,(fontSize*1.2)*(length-i)+fontSize*.3,0])
        linear_extrude(FontDepth+TWEAK)
            text(str(label), font=fontFace, size=fontSize);
    }
}
