
/* [Cover] */

// Cover width and length
cover = 68;

// Total height from the steel part of the outlet to the top of the cover
cover_height = 8;

// Cover corner radius
cover_radius = 5;

// Border radius for the smaller bottom part
cover_bottom_radius = 2.4;

// Cover lip width
cover_lip_width = 4.4;

// Distance from bottom to lip
cover_lip_distance = 4;

// 55 bottom lip
wall_width = 1;

/* [55 cutout] */

// Cutout width/length
cutout_55 = 56.2;

// Needed height for your 55 cover, eg height of the outlet cover. 7.6 can be used for normal outlets, 8.3 for usb charger outlet.
cutout_55_height = 8.3; //7.6; //

// The coutout width/length for the lip below the 55 cutout
cutout_55_inner = 51;


/* [Misc] */

// Resolution
$fn=96;

// Avoid artifacts
clearance = 0.001;


///////////////////////
// Calculated values //
///////////////////////

total_height = wall_width + cutout_55_height;
cover_thickness = total_height - cover_lip_distance;
border_width = (cover - cutout_55) / 2;
slope_cut_degres = atan((total_height - cover_height) / border_width);


///////////
// Build //
///////////

difference () {

    union() {
        
        // Cover
        translate([
            0,
            0,
            cover_lip_distance
        ]) {
            roundedRectangle(
                cover,
                cover,
                cover_thickness,
                cover_radius
            );
        }
        
        // Base
        translate([cover_lip_width,cover_lip_width,0]) {
            roundedRectangle(
                cover-2*cover_lip_width,
                cover-2*cover_lip_width,
                cover_lip_distance,
                cover_bottom_radius
            );
        }
    }

    // Inner 55 cutout
    translate([
        (cover-cutout_55)/2,
        (cover-cutout_55)/2,
        wall_width]
    ) {
        cube([
            cutout_55,
            cutout_55,
            cutout_55_height+clearance
        ]);
    }

    // Inner lip cutout
    translate([
        (cover-cutout_55_inner)/2,
        (cover-cutout_55_inner)/2,
        -clearance]
    ) {
        cube([
            cutout_55_inner,
            cutout_55_inner,
            wall_width+2*clearance
        ]);
    }

    // Sloped cuts for lage 55 covers

    // Left 
    translate([
        -0.6,
        -clearance,
        wall_width+cutout_55_height-tan(slope_cut_degres)*border_width/2
    ]) {
        sloped_cut(-slope_cut_degres);
    }

    // Right
    translate([
        cover-(cover-cutout_55)/2+0.6,
        0,
        wall_width+cutout_55_height-tan(slope_cut_degres)*border_width/2
    ]) {
        sloped_cut(slope_cut_degres);
    }

    rotate(90, [0,0,1]) {
        
        // Bottom
        translate([
            -0.6,
            -cover-clearance,
            wall_width+cutout_55_height-tan(slope_cut_degres)*border_width/2
        ]) {
            sloped_cut(-slope_cut_degres);
        }

        // Top
        translate([
            cover-(cover-cutout_55)/2+0.6,
            -cover,
            wall_width+cutout_55_height-tan(slope_cut_degres)*border_width/2
        ]) {
            sloped_cut(slope_cut_degres);
        }
    }
}

module roundedRectangle(width, depth, height, radius, center=false) {
    translate([radius,radius,0]) {
        minkowski() {
            cube([width-2*radius,depth-2*radius,height/2], center=center);
            cylinder(r=radius,h=height/2);
        }
    }
}

module sloped_cut(deg) {
    translate([
        (cover-cutout_55)/4,
        cover/2,
        (cover-cutout_55)/4
    ]) {
        rotate(deg, [0,1,0]) {
            cube([
                cover,
                cover+2*clearance,
                (cover-cutout_55)/2
            ], center=true);
        }
    }
}
    