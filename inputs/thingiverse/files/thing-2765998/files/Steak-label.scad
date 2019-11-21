echo(version=version());
$fn = 150 ;

font = "Arial";
//Cube
length=120;
width=3;
height=28;
text="My steak !";
//Hex thing
umfang=12;
hoehe=200;
mass=0;

//Letters
letter_size = 20;
letter_height = 5;

function cot(x)=1/tan(x);
offset = width / 2 - letter_height / 2;

module Hexagon(umfang,hoehe)
{
	angle = 360/6;		
	mass = umfang * cot(angle);
	echo(angle, cot(angle), mass);
	echo(acos(.6));

	union()
	{
		rotate([0,0,0])
			cube([umfang,mass,hoehe],center=true);
		rotate([0,0,angle])
			cube([umfang,mass,hoehe],center=true);
		rotate([0,0,2*angle])
			cube([umfang,mass,hoehe],center=true);
	}

}
module letter(l) {

  linear_extrude(height = letter_height) {
    text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
  }
}

difference() {
  union() {
    color("gray") cube([length,width,height], center = true);
    translate([0, -offset, 0]) rotate([90, 0, 0]) letter(text);
  }
}

color("grey")
rotate ([90,0,0]) 
translate([0,0,-hoehe/2-width/2])
Hexagon(umfang,hoehe);


