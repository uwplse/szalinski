// This work was created by David Turnbull and released under a 
// Creative Commons Attribution 4.0 International License.

// Which part would you like to see?
part = "Main"; // [Main:Angle Guide Block,Text:Text For Multi Extruder]
// Blade guide angle
angle = 16; // [10:1:40]
// Rubber band slot width (0=none)
width = 0; // [0:6]


if (part == "Main") {
    bandselect();
} else {
    rotate([0,-angle,0])
    mark(1);
}

module bandselect() {
    ht = tan(angle) * (19-width/2) - 2.5;
    
    if (ht < 1.5) {
        banded(1.5);
    } else if (ht > 4) {
        banded(4);
    } else {
        banded(ht);
    }
}

module banded(ht) {
    difference() {
        fitted();
        
        translate([19-width/2,-1, ht])
        cube([width,22,20]);

        translate([19-width/2 , 19, ht - 1])
        filet();

        translate([19-width/2 , 1, ht - 1])
        rotate([90,0,0])
        filet();

    }
    
}


module filet() {
    difference() {
        cube([width, 1.01, 1.01]);
        
        rotate([0,90,0])
        translate([0,0,-1])
        cylinder(width + 2, 1, 1, $fn = 32);
    }
}

module fitted() {
    difference() {
        union() {
            rotate([0,-angle,0])
            embossed();
            
            translate([0,0,-1])
            cube([1,20,1]);

        }
        
        translate([25,-1,-2])
        cube([200,22,100]);

        translate([0,-1,-101])
        cube([200,22,100]);

    }


}


module embossed() {
    
    difference() {
        translate([0,0,-100])
        cube([100,20,100]);

        mark(1.01);
    }
}

module mark(ht) {
    if (width != 0) {
        mark2(8,ht);
    } else {
        mark2(12.5,ht);
    }    
}

module mark2(x,ht) {
    adjx = sqrt(pow(tan(angle) * x,2) + pow(x,2)) - 4;

    translate([adjx,9.5,-1])
    rotate([0,0,-90])
    linear_extrude(height = ht) {
        text(text = str(angle,"\u00B0"),
            font = "Liberation Sans:style=Bold", 
            size = 8,
            halign = "center"

        );
     }
}

