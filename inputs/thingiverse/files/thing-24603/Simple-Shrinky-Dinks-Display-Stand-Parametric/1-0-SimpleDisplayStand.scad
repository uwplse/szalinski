/*
 * Simple Display Stand, v1.0
 *
 * by Alex Franke (CodeCreations), Jun 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: This simple display stand was modeled after one included with a 
 *   box of Shrinky Dinks toys (http://www.shrinkydinks.com/ -- You should go out and
 *   buy lots of these, because they're loads of fun and the kids will have a blast!)
 *   The default size will fit a standard shrunken Shrinky Dinks piece. It's parametric, 
 *   though, so you can change the size to fit other stuff as well. 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, render,
 *   and print.  
 * 
 * v1.0, Jun 8, 2012: Initial Release.
 * 
 * TODO: 
 *   * nothing yet...  
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////
baseThickness = 1.5;   // The thickness of the base
baseWidth = 14;        // The width of the base oval 
baseLength = 20;       // The length of the base oval

tabThickness = 1.2;    // The thickness of each vertical "tab"
tabRadius = 5;         // The radius of the vertical tabs. 
tabSeparation = 1.6;   // How far apart the tabs are 

$fn=25;                // Quality of circles 


/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////
rotate([90,0,0]) 
difference() {
	union() {
		rotate([-90,0,0]) 
			translate([0,0,baseThickness/2]) 
				scale([baseLength/baseWidth,1,1])
					cylinder(h=baseThickness, r=baseWidth/2, center=true) ;

		translate([0,baseThickness,0]) 
			cylinder(h=(tabThickness*2)+tabSeparation, r=tabRadius, center=true);
	}	

	// cut groove a bit bigger so it renders well 
	translate([0,baseThickness,0]) 
		cylinder(h=tabSeparation, r=tabRadius * 1.01, center=true); 

	// remove bottom 
	rotate([-90,0,0]) 
		translate([0,0,-tabRadius/2] ) 
			scale([baseLength/baseWidth,1,1])
				cylinder(h=tabRadius, r=baseWidth/2, center=true) ;
}
