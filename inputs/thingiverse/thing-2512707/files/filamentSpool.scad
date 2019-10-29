width = 22;
spoolDiameter = 135;
holeDiameter = 51.5;
spoolOuterNumberOfSides=25;
spoolInnerNumberOfSides=75;
sideThickness = 3;
pegWidth = 7;
pegHoleTolerance = 0.2;
numberOfPegs=4;
numberOfFilamentHoles = 6;
filamentHoleWidth=2.35;
generatePeggedSide=true;
generateHoledSide=true;
windingHoleSize = 2.2;
windingHoleOffset = 0.1;

module side(pegs){
    difference(){
            union(){
                //largeWheel on outside
                cylinder($fn=spoolOuterNumberOfSides,h=sideThickness,d=spoolDiameter);
                //inner spool wheel
                cylinder($fn=spoolInnerNumberOfSides,h=width/2,d=holeDiameter+17.5*2);
                //pegs
                if(pegs)
                {
                    for(pegRotate=[0:numberOfPegs]){
                        rotate([0,0,(360/numberOfPegs)*pegRotate]){
                            translate([holeDiameter/2+17.5/2,0,0]){
                                cylinder($fn=6,d=pegWidth,h=width-1);
                            }
                        }
                    }
                }
            }
            
            //peg holes
            if(!pegs){
                for(pegRotate=[0:numberOfPegs]){
                        rotate([0,0,(360/numberOfPegs)*pegRotate]){
                            translate([holeDiameter/2+17.5/2,0,1]){
                                cylinder($fn=6,d=pegWidth+pegHoleTolerance,h=width);
                            }
                        }
                    }
                    //winding hole
                translate([holeDiameter/2+17.5+windingHoleOffset+windingHoleSize,0,-0.01]){
                                cylinder($fn=50,d=windingHoleSize,h=width);
                }
                rotate([0,0,15]){
                    translate([holeDiameter/2+17.5+windingHoleOffset+windingHoleSize,0,-0.01]){
                                cylinder($fn=50,d=windingHoleSize,h=width);
                }
                }
            }
            
            //filament holder holes
            for(filHoles=[0:numberOfFilamentHoles]){
                rotate([0,0,(360/numberOfFilamentHoles)*filHoles]){
                            translate([spoolDiameter/2-5,0,-0.01]){
                                cylinder($fn=50,d=filamentHoleWidth,h=width);
                            }
                        }
            }
            
            //big hole
            translate([0,0,-0.01]){
                cylinder($fn=50,h=width/1.5,d=holeDiameter);
            }
        }
}

if(generatePeggedSide)
{
    translate([spoolDiameter/2+5,0,0])
    {
        side(true);
    }
}

if(generateHoledSide)
{
    translate([0-spoolDiameter/2-5,0,0]){
        side(false);
    }
}