include <MCAD/regular_shapes.scad>
/*Copyright Daniel Hegner, daniel@hegner.se, 2014*/
/* [Global] */

// View top, bottom or both
part = "both"; // [top:Top only, bottom:Bottom only, both:Top and Bottom]

outer_diameter = 55; // [50:100]
inner_diameter = 39; // [10:45]

set_screw_diameter = 8; // [2:16]

/* [Top] */

top_height = 120; // [20:200]

/* [Bottom] */
bottom_height = 50; // [40:200]

/* [Hidden] */

outer_radius=outer_diameter/2;
inner_radius=inner_diameter/2;

resolution=60;

wallThickness=outer_radius-inner_radius;
indentWidth=set_screw_diameter+1;
indentDepth=wallThickness*2/5;
indentHeight=top_height*3/5;
indents=2;

bottomIndentHeight=bottom_height/4;

slitWidth=2;
slitDepth=wallThickness+2;
slitHeight=top_height*4/5;
bottomSlitHeight=bottom_height*4/5;
slits=2;


print_part();

module print_part() {
	if (part == "top") {
		parasolTopBushing();
	} else if (part == "bottom") {
		parasolBottomBushing();
	} else {
		both();
	}
}


module both() {
	translate([-outer_diameter*2/3, 0, 0]) parasolTopBushing();
	translate([outer_diameter*2/3, 0, 0]) parasolBottomBushing();
	//translate([0, outer_diameter, 0]) wedgeCone(bottom_height*2/3, bottom_height); 
}

module wedgeCone(wedgeHeight, alignTop) {
	translate([0,0,alignTop-wedgeHeight])
	difference()
	{
		union()
		{
			cylinder(h=wedgeHeight+1, r1=outer_radius+1, r2=outer_radius+1, center=false, $fn=resolution);
		}
		union()
		{
			translate([0,0,-1.5])
			cylinder(h=wedgeHeight+3, r1=outer_radius+1, r2=outer_radius-indentDepth, center=false, $fn=resolution);
		}
	}
}


module parasolTopBushing() {
	highlight("Top") 
	difference() 
	{
		union() {	
			cylinder_tube(top_height,outer_radius, wallThickness, false, $fn=resolution);
			cylinder_tube(5,outer_radius+5, wallThickness+5, false, $fn=resolution);
		}
		
		union() {
			//indentations(indents, indentWidth, indentDepth, indentHeight, outer_radius,top_height);
			for(r=[0:indents])
			{
				
				rotate([0,0,r*360/indents]) 
					translate([-indentWidth/2, inner_radius+wallThickness-indentDepth,top_height-indentHeight+1]) 
						cube(size=[indentWidth,indentDepth,indentHeight]);	
			}
			rotate([0,0,90])
				for(r=[0:slits])
				{
					
					rotate([0,0,r*360/slits]) 
						translate([-slitWidth/2, inner_radius+wallThickness-slitDepth,top_height-slitHeight+1]) 
							cube(size=[slitWidth,slitDepth,slitHeight]);	
				}
			wedgeCone(top_height*2/3, top_height);
			
		}
	}
}

module indentations(indents, indentWidth, indentDepth, indentHeight, zAxisOffSet, xyPlaneOffset) {
	for(r=[0:indents])
	{
		//TODO: Fix the rotation of the indentations.
		rotate([0,0,r*360/indents]) 
			translate([-indentWidth/2, zAxisOffset-indentDepth,xyPlaneOffset-indentHeight]) 
				cube(size=[indentWidth,indentDepth,indentHeight]);	
		}

}

//TODO: Refactor out slits and indent parts.

module parasolBottomBushing() {
	highlight("Bottom") 
	difference() 
	{
		union() {
			cylinder_tube(bottom_height,outer_radius, wallThickness, false, $fn=resolution);
		}
		
		union() {
			for(r=[0:indents])
			{
				rotate([0,0,r*360/indents]) 
					translate([-indentWidth/2,inner_radius+wallThickness-indentDepth,bottom_height-bottomIndentHeight]) 
						cube(size=[indentWidth,indentDepth,indentHeight]);	
			}


			rotate([0,0,90])
				for(r=[0:slits])
				{
					
					rotate([0,0,r*360/slits]) 
						translate([-slitWidth/2, inner_radius+wallThickness-slitDepth,bottom_height-bottomSlitHeight+1]) 
							cube(size=[slitWidth,slitDepth,slitHeight]);	
				}
			wedgeCone(bottom_height*2/3, bottom_height);
		}
	}


}

module highlight(this_tab) {
  if (preview_tab == this_tab) {
    color("red") child(0);
  } else {
    child(0);
  }
}