depth = 80; // how deep to make the sieve.
diameter = 160; // sieve diameter.
wall_size = 5; // wall thickness.
hole_size = 3;  // hole diameter.
floor_thickness = 0.2;

union() {
    difference() {
        cylinder(h=depth, d=diameter, $fn=100);
        cylinder(h=depth, d=diameter - wall_size*2, $fn=100);
    }
    linear_extrude(height=floor_thickness)
        difference() {
            circle(d=diameter);
            for (i=[-diameter/2:hole_size*2:diameter/2]) {
                for (j=[0:hole_size+1:diameter]) {
                    translate([i, j-diameter/2, 0])
                        circle(d=hole_size, $fn=10);
                    translate(
                        [i-hole_size,
                         j-(diameter/2 + (hole_size+1)/2),
                         0])
                        circle(d=hole_size, $fn=10);
                }
            }
        }
}