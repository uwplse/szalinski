$fn=100;
color("green")
rotate_extrude(convexity=100)
translate([20,0,0])
scale([1.0,2.0]) circle(r=1);

color("yellow")
make_ring_of(radius = 10, count = 7)
translate([19,0,0])
rotate([0,90,-30])
star(30, [3,4,5,6,5,4]);

module make_ring_of(radius, count)
{
    for (a = [0 : count - 1]) {
        angle = a * 360 / count;
        translate(radius * [sin(angle), -cos(angle), 0])
            rotate([0, 0, angle])
                children();
    }
}
module star(num, radii) {
  function r(a) = (floor(a / 10) % 2) ? 10 : 8;
  polygon([for (i=[0:num-1], a=i*360/num, r=radii[i%len(radii)]) [ r*cos(a), r*sin(a) ]]);
}
