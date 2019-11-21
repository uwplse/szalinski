
/* LED Light Bar for MakerGear M2
   Version 1.0
   by Kirk Saathoff
   2013-06-06
 */

diameter = 20;
length = 180;
LED_Count = 6;
ledRotation = 45;

/* [Hidden] */
ledDiam = 5;
ledDiam2 = 6;
ledLen = 8.76;


module led()
{
	color("red") {
	sphere(r=ledDiam/2, $fn=25);
	cylinder(h=ledLen-(ledDiam/2), r=ledDiam/2, $fn=25);
	translate([0, 0, ledLen-(ledDiam/2)-1])
		cylinder(h=1, r=ledDiam2/2, $fn=25);
	}
	translate([0, 1, 0])
		cube([.25, .25, 25]);
	translate([0, -1, 0])
		cube([.25, .25, 25]);
}


module lightBar(showLEDs)
{
	spacing = length / LED_Count;
	//union()
	difference()
	{
		difference()
		{
		//	union()
			difference()
			{
				cylinder(h=length, r=diameter/2, $fn=50);
				translate([0, -diameter/2, -.02]) {
					cube([diameter/2, diameter, length+.04]);
				}
			}
			translate([0, 0, -.02])
				cylinder(h=length+.04, r=(diameter/2)-4, $fn=25);
		}
		for (ledHoleNum = [1:LED_Count]) {
			translate([0, 0, ((ledHoleNum-1)*spacing)+(spacing/2)])
				rotate([0, 90, ledRotation])
					translate([0, 0, -diameter/1.5]) {
						cylinder(h=10, r=5.7/2, $fn=20);
						translate([0, 0, 5.5]) {
							cylinder(h=5, r=7.3/2, $fn=20);
						}
					}
		}
	}
	if (showLEDs) {
		for (ledHoleNum = [1:LED_Count]) {
			translate([0, 0, ((ledHoleNum-1)*spacing)+(spacing/2)])
				rotate([0, 90, ledRotation])
					translate([0, 0, -diameter/2])
						led();
		}
	}
}

showLEDs = 0;
showTestLED = 0;

rotate([0, 90, 0])
	lightBar(showLEDs);

if (showTestLED) {
	translate([50, 50, 0])
		led();
}

