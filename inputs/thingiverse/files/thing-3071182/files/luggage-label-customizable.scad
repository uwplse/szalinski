labelHeight = 1;
labelLength = 72;
labelWidth = 42;
textHeight = 0.6;
fontName = "Arial";
fontSize = 5;
roundRadius = 4;
perimeterWidth = 2;
margin = 4;
name = "Firstname Lastname";
phone = "+xx xxx-xxx-xxxx";
email1 = "longemailaddress";
email2 = "@gmail.com";

difference() 
{
    union() 
    {
        roundedRect([labelLength, labelWidth, labelHeight], roundRadius, $fn = 60);
		translate([-(labelLength/2-margin), 0, labelHeight]) makeTextGroup();
        translate([0, 0, labelHeight]) 
        {
            difference() 
            {
                roundedRect([labelLength, labelWidth, textHeight], roundRadius, $fn = 60);
                roundedRect([labelLength-perimeterWidth, labelWidth-perimeterWidth, textHeight], roundRadius, $fn = 60);
                }
        }
    }
    translate([labelLength/2-margin, 0, 0]) roundedRect([2, 8, labelHeight+textHeight], 2, $fn = 60);
}

module makeTextGroup()
{
	makeText(name, 12);
	makeText(phone, 2);
	makeText(email1, -8);
	makeText(email2, -16);
}

module makeText(textContent, height)
{
	translate([0, height, 0]) linear_extrude(textHeight, center=false) 
		text(textContent, fontSize, font=fontName);
}

// size - [x,y,z]
// radius - radius of corners
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
