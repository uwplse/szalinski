// base thickness
bt = 2.2;

// center most circular cutout diameter
innerD = 26;

// diameter of inner hole that fits around the knob
knobHoleD = 55.79 + 0.6;

// thickness of shield around knob
kt = 2;

// height of shield around knob
kh = 45;

// knob distance, center to center
kd = 79.39;

// U shaped piece that connects 2 knobs
//! arm X (width of the arm)
uX = 25.6;

//! armY (length of arm from center of pot to bridge in arm)
uY1 = 29;

//! UY ( total Y from pot center to top oy connecting U)
uY2 = 45;

// fancy it up by slicing a chunk off the top
//! slice angle
slA = 155;

//! slice Z
slZ = 40;

// end of configurable parameters
$fn = 50;

module base( x )
{
    translate([x, 0, 0])
    {
        difference()
        {
            union()
            {
                cylinder( kh, d = knobHoleD + (2 * kt));
                translate( [-uX/2, 0, 0] )
                    cube( [uX, uY1, bt] );
                
            }
            union()
            {
                translate( [0, 0, bt] )
                    cylinder( kh, d = knobHoleD );
                
                translate( [0, 0, -1] )
                    cylinder( kt + 2, d = innerD );
            }
        }
    }
}

difference()
{
    union()
    {
        base( 0 );
        base( kd );
        translate( [-uX/2, uY1, 0] )
            cube( [kd + uX, uY2 - uY1, bt] );
    }
    union()
    {
        translate( [-500, 500, slZ - 120] )
            rotate( slA, [ 1, 0, 0] )
                cube( [1000, 1000, 100] );
    }
}
