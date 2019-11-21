// Longer side of the base
baseLength = 180;
// Shorter side of the base
baseWidth = 180;
// Height of the basket
height = 150;
// Longer side of the top 
topLength = 200;
// Thickness of the box 
thickness = 2; // [1:4]
// Corner radius, 1 for sharp, 12 for most rounded
radius = 8; // [1:12]
// Longer side of the hole  
handleLength = 80;
// Shorter side of the hole
handleWidth = 16;
// Margin from top for the hole
handleMargin = 20;
// Gap between basket dimensions at the top and lid dimensions
lidClearance = 1; // [1:5]
// Radius of lid handle at its lower end
lidHandleRadius = 10;
// Height of the lid handle
lidHandleHeight = 20;
// How much bigger the top end of the lid handle is than its bottom end -- 1 for narrowest at top and 20 for broadest at top
lidHandleScale = 14; // [1:20]
// Choose what to create 
part = "both"; // [both:Basket and Lid,basket:Basket Only,lid:Lid Only]

if(part == "both") {
	makeBasket();
	makeLid();
}
else if(part == "basket") {
	makeBasket();
} 
else {
	translate([0, 0, -(height+thickness+lidClearance)]) makeLid();
}

$fn = 120;

module makeBasket() {
	difference() { // create basket
		union() { 
			translate([-baseLength/2+radius/2, -baseWidth/2+radius/2, 0]) minkowski() { // set up base
				cube([baseLength-radius, baseWidth-radius, thickness/2]);
				cylinder(r = radius, h = thickness/2);
			}
			translate([0, 0, thickness]) linear_extrude(height = height, scale = topLength/baseLength) difference() { // create rim and extrude it
				roundedRect([baseLength, baseWidth], radius);
				roundedRect([baseLength-2*thickness, baseWidth-2*thickness], radius);
			}
		}
		translate([-handleLength/2+radius/2, -(baseWidth*topLength)/(2*baseLength)+radius/2, height-handleMargin-handleWidth]) rotate([90+atan((topLength-baseLength)/(2*height)), 0, 0]) minkowski() { // cut handle hole
				cube([handleLength-radius, handleWidth-radius, 2*thickness]);
				cylinder(r = radius, h = 2*thickness);
		}
	}
}

module makeLid() {
	union() { // create lid
		translate([-(topLength-radius-thickness-lidClearance)/2, -(baseWidth*topLength/baseLength-radius-thickness-lidClearance)/2, height+thickness+lidClearance]) minkowski() {
			cube([topLength-radius-thickness-lidClearance, baseWidth*topLength/baseLength-radius-thickness-lidClearance, thickness/2]);
			cylinder(r = radius, h = thickness/2);
		}
		translate([0, 0, height+lidClearance+thickness]) linear_extrude(height = lidHandleHeight, scale = lidHandleScale/10) circle(r=lidHandleRadius);
	}
}

module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];

	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r = radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r = radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r = radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r = radius);
	}
}
