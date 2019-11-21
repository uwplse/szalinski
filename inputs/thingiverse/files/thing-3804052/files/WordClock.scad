/* 
 Rainbowduino Word Clock by Russ Hughes
	License:  Creative Commons Attribution-ShareAlike 4.0 International
   http://creativecommons.org/licenses/by-sa/4.0/

    Clock face layout based on the NeoMatrix 8x8 Word Clock by Andy Doro
 https://learn.adafruit.com/neomatrix-8x8-word-clock

*/

// Which one would you like to see?
part = "all"; // [front:Top Cover Only,face:Top Cover as sheet,top: Top Cover no signs, back:Bottom Cover Only,diffusers:Diffusers Only,all:Top and Bottom Cover]

// Which language?
language = "de"; // [de:German,en:English]

/* [Hidden] */

letters_en = [ 
	[ "F", "O", "U", "R", "N", "I", "N", "E" ],
	[ "T", "W", "E", "L", "E", "V", "E", "N" ],
	[ "S", "I", "X", "T", "H", "R", "E", "E" ],
	[ "F", "I", "V", "E", "I", "G", "H", "T" ],
	[ "D", "P", "A", "S", "T", "O", "R", "O" ],
	[ "F", "I", "V", "E", "H", "A", "L", "F" ],
	[ "Q", "U", "A", "R", "T", "E", "R", "Y" ],
	[ "A", "T", "W", "E", "N", "T", "Y", "D" ]
];

letters_de = [ 
	[ "A", "C", "H", "T", "N", "E", "L", "F" ],
	[ "A", "Z", "E", "H", "N", "E", "U", "N" ],
	[ "B", "E", "N", "D", "R", "E", "I", "\u00dc" ],
	[ "S", "I", "E", "Z", "W", "\u00d6", "L", "F" ],
	[ "E", "I", "N", "S", "E", "C", "H", "S" ],
	[ "H", "A", "L", "B", "V", "I", "E", "R" ],
	[ "V", "O", "R", "N", "A", "C", "H", "*" ],
	[ "F", "\u00dc", "N", "F", "Z", "E", "H", "N" ]
];

$fn = 32;
max = 61; 
s = 61/8; 
d_h = 5; 
w_h =10;
b_h = 5;
c_h = 30;
letter_depth = w_h+1;

f="Libration Sans Bold";
//f = "X.Template";
//f = "Stencil Gothic";
//f = "Major Snafu";
f2= "Libration Sans Narrow";
f2s = 5;

module face(letters, fonts)
{
	for (r = [0:7])
	{
		for (c = [0:7])
		{
			translate([r*s + s/2+.2+.2, c*s+s/2+0.5, 0])
				linear_extrude(height = letter_depth+1)
					text(
						letters[c][r], 
						font=fonts, //"Major Snafu",
						size=4, 
						$fn=20, 
						valign="center", 
						halign = "center"
					);
		}
	}
}


module case_front()
{
	difference()
	{
		union()
		{
			translate([-6,-5,0]) 	cube([6,max+6+6, w_h]);	// left side
			translate([max+1,-5,0])	cube([6,max+6+6, w_h]); // right side 
			translate([0,max+1,0]) 	cube([max+3, 6, w_h]);	// top
			translate([-6,-6,0])	cube([max+6+7, 6, w_h]); 	// bottom
		}
		
		// mounting holes
		
		translate([-2,-2,0]) 				cylinder(d=2.4,h=w_h-2);	// ll 
		translate([max+1+2,-5+3,0]) 		cylinder(d=2.4,h=w_h-2);	// lr
		translate([-2,max+1+2,0])	 		cylinder(d=2.4,h=w_h-2);	// ul
		translate([max+1+2,max+1+2,0])	cylinder(d=2.4,h=w_h-2);	// ur 
	}
}

module dividers(w=1)
{
	for (x = [0:8])
	{
		translate([s*x, 1, 0]) cube([w,max,d_h]);
		translate([0, s*x,0]) cube([max+1, w, d_h]);
	}
}

module clock_front()
{
	difference()
	{
		union()
		{
			translate([0,0,w_h-1]) cube([max+1,max+1,1]);
			translate([0,0,b_h]) dividers();
		}
		face();
	}
	//case_front();
}

module clock_face(letters=letters_en, fonts="Major Snafu")
{
	difference()
	{
		union()
		{
			translate([0,0,w_h-1]) cube([max+1,max+1,1]);
			translate([0,0,b_h]) dividers();
		}
		face(letters, fonts);
	}
	case_front();
}


module clock_face2()
{
	difference()
	{
		union()
		{
			translate([0,0,w_h-1]) cube([max+1,max+1,0]);
			translate([0,0,b_h]) dividers();
		}
		//face2();
	}
	case_front();
}

module diffusers()
{
	difference()
	{
		translate([1,1,0]) cube([max,max,4.5]);
		dividers(1.8 );
	}	
}

module standoff(height=c_h-12.25-2, di=5)
{
	difference()
	{
		cylinder(d1=7,d2=di, h=height);
		translate([0,0,2])	cylinder(d=2.5, h=height);
	}
}

