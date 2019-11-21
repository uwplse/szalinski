// preview[view:north east, tilt:top diagonal]

// Top cone base diameter. Usually equal or slightly bigger than the top diameter.
cone2_max=30;

// Top cone top diameter. Usually equal or slightly smaller than the base radius
cone2_min=28;

// Height of the top cone
cone2_height=20;

// Wall thickness of the top cone
cone2_wall=3;

// Top cone protuding width of barb-like outer rings to prevent the hose from slipping (zero to disable)
cone2_barb_width=0;


// Bottom cone base diameter (the outside of the lower cone. Usually equal or slightly smaller than the top, unless you want to make a funnel)
cone1_min=15;

// Bottom top diameter (usually equal or slightly bigger than the base radius, unless you want to make a funnel)
cone1_max=18;

// Height of the bottom cone
cone1_height=30;

// Wall thickness of the bottom cone
cone1_wall=2;

// Bottom cone protuding width of barb-like outer rings to prevent the hose from slipping (zero to disable)
cone1_barb_width=0.8;


// Junction height: how tall is the connection between the two cones. Make sure it is thick enough so as to avoid excessively thin walls and/or steep inner overhang. Twice the wall thickness is a good starting value.
join_height=3;

// Barb flatness ratio (advanced). Sets barb height as a factor of barb size. Eg. 1.0 means a 1:1 x/y aspect ratio (aka 45°), and 2.0 makes a flatter barb.
barb_flatness_ratio=2;

// Barb spacing ratio (advanced). Sets barb spacing as a factor of barb height. So 0 means adjacent barbs, and 1 give an identical flat space as the barbs themselves.
barb_spacing_ratio=2;

// Barb symetry ratio (advanced). Avoid overhang by using a strictly positive value (easier print). Symetrical barbs correspond to 0.5. Negative values give concave barbs, and makes sense only for the lower cone. Values higher than 0.5 lead to reversed barbing (probably useless). -0.2 to 1.2 are good values
barb_skew_ratio=0.15;

// This is only useful to double-check the objet shape and walls before printing
check_guts=0; // [0:no,1:yes]

//
// universal_hose_adapter.scad
//
// By Jérémie FRANCOIS / MoonCactus / contact@tecrd.com
//
// Check the webservice on http://www.tecrd.com/page/liens/universal_hose_adapter (temporary URL)
// Remixed for the Thingiverse customizer (less usable imo for now...)
//



// $fa=10;		// how fine the curved objets are (max angle between broken parts)
tol=1*0.05;	// tolerance (mostly useful for openscad preview)

function xpos(dmin, dmax, height, hpos) = ( dmin+(dmax-dmin)*hpos/height )/2;

module hollow_cone(dmin, dmax, height, wall, barb_width) // TODO: spokes
{
	if(dmin>0 && dmax>0 && height>0)
	{
		// Hollow cone body
		difference()
		{
			cylinder(r1=dmin/2, r2=dmax/2, h=height);
			if(wall>0)
				translate([0,0,-tol])
					cylinder(r1= dmin/2-wall, r2= dmax/2-wall, h=height+2*tol);
		}
		// Babed-like rings
		if(barb_width>0 && barb_flatness_ratio!=0)
		{
			for(bs=[barb_width*barb_flatness_ratio : 1 : barb_width*barb_flatness_ratio]) // this is just to simulate a "local" variable... :(
			{
				for(hpos=[
					bs/2
					: barb_width * barb_flatness_ratio * (1 + barb_spacing_ratio)
					: height - bs/2]
				)
				{
					translate([0,0,hpos])
					rotate_extrude()
						polygon( points=[
							[xpos(dmin,dmax,height,hpos)-tol, 0],
							[xpos(dmin,dmax,height,hpos + bs*(1-barb_skew_ratio)) + barb_width, bs * (1-barb_skew_ratio)],
							[xpos(dmin,dmax,height,hpos + bs)-tol, bs],
						] );
				}
			}
		}
	}
}

	difference()
	{
		union()
		{
			color([1,0,0])
			hollow_cone(cone1_min, cone1_max, cone1_height, cone1_wall, cone1_barb_width);

			color([0,0,1])
				translate([0,0,cone1_height+join_height+cone2_height])
					rotate([180,0,0])
						hollow_cone(cone2_min, cone2_max, cone2_height, cone2_wall, cone2_barb_width);

			// intermediate section
			if(join_height>0)
			{
				color([0,1,0])
				translate([0,0,cone1_height])
				rotate_extrude()
					polygon( points=[
						[ cone1_max/2-cone1_wall, 0],
						[ cone1_max/2, 0],
						[ max(cone1_max,cone2_max)/2, join_height/2],
						[ cone2_max/2, join_height],
						[ cone2_max/2-cone2_wall, join_height],
						[ min(cone1_max/2-cone1_wall,cone2_max/2-cone2_wall), join_height/2],
					] );
			}
		}

		if(check_guts!=0)
		{
			// I failed to understand how/if the customizer default view worked, so I split the part twice at opposite places... :p
			scale([0.5,1,1]) rotate([0,0,45]) translate([0,0,-tol]) cube([100,100,100]);
			//scale([0.5,1,1]) rotate([0,0,180+45]) translate([0,0,-tol]) cube([100,100,100]);
		}
	}
