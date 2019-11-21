// This thing allows you to create NAROD connectors for Gray Hoverman Antennas built
// using aluminum window screen framesq
//
// This is licensed under the creative commons+attribution licence
// To fulfil the attribution requirement, please link to:
//              http://www.thingiverse.com/thing:2160227

/* [Main] */


// size of gap in mm
gap=7.325;

// width of leg in mm
leg_width=13.0;

// thickness of part in mm
thickness=7.3;

// length of leg in mm
leg_length=25.4;

// length of base in mm
base_length=19.0;

// bevel size in mm
width=1.0;

module end(bevel,width,depth,thickness)
{
	translate([0,-width/2,0]) cube([depth-bevel,width,thickness]);
	translate([depth-bevel/2,0,thickness/2]) rotate([0,-90,0]) frustum(thickness,width,thickness-bevel*2,width-bevel*2,bevel);
}

module prism(l, w, h)
{
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}


module drawConnector()
{
	union()
	{
		cube([gap + 1,base_length,thickness],center = true);
		translate([-(gap/2 + (leg_width/2)),leg_length/2,0]) cube([leg_width,base_length + leg_length,thickness],center = true);
		translate([+(gap/2 + (leg_width/2)),leg_length/2,0]) cube([leg_width,base_length + leg_length,thickness],center = true);

		// add trianglar fillets
		translate([+gap/2,base_length/2 + width,thickness/2]) rotate([0,90,180]) prism(thickness,width,width,center=true);
		translate([-gap/2 + width,base_length/2,thickness/2]) rotate([0,90,90]) prism(thickness,width,width,center=true);
	}
}

$fn=0;

drawConnector();
