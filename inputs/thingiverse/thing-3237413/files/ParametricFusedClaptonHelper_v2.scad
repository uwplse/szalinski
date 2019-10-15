/*********************************************************************/
/* Parametric Fused Clapton helper tool for wire building.           */
/* Desgined by: mastabug                                             */
/* Version: 1                                                        */
/* Released: 2018-02-08                                              */
/*********************************************************************/

/*********************************************************************/
/* Parameters that you can adjust to accomodate your specific needs. */
/*********************************************************************/
width = 8;
length = 12;
wireAWG = 28;
wiresToFit=4;
gapTolerance=1.12; /*Multiplier, how much bigger to make the hole compared to wire. */

/*********************************************************************/
/* Don't change below this unless you really know what you're doing! */
/*********************************************************************/
$fn=6;

function awg_to_mm(awg) = 0.127 * pow(92.0,(36.0 - awg) / 39.0);

difference() {
	intersection() {
		cube([width, width, length], center = true);
		cylinder(r= width/1.9, h = length, center = true);
		sphere(r = length/2);
	}
    wireDiameter = awg_to_mm(wireAWG);
    echo("WIRE DIAMETER", wireDiameter);
	rotate(90,0,0) cube([wireDiameter*gapTolerance, wireDiameter* wiresToFit*gapTolerance, length], center = true);
}