// pi zero case
// Glyn Cowles Dec 2017
x=70; // length
y=35; // width
ht=8;
th=.8; // thickness
pilx=58; // pillar separation
pily=23; //   ""
pilht=1; // height of pillars
pild=5; // diam of pillars
pilhole=2.7; // pillar hole or pin size diam
pilPin=1; // mount, set to 1 for pin or 0 for hole
sd=14; // set to 0 or 14 for sd slot
cam=0; // set to 0 else 15 for cam slot
usb1=12; // power
usb2=12; // set to 0 or 12 for usb slot
hdmi=15; // set to 0 or 15 for hdmi slot
topText="PiZeroW"; // text for top 
txtSz=20; // text size
txtx=58; // manual adjustment for text
txty=12; //         ""
hdrx=52; // header pin slot 52mm or set to 0 if not reqd
hdry=5.5; //         "      5.5mm        "

// lh side
c1=(y-cam)/2;
//front
f1=(x-pilx)/2+2;
f3=(x-pilx)/2+1;
f2=x-f1-usb1-usb2-hdmi-f3;
// rh side
sd1=(y-pily)/2+2;
sd2=y-th*2-sd1-sd;

hx=(x-hdrx)/2;
hy=(y-hdry)/2+11.5;
p1=(x-pilx)/2;
p2=(y-pily)/2;
$fn=50;


bottom();
translate([0,y+th,0]) top();
//-------------------------------------------------------------------
module top(){
    difference() {
    cube([x,y,th]); // 
    #translate([txtx,txty,th]) rotate([0,180,0]) linear_extrude(th) text(topText,font="rm playtime stencil",size=txtSz);
    translate([hx,hy,0]) cube([hdrx,hdry,th]); // header cut out
}
csz=3; // post sz
translate([th,th,th]) cube([csz,csz,ht/4]);
translate([x-csz-th,th,th]) cube([csz,csz,ht/4]);
translate([th,y-csz-th,th]) cube([csz,csz,ht/4]);
translate([x-csz-th,y-csz-th,th]) cube([csz,csz,ht/4]);
r=th; // rim ht
translate([th,th,th]) cube([x-2*th,th,r]);
translate([th,y-th*2,th]) cube([x-2*th,th,r]);
translate([th,th,th]) cube([th,y-2*th,r]);
translate([x-th*2,th,th]) cube([th,y-th*2,r]);}
//-------------------------------------------------------------------
module bottom1() {
cube([x,y,th]); // base
// back
translate([0,0,th]) cube([x,th,ht-th]);
// lh
translate([0,th,th]) cube([th,c1,ht-th]);
translate([0,y-c1-th,th]) cube([th,c1,ht-th]);
//rh
translate([x-th,th,th]) cube([th,sd1,ht-th]);
translate([x-th,th+sd+sd1,th]) cube([th,sd2,ht-th]);
//front
translate([0,y-th,th]) cube([f1,th,ht-th]);
translate([f1+usb1+usb2,y-th,th]) cube([f2,th,ht-th]);
translate([f1+usb1+usb2+f2+hdmi,y-th,th]) cube([f3,th,ht-th]);
// pillars
translate([p1,p2,th]) pillar(pild,pild*.8,pilht);
translate([p1+pilx,p2,th]) pillar(pild,pild*.8,pilht);
translate([p1+pilx,p2+pily,th]) pillar(pild,pild*.8,pilht);
translate([p1,p2+pily,th]) pillar(pild,pild*.8,pilht);
}
//-------------------------------------------------------------------
module bottom() {
    if (pilPin==0) { // if holes cut them out
        difference() {
            bottom1();
            translate([p1,p2,0]) pillar(pilhole,pilhole,pilht+th);
            translate([p1+pilx,p2,0]) pillar(pilhole,pilhole,pilht+th);
            translate([p1+pilx,p2+pily,0]) pillar(pilhole,pilhole,pilht+th);
            translate([p1,p2+pily,0]) pillar(pilhole,pilhole,pilht+th);
            
        }
    }
    else { // if pins add them in
        bottom1();
        pinHt=3;
        translate([p1,p2,0]) pillar(pilhole,pilhole*.95,pilht+pinHt);
        translate([p1+pilx,p2,0]) pillar(pilhole,pilhole*.95,pilht+pinHt);
        translate([p1+pilx,p2+pily,0]) pillar(pilhole,pilhole*.95,pilht+pinHt);
        translate([p1,p2+pily,0]) pillar(pilhole,pilhole*.95,pilht+pinHt);
    }
}
//-------------------------------------------------------------------
module pillar(diam1,diam2,ht) {
        cylinder(d1=diam1,d2=diam2,h=ht);
}
//-------------------------------------------------------------------

