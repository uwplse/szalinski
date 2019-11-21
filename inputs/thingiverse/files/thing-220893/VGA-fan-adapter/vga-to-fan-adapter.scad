use <MCAD/boxes.scad>;

/* [Global] */
// What is the fan size?
fan_w=40;//[40,50]

// What is the position of the holes?
holes = "side";// [fan:Regular fan only, vga:VGA fan only, both:Both fans, cross:Cross position, side:On one side]

/* [Hidden] */
$fs=1;
$fa=1.5;

wall_w = 1.2;
vga_w = 41.5;
vga_h = 10;
vga_int_h = vga_h - 2.4;
vga_hole = 35;
fan_hole = fan_w * 0.8;
vga_hole_d = 2.5;
fan_hole_d = 3.5;
fan_nut_d = 6.2;
fan_nut_h = 3;
wire_w = 3;
wire_h = 1.7;


difference()
{
	if(vga_w > fan_w)
	{
		roundedBox([vga_w + wall_w, vga_w + wall_w, vga_h],1,true);
	}
	else
	{
		roundedBox([fan_w + wall_w, fan_w + wall_w, vga_h],1,true);
	}
	union()
	{
		translate([0,0, vga_int_h/2+1]) roundedBox([vga_w, vga_w, vga_h - vga_int_h + 2],1,true);
		cylinder(r = (vga_w-wall_w)/2, h = vga_h+2, center = true);
		if( holes == "vga" || holes == "cross" || holes == "both"  || holes == "side")
		{
			translate([ -vga_hole/2, -vga_hole/2, 0])
				cylinder(r = vga_hole_d/2, h = vga_h+2, center = true);
		}
		if( holes == "vga" || holes == "cross" || holes == "both" )
		{
			translate([  vga_hole/2,  vga_hole/2, 0])
				cylinder(r = vga_hole_d/2, h = vga_h+2, center = true);
		}
		if( holes == "vga" || holes == "both" )
		{
			translate([  vga_hole/2, -vga_hole/2, 0])
				cylinder(r = vga_hole_d/2, h = vga_h+2, center = true);
		}
		if( holes == "vga" || holes == "both"  || holes == "side" )
		{
			translate([ -vga_hole/2,  vga_hole/2, 0])
				cylinder(r = vga_hole_d/2, h = vga_h+2, center = true);
		}

		if( holes == "fan" || holes == "cross" || holes == "both" )
		{
			translate([ -fan_hole/2,  fan_hole/2, 0])
			{
				cylinder(r = fan_hole_d/2, h = vga_h+2, center = true);
				translate([ 0, 0, vga_int_h/2-(vga_h-vga_int_h)+2])
					cylinder(r = fan_nut_d/2, h = fan_nut_h+4, center = true);
			}
		}
		if( holes == "fan" || holes == "cross" || holes == "both" || holes == "side" )
		{
			translate([  fan_hole/2,  -fan_hole/2, 0])
			{
				cylinder(r = fan_hole_d/2, h = vga_h+2, center = true);
				translate([ 0, 0, vga_int_h/2-(vga_h-vga_int_h)+2])
					cylinder(r = fan_nut_d/2, h = fan_nut_h+4, center = true);
			}
		}
		if( holes == "fan" || holes == "both"  || holes == "side" )
		{
			translate([  fan_hole/2,  fan_hole/2, 0])
			{
				cylinder(r = fan_hole_d/2, h = vga_h+2, center = true);
				translate([ 0, 0, vga_int_h/2-(vga_h-vga_int_h)+2])
					cylinder(r = fan_nut_d/2, h = fan_nut_h+4, center = true);
			}
		}
		if( holes == "fan" || holes == "both" )
		{
			translate([ -fan_hole/2,  -fan_hole/2, 0])
			{
				cylinder(r = fan_hole_d/2, h = vga_h+2, center = true);
				translate([ 0, 0, vga_int_h/2-(vga_h-vga_int_h)+2])
					cylinder(r = fan_nut_d/2, h = fan_nut_h+4, center = true);
			}
		}
		translate([-wire_w/2, 0, - vga_h/2 - 1])
			cube([wire_w,	vga_w + fan_w, wire_h + 1]);
	}
}
