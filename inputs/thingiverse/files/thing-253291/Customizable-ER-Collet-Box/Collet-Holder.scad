// Which one would you like to see?
part = "both"; // [bottom:Bottom Only,top:top Only,both:Both Bottom & Top]

// Collet Size
collet_size = "ER20";//[ER8:ER8,ER11:ER11,ER16:ER16,ER20:ER20,ER25:ER25,ER32:ER32,ER40:ER40,ER50:ER50]

//Box Wall Thickness
wall_thickness = 2;//[1:5]

//Number of Columns
columns = 5;

//Number of Rows
rows = 3;

// ignore variable values
Offset = 3;

if (collet_size=="ER8")
{
	print_part(13.5, 1.5, 1.3, 8.5);
}

if (collet_size=="ER11")
{
	print_part(18.0, 2.5, 2.0, 11.5);
}

if (collet_size=="ER16")
{
	print_part(27.5, 4.0, 2.7, 17);
}

if (collet_size=="ER20")
{
	print_part(31.5, 4.8, 2.8, 21);
}

if (collet_size=="ER25")
{
	print_part(34.0, 5.0, 3.1, 26);
}

if (collet_size=="ER32")
{
	print_part(40.0, 5.5, 3.6, 33);
}

if (collet_size=="ER40")
{
	print_part(46.0, 7.0, 4.1, 41);
}

if (collet_size=="ER50")
{
	print_part(60.0, 8.5, 5.5, 52);
}

module print_part(L, L2, L3, D) {
	if (part == "bottom") {
		bottom(L, L2, L3, D);
	} else if (part == "top") {
	 	top(L, L2, L3, D);
	} else if (part == "both") {
		both(L, L2, L3, D);
	} else {
		both(L, L2, L3, D);
	}
}

module both(L, L2, L3, D) {
	bottom(L, L2, L3, D);
	top(L, L2, L3, D);
}

module bottom(L, L2, L3, D) {
    h = L - L2 - L3;
    d1 = ((((D/2)*tan(82.3)) - h)*(cos(82.3)/sin(82.3)))*2;
	Space = D/6;
	height = h + 2;
	box_width = D*rows + (rows+1)*Space + wall_thickness*2;
	box_length = D*columns + (columns+1)*Space + wall_thickness*2;
	pos = -box_length/2;
	chord = (2*(D/2)*sin(45/2));
	
	union() {
		// main box and cutout
		difference() {
			translate([-box_width - Offset, pos, 0]) {
				cube([box_width,box_length,height]);
			}
	
			difference() {
				translate([-box_width - Offset - 0.5, pos - 0.5, height - 5]) {
					cube([box_width+1,box_length+1,6]);
				}
				translate([-box_width - Offset + wall_thickness + 0.1, pos + wall_thickness + 0.1, height-5]) {
					cube([box_width-wall_thickness*2 - 0.2,box_length-wall_thickness*2 - 0.2,6]);
				}
            }
            
			for  (x = [-box_width - Offset + D/2 + wall_thickness + Space:+(D+Space):- Offset]) {
				for  (y = [pos + D/2 + wall_thickness + Space:D+Space:pos+box_length - wall_thickness]) {
                    translate([x,y,2.1]) cylinder(h=h, d1=d1, d2=D);
				}
			}
	
			for  (x = [-box_width - Offset + wall_thickness + Space + D/2 - chord/2:+(D+Space):- Offset]) {
				translate([x,-box_length/2 + wall_thickness + Space/2, height - h/5]) cube([chord, box_length - wall_thickness*2 - Space, h/4 + .1]);
			}

			for  (y = [pos + D/2 + wall_thickness + Space - chord/2:D + Space:pos + box_length]) {
				translate([-box_width - Offset + wall_thickness + Space/2, y, height - h/5]) cube([box_width - wall_thickness*2 - Space,chord, h/4 + .1]);
			}

			for  (x = [-box_width - Offset + D + Space*1.5 + wall_thickness:+(D+Space):- Offset - D/2]) {
				for  (y = [pos + D + Space*1.5 + wall_thickness:D + Space:pos + box_length - wall_thickness - D/2]) {
					translate([x,y,2])	cylinder(d = D*0.55, h = height);
				}
			}
		}
	}
}

module top(L, L2, L3, D) {
	Space = D/6;
    h = L - L2 - L3;
    height = L - h + 8 ;
	box_width = D*rows + (rows+1)*Space + wall_thickness*2;
	box_length = D*columns + (columns+1)*Space + wall_thickness*2;
	pos = -box_length/2;
    z = 0;
//	z = h + wall_thickness - height;
	
	union() {
		difference() {
			translate([Offset, pos, z]) {
				cube([box_width,box_length,height]);
			}
	
			translate([Offset + wall_thickness, pos + wall_thickness, 2]) {
				cube([box_width - wall_thickness*2, box_length - wall_thickness*2, height+1]);
			}			
		}
	}
}