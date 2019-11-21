totalLength = 373.55;
thickness = 19;
lockWidth = 5;
lockOffset = 5;
lockWiggleRoom = 0.15;
smallOpeningSize = 19;
largeOpeningSize = 40.5;
smallOpeningOffsetFromEnd = 89;
largeOpeningOffsetFromEnd = 60.5;
printSmallPieceIf1AndLargePieceIf0 = 1;

if(printSmallPieceIf1AndLargePieceIf0 == 1)
{
    translate([thickness/-2,totalLength/-2,0])
    {
        union()
        {
            difference(){
                cube([thickness,totalLength/2,thickness]);  //main body
                translate([(lockWiggleRoom+0.01)*-1,totalLength/2-(lockWidth),-0.005])
                {
                    cube([(3*(thickness/4))+lockWiggleRoom+0.01,lockWidth+lockWiggleRoom,thickness+0.01]);
                }
                translate([-0.005,smallOpeningOffsetFromEnd,thickness/2])
                {
                    cube([thickness+0.01,smallOpeningSize,thickness/2+0.01]);
                }
            }
            translate([0,totalLength/2,0])
            {
                difference()
                {
                cube([thickness, lockOffset, thickness]);
                translate([-0.01,-0.01,-0.01])
                    {
                        cube([thickness/4+lockWiggleRoom,lockOffset+0.02,thickness+0.02]);
                    }
                }
            }
        }
    }
}
else
{
    rotate([0,0,180])
    {
    translate([thickness/-2,totalLength/-2,0])
    {
        union()
        {
            difference(){
                cube([thickness,totalLength/2,thickness]);
                translate([(lockWiggleRoom+0.01)*-1,totalLength/2-(lockWidth),-0.005])
                {
                    cube([(3*(thickness/4))+lockWiggleRoom+0.01,lockWidth+lockWiggleRoom,thickness+0.01]);
                    translate([0,lockWidth,0])
                    {
                        cube([thickness/4+lockWiggleRoom,lockOffset+0.01,thickness+0.01]);
                    }
                }
                translate([thickness/2,largeOpeningOffsetFromEnd,-0.005])
                {
                    cube([thickness/2+0.01,largeOpeningSize,thickness+0.01]);
                }
            }
            translate([0,totalLength/2,0])
            {
                difference()
                {
                cube([thickness, lockOffset, thickness]);
                translate([-0.01,-0.01,-0.01])
                    {
                        cube([thickness/4+lockWiggleRoom,lockOffset+0.02,thickness+0.02]);
                    }
                }
            }
        }
    }
    }
}