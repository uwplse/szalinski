// preview[view:south, tilt:top]

// Select part(s) to render
part = "both"; // [both:Top and bottom,top:Top,bot:Bottom]

// Detail for rotational extrusion
fn_lathe = 128;// [4:1:256]

// Detail for the curved parts of the cross section
fn_shape = 128;// [4,8,16,32,64,128,256]

// Gap between parts along Z axis
gap_z = .5; // [0:.05:1.5]

// Gap between parts along X and Y axis
gap_xy = .15; // [0:.05:1]


/* [hidden] */
shaft_r = 1;
edge_r = 1.5;
edge_extr = 5;
ofs = 1.25;

if(part == "bot") {
    bot();
} else
if(part == "top") {
    top();
} else
if(part == "both") {
    translate([15, 0, 11.5])
    translate([0, 0, -gap_z])
    rotate(180, [1, 0, 0])
    bot();    
    
    translate([-20, 0, -9+.25])
    top();
}
if(part == "test") {
    bot();
    top();
}


module bot() {
    intersection() { 
        spinning_top();
        translate([0, 0, -gap_z])
        cutout(gap_xy);
    }
}

module top() {
    difference() {
        spinning_top();    
        cutout();
    }    
}

module cutout(gap=0) {
    translate([0, 0, -5])
    cylinder(r=12-gap, h=11.5+5, $fn=fn_lathe);
}

module spinning_top() {
    difference() {
        rotate_extrude($fn=fn_lathe, angle=360/1)
        difference() {
            offset(r=ofs, $fn=fn_shape)
            difference() {                
                union() {
                    color("green")
                    polygon(points=[
                        [0, 0+2],
                        [shaft_r, 2],
                        [10+shaft_r, 10],
                        [10+shaft_r, 10+edge_r*2],
                        [shaft_r+1, 30+edge_r*2+5],
                        [0, 30+edge_r*2+5]
                    ]);

                    // Bottom tip
                    color("green")
                    translate([0,shaft_r+1])
                    circle(r=shaft_r, $fn=fn_shape);

                    // Top tip
                    color("green")
                    translate([0, 30+edge_r*2+4])
                    circle(r=shaft_r+1, $fn=fn_shape);
                
                    color("green")
                    translate([10+shaft_r, 10+edge_r])
                    square([edge_extr*2, edge_r*2], center=true);
                }

                color("red")
                translate([10+shaft_r, 2])
                scale([1, .8])
                circle(r=10, $fn=fn_shape);

                color("red")
                translate([10+shaft_r, 30+edge_r*2])
                scale([1, 2])
                circle(r=10, $fn=fn_shape);
            }
            
            color("red")
            translate([-shaft_r-4, -5])
            square([shaft_r+4, 50]);
        }
    }
}