$fn = 200;

// total height
h = 15;

// radius of main body of tray. note that the lip at the top is wider than this
r = 35;

wall_thick = 1.5;

// how much smaller the bottom is in radius than the top part of the tray, which it needs to fit inside.
tol = 0.3;

// the radius at the bottom of the tray is r - horiz_inset - this way the bottom of one tray can fit into the top of another
horiz_inset = wall_thick + tol;

// how much overlap there is between trays when they're stacked. TODO: also account for slant_dy
vert_inset = 3;
slant_dy = horiz_inset;
fillet_r = h - wall_thick - vert_inset - slant_dy;

// embossed text at the center of the tray
text = "thing:2005869";
font_size = 5;


module profile() {

    /*           
    Side profile of the tray. First create a polygon for this shape, then
    subtract a circle so that the inside bottom edge of the container is
    rounded. This makes it much easier to grab parts out of it since they can't
    get stuck in the corner.

                     __
                    /  |
                   |  / <- the slanted parts move by (horiz_inset, slant_dy)
                   | | 
                ___| |
               |     | <- note that the inside of this contains a square of size fillet_r - we later remove a circle to leave just a beveled lower right corner
      _________|     / <- the slanted edge here and above make it printable without supports.
      ______________|

    */

    // The polygon starts out at the bottom center point, then lists the points
    // counter-clockwise
    difference() {
        polygon([
            [0,0],
            [r-horiz_inset, 0],
            [r-horiz_inset, vert_inset],
            [r, vert_inset + slant_dy],
            [r, h-2*slant_dy],
            [r+wall_thick, h-slant_dy],
            [r+wall_thick, h],
            [r, h],
            [r-wall_thick, h-slant_dy],
            [r-wall_thick, wall_thick + fillet_r],
            // most of the fillet_r x fillet_r square is removed when we
            // subtract the circle below, giving the inside a rounded edge.
            [r-wall_thick-fillet_r, wall_thick + fillet_r],
            [r-wall_thick-fillet_r, wall_thick],
            [0, wall_thick]
        ]);

        translate([r-wall_thick-fillet_r, wall_thick+fillet_r])
        circle(r=fillet_r);
    }
}

module tray(text="", font_size=10) {
    difference() {
        rotate_extrude(convexity=10)
        profile();

        // draw embossed text
        if (text != "") {
            d = wall_thick/4.0; // embossed text depth
            translate([0, 0, wall_thick-d])
            linear_extrude(1000)
            text(text,halign="center", valign="center",size=font_size);
        }
    }
}

tray(text=text, font_size=font_size);
