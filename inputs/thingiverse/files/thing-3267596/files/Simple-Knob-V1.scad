ShaftHeight = 15;
ShaftDiameter = 10;
FlatToRound = 7;
KnobHeight = 25;
KnobDiameter = 50;



$fs = .02;
$fa = 1;

module CutCylinder(H, D, FlatToRound)
{
    CutDepth = D - FlatToRound ;
    R = D / 2;
    CircleEdge =  (R  - (CutDepth / 2 ) );
    difference()
    {
        cylinder( h = H , d = D ,center = true );
        translate( [ CircleEdge , 0 , 0 ] )
        {
            cube( [  CutDepth +.01  , D , H + 0.01 ] , center = true );
        }
        
    }
    
}

module Knob( ShaftHeight , ShaftDiameter , FlatToRound ,
            KnobHeight, KnobDiameter  )
{
    difference()
    {
        union()
        {
            cylinder( h = KnobHeight , d = KnobDiameter , center = true );
            translate([ 0 - (KnobDiameter / 2)-0.5 , 0 , 0 ])
            {
                cube([1,1,KnobHeight], center = true);
            }
                
        }
        translate([0,0,( KnobHeight / 2 ) - ( ShaftHeight / 2 ) +0.01 ])
        {
            CutCylinder( ShaftHeight , ShaftDiameter , FlatToRound );
        }
    }
    
}


translate([ 1 + (KnobDiameter / 2 ) , (KnobDiameter / 2 ) , KnobHeight / 2 ])
{
    Knob( ShaftHeight , ShaftDiameter , FlatToRound , KnobHeight , KnobDiameter );
}