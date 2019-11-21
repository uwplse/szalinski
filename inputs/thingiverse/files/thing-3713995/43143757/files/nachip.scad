// Text
text1 = "David";
text2 = "Jan 1st";
text3 = "2014";

// Text Scale
textScale = 1.3; // [0.1:0.1:2]

// Chain Hole
withChainHole = "true"; // [true:With,false:Without]

/* [Hidden] */
chip_width = 4;
engraving_depth = 0.5;
epsilon = 0.01;

module logoPolygon() {
    intersection() {
        cylinder(h=engraving_depth, r=16);
        union() {
            linear_extrude(height = engraving_depth, convexity=10)
            polygon(points=[
                [0,-15.5],
                [0,12],
                [-3.75,12],
                [-3.75,0],
                [-11, 15],
                [-10.7, 6],
            ]);
            linear_extrude(height = engraving_depth, convexity=10)
            polygon(points=[
                [-epsilon,1],
                [2,1],
                [2,16],
                [5.5,16],
                [5.5,1],
                [16,1],
                [16,-2],
                [5.5,-2],
                [5.5,-10],
                [2,-10],
                [2,-2],
                [-epsilon,-2],
            ]);
            difference() {
                cylinder(h=engraving_depth, r=16);
                union() {
                    translate([0,0,-epsilon])
                    cylinder(h=engraving_depth+epsilon*2, r=12);
                    translate([0,-15,engraving_depth/2])
                    cube([40, 10, engraving_depth+epsilon*2], center=true);
                    translate([0,0,-epsilon])
                    linear_extrude(height=engraving_depth+epsilon*2)
                    polygon(points=[[-11,15],[2,-12],[2,20]]);
                }
            }
        }
    }
}

module topText() {
    font = "Heebo:style=Bold";

    translate([0, 5, chip_width-engraving_depth])
    linear_extrude(engraving_depth, convexity = 10)
    text(text=str(text1), font=font, size=5, halign="center");
    
    translate([0, -2, chip_width-engraving_depth])
    linear_extrude(engraving_depth, convexity = 10)
    text(text=str(text2), font=font, size=5, halign="center");
    
    translate([0, -9, chip_width-engraving_depth])
    linear_extrude(engraving_depth, convexity = 10)
    text(text=str(text3), font=font, size=5, halign="center");
}

module chip_body() {
    cylinder(h=chip_width, r=20, center=false);
}

module chainHole() {
    translate([0,0,chip_width/2]) {
        difference() {
            union() {
                cylinder(h=chip_width, r=chip_width/2, center=true);
                translate([0, -chip_width/4, 0])
                cube([chip_width, chip_width/2, chip_width], center=true);
            }
            rotate([0,90,0])
            intersection() {
                hole_h = chip_width+1;
                hole_cube_size = chip_width*.5;
                cube([hole_cube_size, hole_cube_size, hole_h], center=true);
                rotate([0,0,45])
                cube([hole_cube_size, hole_cube_size, hole_h], center=true); 
            }
        }
    }
}

module chip() {
    union() {
        difference() {
            chip_body();
            union() {
                translate([0,0,-epsilon])
                rotate([0,180,0])
                translate([0,0,-engraving_depth])
                logoPolygon();
                translate([0,0,epsilon])
                scale([textScale,textScale,1])
                topText();
            }
        }
        if (withChainHole == "true") {
            translate([0, 20+chip_width*2/5, 0])
            chainHole();
        }
    }
}

$fn=100;
chip();
