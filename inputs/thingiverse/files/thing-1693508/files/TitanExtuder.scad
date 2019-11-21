// Single or double mount
DoDual = 0; // [0:Single;1:Double]

// C-Bot or D-Bot compatible?
dBot = 1; // [0:C-Bot;1:D-Bot]

TitanFront(DoDual);
*TitanBack(DoDual);
*Adaptor();
*CableTieMount();

/***********************************************************************/

$fn=360;

corner=12;

// Thickness of the plates
thickness = 5.2;

// Extra thickness for the hotend's mount
extraHotendThickness = 0.5;

// Overall width of motor
nema_width = 42.3;

// Spacing between M3 holes
nema_hole_spacing = 31;

// Clearance hole size for M3
nema_hole_size = 3.5;

// Clearance hole for motor boss
nema_boss_size = 27;

m3_bolt_boolean = 3.6;
m3_nut_embedded_dia = 6.35;
m3_nut_height = 2.4;

Length=[0,60];

/***********************************************************************/

module TitanFront(Dual)
{
	translate([-35.6, 0, 0]) XYCarriage(1, Dual);
}
	

module TitanBack(Dual)
{
    if (dBot) {
        DBotXYCarriage(0, Dual);
    } else {
        XYCarriage(0, Dual);
    }
}


module HalfCircle(diam, height)
{
	difference()
	{
		cylinder(d=diam, h=height);
		translate([0, -diam/2 - 0.1, -0.1]) cube([diam/2 + 0.1, diam + 0.2, height + 0.2]);
	}
}

module CableTieMount()
{
	difference()
	{
		union()
		{
			cube([13 + m3_bolt_boolean + 2, m3_bolt_boolean + 2, 2], center=true);
			translate([0, 0, 2]) cube([13 - m3_bolt_boolean - 2, m3_bolt_boolean + 2, 2], center=true);
		}
		
		translate([0, 0, -1.1])
		{
			translate([-13 / 2, 0, 0]) cylinder(d=m3_bolt_boolean, h=2.2);
			translate([ 13 / 2, 0, 0]) cylinder(d=m3_bolt_boolean, h=2.2);
		}
		
		translate([0, 0, 1.00]) cube([4.5, 10, 2], center=true);
	}
}

module Clamp(DoBoltHead=1)
{
	difference()
	{	
		hull()
		{
                translate([5.6-extraHotendThickness, -9, -1]) cube([thickness+extraHotendThickness, 1, 2]);
                translate([5.6-extraHotendThickness, -6.5, 9.5]) rotate([0, 90, 0]) cylinder(d=5, h=thickness+extraHotendThickness);
                translate([5.6-extraHotendThickness, 16, -1]) cube([thickness+extraHotendThickness, 1, 2]);
                translate([5.6-extraHotendThickness, 14.5, 9.5]) rotate([0, 90, 0]) cylinder(d=5, h=thickness+extraHotendThickness);
		}
        translate([0, 12, 5.8]) rotate([0, 90, 0]) cylinder(d=m3_bolt_boolean, h=20);
        translate([0, -4, 5.8]) rotate([0, 90, 0]) cylinder(d=m3_bolt_boolean, h=20);
	}
	
}

