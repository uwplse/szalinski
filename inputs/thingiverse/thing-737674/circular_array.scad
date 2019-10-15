// circular array
// https://github.com/davidelliott/parametric-lab 
// License: CC-BY

// Function to array items in a circular arrangement
// Two methods are provided

// method "simple":
//	uses intersection() of a square array with a cylinder

// method "complete":
// calculates item positions providing the following benefits -
//		avoid partial items on the edge of the array
//		ability to count the number of items

method="complete";
radius=50;
spacing=5;

////////////////////
// usage examples //
////////////////////

// use default settings to array some cubes using the "complete" method
circular_array(method=method,r=radius,spacing=spacing) cube([3,3,3]);

// and the same again using the "simple" method
//translate([110,0,0]){
//	color("green") circular_array(method="simple") cube([3,3,3]);
//}


// array of touching spheres to check proper function of the spacing parameter
// circular_array(r=100,spacing=10) sphere(r=5,$fn=60);

// something useful - a filter holder
// subtract an array of cylinders from a circular disc
// leaving space at the edge for clamping.
// note that render() is used to prevent the previewer
// slowing down, and that calculation is slow.
// render(convexity = 2) difference(){
// cylinder(r=70,h=2);
// translate([0,0,2.5]){circular_array(r=50, spacing=3) cylinder(h=5);}
// }


///////////////////////////
// MODULE circular_array //
///////////////////////////

// Parameters:
// 	r is the array radius
// 	spacing is the spacing between items (not taking account of the item size)
//		method should be "simple" or "complete"
//		height applies to the "simple" method only, and should be greater than the height of the object being arrayed

// Explanation for "complete" method:
// we set x in a loop and then calculate y.
// For each point on the grid, just need to check if
// it is within the bounds of a circle or not
// Do this by working out (x,y) coordinates for each point
// on the circumference:
// r = radius of circle
// x = x in the coordinate system
// t = angle made by line from circumference at (x)
//		with the x-axis at the centre of the circle
// cos(t) = x/r
// t = acos(x/r)
// x = x
// y = r * sin(t)
// y = r * sin(acos(x/r)
// this was very useful:
// http://www.mathopenref.com/coordparamcircle.html

module circular_array(r=50,spacing=5,method="complete",height=10)
{
		echo("Circular array:");
		echo("method: ",method);
		echo("radius: ",r);
		echo("spacing between item centres: ",spacing);

		if(method=="simple") {
			// first build a square array:
			// then find the intersection with a cylinder
			intersection(){
				union(){
					for (x=[0:spacing:r*2]){
						for (y=[0:spacing:r*2]){
							translate([r-x,r-y,0]) children();
						}
					}
				}
				cylinder(r=r,h=height);
			}
		}
		else // i.e. method=="complete" (default)
		{
			for (x = [-r:spacing:r]) {
				for (y = [-r:spacing:r]) {
					if((y < (r * sin(acos(x/r)))) && (y > (-r * sin(acos(x/r))))){
						translate([x, y, -5 ])
							children();
							echo("item");
						}
					}
			}
			echo("Count occurences of 'item' above to determine the number of items in the array.");
		}
		echo("End of circular array.");
}

