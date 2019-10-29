// Distance between lines
spacing=5;

// Printable radius
radius=150;

// Nozzle diameter
nozzle=0.4;

// $fn
$fn=50;


for (r = [0:spacing:radius]) {
    difference() {
        cylinder(r=r, h=nozzle*.75);
        cylinder(r=r-nozzle*3, h=100);
    }
}