module XYCarriage(DoFront = 1, Dual = 0)
{
	difference()
	{
		union()
		{
			difference()
			{
				union()
				{
					translate([0, 0, 0]) hull()
					{
						translate([corner/2, corner/2, 0]) cylinder(d=corner, h=5);
						translate([corner/2, 80 - corner/2 + Length[Dual], 0]) cylinder(d=corner, h=5);
						translate([64.9 - corner/2, 80 - corner/2 + Length[Dual], 0]) cylinder(d=corner, h=5);
						translate([64.9 - corner/2, corner/2, 0]) cylinder(d=corner, h=5);
					}

					for (y=[0, 80 - corner + Length[Dual]])
						hull()
						{
							translate([64.9 - corner/2, y + corner/2, 5]) cylinder(d=corner, h=1);
							translate([62.9 - corner/2, y + corner/2, 5]) cylinder(d=corner, h=1);
						}

					if (DoFront)
					{
						translate([-37.04, 13, 0]) RoundedRect([39, 51, 5], 2);

						translate([-45.1 - 20, 30 - 1.5, 0]) RoundedRect([30, 20, 5], 2.5);
                        translate([-35, 30, 0]) HalfCircle(34, 5);
                        translate([-35, 47, 0]) HalfCircle(34, 5);
                        
						
						translate([54.1, 34.5, 5]) Clamp(0);
						
						if (Dual)
						{
							translate([-38, 63, 0]) cube([39, 11, 5]);
							translate([0, Length[1], 0])
							{
								translate([-37.04, 13, 0]) RoundedRect([39, 51, 5], 2);
								translate([54.1, 34.5, 5]) Clamp(0);
							}
                            
                            translate([0, Length[Dual] / 2 * 2, 0])
                            {						
                                translate([-45.1 - 20, 30 - 1.5, 0]) RoundedRect([30, 20, 5], 2.5);
                                translate([-35, 30, 0]) HalfCircle(34, 5);
                                translate([-35, 47, 0]) HalfCircle(34, 5);
                            }
						}
					}
				}	

				if (DoFront)
				{					
					if (Dual)
					{
						for(y = [0:60:60]) {
                            translate([-46.05 - 20, y - 1.5 + (Length[Dual] / 2), 0])
                            {
                                translate([5, 5, -0.1]) 
                                {
                                    cylinder(d=m3_bolt_boolean, h=5.2);
                                    cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);
                                }
                                translate([5, 15, -0.1]) 
                                {
                                    cylinder(d=m3_bolt_boolean, h=5.2);
                                    cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);
                                }
                            }
                        }
                    } else {
                        translate([-46.05 - 20, 30 - 1.5 + (Length[Dual] / 2), 0])
                        {
                            translate([5, 5, -0.1]) 
                            {
                                cylinder(d=m3_bolt_boolean, h=5.2);
                                cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);
                            }
                            translate([5, 15, -0.1]) 
                            {
                                cylinder(d=m3_bolt_boolean, h=5.2);
                                cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);
                            }
                        }
                    }

					translate([-11.04, 36, 0])
					{
						for (x = [-0.5:1:0.5])
							for (y = [-0.5:1:0.5])
								translate([x * nema_hole_spacing, y * nema_hole_spacing, 0])
									cylinder(h = thickness * 2, r = nema_hole_size / 2, center = true, $fn=150);

						cylinder(h = thickness * 2, r = nema_boss_size / 2, center = true, $fn = 250);
					}
					
					if (Dual)
					{
						translate([-11.04, 36 + Length[1], 0])
						{
							for (x = [-0.5:1:0.5])
								for (y = [-0.5:1:0.5])
									translate([x * nema_hole_spacing, y * nema_hole_spacing, 0])
										cylinder(h = thickness * 2, r = nema_hole_size / 2, center = true, $fn=150);

							cylinder(h = thickness * 2, r = nema_boss_size / 2, center = true, $fn = 250);
						}
					}
					
					translate([-35.14, 14.9, 2]) cube([45.2, 47.2, 5]);
					translate([31.9, 40, -0.1]) cylinder(d=30, h=5.2);
					
