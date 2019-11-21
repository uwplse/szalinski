/* [Geometry */
Width=3.5;
LengthEnd=8;
Height=10;
Distance=1;
FieldWidth=160;
FieldLength=100;
SaveSpace=1; // [0:no, 1:yes]

/* [Hidden] */
xext=SaveSpace ? 2*LengthEnd+Width+Distance*2 : 2*LengthEnd+Distance;
yext=SaveSpace ? LengthEnd+ Distance : LengthEnd+Distance;

Anzahl_X = round(FieldWidth/xext-0.5);
Anzahl_Y = round(FieldLength/yext-0.5);
echo(str("Creating ", 
           Anzahl_X * (SaveSpace?2:1), 
           " * ", 
           Anzahl_Y, 
           " = ", 
           Anzahl_X * Anzahl_Y * (SaveSpace?2:1), " T-crosses."));

module T_polygon()
{
   polygon([
        [0,0],
        [2*LengthEnd,0],
        [2*LengthEnd,Width],
        [LengthEnd+Width/2,Width],
        [LengthEnd+Width/2,LengthEnd],
        [LengthEnd-Width/2,LengthEnd],
        [LengthEnd-Width/2,Width],
        [0,Width]
        ]);
}

linear_extrude(height=Height)
    for (i=[0:Anzahl_X-1])
        for(j=[0:Anzahl_Y-1])
            translate([i*xext,j*yext,0])
            {
                T_polygon();
                if (SaveSpace)
                    translate([LengthEnd+Width/2+Distance, yext-Distance,0])
                        scale([1,-1,1])
                            T_polygon();
            }