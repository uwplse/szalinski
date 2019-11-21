/* [Basic] */
//width of bookmark
width = 25;
//length of bookmark
length = 160;
//thickness of bookmark
height = 0.6;
//diameter of holes
hole_diameter = 3.2;
//distance between hole centers
hole_distance = 8.5;

//tag at the edge of bookmark
writeTag = 1; //[0:No tag,1:Tag]

textTag = "Arduino";
//you can select font name from here https://www.google.com/fonts
textFont = "Open Sans";
textStyle = "Bold";
textSize = 4;
//text extrusion
textHeight = 0.4;

/* [Advanced] */
//right border radius
fillet_radius=2;
//distance of hole center from edge
dist_hole_edge = 4;
//widht of slot between hole and edge
slot_width = 2;
//minimal width of border between outer holes and edge
hole_border = 2;
//distance between text and the edge
textDistance = 0.5;

/* [Hidden] */
$fn=50;
	
difference(){
	body();
	holes();
}

module body()
{
	linear_extrude(height)
	hull()
	{
	    // place 2 circles in the right corners, with the given radius
	
	    translate([(length/2)-(fillet_radius/2), (-width/2)+(fillet_radius/2), 0])
	    circle(r=fillet_radius);
	
	    translate([(length/2)-(fillet_radius/2), (width/2)-(fillet_radius/2), 0])
	    circle(r=fillet_radius);

		 // place box on the left size, width of 2mm
		 translate([(-length/2) + 1, 0, 0])
		 square([2, width], true);

	}
    if (writeTag == 1) {
        translate([length/2 - textSize/2 -textDistance, 0, height-0.01])
            rotate([0,0,90]) 
                    linear_extrude (height=textHeight)
                        text(text=textTag, font=str(textFont,":style=",textStyle), size=textSize, halign="center", valign="center");
    }
}

module holes()
{
	num_holes = floor((width - 2 * hole_border - hole_diameter)/hole_distance);
	init_distance = (width - num_holes* hole_distance - hole_diameter)/2 + hole_diameter/2; 
	//echo("init_distance");
	//echo (init_distance);
	union() {
		for (i=[0:num_holes])
		{
			translate([-(length/2)+dist_hole_edge, -width/2 + init_distance + i*hole_distance , -0.1])
		   cylinder(d=hole_diameter, h=height+0.2);
	
			translate([-(length/2), -width/2 + init_distance + i*hole_distance , height/2+0.1])
		   cube([2*dist_hole_edge, slot_width, height+0.4], center=true);	
		}
	}
}
