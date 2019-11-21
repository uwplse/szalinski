// cookie shape 
shape = [[[-30,30],[0,15],[30,30],[15,0],[30,-30],[0,-15],[-30,-30],[-15,0]],[[0,1,2,3,4,5,6,7]] ]; //[draw_polygon:100x100]

// do you want to sketch a drawing of the cookie? or upload an image?
source = "drawing"; // [drawing, image]

// cookie shape image file. It should be a white cookie on a black background.
shape_file = ""; // [image_surface:100x100]

// drawing scale, 1.0 gives a maximum cookie size of 10cm
scale = 1.0;

// smoothing factor, increase this number to smooth out rough edges, but beware that it might remove small features (eg try 10)
smooth = 0.0;

// cutter total height in mm, 2mm of that height is the lip around the top 
height = 15;

/* [Hidden] */

$fn=60;

module cookie_cutter(h=10) {
    difference() {
        union() {
            linear_extrude(height=2, convexity=10)
                offset(r=3)
                    children();
            translate([0,0,2])
                linear_extrude(height=h-4, convexity=10)
                    offset(r=1)
                        children();
            for (y=[0.9 : -0.1 : 0.5])
            translate([0,0,h+1.6-y*4])
            linear_extrude(height=0.4, convexity=10)
                offset(r=y)
                children();
        }
        translate([0,0,-1])
            linear_extrude(height=h+2, convexity=10)
                children();
    }
}

module smooth_2d(s=smooth) {
    offset(r=-s)
    offset(r=s)
    children();
}

module image_2d(file) {
    projection(cut = true)
    translate([0,0,-50])
    surface(file = file, center = true, invert = false);
}

module dat_2d(file) {
    projection(cut = true)
    translate([0,0,-5])
    scale([1,1,10])
    surface(file = file, center = true, invert = true);
}

module main() {
    mirror([1,0,0])
    cookie_cutter(h=height) {
        scale(scale)
        smooth_2d() {
            if (source == "image") {
                dat_2d(file = shape_file);
            } else {
                polygon(points = shape[0], paths = shape[1]);
            }
        }
    }
}

main();
