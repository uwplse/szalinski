/////////////////////////
// iphone SE car holder
//


module rounded_cube (w, d, h, r, centered = false)
{
    tr_x = centered ? -w/2 : 0;
    tr_y = centered ? -d/2 : 0;
    tr_z = centered ? -h/2 : 0;
    
    translate ([tr_x,tr_y,tr_z]) hull () {
        $fn=40;
        translate ([0,r,r]) rotate ([0,90,0]) cylinder (w,r,r);
        translate ([0,d-r,r]) rotate ([0,90,0]) cylinder (w,r,r);
        translate ([0,r,h-r]) rotate ([0,90,0]) cylinder (w,r,r);
        translate ([0,d-r,h-r]) rotate ([0,90,0]) cylinder (w,r,r);
    }
}

iph = 123.8;        // iphone height
ipd = 58.6;         // iphone depth
ipw = 7.6;          // iphone width
ipr = 11.6;         // iphone corner radius
cth = 5.5;            // casing thickness

ih = iph + 2*cth;   // inner height
iw = ipw + 2*cth;   // inner width
id = ipd + 2*cth;   // inner depth
ir = ipr + cth;     // inner radius

th = 3;             // holder thickness
sm = 4;             // side margin
bm = 16;            // bottom margin
hbm = 13;            // home button radius margin

oh = ih + 2*th;     // outer height
ow = iw + 2*th;     // outer width
od = id + 2*th;     // outer depth

rr = 3;             // rounding radius
bsl = 40;           // bottom slot length
bsw = 7;            // bottom slot width
bpl = 14;           // bottom power length

hr = 1.65;           // hole radius
shr = 3;          // screw head readius
shh = 3;            // screw head height

//
// main holder body
//

difference () {
    union () {
        // outer body
        rounded_cube (ow,od,oh,ipr);
        // rear attachment
        color ("darkgray") translate ([-th,th,(oh-id)/4+th]) 
            rounded_cube (th,id,id-th,ir);
    }

    // top left corner cut-out
    translate ([-0.05,-th*2,oh*1.1]) rotate ([0,90,0]) 
        cylinder (h = ow+0.1, r = oh*0.5, $fn=100);
        
    // iphone cut-out
    translate ([th,th,th]) rounded_cube (iw,id,oh+th,ir);
    
    // front and top cut-out
    translate ([th,th+sm,bm+th]) rounded_cube (ow-th+0.01,id-2*sm,oh,rr);

    // home button cut-out
    translate ([th+iw-0.005,th+id/2-hbm,th]) 
        rounded_cube (th+0.01,hbm*2,bm+4,rr);
    translate ([th+iw-0.005,th+id/2-hbm-rr,th+bm-rr]) 
        cube ([th+0.01,2*rr+2*hbm,rr+0.01]);
    
    // bottom slot and power outlet
    translate ([(ow-bsw)/2,th+id/2-bsl/2,th*1.5]) 
        rotate ([0,90,0]) rounded_cube (th*2,bsl,bsw,bsw/2);
    translate ([(ow-iw)/2,th+id/2-bpl/2,th*1.5]) 
        rotate ([0,90,0]) rounded_cube (th*2,bpl,iw*2,rr);
    translate ([ow-rr,od/2-bpl/2-rr,-0.1]) 
        cube ([rr+0.1,bpl+rr*2,rr+0.2]);

    // screw holes
    for (i=[0:1:5]) {
        ex = i==0? 1 : i==5 ? 1 : 0;
        for (j=[ex:1:5-ex]) {
            translate ([th+0.01,th+hr+ir/4+j*id/6,hr+ir/2+i*(id-th-2*hr)/6+(ih-id+th)/4]) 
            rotate ([0,-90,0]) {
                $fn=40;
                cylinder (h=th*2+0.1,r=hr);
                cylinder (h=shh,r=shr);
            }
        }
    }
}


// adding rounding near the home button
translate ([th+iw,th+id/2-hbm-rr,th+bm-rr]) 
    rotate ([0,90,0]) cylinder (h=th,r=rr, $fn=40);
translate ([th+iw,th+id/2+hbm+rr,th+bm-rr]) 
    rotate ([0,90,0]) cylinder (h=th,r=rr, $fn=40);

translate ([ow-rr,od/2-bpl/2-rr,0])
    rotate ([0,0,0]) cylinder (h=th,r=rr, $fn=40);
translate ([ow-rr,od/2+bpl/2+rr,0])
    rotate ([0,0,0]) cylinder (h=th,r=rr, $fn=40);
