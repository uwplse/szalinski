/* Height of basket */
height=80;
/* Top width of basket */
top_width=180;
/* Bottom width of basket */
bottom_width=140;
/* Outer overlap of top part */
top_overlap_outer=8;
/* Inner overlap of top part */
top_overlap_inner=7;
/* Thinnest of basket */
thinnest=3;//[2:7]
/* Size of the holes */
holesize=5;//[4:10]

/* Print bottom part? */
bottom_part=1; //[1,0]

/* Print top part? */
top_part=1; //[1,0]



module skimmerShape(customthinnest = thinnest, customheight = height) {
    difference() {
        cylinder(h=customheight,r1=bottom_width/2, r2=top_width/2);     
        translate([0,0,-1]) cylinder(h=customheight + 3,r1=bottom_width/2-customthinnest, r2=top_width/2-customthinnest);     
    }
}

module skimmerVerticalHoles() {
    difference() {
        skimmerShape();
        for (h = [holesize / 2:holesize * 1.2:height]) { 
            translate([-top_width/2, -top_width/2, h]) cube([top_width, top_width, holesize]);            
        }
        translate([-top_width/2, -top_width/2, height - holesize - 1]) cube([top_width, top_width, holesize + 2 ]);             
        
    }
}


module skimmerhorizontalHoles() {
    difference() {
        skimmerShape();
        difference() {
            translate([0, 0, -1]) cylinder(h=height + 2, r1=top_width, r2=top_width);
            for (rotation = [0:5:179]) {
                rotate([0,0,rotation])  translate([-top_width / 2, -holesize/4, -1]) cube([top_width, holesize / 2, height + 2]);
            }        
        } 
    }
}

module skimmerhorizontalBold() {
    boldthin = holesize * 1.8;
    difference() {
        skimmerShape(customthinnest = thinnest  * 2.0);
        difference() {
            translate([0, 0, -1]) cylinder(h=height + 2, r1=top_width, r2=top_width);
            for (rotation = [0:90:170]) {
                rotate([0,0,rotation])  translate([-top_width / 2, -boldthin/2, -1]) cube([top_width, boldthin, height + 2]);
            }
        }
    }
}

module bottomholes() {
    difference() {
        translate([-top_width/2, -top_width/2, 0]) cube([top_width, top_width, thinnest]);
        for (x = [0:holesize * 1.2:top_width]) { 
            for (y = [0:holesize * 1.2:top_width]) {
                translate([x -top_width / 2 + holesize * 0.1,y - top_width / 2 + holesize * 0.1,-1]) cube([holesize, holesize,thinnest + 2]);
            }
        }
    }
}

module bottom() {
    union() {
        intersection() {
            translate([0,0, -1]) cylinder(h=thinnest + 2, r=bottom_width/2);
            union() {
                bottomholes();
                boldthin = holesize * 1.8;

               translate([-boldthin / 2,-bottom_width/2,0]) cube([boldthin, bottom_width,thinnest * 2.0]);
                translate([-bottom_width/2,-boldthin / 2,0]) cube([bottom_width, boldthin,thinnest * 2.0]);

            }
        }
        difference() {
            translate([0,0, 0]) cylinder(h=thinnest, r=bottom_width/2);
            translate([0,0, -1]) cylinder(h=thinnest + 2, r=bottom_width/2 - 1.5 * thinnest);                
        }
    }
}

module toppart() {
    difference() {
        difference() {
            translate([0,0,height - 1]) cylinder(h=thinnest * 1.5, r=top_width/2 + top_overlap_outer / 2);
            translate([0,0,height - 1 - 1 ]) cylinder(h=thinnest * 1.5 + 2, r=top_width/2 - top_overlap_inner);
        }
        translate([0,0,height + thinnest * 0.7]) cylinder(h=thinnest * 1.5,r=top_width/2 + 0.4);
    };     
}

module skimmer_bottom() {
    skimmerVerticalHoles();
    skimmerhorizontalHoles();
    skimmerhorizontalBold();
    bottom();
}

$fn = 100;

if (bottom_part) {
    skimmer_bottom();
}

if (top_part) {
    translate([0,0,10]) toppart();
}








