// customizable nintendo EPS piece

//custom text
custom_text = "nintendo";
text_size = 20;
//radius of the rounded edges
round_radius_rect = 1;
//nintendo alike logo
nintendo_round = "yes"; //[yes,no]

if (nintendo_round=="yes") {
        size = [100, 39, 19.5];
        radius = 36/2;
        radius_2 = 25/2;
        
        x = size[0];
        y = size[1];
        z = size[2];
    difference() {    
    	linear_extrude(height=z)
        hull() {
            translate([(-x/2)+(radius/2), 0, 0])
            circle(r=radius);
            
            translate([(x/2)-(radius/2), 0, 0])
            circle(r=radius);     
        }
        
        linear_extrude(height=z+2)
        hull() {
            translate([(-x/2)+(radius_2/2), 0, 0])
            circle(r=radius_2);
            
            translate([(x/2)-(radius_2/2), 0, 0])
            circle(r=radius_2);     
        }
    }
}
if (nintendo_round=="yes") {
    roundedRect([120, 39, 16.5], round_radius_rect, $fn=12);
    translate([0,0,0])
    linear_extrude(19.5)
    text(custom_text, size = text_size, halign = "center", valign = "center");
    //text(custom_text, size = text_size, font = "Pretendo", halign = "center", valign = "center"); 
} else {
     difference() {
    roundedRect([120, 39, 19.5], round_radius_rect, $fn=12);
    translate([0,0,16])
    linear_extrude(5)
    text(custom_text, size = 20, halign = "center", valign = "center");
    //text(custom_text, size = text_size, font = "Pretendo", halign = "center", valign = "center"); 
     }
}


module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}