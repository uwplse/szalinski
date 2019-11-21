//Name tag inputs:

//Input the pet name
name="Daisy";

//Input the desired pet name text size
name_size=18;

//Input the phone number
number="989-400-7104";

//Input the desired phone number text size
number_size=7;


//Name tag code
$fn=100;
module tag(){difference(){cylinder(4,38,38); translate([0,25,-1]) cylinder(6,5,5);};};

module namenumber(){translate([0,-10,3]) linear_extrude(1.5)  text(size=name_size,name, halign="center" );}

difference(){tag(); namenumber();};


