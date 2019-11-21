// by Les Hall
//


font = "knewave.dxf";
font_size=13;
text_depth=4;
$fn=16;


// ************* Executable part *************
use <Write.scad>


module text(message)
{
	for (line = [0:len(message)-1])
	translate([0, -font_size*1.5*line, 0])
	write(message[line],t=text_depth,h=font_size,center=true,font=font);
}


module opampA(message)
{
	// text
	translate([40, 55, 0])
	text(message);

	// triangle
	cylinder(r=40, h=6, center=true, $fn=3);

	// inputs
	for(side=[-1:2:1])
	translate([-30, side*15, 0])
	{
		rotate(90, [0, 1, 0])
		cylinder(r=3, h=20, center=true);
		translate([0, 10, 0])
		if (side < 0)
			text(["5"]);
		else
			text(["6"]);
	}

	// output
	translate([45, 0, 0])
	{
		rotate(90, [0, 1, 0])
		cylinder(r=3, h=20, center=true);
		translate([0, 10, 0])
		text(["7"]);
	}

	// power
	for(side=[-1:2:1])
	translate([0, side*30, 0])
	{
		rotate(90, [0, 1, 0])
		rotate(90, [1, 0, 0])
		cylinder(r=3, h=20, center=true);

		translate([10, 0, 0])
		if (side < 0)
			text(["4"]);
		else
			text(["8"]);
	}
}




module opampB(message)
{
	// text
	translate([40, 55, 0])
	text(message);

	// triangle
	cylinder(r=40, h=6, center=true, $fn=3);

	// inputs
	for(side=[-1:2:1])
	translate([-30, side*15, 0])
	{
		rotate(90, [0, 1, 0])
		cylinder(r=3, h=20, center=true);
		translate([0, 10, 0])
		if (side < 0)
			text(["3"]);
		else
			text(["2"]);
	}

	// output
	translate([45, 0, 0])
	{
		rotate(90, [0, 1, 0])
		cylinder(r=3, h=20, center=true);
		translate([0, 10, 0])
		text(["1"]);
	}
}


module resistor(message)
{
	// zig zags
	for(segment=[0:6])
	translate([(segment-3)*cos(30)*10, 0, 0])
	rotate(90, [0, 1, 0])
	rotate(pow(-1, segment)*60, [1, 0, 0])
	if ( (segment > 0) && (segment < 6) )
		cylinder(r=2, h=20, center=true);
	else if (segment > 0)
		translate([0, 0, -5*cos(30)])
		cylinder(r=2, h=10, center=true);
	else
		translate([0, -0, 5*cos(30)])
		cylinder(r=2, h=10, center=true);

	// end wires
	for(side=[-1:2:1])
	translate([side*cos(30)*3.5*10, 0, 0])
	rotate(90, [0, 1, 0])
	cylinder(r=2, h=10, center=true);

	// text
	translate([0, 40, 0])
	text(message);
}


module capacitor(message)
{
	// plates
	for(side=[-1:2:1])
	translate([side*5, 0, 0])
	rotate(90, [0, 1, 0])
	rotate(90, [1, 0, 0])
	cylinder(r=2, h=20, center=true);

	// end wires
	for(side=[-1:2:1])
	translate([side*20, 0, 0])
	rotate(90, [0, 1, 0])
	cylinder(r=2, h=30, center=true);

	// text
	translate([0, 40, 0])
	text(message);
}


