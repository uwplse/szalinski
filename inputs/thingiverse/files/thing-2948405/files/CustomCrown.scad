/////////// START OF PARAMETERS /////////////////

// Inner radius
inner_radius = 70;
// Body height
body_height = 25;
// Text
text_val = "Name";
// Font
text_font  = "Liberation Serif:style=Bold";
text_offset = -7.5;
text_height = 1.2;

pearl_size  = 4;

// Radius of facets
facet_radius = 1.2;

// Upper extra radius for the spikes
upper_extra = 9;

// # of spikes 
aantal_spikes = 7;

// Height of spikes
hoogte_spikes = 50;

// Oval Spikes
oval_spikes = true;
// If oval does not match the Pearl change this first
ovalWidth  = 65; 
// Oval hight changes the curve an should be at least twize as large as the hoogte_spikes
ovalHeight = 120;
// nice looking offset 
ovalOffset = 10;
// text size
text_size = 3*body_height/5;
/////////// END OF PARAMETERS /////////////////

outer_radius = inner_radius+2;
$fn = 40;
pi  = 3.1415926;
pi2 = pi*2;

// Flens Top
module flensTop() translate([0, 0, -(body_height/2)+facet_radius]) {
	difference() {
		rotate_extrude()
            translate([outer_radius, 0, 0])
                circle(r = facet_radius);
		rotate_extrude()
			translate([outer_radius-(2*facet_radius), -facet_radius, 0])
				square(2*facet_radius);
	}
}

// Flens Bottom
module flensBottom() translate([0, 0, (body_height/2)-facet_radius]) {
	difference() {
		rotate_extrude()
            translate([outer_radius, 0, 0])
                circle(r = facet_radius);
		rotate_extrude()
			translate([outer_radius-(2*facet_radius), -facet_radius, 0])
				square(2*facet_radius);
	}
}

//Gems    3 gems=[5:7]  5 gems=[4:8]
module gems() for (i = [5:7]) {
	translate([sin(360*i/6)*(outer_radius-.5), cos(360*i/6)*(outer_radius-.5), 0 ]) 
        sphere(r = body_height/7.5);
}

//Body
module body() difference() {
    union() {
        gems();
        flensTop();
        flensBottom();
        cylinder(r=outer_radius, h=body_height, center=true, $fn=200);
        translate([0, 0, text_offset]) 
            textCylinder(text=text_val, h=text_height, size=text_size, r=outer_radius, font=text_font, center=false);
    }
    cylinder(r=inner_radius, h=body_height+2, center=true, $fn=200);
    //translate([0, 0, -0.5*body_height+6.35]) cylinder(r=4.7,h=4); //Inkeping tbv connector
}


module spikes() translate([0, 0, .499*body_height]) difference() {
    union() {
        for (i = [0:aantal_spikes]) {
            rotate([90, 0, 360/aantal_spikes*i])
                linear_extrude(height = outer_radius+upper_extra, center = false)
                    polygon(points=[[-pi*inner_radius/aantal_spikes, 0],
                                    [pi*inner_radius/aantal_spikes,  0],
                                    [0, hoogte_spikes]]);
        }
    }
    //Cut out spikes inner
    translate([0, 0, -.001*body_height]) cylinder(r1=inner_radius, r2=inner_radius+upper_extra, h=hoogte_spikes+0.1, $fn=200);         
        cube(300, center=true);
        cylinder(r1=outer_radius, r2=outer_radius+upper_extra, h=hoogte_spikes, $fn=200);
    }  //Cut out spikes outer 
    difference() { 
}

module spikesOval() translate([0, 0, .499*body_height]) difference() {
    union() {
        for (i = [0:aantal_spikes]) {
            rotate([0, 0, 360/aantal_spikes*i+270]) 
                difference() {
                    translate([0, -1.05*pi*inner_radius/aantal_spikes, 0]) 
                        cube([outer_radius+upper_extra, 2.1*pi*inner_radius/aantal_spikes, hoogte_spikes]);
                    translate([0, -1*pi*inner_radius/aantal_spikes, ovalHeight/2+ovalOffset]) 
                        resize([outer_radius+upper_extra, ovalWidth, ovalHeight]) rotate([0, 90, 0]) 
                            cylinder(r=pi*inner_radius/aantal_spikes, h=outer_radius+upper_extra, $fn=100);
                    translate([0, pi*inner_radius/aantal_spikes, ovalHeight/2+ovalOffset]) 
                        resize([outer_radius+upper_extra, ovalWidth, ovalHeight]) rotate([0, 90, 0]) 
                            cylinder(r=pi*inner_radius/aantal_spikes, h=outer_radius+upper_extra, $fn=100);
                }
        }
    }
    //Cut out spikes inner
    translate([0, 0, -.001*body_height]) cylinder(r1=inner_radius, r2=inner_radius+upper_extra, h=hoogte_spikes+0.1, $fn=200);         
    difference() { 
        cube(300, center=true);
        cylinder(r1=outer_radius, r2=outer_radius+upper_extra, h=hoogte_spikes, $fn=200);
    }  //Cut out spikes outer 
}

//Pearls on top of spikes
module pearls() {
    pos = (outer_radius-inner_radius)/2+inner_radius+upper_extra;
    rotate([0, 0,  180]) {
        for (i = [0:aantal_spikes]) {
            translate([sin(360*i/aantal_spikes)*(pos), cos(360*i/aantal_spikes)*(pos), 
                      .5*body_height+hoogte_spikes-1]) sphere(pearl_size);
        }
    }
}




module crown() {
    body();
    if (oval_spikes == true) spikesOval();
    else spikes();
    pearls(); 
}

crown();
/// HELPERFUNCTIONS
// textManipulation.scad
// by MichaelAtOz  - Public Domain
// Note: Due to text() sizing being approximate you will have to manually adjust position.
//		 Also the technique used stretches the sides of larger text. (or smaller r)
module textCylinder(	text="TEST"
						,r=30
						,h=2			// embosed height of letters
						,size=10		// text(size=)
						,rotate=[0,0,0]		// | y= rotate face of text
											// | z= rotate around the circumference
											// | x is ignored
						,font=undef		// : these allow default value in text()
						,spacing=undef	// : undef gets rid of WARNING unknown variable
						,language=undef
						,script=undef
						,valign=undef
						,halign="center" // is centered due to the technique used here
										// feel free to try others, YMMV.
						,direction=undef
						) { 
	s=0.1; s2=s*2;	// small, for difference etc.
	l=3;			// large (as a multiplyer) to allow for text size irregularity
	tall=( rotate!=[0,0,0] || direction=="btt" || direction=="ttb" );
	_h= (	tall 					// keep cut cylinders to reasonable size
			? (size*len(text)*l) 
			: size*l ); 
	_r=(r+h)*l;
	//echo(r=r,h=h,text=text,size=size,rotate=rotate);
	//echo(l=l,tall=tall,_h=_h,_r=_r);
	difference() {
		rotate([90,rotate[1],rotate[2]])
			linear_extrude(height=r+h,convexity=5)
				text(text,size,halign="center"
						,font=font
						,spacing=spacing
						,language=language
						,script=script
						,valign=valign
						,direction=direction
				);
		// -
		translate([0,0,size/2]) {
			cylinder(r=r,h=_h,center=true);
			difference() {
				cylinder(r=_r,h=_h+s,center=true);
				// -
				cylinder(r=r+h,h=_h+s2,center=true);
			} //d
		} // t
	} // d
} // textCylinder
