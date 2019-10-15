/* 
    Cord Switch Tip by dector (https://www.thingiverse.com/thing:3172373)

    This version is optimized for Thingiverse Customizer.
    For full sources and latest version checkout github repository:

    https://github.com/dector/things/tree/master/CordSwitchTip
*/

tipLength = 20;
tipDiameter = 7;

ropeWidth = 2.5;

capGap = 0.2;
tubeBigHoleDiameter = tipDiameter - 2;

capBigDiameter = tipDiameter;
capBigHeight = 2;
capSmallDiameter = tubeBigHoleDiameter - capGap;
capSmallHeight = 2;

tubeLength = tipLength - capBigHeight;
tubeDiameter = tipDiameter;
tubeBigHoleLength = 8;
tubeSmallHoleLength = tubeLength - tubeBigHoleLength;
tubeSmallHoleDiameter = ropeWidth;

$fa = 1;
$fs = 0.2;

// Tube
{
    difference() {
        cylinder(d = tubeDiameter, h = tubeLength);
        
        union() {
            cylinder(d = tubeSmallHoleDiameter, h = tubeSmallHoleLength);
            
            translate([0, 0, tubeSmallHoleLength]) cylinder(d = tubeBigHoleDiameter, h = tubeBigHoleLength);
        }
    }
}

// Cap
translate([tubeDiameter + 5, 0, 0]) {
    cylinder(d = capBigDiameter, h = capBigHeight);

    translate([0, 0, capBigHeight])
    cylinder(d = capSmallDiameter, h = capSmallHeight);
}