					if (Dual)
					{
						translate([0, Length[1], 0])
						{
							translate([-35.14, 14.9, 2]) cube([45.2, 47.2, 5]);
							translate([31.9, 40, -0.1]) cylinder(d=30, h=5.2);
						}
					}
				}
				else
				{
					// This needs to be offset the opposite direction to match the front
					translate([-35.14, 80 - 14.9 - 47.2 + 5, -0.1]) cube([45.2, 47.2 - 5, 5.2]);
					translate([64.9 / 2 - 0.4, 40, -0.1]) scale([1, 1.7, 1]) cylinder(d=30, h=5.2);
					
					for (y1=[25, 55])
						for (y2=[-5:5:5])
							translate([57.95, y1 + y2, -0.1]) cylinder(d=3.2, h=5.2);

					translate([57.95, 25 - 5, -0.1]) cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);;
					translate([57.95, 55 - 5, -0.1]) cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);;
					
					if (Dual) translate([0, Length[1], 0])
					{
						translate([-35.14, 80 - 14.9 - 47.2 + 5, -0.1]) cube([45.2, 47.2 - 5, 5.2]);
						translate([64.9 / 2 - 0.4, 40, -0.1]) scale([1, 1.7, 1]) cylinder(d=30, h=5.2);

						for (y1=[25, 55])
							for (y2=[-5:5:5])
								translate([57.95, y1 + y2, -0.1]) cylinder(d=3.2, h=5.2);

						translate([57.95, 25 - 5, -0.1]) cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);;
						translate([57.95, 55 - 5, -0.1]) cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);;
					}
				}

				translate([6, 6, -0.1]) cylinder(d=5.4, h=5.2);
				translate([6, 80 - 6 + Length[Dual], -0.1]) cylinder(d=5.4, h=5.2);

				for (y=[6, 80 - 6 + Length[Dual]])
					hull()
					{
						translate([64.9 - 6, y, -0.1]) cylinder(d=5.4, h=7.2);
						translate([62.9 - 6, y, -0.1]) cylinder(d=5.4, h=7.2);
					}
					
				translate([62.9 - corner, 67 + Length[Dual], 5]) rotate([0, -4, 0]) cube([16, 15, 2]);
				translate([62.9 - corner, -1, 5]) rotate([0, -4, 0]) cube([16, 15, 2]);
					
				translate([18.4, -0.1, 2]) cube([7.1, 13.1, 5]);
				translate([38.4, 80.2 - 13.2 + Length[Dual], 2]) cube([7.1, 13.1, 5]);
			}

			for (y=[1:2:11])
				translate([18.4, y, 2]) rotate([0, 90, 0]) cylinder(d=2, h=7.1, $fn=4);
			translate([18.4, 13, 2.5]) rotate([0, 90, 0]) cylinder(d=5, h=7.1, $fn=4);

			translate([64, 80 + Length[Dual], 0])
				rotate([0, 0, 180])
				{
					for (y=[1:2:11])
						translate([18.4, y, 2]) rotate([0, 90, 0]) cylinder(d=2, h=7.1, $fn=4);
					translate([18.4, 13, 2.5]) rotate([0, 90, 0]) cylinder(d=5, h=7.1, $fn=4);
				}
		}

		for (y=[5, 75 + Length[Dual]])
			for (x=[15.45, 28.45, 35.45, 48.45])
				translate([x, y, -0.1]) 
				{
					cylinder(d=3.2, h=5.2);
					cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);
				}
	}
			
	for (y=[5, 75 + Length[Dual]])
		for (x=[15.45, 28.45, 35.45, 48.45])
			translate([x, y, m3_nut_height - 0.2]) 
				cylinder(d=m3_nut_embedded_dia - 1, h=0.2);

	if (DoFront)
	{
        if (Dual)
        {
            for(y = [5:60:65]) {
                translate([-41 - 20, y - 1.5 + (Length[Dual] / 2), m3_nut_height - 0.2])
                {
                    cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
                    translate([0, 10, 0]) cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
                }
            
                translate([58.15, 30.5 + 7.5, m3_nut_height - 0.2])
                {
                    cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
                    translate([0, 20, 0]) cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
                }
            }
        }
        else
        {
            translate([-41 - 20, 35 - 1.5 + (Length[Dual] / 2), m3_nut_height - 0.2])
            {
                cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
                translate([0, 10, 0]) cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
            }
        }
    }
	else
	{
		translate([57.95, 20, m3_nut_height - 0.1]) cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
		translate([57.95, 50, m3_nut_height - 0.1]) cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
        
        if (Dual) {
            translate([57.95, 80, m3_nut_height - 0.1]) cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
            translate([57.95, 110, m3_nut_height - 0.1]) cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
        }
	}
}


