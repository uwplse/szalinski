// Enter the spool hole diameter in mm
spoolHoleD = 32;

// Enter the thickness of the spool in mm
spoolHeight = 60;


difference()
{
    union()
    {
        cylinder(r = 55, h = 3);
        cylinder(r = (spoolHoleD-2)/2, h = spoolHeight+3);
    }
    cylinder(r = ((spoolHoleD-2)/2)-3, h = spoolHeight+3);
}
$fn = 100;