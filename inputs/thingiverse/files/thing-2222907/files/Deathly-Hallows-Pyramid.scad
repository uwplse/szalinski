/* [Hidden] */
$fn=75;
pyramidAngle = 60; // Angle of Pyramid Sides

/* [Configure] */
// Total Height of object
totalHeight = 100; //[50:220]
// % of Total Height
pyramidHeightPct = 75; //[70:80]
// % of Pyramid Height
sphereRadiusPct = 27; //[27:32]
// % of Pyramid Height
sparSidePct = 7; //[3:20]

pyramidHeight = totalHeight * (pyramidHeightPct / 100);
sphereRadius = pyramidHeight * (sphereRadiusPct / 100);
sparSide = pyramidHeight * (sparSidePct / 100);
cornerXY = pyramidHeight / tan(pyramidAngle);
sparLength = sqrt(pow(pyramidHeight,2) + pow(cornerXY,2));
topAngle = 180 - (pyramidAngle * 2);
halfBaseLength = pyramidHeight / tan(pyramidAngle);
topZOffset = pyramidHeight - (sparSide / sin(topAngle/2));
baseXOffset = (topZOffset - sparSide) * tan(topAngle/2);
baseZOffset = sparSide;
fontSize = pyramidHeight * .13;
textOffset1 = pyramidHeight * .45;
textOffset2 = pyramidHeight * .60;
textCutOutDepth = sparSide / 2;


difference() // Pyramid
{
    pyramid();
    cutOut();
    rotate([0,0,90])
        cutOut();
}

// Sphere
translate([0,0,sphereRadius+baseZOffset-1])
    sphere(sphereRadius, center=true, $fn=200);

// Tower Base
translate([0,0,totalHeight/4])
    cylinder(r=sparSide/2, h=totalHeight/2, center=true); 

// Tower Top
translate([0,0,totalHeight * .75])
    cylinder(r1=sparSide/2, r2=.75, h=totalHeight/2, center=true); 

module cutOut()
{


    translate([0,sparLength,baseZOffset])
        rotate([90,0,0])
            linear_extrude(sparLength*2)
                polygon([
                    [-baseXOffset,0],
                    [baseXOffset,0],
                    [0,topZOffset-baseZOffset]
                ]);
} // End cutOut()


module pyramid()
{
    polyhedron(
        points=[
            [cornerXY,cornerXY,0],
            [cornerXY,-cornerXY,0],
            [-cornerXY,-cornerXY,0],
            [-cornerXY,cornerXY,0],
            [0,0,pyramidHeight]
            ],
        faces=[
            [0,1,4],
            [1,2,4],
            [2,3,4],
            [3,0,4],
            [3,2,1,0]
            ]
    );
} // End pyramid()
