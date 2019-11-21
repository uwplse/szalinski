


stegh = 3;          // height of collar
stegb = 1;          // width of collar
rui = 41/2 - stegb; // inner radius of funnel (top (smaller side))
rua = 49/2;         // outer radius of funnel (top)
roi = rui + 10;     // inner radius of funnel (bottom)
rand = 3;
roa = roi + rand;   // outer radius of funnel (bottom)
h = 30;             // height of funnel without collar


module sshape(b=1,h=1,w=0,fn=128) {
    r = 1 / ( 2 - sqrt(2));
    o = 1 / sqrt(2) * r;
    br = w /b;
    scale ([b,h]) scale([1,0.5]) {
        intersection() {
            translate([-1/2-br,-1]) square([1+br,1]);
            translate([-o,-o]) circle(r,$fn=fn);
        }
        difference() {
            translate([-1/2-br,0]) square([1/2+br,1]);
            translate([o,o]) circle(r,$fn=fn);
        }
}
}

b1 = roi-rui;
b2 = roa-rua;
rotate_extrude(convexity = 10 , $fn=256) {
    difference() 
    {
        translate ([rua + b2/2 + 0 * rand,0])  sshape(b2,h,rua+b2);
        translate ([rui + b1/2,0]) sshape(b1,h+0.001,rui+b1);
    }
    translate ([rui+.12 ,h/2-0.001]) square([stegb,stegh]);
}
