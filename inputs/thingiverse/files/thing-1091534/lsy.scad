//Digital Design Fabrication HW2
//Suzy Lau ID20144649
//150914

//variables
/* [Star_Pattern] */
num=30;//[20,30,40]
radii=[3,4,5,6,5,4];

/* [Ring_Pattern] */
count=7;//[2:9]

$fn=100;
color("green")
rotate_extrude(convexity=100)
translate([20,0,0])
scale([1.0,2.0]) circle(r=1);

color("yellow")
make_ring_of(10, count)
translate([19,0,0])
rotate([0,90,-30])
star(num, radii);

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