module case_back()
{
	difference()
	{
		union()
		{
			cube([max+1,max+1,2]);
			translate([-6,-5,0]) 		cube([6,max+6+6, c_h]);	// left side
			translate([max+1,-5,0])		cube([6,max+6+6, c_h]); // right side 
			translate([0,max+1,0]) 		cube([max+3, 6, c_h]);	// top
			translate([-6,-6,0])		cube([max+6+6+1, 6, c_h]); 	// bottom
		}
		
		// mount holes 
		
		translate([-2,-2,0]) 			cylinder(d=3,h=c_h+4);	// ll 
		translate([max+1+2,-5+3,0]) 	cylinder(d=3,h=c_h+4);	// lr
		translate([-2,max+1+2,0]) 		cylinder(d=3,h=c_h+4);	// ul
		translate([max+1+2,max+1+2,0])	cylinder(d=3,h=c_h+4);	// ur 
		
		translate([-2,-2,0]) 			cylinder(d=5.5,h=4);	// ll 
		translate([max+1+2,-5+3,0]) 	cylinder(d=5.5,h=4);	// lr
		translate([-2,max+1+2,0]) 		cylinder(d=5.5,h=4);	// ul
		translate([max+1+2,max+1+2,0])	cylinder(d=5.5,h=4);	// ur 
		
		// USB cutout
		
		translate([-6,20,30-8-5])	cube([6, 13, 8]); 	// bottom

		// Time Adjust Button Holes
			
		translate([18+20+5+5,10+12.5+7.5,0])	cylinder(d=5,h=5);
		
		translate([18+20,10+12+7.5,.2]) 	
			rotate([0,180,0])
				linear_extrude(height = 0.2)
					text(
						"+M", 
						font = f2,
						size=f2s, 
						$fn=20, 
						valign="center", 
						halign = "left"
					);
		
		translate([18+20+5+5,10+30+5.5,0])	cylinder(d=5,h=5);
		
		translate([18+20,10+30+5.5,.2])	
			rotate([0,180,0])
				linear_extrude(height = 0.2)
					text(
						"+H", 
						font = f2,
						size=f2s, 
						$fn=20, 
						valign="center", 
						halign = "left"
					);

		// power socket cutout
		
		translate([18+30,13,0])
			 cylinder(d=12,h=16);
		
		translate([18+20,13,0.2]) rotate([0,180,0])
					linear_extrude(height = 0.2)
					text(
						"+6.5 to 9vdc", 
						font = f2,
						size=f2s, 
						$fn=20, 
						valign="center", 
						halign = "LEFT"
					);
	}
	
	// standoffs for Rainbowduino
	
	translate([4.5, 4.5, 2]) 			standoff();
	translate([4.5, max-3.5, 2]) 		standoff();
	translate([max-3.5, 4.5, 2]) 		standoff();
	translate([max-3.5, max-3.5, 2]) 	standoff();
	
	// time adjust buttons pc standoff
	
	translate([18+20+5+5+10, (((10+30+1.5) - (10+12.5+1.5))/2)+10+12.5+6.5,0])
			standoff(height=9, di=5);
	
	// rtc pc standoffs	
	
	translate([5,20,2]) standoff(height=10, di=4);
	translate([5+18,20,2]) standoff(height=10, di=4);
}

module time_buttons()
{
	hull() {
		translate([18+30+5+5,10+12.5+1.5,1])	sphere(d=4);
		translate([18+30+5+5,10+12.5+1.5,1])	cylinder(d=4,h=2);
	}
	translate([18+30+5+5,10+12.5+1.5,5+.4-2.4])	cylinder(d=12,h=1.6);
	
	hull ()	{
		translate([18+30+5+5,10+30+1.5,1])	sphere(d=4);
		translate([18+30+5+5,10+30+1.5,1])	cylinder(d=4,h=2);
	}
	translate([18+30+5+5,10+30+1.5,5+.4-2.4])	cylinder(d=12,h=1.6);
}

print_part();

module print_part() {
	if (part == "front") {
        if (language == "de") {
		    translate([0,0,10]) rotate([0,180,0]) clock_face(letters=letters_de);
        }
        else if (language == "en") {
		    translate([0,0,10]) rotate([0,180,0]) clock_face(letters=letters_en);
        }
        else {
		    translate([0,0,10]) rotate([0,180,0]) clock_face(letters=letters_en);
        }
    } else if (part == "top") {
        translate([0,0,10]) rotate([0,180,0]) clock_face2();
    } else if (part == "face") {
        if (language == "de") {
		    projection() translate([-0,0,10]) rotate([0,180,0]) clock_face(letters=letters_de, fonts="Libration Sans Bold");
        }
        else if (language == "en") {
		    projection() translate([-0,0,10]) rotate([0,180,0]) clock_face(letters=letters_en, fonts="Libration Sans Bold");
        }
        else {
		    projection() translate([-0,0,10]) rotate([0,180,0]) clock_face(letters=letters_en, fonts="Libration Sans Bold");
        }
	} else if (part == "back") {
		case_back();
	} else if (part == "diffusers") {
		diffusers();
	} else if (part == "all") {
		showAll();
	} else {
		showAll();
	}
}

module showAll() {
    if (language == "de") {
        translate([0,0,30.1]) clock_face(letters=letters_de);
    }
    else if (language == "en") {
	    translate([0,0,30.1]) clock_face(letters=letters_en);
    }
    else {
	    translate([0,0,30.1]) clock_face(letters=letters_en);
    }
    case_back();
}

// uncomment to print clock face
//projection() translate([-0,0,10]) rotate([0,180,0]) clock_front();
//translate([-0,0,10]) rotate([0,180,0]) clock_face2();

// uncomment to print led diffusers
//translate([0,0,0]) diffusers();

// uncomment to print back of case
//translate([-0,0,0]) rotate([0,0,0]) case_back();

// uncomment to print time adjust buttons
//translate([0,0,4.5]) rotate([0,180,0]) time_buttons();