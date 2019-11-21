min_gap = 4.6; // the diameter of the plastic rings
circles = 6;
$fn = 18;

concentric_ring_board(circles);

module concentric_ring_board(rings) {
    translate([0,0,-2]) cylinder(h=2, r=2+min_gap*rings, $fn=36);
    spike(0,0);
    for (ring=[1:rings]) {
        circle(min_gap*ring);
    }
}

module circle(r, x=0, y=0, theta=0) { 
    // a circular ring of spikes, radius r, centered on x,y, offset of first peg theta
   circumference = 2 * 3.14159265 * r;
   n_spikes = floor(circumference/min_gap);
   angle = 360.0 / n_spikes;
   for (i=[0:n_spikes-1]) {
       dx = r * cos(theta+angle*i);
       dy = r * sin(theta+angle*i);
       spike(x+dx, y+dy);
   }
}

module spike(x=0, y=0) { // a single spike at position x,y
    translate([x,y,0]) cylinder(h=3.64, d1=2.07, d2=1.58, centre=false);
}
