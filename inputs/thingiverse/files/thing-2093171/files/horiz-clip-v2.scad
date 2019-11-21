//   Horizontal clip to pinch two materials of different thicknesses
//   R. Lazure  February 2017
//
//  Keeps a common face of both materials inline
//   i.e. does not center the materials relative to one another
//
//   The HClip2 module is a modification of WilliamAAdams' Yazzonic Panel Clips
//   http://www.thingiverse.com/thing:5208
//
///// inputs ////////////////
// How long?
clip_length = 25.4;  //[15:50]
//
// Minimum wall thickness?
clip_thickness = 2;  //[1:5]
//
// height ?
clip_height = 15; //[10:50]
//
// largest gap width?
clip_gap1 = 3; //[2:10]
//
// smallest gap width?
clip_gap2 = 2; //[2:10]
//
 /* [Hidden] */

gDefaultExtent = clip_length/2;  
gGap1 = clip_gap1;
gGap2 = clip_gap2;
gDefaultThickness = clip_thickness;
gDefaultLength = clip_height;


HClip2(gDefaultLength, gDefaultExtent, gDefaultThickness, gGap1, gGap2);

module HClip2(length, extent, thickness, gap1, gap2)
// for 2 different widths
// RLazure added January 11, 2017
{
	difference()
	{       
		// full block size	
		translate([-extent-thickness/2, 0,0])
		cube(size=[thickness+extent*2, gap1+2*thickness, length]);
		
        union ()
        {
        // gap1 section
		color("red")translate([-extent-thickness/2-1, thickness,-1])
		cube(size=[thickness+extent+1, gap1+0.25, length+2]);
        
        // gap2 section
        color("blue")translate([thickness/2-1, thickness,-1])
		cube(size=[thickness+extent+1, gap2+0.6, length+2]);
        }
        }
		// divider wall along y-axis
		color("green")translate([-thickness/2, thickness-1, 0])
		cube(size=[thickness, gap1+thickness+0.25, length]);
	
}
