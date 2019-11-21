//in mm; consider shaving off a couple mm for a tight fit
socket_width=25;

/* [Hidden] */

$fn=128;
$fassung=socket_width;
$fas_halt=$fassung+3;
$halt_height=30;
module halterung() // centered on 0, open toward x
	{
	rotate([0,0,-45]) translate([0,0,-15])
		cylinder(h=$halt_height,d=$fas_halt);
	}

//rotate(z=45) translate(z=-10) halterung();

$width = 50;
$depth = 3;
$height = 50; // must be >= $width
$einkerbung = 20;
$rundecke = 10;

module sockel()
	{
	difference()
		{
		union()
			{
			translate([-$depth*3/2,-$width/2,0]) cube([$depth*3,$width,$height-$width/2]);
			translate([-$depth*1.5,0,$height-$width/2]) rotate([0,90,0]) cylinder(h=$depth*3,d=$width);
			translate([$depth/2,$width/2-$rundecke/2,0]) rotate([0,90,0]) cylinder(h=$depth,d=$rundecke);
			translate([$depth/2,-($width/2-$rundecke/2),0]) rotate([0,90,0]) cylinder(h=$depth,d=$rundecke);
			}
		translate([-$depth/2,-($width/2 + 5),-10]) cube([3,$width+10,$einkerbung]);
		hull()
			{
			translate([0,$width/2-$rundecke*1.5,$rundecke/2]) rotate([0,90,0]) cylinder(h=$depth*2,d=$rundecke);
			translate([0,-($width/2-$rundecke*1.5),$rundecke/2]) rotate([0,90,0]) cylinder(h=$depth*2,d=$rundecke);
			translate([0,-($width-$rundecke*2)/2,-$rundecke*2]) cube([$depth*2,$width-$rundecke*2,$rundecke]);
			}
		}
	}

$deg = 30;
//$ausgleich_x = ($fas_halt/2) / cos($deg);
//$ausgleich_z = ($fas_halt/2) / cos(90-$deg);
$ausgleich = sin($deg) * $halt_height;

//translate([($ausgleich_x)-($depth*1.5),0,50+$ausgleich_z/2])
//translate([$ausgleich,0,0])

module remme()
	{
	rotate([0,0,-45]) translate([0,0,-15])
		{
		translate([0,0,-5]) cylinder(h=$halt_height+10,d=$fassung);
		translate([0,0,-5]) cube([$fassung,$fassung,$halt_height+10]);
		}
	}


difference()
	{
	union()
		{
		sockel();
		translate([-$depth*1.5,0,$height]) 
			rotate([0,-$deg,0]) 
			translate([$fas_halt/2,0,-$halt_height/2]) halterung();
		}
	translate([-$depth*1.5,0,$height]) 
		rotate([0,-$deg,0]) 
		translate([$fas_halt/2,0,-$halt_height/2]) remme();
	}