module comparator(trans=[0, 0, 0], rot=0, rotVec=[0, 0, 1])
{
	translate(trans)
	rotate(rot, rotVec)
	{
		// opamp used as comparator
		opampA(["U1A", "LM358"]);

		// Vcc
		translate([0, 40, 0])
		{
			rotate(90, [0, 1, 0])
			cylinder(r=2, h=20, center=true);

			translate([0, 10, 0])
			text(["Vcc"]);
		}

		// GND
		translate([0, -45, 0])
		rotate(-90, [0, 0, 1])
		cylinder(r=10, h=2, center=true, $fn=3);
	
		// hysteresis resistor
		translate([0, -120, 0])
		resistor(["R1", "1MEG"]);

		// feedback wires
		// 
		// left horizontal wire
		translate([-45, -120, 0])
		rotate(90, [0, 1, 0])
		cylinder(r=2, h=40, center=true);
		// right horizontal wire
		translate([45, -120, 0])
		rotate(90, [0, 1, 0])
		cylinder(r=2, h=40, center=true);
		// left vertical wire
		translate([-65, -67.5, 0])
		rotate(90, [0, 1, 0])
		rotate(90, [1, 0, 0])
		cylinder(r=2, h=100, center=true);
		// right vertical wire
		translate([65, -60, 0])
		rotate(90, [0, 1, 0])
		rotate(90, [1, 0, 0])
		cylinder(r=2, h=120, center=true);
		// output wire
		translate([60, 0, 0])
		rotate(90, [0, 1, 0])
		cylinder(r=2, h=10, center=true);
		// input wire
		translate([-70, -15, 0])
		rotate(90, [0, 1, 0])
		cylinder(r=2, h=60, center=true);
		// dot
		translate([-65, -15, 0])
		sphere(r=4);

		// upper bias resistor
		translate([-100, 70, 0])
		rotate(90, [0, 0, 1])
		resistor(["R2", "100k"]);
		// VCC

		// lower bias resistor
		translate([-100, -70, 0])
		rotate(90, [0, 0, 1])
		resistor(["R3", "100k"]);

		// wires
		// 
		// middle wire
		translate([-100, 0, 0])
		rotate(90, [0, 1, 0])
		rotate(90, [1, 0, 0])
		cylinder(r=2, h=80, center=true);
		// dot
		translate([-100, -15, 0])
		sphere(r=4);

		// Vcc
		translate([-100, 105, 0])
		{
			rotate(90, [0, 1, 0])
			cylinder(r=2, h=20, center=true);

			translate([0, 10, 0])
			text(["Vcc"]);
		}

		// GND
		translate([-100, -110, 0])
		rotate(-90, [0, 0, 1])
		cylinder(r=10, h=2, center=true, $fn=3);
	
		// upper reference resistor
		translate([-170, 70, 0])
		rotate(90, [0, 0, 1])
		resistor(["R4", "100k"]);
	
		// lower reference resistor
		translate([-170, -70, 0])
		rotate(90, [0, 0, 1])
		resistor(["R5", "100k"]);

		// wires
		// 
		// middle wire
		translate([-170, 0, 0])
		rotate(90, [0, 1, 0])
		rotate(90, [1, 0, 0])
		cylinder(r=2, h=80, center=true);
		// horizontal wire
		translate([-105, 15, 0])
		rotate(90, [0, 1, 0])
		cylinder(r=2, h=130, center=true);
		// dot
		translate([-170, 15, 0])
		sphere(r=4);

		// Vcc
		translate([-170, 105, 0])
		{
			rotate(90, [0, 1, 0])
			cylinder(r=2, h=20, center=true);

			translate([0, 10, 0])
			text(["Vcc"]);
		}

		// GND
		translate([-170, -110, 0])
		rotate(-90, [0, 0, 1])
		cylinder(r=10, h=2, center=true, $fn=3);

		// input resistor
		translate([-250, 0, 0])
		resistor(["R6", "2.2k"]);	
		// horizontal wire
		translate([-192.5, 0, 0])
		rotate(90, [0, 1, 0])
		cylinder(r=2, h=45, center=true);
		// dot
		translate([-170, 0, 0])
		sphere(r=4);

		// input capacitor
		translate([-320, 0, 0])
		capacitor(["C1", "47uF"]);
	}
}

module base()
{
	translate([-400, -175, -5])
	cube([550, 350, 6]);
}


translate([0, 130, 0])
color([0, 0.75, 0.75])
text(["Input", "Comparator", "Circuit"]);

color([0, 0.5, 0])
base();

color([0.75, 0.75, 0])
comparator();