module Adaptor()
{
	// This came from another project and I created the adaptor by
	// just cutting out the extra stuff.
	difference()
	{
		intersection()
		{
			union()
			{
				translate([0, 0, 6]) cylinder(d=16, h=62.3 - 9.7 - 6);
				translate([0, 0, 62.3 - 9.7]) cylinder(d=12, h=6);
				translate([0, 0, 62.3 - 3.7]) cylinder(d=16, h=3.7);
				cylinder(d1=0.4, d2=7.5, h=6);
			}

			translate([0, 0, 62.3 - 9.7 - 3.3]) cylinder(d=18, h=13);
		}

		cylinder(d=4.6, h=65);
	}
}


module RoundedRect(size, radius, center=false)
{
  x = size[0];
  y = size[1];
  z = size[2];

  if (center)
  {
    linear_extrude(height=z)
      hull()
      {
        // place 4 circles in the corners, with the given radius
        translate([(-x/2)+radius, (-y/2)+radius, 0])
          circle(r=radius);

        translate([(x/2)-radius, (-y/2)+radius, 0])
          circle(r=radius);

        translate([(-x/2)+radius, (y/2)-radius, 0])
          circle(r=radius);

        translate([(x/2)-radius, (y/2)-radius, 0])
          circle(r=radius);
     }
  }
  else
  {
    linear_extrude(height=z)
      hull()
      {
        // place 4 circles in the corners, with the given radius
        translate([radius, radius, 0])
          circle(r=radius);

        translate([x - radius, radius, 0])
          circle(r=radius);

        translate([x - radius, y - radius, 0])
          circle(r=radius);

        translate([radius, y - radius, 0])
          circle(r=radius);
      }
  }
}

module DBotXYCarriage(DoFront = 0, Dual = 0)
{
	difference()
	{
		union()
		{
			difference()
			{
				union()
				{
					translate([0, 0, 0]) hull()
					{
						translate([corner/2, corner/2, 0]) cylinder(d=corner, h=5);
						translate([corner/2, 80 - corner/2 + Length[Dual], 0]) cylinder(d=corner, h=5);
						translate([64.9 - corner/2, 80 - corner/2 + Length[Dual], 0]) cylinder(d=corner, h=5);
						translate([64.9 - corner/2, corner/2, 0]) cylinder(d=corner, h=5);
					}

					for (y=[0, 80 - corner + Length[Dual]])
						hull()
						{
							translate([64.9 - corner/2, y + corner/2, 5]) cylinder(d=corner, h=1);
							translate([62.9 - corner/2, y + corner/2, 5]) cylinder(d=corner, h=1);
						}

					if (DoFront)
					{
						translate([-37.04, 13, 0]) RoundedRect([39, 51, 5], 2);

						translate([0, Length[Dual] / 2, 0])
						{						
							translate([-45.1 - 20, 30 - 1.5, 0]) RoundedRect([30, 20, 5], 2.5);
							translate([-35, 30, 0]) HalfCircle(34, 5);
							translate([-35, 47, 0]) HalfCircle(34, 5);
						}
						
						translate([54.1, 34.5, 5]) Clamp(0);
						
						if (Dual)
						{
							translate([-38, 63, 0]) cube([39, 10, 5]);
							translate([0, Length[1], 0])
							{
								translate([-37.04, 13, 0]) RoundedRect([39, 51, 5], 2);
								translate([54.1, 34.5, 5]) Clamp(0);
							}
						}
					}
				}	

				if (DoFront)
				{
					translate([58.15, 30.5 + 7.5, -0.1])
					{
						cylinder(d=m3_bolt_boolean, h=20);
						cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);
						
						translate([0, 20, 0]) 
						{
							cylinder(d=m3_bolt_boolean, h=20);
							cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);
						}
					}
					
					if (Dual)
					{
						translate([58.15, 30.5 + 7.5 + Length[1], -0.1])
						{
							cylinder(d=m3_bolt_boolean, h=20);
							cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);
							
							translate([0, 20, 0]) 
							{
								cylinder(d=m3_bolt_boolean, h=20);
								cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);
							}
						}
					}
					
