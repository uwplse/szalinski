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
wireCrossSectionMM=0.32; /*NB! In mm!!! Know your wires 26AWG=0.4mm, 28AWG=0.32, etc.*/
wiresToFit=4;
gapTolerance=1.12; /*Multiplier, how much bigger to make the hole compared to wire. */

/*********************************************************************/
/* Don't change below this unless you really know what you're doing! */
/*********************************************************************/
$fn=20;

difference() {
	intersection() {
		cube([width, width, length], center = true);
		cylinder(r= width/1.9, h = length, center = true);
		sphere(r = length/2);
	}
	cube([wireCrossSectionMM*gapTolerance, wireCrossSectionMM * wiresToFit*gapTolerance, length], center = true);
}



