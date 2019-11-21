// ================

// bearings 8x22x7
// spools are 88 x (80+56+80 = d216 r108)

// SET THIS which spool are you using?
// spool width: 88mm = 1kg spool, 54mm = 700g spool, 65mm = 1kg Inland spools
spoolw=88; // 
// spoolw=54; 


// holder wheel width
bwc=10;

// TWEAK THIS depending on material and printer:

// wheel plate to side bar clip material margin 
sscm=0.05;

// ================

// width of spool side wheel 
spoolww=4;

spooldd=spoolw-spoolww; // center of side wheel to center of side wheel

// holder wheel margin to sides
bwcm=1;

// holder side thickness
bht=1.6;

bhw=bwc+bwcm*2+bht*2; // total width

// side to side bar distance from wheel center
sswd=15;

// side to side bar depth
ssd=8;

// side to side bar height
ssh=1.5;

// side to side bar in between height
ssh2=3;

// side to side bar clip height
ssch=5;

// side to side bar clip depth
sscd=5.4;

// side to side bar clip width
sscw=5.4;

// side to side bar height margin (executed on side bar)
sshm=0.8;

// side to side bar height margin (executed on side bar)
ssdm=0.4;


// ================
// library

module box(pos,size) { translate(pos) cube(size); }

module torus(pos=[0,0,0],r1=10,r2=2,angle=360)
{
   translate(pos)
   rotate_extrude(angle=angle)
      translate([r1,0]) circle(r=r2);
}

module cyl_y(base=[0,0,0],h=10,r=5)
{
   translate(base) rotate([-90,0,0]) cylinder(h=h,r=r);
}

module cyl_x(base=[0,0,0],h=10,r=5)
{
   translate(base)
      rotate([0,90,0])
      cylinder(h=h,r=r);
}

module cyl_z(base=[0,0,0],h=10,r=5)
{
   translate(base) cylinder(h=h,r=r);
}

// ================

module spooldemo(dist=spoolw,d=spoold,id=56)
{
   cyl_x([-dist/2,0,0],h=spoolww,r=d/2);
   cyl_x([dist/2-spoolww,0,0],h=spoolww,r=d/2);
}

module bearing_demo(efr=0)
{
   difference() 
   {
      cyl_x([0,0,wh],h=bew,r=bwd/2+efr);
      cyl_x([0-1,0,wh],h=bew+2,r=bwi/2);
   }
}

module sidebar(dist=spooldd)
{
   union()
   {
      box([0,sswd,0],[bhw+dist,ssd,ssh]); // full
      box([bhw+sscm,sswd,0],[dist-bhw-sscm*2,ssd,ssh2]); // between 
      box([bhw/2-sscw/2+sscm,sswd+ssd/2-sscd/2+sscm,0.1],[sscw-sscm*2,sscd-sscm*2,ssch+ssh-0.1]); // box left
      box([dist+bhw/2-sscw/2+sscm,sswd+ssd/2-sscd/2+sscm,0.1],[sscw-sscm*2,sscd-sscm*2,ssch+ssh-0.1]); // box right
   }
}

sidebar();
