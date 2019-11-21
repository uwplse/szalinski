// preview[view:"south west", tilt:"top diagonal"]

//
unit = 1; // [1:mm, 10:cm, 25.4:inch, 304.8:foot]

// you can define multiple radii by using an array, eg: [12,14,16]
radius = 40;

// 
text_mode = "protuded"; // [engraved:Engraved Text, protuded:Protuded Text]

//
text_font = "Teko"; // [Aldrich, Electrolize, Teko]


/* [Advanced] */

// in degrees
body_angle = 90; //[20:5:140]

//
body_thickness = 4;

// leave empty to use the Body Size Ratio
body_size = "";

// radius-to-body-size
body_size_ratio = 0.5; // [0.1:0.1:1]

//
text_thickness = 1.5;

// text-to-body-size
text_ratio = 0.7; // [0:0.1:1]

// leave empty to use the font selected by the drop-down menu
custom_font = "";

/* [Hidden] */

$fn=1000;

normalized_body_size = unit * body_size;
normalized_body_thickness = unit * body_thickness;
normalized_text_thickness = unit * text_thickness;

radius_gauge_input(radius);	

//------------------------------------------------------------------------------------------------------------------------------
function get_draw_font() = 
	len( custom_font ) > 0
	? custom_font 
	: text_font;
//------------------------------------------------------------------------------------------------------------------------------
function get_body_size( r ) = 
	normalized_body_size >= 0
	? normalized_body_size
	: r * body_size_ratio;
//------------------------------------------------------------------------------------------------------------------------------
/* Recursively find the sum of all radii from 0 to i */
function previous_radii_sum(v, i) = 
	(i==0) 
	? get_body_size(v[i])
	: get_body_size(v[i]) + previous_radii_sum(v, i-1);
//------------------------------------------------------------------------------------------------------------------------------
module radius_gauge_input(radius)
{
	radii_count = len(radius);
	
	if (radii_count == undef)
	{
		/* The radius count is undefined, it is not an array */
		normalized_radius = unit * radius;
		radius_gauge(normalized_radius);
	}else
	{
		/* The radius count is defined, it is an array */
		for( i = [0:radii_count - 1] )
		{
			normalized_radius = unit * radius[i];
			
			/* Offset the gauge to place them next to each other */
			offset = (i==0) ? 0 : unit * previous_radii_sum(radius, i-1);
			
			translate( [offset,0, 0] ) 
				radius_gauge(normalized_radius);
		}	
	}
}
//------------------------------------------------------------------------------------------------------------------------------
module radius_gauge(radius)
{
	if(text_mode == "engraved")
	{
		radius_gauge_engraved(radius);
	}else if(text_mode == "protuded")
	{
		radius_gauge_protuded(radius);
	}
}
//------------------------------------------------------------------------------------------------------------------------------
module radius_gauge_protuded(radius)
{
	union()
	{
		/* Take the body */
		radius_gauge_body(radius);
		
		/* Add the text on top of it */
		translate( [0,0, normalized_body_thickness] )
			radius_gauge_text(radius);
	}
}
//------------------------------------------------------------------------------------------------------------------------------
module radius_gauge_engraved(radius)
{
	difference()
	{
		/* Take the body */
		radius_gauge_body(radius);
		
		/* Substract the text from it */
		translate( [0,0, normalized_body_thickness-normalized_text_thickness] ) 
			radius_gauge_text(radius);
	}
}
//------------------------------------------------------------------------------------------------------------------------------
module radius_gauge_body(radius)
{
	size = get_body_size(radius);
	
	linear_extrude(normalized_body_thickness)
		intersection()
		{
			/* Intersect with a template to cut off the rest */
			radius_gauge_angle_template(radius+size);
			
			/* Take two equally sized circles, move one, substract the other */
			difference()
			{					
				translate([size,0])
					circle(r=radius);
				
				circle(r=radius);
			}
		}
}
//------------------------------------------------------------------------------------------------------------------------------
module radius_gauge_angle_template(radius)
{
	/* Calculate all angles in the triangle */
	triangle_height_angle = body_angle / 2;
	triangle_base_angle = 90 - triangle_height_angle;
	
	/* Calculate the legs based on the sine rule */
	triangle_height = radius * sin(triangle_height_angle);
	triangle_base = radius * sin(triangle_base_angle);

	/* Half diamond, half square */
	polygon([ 	[0,0],
				[triangle_base,triangle_height],
				[radius,triangle_height],
				[radius,-triangle_height],
				[triangle_base,-triangle_height]
			]);
}
//------------------------------------------------------------------------------------------------------------------------------
module radius_gauge_text(radius)
{
	size = get_body_size(radius);
	text_size = size * text_ratio;
	
	linear_extrude(normalized_text_thickness)
	translate( [radius + (size/2), 0] )
	rotate(-90)
		text( 	str(radius/unit), 
				size = text_size, 
				font = get_draw_font(), 
				halign = "center", 
				valign = "center"  
			);
}
