/* [Container] */
// Create a tile container for hexagon tiles.
// example: Catan tiles: Mayfair editions: base + seafarers + 5-6 expansion for both.
// diameter of hex tile (mm).  Measure point to point across center of tile.  Add a few extra mm so tiles fit nicely.
_d = 92;  

// Length of container (mm). Add a few extra mm so tiles fit nicely.
_l = 102; 

// thickness of container walls (mm)
_wall_thickness = 1.6; 

/* [Lid parameters] */
// generate a lid (instead of container) that will fit the storage container defined by other params
_generate = "container"; //[container, lid] 

// wall thickness of lid
_lid_wall_thickness = 1.2; 
// The lid will be snug, depending on printer.  Provide a negative to make tighter, positive to make looser fitting lid (ex: 0.2, will make a looser fitting lid.
_lid_fudge = 0;  

module hex_holder(diam, l, wall, extra_cut = 0)
{
	outer_d = diam + (wall * 2);
	outer_l = l + (wall * 2);
	difference() {
		rotate([0,0,30]) cylinder(outer_l,d=outer_d,d=outer_d, center = true, $fn=6);
		rotate([0,0,30]) cylinder(l,d=diam,d=diam, center = true, $fn=6);
		translate([0,(diam * (11/16)) - extra_cut,0])  
            cube([outer_d + .1,outer_d +  .1,outer_l + .1], center=true);
	}
}


if(_generate == "lid")
{
    rotate([60,0,0])
    rotate([0,90,0])
    hex_holder(_d + (2 * _wall_thickness) + 1.5 + _lid_fudge
                , _l + (2 * _wall_thickness) + 1.2 + _lid_fudge
                , _lid_wall_thickness 
                ,((21/16) * _wall_thickness) + _lid_wall_thickness);
}
if(_generate == "container")
{
    rotate([60,0,0])
    rotate([0,90,0])
    hex_holder(_d, _l, _wall_thickness);
}

//ex: // Neuroshima Hex tiles:
//_d = 41; 
//_l = 62;
