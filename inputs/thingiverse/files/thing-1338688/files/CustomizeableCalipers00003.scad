// Caliper (c) 2013 Wouter Robers
// updated 2016 Al Billington



/* [Dimensions] */
//The length of the measuring portion of the caliper
Length=150;
//The width of the measuring portion of the caliper
Width=15; //[10:30]
//The thickness of the measuring portion of the caliper
Thickness=3; //[1:6]
//The distance between each major tick mark (e.g. cm = 10, inches = 25.4)
Scale=10;
//The numbering multiplier for each major tick
MajorScaleIncrement = 1;
//The number of minor ticks between each major tick
MinorScale=10;
//the thickness of the edges of the Sliding piece above and below the ruler piece
outerEdgeThickness = 2.5; //[1:.5:5]
//Tolerance for the gap between the pieces.
Clearance=.1;

/* [Optional Features] */
// Bold Letters - more readable letters.  A higher value increases the effect.  Increases rendering time.
bold =0; // [0:.1:1]
// Hole Size - optional hole for hanging (0 to disable)
holeSize = 03; //[0:5]
//Brim Height - add brim circles to help with bed adhesion.  use your layer height to enable, 0 to disable
BrimCircleHeight = .3;
//The number of major scales that the base scale encompasses (recommended 2 for cm, 1 for in)
BottomScaleSize = 2;

/* [Advanced] */
//Thickness of the marker ticks
ScaleThickness=1;//[0:.1:2]
// This parameter compensates for filament width in some Printers (e.g. Makerbot Replicator).
Offset=0.15;





/* [Hidden] */
minorTickMinHeightRatio = .2;
minorTickMaxHeightRatio = .3;
maxNumDigits = floor(log(Length / Scale * MajorScaleIncrement)) + 1;
letterHeight = min(Width *(1 - minorTickMaxHeightRatio*1.35), Scale/maxNumDigits*1.05);
include <write/Write.scad>;
color([0.8,0.8,0.8]);

{

difference()
{
    if(holeSize >0)
{
    lenBuffer=Width;
}
    union() 
    {
    // Main body
    translate([-20,0])
          edgeProfile(Length + 21+ holeSize*3, Width);

    //Top Caliper Blade
    linear_extrude(height = Thickness) 
        caliperBlade(1);
    translate([-Offset,-40])
        brimCircle();
    translate([-15-Offset,Width+15])
        brimCircle();
    translate([Length,0])
        brimCircle();
    translate([Length,Width])
        brimCircle();

    }
// Main Body Scale
increment = Scale;
end = Length;

    for(i=[1:increment:end])
    {

        for(j=[0:1:MinorScale-1])
        {
            currentLocation = i + j*(increment/MinorScale);
        translate([currentLocation,-1,Thickness-ScaleThickness]) cube([0.4,Width*StripeLength(j),ScaleThickness*2]);
        }
        
        // Main Body Scale Numbers
        scaleNumber = floor(i/Scale - .001); // need .001 to avoid rounding errors
        translate([i+letterHeight/8+.5*bold,(Width*(1 - minorTickMaxHeightRatio*1.15))-bold-letterHeight/2,Thickness-ScaleThickness]) writeNumbers(str(scaleNumber * MajorScaleIncrement));
    }
    translate([Length + 1.5*holeSize, Width/2, -5])
    cylinder(100, holeSize, holeSize);

}


//Slider bottom part
translate([80,-40-Width,-Thickness/2]) 
{


    //Slider top part
    difference()
    {
        translate([0,0,Thickness/2])  
        union()
        {
            //Thumb grip
               
            translate([45,-Thickness-outerEdgeThickness]) 
                cylinder(r=4,h=Thickness);
                linear_extrude(height = Thickness*1.5) 
                scale([-1,1,1])
                caliperBlade(0);
                    translate([-Offset,-40])
                        brimCircle();
                    translate([-15-Offset,Width+20])
                        brimCircle();
                    translate([50,20])
                        brimCircle(); 
               translate([-20,0])
                        brimCircle(); 
            linear_extrude(height = Thickness/2) 
                polygon([
                [Offset,-Thickness],
                [Offset,Width+Thickness+Clearance+outerEdgeThickness],
                [-15-Offset,Width+Thickness+Clearance+outerEdgeThickness],
                [-15-Offset,Width+15+outerEdgeThickness],
                [-20,Width+10],
                [-20,-Thickness]]);
           linear_extrude(height = Thickness*1.5) 
                polygon([
                [Offset,Width+Thickness+Clearance+outerEdgeThickness],
                [Offset,-Thickness-outerEdgeThickness],
                [50,-Thickness-outerEdgeThickness],
                [50,Width+Thickness+Clearance+outerEdgeThickness]]);
           
        }
        // Scale Slider
        translate([1,0,0])
        for(i=[0:Scale/MinorScale:Scale])
        {   
            BottomScaleTotalLength = BottomScaleSize - 1 + (MinorScale-1)/MinorScale;
            translate([i*BottomScaleTotalLength,-10*StripeLength(floor(i/Scale*MinorScale)),Thickness*2-ScaleThickness]) 
            scale(1,1,1)
                cube([0.4,15, ScaleThickness*2]);
        }

        
            translate([-1,-.01,Thickness]) 

    translate([-30,0])
       scale(1.05,1,1)    
        edgeProfile(Length, Width + Clearance);

    }
}
} //color

function StripeLength(Value)= 
    minorTickMinHeightRatio+1*floor(1/(((Value)%MinorScale)+1))
    +(minorTickMaxHeightRatio - minorTickMinHeightRatio)*floor(1/(((Value)%(MinorScale/2))+1))
    -0.05*floor(1/(((Value)%2)+1));

module edgeProfile(length, width)
{
    steepness = .6;
    
    rotate([90,0,90]) 
            linear_extrude(height = length) 
    translate([- Thickness*steepness,0])
    polygon([
    [0,0],
    [Thickness*steepness,Thickness],
    [Thickness*steepness+width,Thickness],
    [width+2*Thickness*steepness, 0],
    ]
    );
}

module caliperBlade(enableTopBlade = 0)
{
        polygon([
        [0,0],
        [-Offset,0],
        [-Offset,-40],
        [-10,-30],
        [-20,0],
        [-20,Width],
        [-15+Offset,Width],
        [-15+Offset,Width+(15+outerEdgeThickness)*enableTopBlade],
        [-10,Width+(5+outerEdgeThickness)*enableTopBlade],
        [-10,Width],
        [0,Width]
        ]);
}

module writeNumbers(word)
{
    thickness = ScaleThickness*2;
    font="write/Letters.dxf";
    
    
    if(bold > 0)
    {
    minkowski()
    {
        write(word,h=letterHeight,t=thickness,font=font);
        cylinder(ScaleThickness,bold*.12,bold*0.7);
    }
    }
    else
    {
     write(word,h=letterHeight,t=thickness,font=font);
    }
}

module brimCircle()
{
    cylinder(BrimCircleHeight, 12, 12);
}
