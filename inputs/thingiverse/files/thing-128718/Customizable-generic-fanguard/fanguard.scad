//
// parametric fanguard (rev 1.01) - 20130806-1638
//
// (c)Jeremie Francois (jeremie.francois@gmail.com)
//	http://www.thingiverse.com/MoonCactus
//	http://tridimake.blogspot.com
//
// Licence: Attribution - Share Alike - Creative Commons
//

// Fan size (eg. 25, 30, 40, 50 mm side length)
fan_side_length=30;

// Distance between two consecutive mounting fan screws (respectively 20, 24, 32, 40 mm)
mount_hole_width=24;

// Mounting screw diameter (respectively 3, 3, 3.5, 4.5 mm)
mount_hole_d=3;

// The mesh kind
mesh_kind="hex"; // [hex,square,radial_circles,radial_poly]

// The mesh cell size (mm)
mesh_holes_d=5;

// The mesh thickness (mm)
mesh_thickness=1;

// Additional distance between the mesh and the fan (add it to the mesh thickness for the total height) (mm)
mesh_clearance=1;

// Mesh string thickness ratio (depends on your nozzle and gcode generator); default gives about 0.8 mm (two passes)
mesh_density_ratio= 98; // [90:120]

// Minimum side wall thickness (mm)
solid_outer_border=1;

// Outer roundness (ratio over the total height; values over 50% ask for a thick wall also)
outer_roundness=50; // [0:100]

// Mesh radial offset for circular meshes (tune it for a better flow, when the outer ring is the most "open")
mesh_offset= 68; // [0:100]

tol=0.1+0;
$fa=1+0;
$fs=0.33+0;


dholes= mesh_holes_d;
marginhole= (fan_side_length-mount_hole_width)/2;
roundness= outer_roundness * (mesh_thickness + mesh_clearance) / 100;

function drot(radius, spacing)= 360 / round( (2 * 3.1415926 * radius) / spacing );

module wedge(radius,dholes)
{
	w= (drot(radius, dholes)/2) * mesh_density_ratio / 125;
	dl= (mesh_holes_d) * mesh_density_ratio / 135;
	translate([0,0,-tol])
	scale([1,1,mesh_thickness+2*tol])
	hull()
	{
		rotate([0,0,-w]) translate([radius-dl/2,0,0])	cylinder(r=0.1,$fn=4);
		rotate([0,0,+w]) translate([radius-dl/2,0,0])	cylinder(r=0.1,$fn=4);
		
		translate([radius+1.05*dl/2,0,0])	cylinder(r=0.1,$fn=4);
		
		rotate([0,0,-w]) translate([radius+dl/2,0,0])	cylinder(r=0.1,$fn=4);
		rotate([0,0,+w]) translate([radius+dl/2,0,0])	cylinder(r=0.1,$fn=4);
	}
}

union()
{
	difference()
	{
		hull()
		{
			for(i=[-1,+1]) for(j=[-1,+1])
				translate([i*(fan_side_length/2-roundness),j*(fan_side_length/2-roundness),0])
					translate([0,0,roundness])
					{
						intersection() { sphere(r=roundness); translate([0,0,-roundness-tol]) cylinder(r=roundness+tol, h=roundness+tol); }
						cylinder(r=roundness,h=mesh_thickness+mesh_clearance-roundness);
					}
		}
		// Carve main section and screw holes
		translate([0,0,-tol]) scale([1,1,mesh_thickness+mesh_clearance+2*tol])
		{
			cylinder(r=fan_side_length/2-solid_outer_border);
			for(i=[-1,+1]) for(j=[-1,+1])
				translate([i*(fan_side_length/2-marginhole),j*(fan_side_length/2-marginhole),0])
					cylinder(r=mount_hole_d/2);
		}
	}

	difference()
	{
		cylinder(r=fan_side_length/2-solid_outer_border+tol, h=mesh_thickness);
		// Hey... if you find this readable, you are mad :)
		if(mesh_kind=="radial_circles" || mesh_kind=="radial_poly")
		{
			for(radius=[mesh_offset*mesh_holes_d/100:mesh_holes_d*0.95:fan_side_length/2])
				// circumference= 2*PI*radius
				for(rot=[0:drot(radius, dholes):359.9])
					rotate([0,0,rot])
						if(mesh_kind=="radial_poly")
							wedge(radius,dholes);
						else if(mesh_kind=="radial_circles")
						{
							translate([radius,0,-tol])
							cylinder(r=38*mesh_holes_d/mesh_density_ratio, h=mesh_thickness+2*tol);
						}
		}
		else // hex or square
		{
			for(i=[0:dholes:fan_side_length/2+dholes])
				for(j=[0:dholes:fan_side_length/2+dholes])
					for(si=[-1,+1]) for(sj=[-1,+1]) scale([si,sj,1])
						if(mesh_kind=="hex")
						{
							translate([i + (((j+dholes) / dholes + 1) % 2) * dholes/2 ,(j)*0.9,-tol]) // HUH!
								rotate([0,0,30])
									cylinder(r=50*mesh_holes_d/mesh_density_ratio, $fn=6, h=mesh_thickness+2*tol);
						}
						else if(mesh_kind=="square")
						{
							translate([i,j,-tol])
								cube([
									75*mesh_holes_d/mesh_density_ratio,
									75*mesh_holes_d/mesh_density_ratio,
									mesh_thickness*3+2*tol],center=true);
						}
		}
	}

}