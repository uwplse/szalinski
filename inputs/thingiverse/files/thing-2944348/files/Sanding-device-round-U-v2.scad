// ancho  -  width
    a=30;
// largo  -  lenght
    b=50;
// ancho interno - inner width
    c=20;
// ancho asidero - grip length
    d=20;
// espesor - thickness
    e=2;
// ancho tira papel lija - sanding paper strip width
    f=10;
// clip width tolerance offset
    g=4;
// radio redondeo esquina - corner rounding radius
// corner rounding radius (0 <= r < a/2)
    r1=2;
// radio redondeo esquina clip - clip corner rounding radius
// corner rounding radius (0 <= r < e/2)
    r2=0.99;
// $fn
    $fn=180;
    
fork();
translate([a/2-1.5*e,d+(a-c)/2+e+g+1]) clip();
translate([a/2-1.5*e,d-3]) clip();

// --------------------------------------------------------------------
module fork(a=a,b=b,c=c,d=d,e=e,r=r1) {
    ab=(a-c)/2;
    linear_extrude(height=e) {
        difference() {
            offset (r=r) difference() {
                translate([r,r]) square([a-2*r,b-2*r]);
                translate([ab-r,d]) square([c+2*r,b]);
            }
            translate([a/2,d+r]) circle(d=c);
        }
    }
}

module clip(r=r2) {
    fork(3*e, (a-c)/2+2*e+g, e, e, f, r);
}
