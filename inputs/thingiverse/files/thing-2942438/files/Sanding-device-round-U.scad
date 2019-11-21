// ancho interior - inner width
    a=20;
// largo interior - inner lenght
    b=30;
// ancho brazos - arms width
    c=5;
// ancho asidero - grip length
    d=15;
// espesor - thickness
    e=2;
// ancho tira papel lija - sanding paper strip width
    f=10;
// clip width offset
    g=4;
// radio redondeo esquina - corner rounding radius
// corner rounding radius (0 <= r < a/2)
    r1=2;
// radio redondeo esquina clip - clip corner rounding radius
// corner rounding radius (0 <= r < e/2)
    r2=0.99;
// $fn
    $fn=100;

fork();
translate([(a+2*c-2.2*e)/2,d]) clip(r2);
translate([(a+2*c-2.2*e)/2, d+c+2*e+g+r2]) clip(r2);

// --------------------------------------------------------------------
module fork(a=a,b=b,c=c,d=d,e=e,f=f,g=g,r=r1) {
    linear_extrude(height=e) {
        difference() {
            translate([r,r]) offset(r=r) {square([a+2*(c-r),b+d-2*r]);}
            offset(r=r) translate([c+r,d]) square([a-2*r,b]);
        }
    }
}

module clip(r) {
    intersection() {
        cube([2.2*e,c+1.5*e+g+r,f]);
        union(){
            fork(e, c+g, 0.6*e, e+r, f, f, g, r);
            translate([0.3*e,c+e+g+0.5,0]) cylinder(r=0.5*e,h=f);
            translate([1.9*e,c+e+g+0.5,0]) cylinder(r=0.5*e,h=f);
        }
    }
}