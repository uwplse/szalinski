//CUSTOMIZER VARIABLES

// LiPo length
lipo_len = 110; // [20:128]

// LiPo width
lipo_wdt = 35; // [10:40]

// LiPo height
lipo_hgt = 17; // [5:20]

//CUSTOMIZER VARIABLES END


rotate([90,-90,0])
difference() {
    // NiMh battery analog
    height = 23*1;
    width  = 45*1;
    length = 130*1;

    radius = height / 2;
    cyl_cc = width - (radius * 2);
    cyl_from_c = cyl_cc / 2;

    hull() {
        translate([0,cyl_from_c,0]) {
            cylinder (length, radius, radius);
        }
        translate([0,-cyl_from_c,0]) {
            cylinder (length, radius, radius);
        }
    }

    // LiPo cutout
    
    translate([radius-lipo_hgt,-lipo_wdt/2,(length-lipo_len)/2]) {
        cube([lipo_hgt,lipo_wdt,lipo_len]);
    }

    // Cable cutouts
    cut_width = 8; // [2:10]
    translate([radius-lipo_hgt,(-cut_width)+lipo_wdt/2,0]) {
        cube([lipo_hgt,cut_width,(length-lipo_len)/2]);
    }

    translate([radius-lipo_hgt,-lipo_wdt/2,0]) {
        cube([lipo_hgt,cut_width,(length-lipo_len)/2]);
    }

}

