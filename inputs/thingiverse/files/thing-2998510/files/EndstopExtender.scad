/* [Base Parameters] */

// in mm
baseDiameter = 20; // [1:0.1:50]

// in mm (take care to use the core diameter - default is an M3 screw)
threadDiameter = 2.5; // [1:0.01:20]

// in mm (extension height)
footHeight = 5; // [1:0.01:50]

// in mm (distance that the screw enter the extension)
threadHeight = 5; // [1:0.1:50]

// in mm
thickness = 2; // [0.1:0.01:10]

// used as §fn value
resolution = 50;

/* [Tick Parameters] */
// number of ticks (take the thread pitch as a reference - M3 pitch: 0.5)
ticks = 5; // [0:1:36]

// number of sub ticks per tick
subTicks = 1; // [0:1:20]

// in mm (tick height)
tickHeight = 2.5; // [1:0.1:50]

// in mm (sub tick height)
subTickHeight = 1.5; // [1:0.1:50]

/* [Hidden] */

$fn = resolution;

difference() {
    union() {
        cylinder(h = thickness, r = baseDiameter / 2);
        cylinder(h = footHeight + threadHeight, r1 = baseDiameter / 2 - thickness, r2 = threadDiameter / 2 + thickness);
        tickWidth = max(thickness, threadDiameter);
        for(tickAngle = [0 : 360 / ticks : 360]) {
            rotate([0, 0, tickAngle]) {
                linear_extrude(height = tickHeight + thickness) {
                    polygon(points = [ [-tickWidth / 2, 0], [tickWidth / 2, 0], [0, baseDiameter / 2] ]);
                }
                for(subTickAngle = [(360 / ticks) / (subTicks + 1) : (360 / ticks) / (subTicks + 1) : 360 / ticks - 0.00001]) { // - 0.00001 to avoid the last subTick to be drawn - this is an ugly hack but shouldn't bring any problems
                    rotate([0, 0, subTickAngle]) {
                        linear_extrude(height = subTickHeight + thickness) {
                            polygon(points = [ [-tickWidth / 2, 0], [tickWidth / 2, 0], [0, baseDiameter / 2] ]);
                        }
                    }
                }
            }
        }
    }
    translate([0, 0, footHeight]) {
        cylinder(h = threadHeight + 1, r = threadDiameter / 2);
    }
} 
