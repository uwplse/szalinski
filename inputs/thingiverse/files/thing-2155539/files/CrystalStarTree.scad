// Crystal Star Tree
height=150;
radius=50;
points=8;

function starvec(theta, n, s1, s2, i) = (i < n-1)?concat([[(i%2?s1:s2)*sin(theta*i),(i%2?s1:s2)*cos(theta*i)]], starvec(theta,n,s1,s2,i+1)) : [[(i%2?s1:s2)*sin(theta*i),(i%2?s1:s2)*cos(theta*i)]];

module star(r, n, i = 0.5) {
    p = starvec(360.0/(n*2),n*2,r,i*r,0);
    polygon(points=p, convexity=n);
}

module star_column(rad, h, pts) {
    linear_extrude(height=h,twist=180,scale=.01,$fn=32,convexity=10)
        scale([1,1])
            star(r=rad,n=pts,i=.8);
}

difference() {
    star_column(radius, height, points);
    rotate([0,0,12])
        translate([0,0,-height/15])
            star_column(radius, height, points);
}