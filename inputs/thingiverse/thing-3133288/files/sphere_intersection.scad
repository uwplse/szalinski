r = 25;
d = 20;
dh = d/2;
$fn = 50;

spheres();

module spheres() {
    intersection() {
        spA();
        spB();
        spC();
        }
    }

module spObject(){
    sphere(r, $fn, center=true);
    }

module spA() translate([d, 0, 0]) spObject();
module spB() translate([dh, -dh*1.732, 0]) spObject();
module spC() spObject();

echo(version=version());
