// Number of Tubes at X axis
TubesX = 3;
// Number of Tubes at Y axis
TubesY = 4;
// Tube Height
TubeHeight = 150;
// Tube diameter
TubeDiameter = 16;
// Hole diameter
HoleDiameter = 18;
// Top table height
HolderHeight = 100;
// Walls thickness
HolderThickness = 2; // [2:50]
// Zero to remove
SecondTableHeight = 50;
// Inter tube space
InterTubeSpace = 4; // [2:50]
// Alternate even rows positions ?
AlternateEvenRows = "Yes"; // [Yes,No]
// Draw Sample Tubes?
DrawSampleTubes = "No";  // [Yes,No]
// Make half hole at bottom table?
MakeHalfHoleBottom = "Yes"; // [Yes,No]
DrawHatchOnWalls = "Yes"; // [Yes,No]
MakeSquaredHoles = "Yes"; // [Yes,No]
       
/* [HIDDEN] */
$fn=50;
bAlternateEvenRows = "Yes" == AlternateEvenRows; // Alternate even rows positions
bDrawSampleTubes = "Yes" == DrawSampleTubes;  // Draw Sample Tubes?
bMakeHalfHoleBottom ="Yes" == MakeHalfHoleBottom; // Make half hole at bottmo table?

modelX = (TubesX+0.5)*(HoleDiameter+InterTubeSpace);
modelY = (TubesY+0.5)*(HoleDiameter+InterTubeSpace);

holderThickness = HolderThickness < 2 ? 2: HolderThickness;

//wall();
All();

module All(){
    difference()
    {
        union(){
            translate([0,0,HolderHeight]) table();
            translate([0,0,SecondTableHeight]) table();
            table();
        }
        z = bMakeHalfHoleBottom ? (holderThickness/2) : 0;
        translate([0,0,0.01 + holderThickness-z]) // Better Drawing
            DrawTubes();
    }
    wall();
    translate([0,
              modelY-holderThickness,
              0])
        wall();
    if(bDrawSampleTubes)
        DrawTubes(TubeDiameter);
}
module wall(){
    if("Yes" == DrawHatchOnWalls){
        difference(){
            cube([modelX,
                  holderThickness,
                  HolderHeight]);
            intersection(){
                wallPatternRestriction();
                patternDiagonal();
            }
        }    
    }else{
        cube([modelX,
              holderThickness,
              HolderHeight]);
    }
}
module wallPatternRestriction(){
    translate([holderThickness,-holderThickness*0.5,holderThickness])
        cube([modelX-2*holderThickness,
              holderThickness*2,
              HolderHeight-2*holderThickness]);
}
module patternDiagonal(){
    for(i = [0:holderThickness*3:HolderHeight]){
        translate([0,-1,modelX/2+i]) rotate([0,45,0])
            cube([modelX*2,holderThickness*2,holderThickness]);
    }
}
module table(){
    cube([modelX,
          modelY,
          holderThickness]);
}
module DrawTubes(Diameter = HoleDiameter){
    color("lightblue")
    for(x = [1:TubesX])
    {    
        alternate = (x%2 == 0 && bAlternateEvenRows);
        for(y = [1: alternate ? TubesY-1:TubesY])
        {            
            offsetY = alternate ? (InterTubeSpace+HoleDiameter/2) : 0;
            
            if("Yes" == MakeSquaredHoles){
                translate([x*(HoleDiameter+InterTubeSpace)-HoleDiameter*0.75,
                       offsetY+y*(HoleDiameter+InterTubeSpace)-HoleDiameter*0.75,0])
                cube([Diameter,Diameter,TubeHeight]);
            }else{
                translate([x*(HoleDiameter+InterTubeSpace)-HoleDiameter/4,
                       offsetY+y*(HoleDiameter+InterTubeSpace)-HoleDiameter/4,0])
                cylinder(r = Diameter/2,h=TubeHeight);
            }
        }
    }
}