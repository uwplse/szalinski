// ---------- variables in mm ----------
// just change these two values to
// adapt these end caps to your
// handlebar :)

// The outer diameter of the cap.
capDiameter = 26;

// The diameter of the "plug/cross part". In my case an added 0.2mm to the measured inner diameter of the handlebar gave the caps a pretty good fit.
plugDiameter = 17.2;

perimeterWidth = 0.4;

union() {
    // ---------- plug ----------

    intersection() {
        hull () {
            // upper (tapered) part
            translate([0,0,24])
                cylinder(h=2, d=plugDiameter-3, center=false, $fn=120);


            // lower part
            translate([0,0,2.2])
                cylinder(h=12, d=plugDiameter, center=false, $fn=120);
        };
        
        // cross section cutout
        union() {
            translate([-14,-3*perimeterWidth,2.2])
                cube([28,6*perimeterWidth,23], center = false);
            translate([-3*perimeterWidth,-14,2.2])
                cube([6*perimeterWidth,28,23], center = false);
        };
    };

    // ---------- cap ----------

    difference() {
        resize(newsize=[capDiameter,capDiameter,0])
        difference() {
            difference() {
                // create the cap body
                translate([0,0,2])
                    cylinder(h=4, d=26, center=true, $fn=120);
                
                // subtract the inset
                translate([0,0,3.5])
                    cylinder(h=3, d=24, center=true, $fn=120);
            };
            
            // subtract the bicycle
            rotate([0,180,0])
            translate([0.25,4,0])
            resize(newsize=[28,28*0.6132,2])
            union () {
                // frame
                frameTrianglePoints = [[0,2],[6,-7],[-5.5,-7],[-10,2],[-0.75,1],[4,-6],[-4.65,-6],[-8.25,1]];
                frameTrianglePaths = [[0,1,2,3],[4,5,6,7]];
                linear_extrude(height = 1, center = true, convexity = 10, twist = 0)
                polygon(frameTrianglePoints,frameTrianglePaths,10);

                // front wheel
                translate([7.85,1,0])
                difference () {
                    cylinder(h=1, d=10, center=true, $fn=120);
                    cylinder(h=2, d=8, center=true, $fn=120);
                };

                //back wheel
                translate([-8.8,1,0])
                difference () {
                    cylinder(h=1, d=10, center=true, $fn=120);
                    cylinder(h=2, d=8, center=true, $fn=120);
                };

                // saddle pole
                translate([-3.5,-4,0])
                rotate([0,0,60])
                cube([12,1,1], center = true);

                // saddle
                saddleTrianglePoints =[[-3,-9],[-2,-10],[-8,-10],[-8,-9],[-6,-8]];
                saddleTrianglePaths =[[0,1,2,3,4]];
                translate([-0.75,0.75,0])
                rotate([0,0,5])
                linear_extrude(height = 1, center = true, convexity = 10, twist = 0)
                polygon(saddleTrianglePoints,saddleTrianglePaths,10);

                // fork
                translate([5,-10,0])
                rotate([0,0,-15])
                color("Green")
                union () {
                    translate([0,6,0])
                    cube([1,12,1], center = true);

                    translate([-1.5,-1,0])
                    cube([1,1,1], center = true);

                    translate([-1,0,0])
                    difference () {
                        cylinder(h=1, d=3, center=true, $fn=120);
                        cylinder(h=2, d=1, center=true, $fn=120);
                        translate([-1.5,0,0])
                            cube([3,3,2], center = true);
                        translate([0,1.5,0])
                            cube([3,3,2], center = true);
                    };
                };
            };
        };

        // create a nice beveled edge
        difference() {
            cylinder(h=4, d=capDiameter+2, center=true, $fn=120);

            translate([0,0,3])
                cylinder(h=6, d1=capDiameter-2, d2=capDiameter+10, center=true, $fn=120);
        };
    };
};