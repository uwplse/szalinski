// License:  Creative Commons Attribtion-NonCommercial-ShareAlike
// http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// Author: Jetty, 1st November, 2011
//
//
// Heated Build Platform Wedge Removal Tool
//
// Print with 100% Fill

maxThickness  = -4;
length = 70;
width = 50;

rotate(a=[90, 90, 90])
{
	linear_extrude(height = width, center = true, convexity = 10, twist = 0)
		polygon(points=[ [0,0], [maxThickness, length], [0, length] ], paths=[[0,1,2]]);
}
