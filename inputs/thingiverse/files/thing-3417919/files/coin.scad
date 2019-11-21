// A maker coin
// 2019 - Christian Muehlhaeuser <muesli@gmail.com>
// Inspired by https://www.thingiverse.com/thing:1897796

/* [Coin Dimensions] */

// radius of the coin
coin_radius=24; //[10:1:30]
// outer height/thickness
outer_thickness=9; //[4:1:20]
// inner height/thickness
inner_thickness=4; //[2:1:20]
// diameter of internal torus
torus_diameter=7; //[4:1:12]

/* [Notches] */

// how many notches
notches=8; //[0:1:16]
// radius of notches
notches_radius=20; //[1:1:36]
// offset for notches
notches_offset=18; //[1:1:34]

/* [Logo] */

// upper text
text_upper="mueslix";
// center text
text_center="@";
// lower text
text_lower="twitter.com";

// font face
font_face="Roboto";
// font style
font_style="Bold";
// size of upper text
font_upper_size=4; //[0:1:10]
// size of center text
font_center_size=3; //[0:1:10]
// size of lower text
font_lower_size=4; //[0:1:10]

/* [Hidden] */
$fn = 64;

r1=outer_thickness/2;
r1_dist=coin_radius-r1;
diff=r1-inner_thickness;
r2=(pow(r1_dist,2)-(pow(r1,2)-pow(diff,2)))/((2*r1)+(2*diff));
r2_dist=r2+inner_thickness;
r3=torus_diameter/2;

module coin() {
	rotate_extrude(convexity = 10) {
		difference() {
			union() {
				polygon(points=[[0,0],[r1_dist,0],[r1_dist,r1,],[0,r2_dist]]);
				translate([r1_dist,r1,0])
					circle(r1);
			}
			// add an extra .01 to ensure they touch
			translate([0,r2_dist,0])
				circle(r2+.01);
		}
	}
}

module torus() {
	rotate_extrude(convexity = 10) {
		translate([r1_dist,r1,0])
			circle(r3);
	}
}

module logo() {
	translate([0,(font_upper_size+font_center_size/2),1])
		linear_extrude(r1*2)
			text(text_upper,font=str(font_face, ":style=", font_style),size=font_upper_size,valign="center",halign="center");

	translate([0,0,1])
		linear_extrude(r1*2)
			text(text_center,font=str(font_face, ":style=", font_style),size=font_center_size,valign="center",halign="center");

	translate([0,-(font_lower_size+font_center_size/2),1])
		linear_extrude(r1*2)
			text(text_lower,font=str(font_face, ":style=", font_style),size=font_lower_size,valign="center",halign="center");
}

module notches() {
	if (notches > 0) {
		for (a=[0:360/notches:359]) {
			rotate([0,0,a])
				translate([coin_radius+notches_offset,0,0])
					cylinder(r=notches_radius,h=outer_thickness);
		}
	}
}

difference() {
	difference() {
		union() {
			coin();
			torus();
		}
		logo();
	}
	notches();
}
