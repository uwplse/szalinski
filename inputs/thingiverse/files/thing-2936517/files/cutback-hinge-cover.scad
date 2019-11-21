// Cabinet hinge cover
// features cut-back front edge for reduced width doors
// basic dimensions fit standard door hinge
// By misterC @ thingiverse

// CUSTOMIZER VARIABLES
/* [Customize options] */
// Cut length (parallel to door edge) or zero if none required. Negative value for cuts past halfway (use with caution)
cutoff_length = 30;		// [-60:60]
// Do we want nibs around the plug (can help fixing grip)
nibs_wanted = 1;		// [0:False, 1:True)
// Options for extras - if both are true then pips get covered by studs
// Studs to fill screw holes
studs_wanted = 1;		// [0:False, 1:True]
// Small pips to locate on marker holes
pips_wanted = 0;		// [0:False, 1:True]
// Model resolution
fn = 30;				// [10:LoPoly, 30:Standard, 90:Final render]

// input parameters
/* [Hinge plug] */
// Diameter of hinge cutout
hinge_diameter = 36;	// [20:60]
// Depth of plug into cutout
hinge_height = 8;       // [5:25]
// Fitting tolerance for plug
hinge_gap = 0.5;		// [0:0.25:2]
// Thickness of plug wall
plug_wall = 1.6;		// [0.8:0.2:3]
// Diameter of nibs around plug
nib_size = 0.8;			// [0.5:0.1:2]
// Taper ratio of nibs (bottom to top)
nib_scale = 0.8;		// [0.5:0.1:1]
/* [Screw plugs] */
// Diameter of hinge screw holes
screw_diameter = 8;		// [4:12]
// X offset of screw holes from hinge centre
screw_Xoff = 9.5;       // [0:50]
// Y offset of screw holes from hinge centre (+Y & -Y used)
screw_Yoff = 22.5;      // [0:50]
// Fitting tolerance for plugs into screw holes
screw_gap = 0.75;		// [0:0.25:2]
/* [Cover sizes] */
// Cover horizontal distance beyond geometry
cover_overlap = 3.5;		// [1:10]
// Cover vertical thickness (fillet included)
cover_thick = 1.6;		// [1:0.1:3]

// PROGRAM VARIABLES AFTER THIS POINT
/* [Hidden] */

// Working constants
cut_fudge = 0.5;
cube_extra = 2;
$fn = fn;

// Calculated constants
plug_diameter = true_diameter(hinge_diameter) - 2*hinge_gap;
plug_inner = plug_diameter - 2*plug_wall;
plug_shoulder = 0.75*hinge_height;
plug_taper = 0.25*hinge_height;
screw_stud = hinge_height * 0.3;
stud_diameter = true_diameter(screw_diameter) - 2*screw_gap;

hinge_radius = true_diameter(hinge_diameter)/2;
screw_radius = true_diameter(screw_diameter)/2;

cutoff_Y = (abs(cutoff_length) >= plug_diameter) ? plug_diameter/2 : abs(cutoff_length/2);	// Trap cut length > diameter and +/-
cutoff_X = sqrt(pow(plug_diameter/2,2) - pow(cutoff_Y,2)) * sign(cutoff_length);			// Pythagoras with +/- adjustment
cutoff_A = (cutoff_X==0) ? 90 : (cutoff_length > 0) ? cutang() : 180 - cutang();			// Sort angle for 90 and +/- cutoff

echo (cutoff_Y, cutoff_X, cutoff_A, cutang());

half_width = screw_Yoff + screw_radius + cover_overlap;
plug_profile = [[0,0],[0,plug_shoulder+plug_taper],[plug_wall,plug_shoulder],[plug_wall,0],[0,0]];


// PROGRAM

// make plug
if (cutoff_length)		// We have to condider a cut
{
	intersection()
	{
		plug_profile(cutoff_A);
		// intersect with a cube to remove volume beyond cut line
		translate([-(plug_diameter+cube_extra)/2,-(plug_diameter+cube_extra)/2,-1])
			cube([1+plug_diameter/2+cutoff_X-plug_wall,plug_diameter+cube_extra,plug_shoulder+plug_taper+cube_extra]);
	}
	// seal cutoff with wall (use plug profile for neatness)
	intersection()
	{
		wall_offset(cutoff_X,0) polygon(plug_profile);
		solid_plug();
	}

	// cover area
	part_cover(cutoff_X);
}
else					// Just plug and cover.  Simples
{
	plug_profile();
	full_cover();
}

