$fn = 50;

// Distance between profile and surface it will be mounted against.
SurfaceDistance = 5;

// Size of profile this is for square profiles only.
ProfileSize = 20;

// Radius of the bracket, will be the beefyness of the bracket.
EndRadius = 20;

// Distance between surface mounting holes
HoleDistance = 60;

// Hole radius for the screw threat that grabs the profile
ProfileScrewHole = 2.5;

// Hole radius for the screw head that grabs the profile
ProfileScrewHead = 7;

// Thickness of material between surface and screw head
ProfileScrewMaterial = 5;

// Hole radius for the screw threat that grabs surface
SurfaceScrewHole = 2.5;

// Hole radius for the screw head that grabs surface
SurfaceScrewHead = 7;

// Thickness of material between surface and screw head
SurfaceScrewMaterial = 5;

module wallmount(HoleDistance, EndRadius, ProfileSize, SurfaceDistance)
{
	difference()
	{
		hull()
		{
			translate([ 0, HoleDistance * 0.5, 0]) cylinder(5, EndRadius, EndRadius, false);
			translate([ 0, HoleDistance * -0.5, 0]) cylinder(5, EndRadius, EndRadius, false);
			translate([ 0, 0, (ProfileSize * 0.5) + SurfaceDistance ]) cube([ ProfileSize, ProfileSize, ProfileSize ], true);
		}
		translate([ 0, 0, (ProfileSize * 0.5) + SurfaceDistance ]) cube([ EndRadius * 3, ProfileSize + 0.1, ProfileSize + 1 ], true);
		union()
		{
			translate([ 0, HoleDistance * 0.5, -1 ]) rotate([ 0, 0, 0 ]) cylinder(ProfileSize, SurfaceScrewHole, SurfaceScrewHole, false);
			translate([ 0, HoleDistance * 0.5, SurfaceScrewMaterial ]) rotate([ 0, 0, 0 ]) cylinder(ProfileSize, SurfaceScrewHead, SurfaceScrewHead, false);
			translate([ 0, HoleDistance * -0.5, -1 ]) rotate([ 0, 0, 0 ]) cylinder(ProfileSize, SurfaceScrewHole, SurfaceScrewHole, false);
			translate([ 0, HoleDistance * -0.5, SurfaceScrewMaterial ]) rotate([ 0, 0, 0 ]) cylinder(ProfileSize, SurfaceScrewHead, SurfaceScrewHead, false);
		}
		union(){
			translate([ 0, 0, (ProfileSize * 0.5) + SurfaceDistance ]) rotate([ 90, 90, 0 ])
			{
				translate([ 0, 0, 0 ])
					cylinder(HoleDistance, ProfileScrewHole, ProfileScrewHole, true);
				translate([ 0, 0, (ProfileSize * 0.5) + ProfileScrewMaterial ])
					cylinder(HoleDistance, ProfileScrewHead, ProfileScrewHead, false);
				translate([ 0, 0, - HoleDistance - (ProfileSize * 0.5) - ProfileScrewMaterial ])
					cylinder(HoleDistance, ProfileScrewHead, ProfileScrewHead, false);
			}
		}
	}
}

wallmount(HoleDistance, EndRadius, ProfileSize, SurfaceDistance);