					translate([-46.05 - 20, 30 - 1.5 + (Length[Dual] / 2), 0])
					{
						translate([5, 5, -0.1]) 
						{
							cylinder(d=m3_bolt_boolean, h=5.2);
							cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);
						}
						translate([5, 15, -0.1]) 
						{
							cylinder(d=m3_bolt_boolean, h=5.2);
							cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);
						}
					}

					translate([-11.04, 36, 0])
					{
						for (x = [-0.5:1:0.5])
							for (y = [-0.5:1:0.5])
								translate([x * nema_hole_spacing, y * nema_hole_spacing, 0])
									cylinder(h = thickness * 2, r = nema_hole_size / 2, center = true, $fn=150);

						cylinder(h = thickness * 2, r = nema_boss_size / 2, center = true, $fn = 250);
					}
					
					if (Dual)
					{
						translate([-11.04, 36 + Length[1], 0])
						{
							for (x = [-0.5:1:0.5])
								for (y = [-0.5:1:0.5])
									translate([x * nema_hole_spacing, y * nema_hole_spacing, 0])
										cylinder(h = thickness * 2, r = nema_hole_size / 2, center = true, $fn=150);

							cylinder(h = thickness * 2, r = nema_boss_size / 2, center = true, $fn = 250);
						}
					}
					
					translate([-35.14, 14.9, 2]) cube([45.2, 47.2, 5]);
					translate([31.9, 40, -0.1]) cylinder(d=30, h=5.2);
					
					if (Dual)
					{
						translate([0, Length[1], 0])
						{
							translate([-35.14, 14.9, 2]) cube([45.2, 47.2, 5]);
							translate([31.9, 40, -0.1]) cylinder(d=30, h=5.2);
						}
					}
				}
				else
				{
					// This needs to be offset the opposite direction to match the front
					translate([-35.14, 80 - 14.9 - 47.2 + 5, -0.1]) cube([45.2, 47.2 - 5, 5.2]);
*					translate([64.9 / 2 - 0.4, 40, -0.1]) scale([1, 1.7, 1]) cylinder(d=30, h=5.2);
					
					translate([0, 36, 0]) {
	
 translate([-0.07, -0.35, 0]) translate([41.5 - 4.65, 27 - 4, -2]) cylinder(d=3.6, h=10);
 translate([-0.45, -0.35, 0]) translate([41.5 - 4.65 - 18.6, 27 - 4, -2]) cylinder(d=3.6, h=10);

	translate([-0.07, -0.35, 0]) translate([40 - 3.15, 27 - 4, -0.1]) cylinder(d=6.25, h=3, $fn=6);
	translate([-0.45, -0.35, 0]) translate([40 - 3.15 - 18.6, 27 - 4, -0.1]) cylinder(d=6.25, h=3, $fn=6);
	
	translate([0, -0.9, 0]) translate([19.5, 27 - 9.7, 5.5]) rotate([0, 90, 0]) cylinder(d=4.5, h=15);

	translate([0.4, -1.0, 0]) translate([11, 27 - 14, 5.5]) rotate([270, 0, 0]) cylinder(d=4, h=11);

					}
					
					for (y1=[25, 55])
						for (y2=[-5:5:5])
							translate([57.95, y1 + y2, -0.1]) cylinder(d=3.2, h=5.2);

					translate([57.95, 25 - 5, -0.1]) cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);;
					translate([57.95, 55 - 5, -0.1]) cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);;
					
					if (Dual) translate([0, Length[1], 0])
					{
						translate([-35.14, 80 - 14.9 - 47.2 + 5, -0.1]) cube([45.2, 47.2 - 5, 5.2]);
						translate([64.9 / 2 - 0.4, 40, -0.1]) scale([1, 1.7, 1]) cylinder(d=30, h=5.2);

						for (y1=[25, 55])
							for (y2=[-5:5:5])
								translate([57.95, y1 + y2, -0.1]) cylinder(d=3.2, h=5.2);

						translate([57.95, 25 - 5, -0.1]) cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);;
						translate([57.95, 55 - 5, -0.1]) cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);;
					}
				}

				translate([6, 6, -0.1]) cylinder(d=5.4, h=5.2);
				translate([6, 80 - 6 + Length[Dual], -0.1]) cylinder(d=5.4, h=5.2);

				for (y=[6, 80 - 6 + Length[Dual]])
					hull()
					{
						translate([64.9 - 6, y, -0.1]) cylinder(d=5.4, h=7.2);
						translate([62.9 - 6, y, -0.1]) cylinder(d=5.4, h=7.2);
					}
					
				translate([62.9 - corner, 67 + Length[Dual], 5]) rotate([0, -4, 0]) cube([16, 15, 2]);
				translate([62.9 - corner, -1, 5]) rotate([0, -4, 0]) cube([16, 15, 2]);
					
				translate([18.4, -0.1, 2]) cube([7.1, 13.1, 5]);
				translate([38.4, 80.2 - 13.2 + Length[Dual], 2]) cube([7.1, 13.1, 5]);
			}

			for (y=[1:2:11])
				translate([18.4, y, 2]) rotate([0, 90, 0]) cylinder(d=2, h=7.1, $fn=4);
			translate([18.4, 13, 2.5]) rotate([0, 90, 0]) cylinder(d=5, h=7.1, $fn=4);

			translate([64, 80 + Length[Dual], 0])
				rotate([0, 0, 180])
				{
					for (y=[1:2:11])
						translate([18.4, y, 2]) rotate([0, 90, 0]) cylinder(d=2, h=7.1, $fn=4);
					translate([18.4, 13, 2.5]) rotate([0, 90, 0]) cylinder(d=5, h=7.1, $fn=4);
				}
		}

		for (y=[5, 75 + Length[Dual]])
			for (x=[15.45, 28.45, 35.45, 48.45])
				translate([x, y, -0.1]) 
				{
					cylinder(d=3.2, h=5.2);
					cylinder(d=m3_nut_embedded_dia, h=m3_nut_height, $fn=6);
				}
	}
			
	for (y=[5, 75 + Length[Dual]])
		for (x=[15.45, 28.45, 35.45, 48.45])
			translate([x, y, m3_nut_height - 0.2]) 
				cylinder(d=m3_nut_embedded_dia - 1, h=0.2);

	if (DoFront)
	{
		translate([-41 - 20, 35 - 1.5 + (Length[Dual] / 2), m3_nut_height - 0.2])
		{
			cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
			translate([0, 10, 0]) cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
		}
	
		translate([58.15, 30.5 + 7.5, m3_nut_height - 0.2])
		{
			cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
			translate([0, 20, 0]) cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
		}
		
		if (Dual)
		{
			translate([58.15, 30.5 + 7.5 + Length[Dual], m3_nut_height - 0.2])
			{
				cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
				translate([0, 20, 0]) cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
			}
		}
	}
	else
	{
		translate([57.95, 20, m3_nut_height - 0.1]) cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
		translate([57.95, 50, m3_nut_height - 0.1]) cylinder(d=m3_nut_embedded_dia - 1, h=0.2);
	}
}