// add studs if wanted
if(studs_wanted) for (ycount=[-screw_Yoff,screw_Yoff])
{
    translate([-screw_Xoff,ycount,0]) cylinder(h=screw_stud,d=stud_diameter);
    translate([-screw_Xoff,ycount,screw_stud]) scale([1,1,0.5]) sphere(d=stud_diameter);
}
// add pips if wanted (doesn't matter if both, this lot gets hidden by the previous element)
if(pips_wanted) for (ycount=[-screw_Yoff,screw_Yoff]) translate([-screw_Xoff,ycount,0]) cylinder(h=1,d1=1,d2=0);

// END OF PROGRAM

// MODULES
module full_cover()		// uses a minkowski to make a radiussed plate then intersects it to cut off at z=0 for a smooth surface
{
	intersection()
	{
		hull()
		{
			do_minkowski(hinge_radius);
			for (xcount=[screw_radius,hinge_radius-screw_radius], ycount=[-screw_Yoff,screw_Yoff])
				translate([-xcount,ycount,0]) do_minkowski(screw_radius);
		}
		// now keep the volume below z=0
		translate([0,0,-cover_thick]) cube([3*hinge_diameter,3*hinge_diameter,2*cover_thick],center=true);
	}
}

module part_cover(X_offset)
{
	difference()	// cut off at the cutoff distance
	{
		full_cover();
		wall_offset(X_offset,-cover_thick-cut_fudge) square([hinge_diameter-X_offset,cover_thick+2*cut_fudge]);
	}
	intersection()	// with a filleted edge
	{
		full_cover();
		hull()
		{
			for(ycount=[-half_width,half_width]) translate([X_offset-cover_overlap,ycount,-cover_thick/2])
			{
				cylinder(r=cover_overlap,h=cover_thick);
				scale([cover_overlap,cover_overlap,cover_thick]) sphere(r=1);
			}
		}
	}
}

module plug_profile(start_ang=0,)	// spin the plug wall profile then add nibs.  Default angle gives 360 plug
{
	// plug profile with taper top, formed by spinning wall profile from start_ang through 180 to -start_ang
	rotate(start_ang) rotate_extrude(angle=2*(180-start_ang),$fn=2*fn) translate([plug_inner/2,0,0]) polygon(plug_profile);
	// add locating nibs
	if (nibs_wanted) nib([0:60:360]);		// create nibs at this point so they get included in Boolean geometry of plug
}

module solid_plug()		// the volume occupied by the plug (ignoring central hole) used for intersection operations
{
	cylinder(h=plug_shoulder,d=plug_diameter);
	translate([0,0,plug_shoulder]) cylinder(h=plug_taper,d1=plug_diameter,d2=plug_inner);
}

module nib(angle_range)	// tapering cylinders with rounded top to act as a fixing aid
// at the moment this is a "dumb" call, could be improved to cater for start_ang variable
{
	$fn=fn/2;
	for (angle=angle_range) rotate(angle)
	{
		translate([plug_diameter/2,0,0]) cylinder(h=plug_shoulder*nib_scale,r1=nib_size,r2=nib_size*nib_scale);
		translate([plug_diameter/2,0,plug_shoulder*nib_scale]) scale([nib_scale,nib_scale,pow(nib_scale,2)]) sphere(r=nib_size);
	}
}

module wall_offset(X_offset,Z_offset)	// position the flat plug wall and extrude the child element over the full cover width
{
	translate([X_offset-plug_wall,0,Z_offset]) rotate([90,0,0]) linear_extrude(height=2*(half_width+cut_fudge),center=true) children();
}

module do_minkowski(minkowski_distance) // makes a filleted cylinder
{
    minkowski()
    {
        cylinder(r=minkowski_distance-(cover_overlap/2),h=cover_thick/2,center=true);
        scale([cover_overlap,cover_overlap,cover_thick]) sphere(r=1);
    }
}

// FUNCTIONS

function true_diameter(input_size)
    = input_size * 1/cos(180/fn);

function cutang()
	= asin(abs(cutoff_length) / plug_diameter);		// both are twice the required value so scalar cancels
