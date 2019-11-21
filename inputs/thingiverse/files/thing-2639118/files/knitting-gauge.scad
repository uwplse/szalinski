        

// A selection of large knitting needles
//needles = [5, 5.25, 5.5, 5.75, 6, 6.5, 7, 8, 9, 10, 12.5, 14, 15.5, 19, 25];

// A selection of midsized knitting needles
needles = [2, 2.25, 2.5, 2.75, 3, 3.5, 3.75, 4, 4.25, 4.5, 4.75, 5, 5.25, 5.5, 5.75, 6, 6.5, 7];

// A selection of small knitting needles
//needles = [1, 1.125, 1.25, 1.5, 1.625, 1.75, 2, 2.25, 2.5, 2.75, 3, 3.5, 3.75, 4, 4.25, 4.5, 4.75, 5];

// Added to the hole radii to make the needles fit in the printed gauge
additional_hole_radius = 0.1; 

// The thickness of the gauge disc
thickness = 2;

// Font size
text_size = 4;


count = len(needles);
min_dist = (needles[count-1] + needles[count-2])/2 + 3;
k1 = (min_dist/2);
a = 360/count/2;
rr = k1 / tan(a);
r_t = rr - needles[count-1]/2-1.2;
disc_r = rr + min_dist/2 + 1;
center_hole_r = r_t - text_size*3.1;

$fn=50;

module label(x,y, s, ang) {
    translate([x, y, thickness-0.6])
        linear_extrude(height=3)
            rotate(-ang + 90) text(s, size = text_size, valign="center", halign="right", font="Liberation Sans:style=Bold Italic");   
}


difference() 
{
    difference() {
        cylinder(thickness, disc_r, disc_r);
        translate([0,0,-1]) cylinder(thickness+4, center_hole_r, center_hole_r);  
    }
    
    for (i=[0:len(needles)-1]) {
        r = needles[i] / 2 + additional_hole_radius;
        angle = -i * 360 / len(needles);
        x = sin(angle) * rr;
        y = cos(angle) * rr;
        x_t1 = sin(angle) * r_t;
        y_t1 = cos(angle) * r_t;
        translate([x,y,thickness/2]) cylinder(thickness+2, r, r, center=true);
        label(x_t1, y_t1, str(needles[i]), angle);
    }

}

