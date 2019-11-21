// ================

// part selection
part="demo"; // ["demo","wheel holder","wheel clip","wheel","holder to holder clip","filament loop/front", "all parts", "parts (abs)", "wheels (pet)", "clips (pla)", "pfte clip"]

// bearings 8x22x7
// spools are 88 x (80+56+80 = d216 r108)

// SET THIS which spool are you using?
// spool width: 88mm = 1kg spool, 54mm = 700g spool, 65mm = 1kg Inland spools
spoolw=88; // 
// spoolw=54; 

// distance between bearings/wheels
bhd=150;

// bearing width
bew=7;

// bearing diameter
bwd=22;

// bearing inner diameter (hole)
bwi=8;

// bearing inner diameter (nonmoving, for clip part)
bwi2=11; 

// holder wheel width
bwc=10;

// TWEAK THIS depending on material and printer:

// wheel plate to side bar clip material margin 
sscm=0.05;

// wheel plate to wheel clip material margin 
wcm=0.20;

// wheel clip to bearing side material margin
wcbm=0.15;

// wheel clip to bearing diameter material margin
wcim=-0.05;

// wheel to bearing material margin, 0.15 for ABS, 0.05 for PET
wbm=0.05;

// wheel plate to filament loop clip material margin
flcm=0.15; 

// ================

// width of spool side wheel (for demo only)
spoolww=4;

// spool diameter (for demo only)
spoold=216; 

// spool height offset (for demo only)
spoolhoff=7;

spooldd=spoolw-spoolww; // center of side wheel to center of side wheel

// holder wheel margin to sides
bwcm=1;

// holder side thickness
bht=1.6;

// bottom plate thickness
bhp=1;

bhw=bwc+bwcm*2+bht*2; // total width

// extra length (x2)
bbb=15;


// minimum side height
bsh=5;


// wheel center height
wh=20;

// wheel holder diameter
whd=8;

// wheel holder margin
whdm=0.2;

// wheel holder high part
whh=16;

// wheel holder diagonal part
whl=25;

// extra upper part above wheel center
whu=5;

wht=whu+wh; // top part of wheel holder 

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

// extra material for filament clip holder
fche=10;

// filament clip holder height
fchh=20;

// filament loop plate thickness
flpt=2;

// minimum thread
ti=1.6;

// maximum thread
to=3.5; 

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

module wheelclip(type=1)
{
   d=0.5; // distance between clips
   cld=1; // back clip depth
   clw=1; // back clip extra width
   m=wcbm;
   w1=(bhw-bew-bht*2)/2-m;
   w2=(bhw/2-d/2-(bht+m)-w1);

   difference()
   {
      union()
      {
         if (type==1)
         {
            cyl_x([bht+w1,0,0],h=w2,r=bwi/2-wcim,$fn=180);
         }
         else if (type==2)
         {
            dh=bwi/2-0.5;
            dw=0.8;
            cyl_x([bht+w1-2,0,0],h=w2+2,r=dh);
            intersection()
            {
               union()
               {
                  cyl_x([bht+w1+0.4,0,0],h=w2-0.4,r=bwi/2-wcim);
                  cyl_x([bht+w1,0,0],h=0.4,r=bwi/2);
               }
               rotate([0,90,0])
                  for (a=[0:360/8:180-1])
                     rotate([0,0,a])
                        cube([dw,20,20],center=true);
            }
         }
         else if (type==3)
         {
            rotate([0,90,0])
               for (a=[0:360/3:360-1])
                  rotate([0,0,a])
                     difference()
                     {
                        r=bwi/3-wcim;
                        cyl_z([bwi/6,0,w1+w2/2+0.4],h=w2-0.4,r=r);
                        cyl_z([bwi/6,0,w1+w2/2-1],h=w2+2,r=r-0.8);
                     }
            cyl_x([bht+w1,0,0],h=w2,r=2.4);
         }
//#                  cyl_x([bht+w1+0.4,0,0],h=w2-0.4,r=bwi/2-wcim);
         cyl_x([bht+wcbm,0,0],h=w1,r=bwi2/2);
         // note: radially symmetric!
         box([-cld/2,-whd/2+wcm,-whd/2+wcm], [cld/2+bht+wcbm,whd-wcm*2,whd-wcm*2]); // wht-wh+whd/2-wcm
         box([-cld,-whd/2-clw,-whd/2-clw], [cld-wcbm,whd+clw*2,wht-wh+whd/2+clw]);
      }
      cyl_x([-10,0,0],h=whd+20,r=1.6);
   }
}

module wheel() // outside bearing
{
   tiw=0.5; // position for maximum
   tw=2.0; // position for minimum
   m=wbm; // margin
   difference()
   {
      union()
      {
         rotate([0,90,0])
         rotate_extrude()
   translate([bwd/2,bwc/2])
            rotate(-90)
            polygon([[0,-1],
                    [0,to],
                    [tiw,to],
                    [tw,ti],
                    
                    [bwc-tw,ti],
                    [bwc-tiw,to],
                    [bwc-0,to],
                    [bwc-0,-1]]);
         cyl_x([-bwc/2,0,0],h=bwc,r=ti+bwd/2);
      }
//      cyl_x([-bew/2-20,0,0],h=bew+40,r=bwd/2,$fn=180); // bearing
      cyl_x([-bew/2,0,0],h=bew,r=bwd/2+m,$fn=180); // bearing
      cyl_x([-bwc/2-1,0,0],h=bew+20,r=bwc-2); // no material, left side
      cyl_x([-bew/2,0,0],h=bew+20,r=bwd/2+m,$fn=180); // no material, right side
   }
}

module wheelplate(bearing=false)
{
   difference()
   {
      union()
      {
         box([0,-bbb-fche,0],[bhw,bhd+bbb*2+fche,bhp]);

         box([bht-1,-bbb+2-fche+6,0.01],[bhw-bht*2+2,2,10]); // front wall
         box([bht-1,bbb+bhd-bht,0.01],[bhw-bht*2+2,bht,bsh]); // back wall
         
         for (x=[0,bhw-bht])
            translate([x,0,0])
            {
               box([0,-bbb-fche,0],[bht,bhd+bbb*2+fche,bsh]); // side minimum

               for (y=[0,bhd])
                  translate([0,y,0])
                     difference()
                  {
                     union()
                     {
                        rotate([90,0,90])
                           linear_extrude(height=bht)
                           polygon([[(y==0)?-bbb-fche:(-whh/2-whl),bsh],
                                    (y==0)?[-bbb-fche,fchh]:[0-whh/2,wht],
                                    [0-whh/2,wht],
                                    [0+whh/2,wht],
                                    [(y==0)?whh/2+whl:(bhd+bbb-y),bsh]]);

                        // reinforcement
                        {
                           emw=1;
                           emd=3;
                           emdd=1.5;
                           box([x?0:-emw,whd/2+emdd,0],[emw+bht,whh/2-whd/2-emdd,wht]);
                           box([x?0:-emw,-whh/2,0],[emw+bht,whh/2-whd/2-emdd,wht]);
                           box([x?0:-emw,-whh/2,0],[emw+bht,whh,wh-whd/2-emdd]);
                           // [10+emw+bht,whd+emdd*2,-whd/2+wcm]);
                        }

                        if (x==0)
                        {
                           // side clip surround material
                           union()
                           {
                              sscbd=2;
                              sscbh=5;
                              sy=(y==0)?0:(-sswd*2-ssd);
                              box([0,sswd-sscbd+sy,0.1],[bhw,ssd+sscbd*2,sscbh]);
                           }
               
                          if (bearing) // bearing demo
                             translate([bhw/2-bew/2,0,0])
#                             bearing_demo();
                        }
                     }

                     // cyl_x([-1,0,wh],h=2+bhw,r=whd/2); // clip cutout
                     box([-1,-whd/2,wh-whd/2],[2+bhw,whd,wht-(wh-whd/2)+1]); // clip cutout

                  }
            }
      }

      for (y=[0,bhd-sswd*2-ssd])
         translate([0,y,0])
            // side to side clip material
            union()
         {
            box([-1,sswd-ssdm,-1],[bhw+2,ssd+ssdm*2,ssh+sshm+1]);
            box([bhw/2-sscw/2,sswd+ssd/2-sscd/2,-0.1],[sscw,sscd,ssch+ssh+10]);
         }

      box([bht-1,-bbb+2-fche,bhp+1],[bhw-bht*2+2,5,5]); // filament clip holder
      box([bht-1,-bbb+2-fche,fchh-7],[bhw-bht*2+2,5,5]); // filament clip holder
   }         
}

module holderfront()
{
   clt=0.8; // clip spring thickness
   cltq=1.0; // clip spring reinforcement
   box([0,0,0],[bhw,flpt-flcm,fchh+1]);
   box([bht+2,flpt-0.5,bhp+flcm],[bhw-bht*2-4,3,3]);
   module filamentloopclip()
   {
      box([flcm,flpt-0.5,bhp+1],[clt,7+0.5,fchh+1-bhp-1]);
      box([flcm-bht+1,2+flpt+flcm,bhp+1 +flcm], [1.0,5-flcm*2,5-flcm*2]); // filament clip holder
      box([flcm-bht+1,2+flpt+flcm,fchh-7+flcm], [1.0,5-flcm*2,5-flcm*2]); // filament clip holder

      difference()
      {
         box([flcm+clt,flpt-0.5,bhp+1],[cltq,cltq+0.5,fchh+1-bhp-1]);
         cyl_z([flcm+clt+cltq+0.1,flpt+cltq,bhp],h=fchh+1-bhp+1,r=cltq,$fn=12);
      }
   }
   translate([bht,0,0]) filamentloopclip();
   translate([bhw-bht,0,0]) mirror([1,0,0]) filamentloopclip();
}

module filamentloop(loop=true,dualside=true,dist=spooldd)
{
   holderfront();
   if (dualside) translate([dist,0,0]) holderfront();

   module loopprofile(d=4,w=6,simple=false)
   {
      if (simple)
         polygon([[0,0],
                  [w,0],
                  [w,d],
                  [0,d]]);
      else
         union()
         {
            translate([d/2,d/2]) circle(r=d/2,$fn=24);
            translate([w-d/2,d/2]) circle(r=d/2,$fn=24);
            translate([d/2,0]) square([w-d,d]);
         }
   }
   
   module filamentlooploop(h=20,w=50,pd=4,pw=6)
   {
      rotate([90,-90,0])
         translate([h/2+pw,-h/2,-pd])
      {
         sb=w-h; // straight bit
      
         rotate_extrude(angle=180,$fn=90)
            translate([h/2,0,0]) loopprofile(d=pd,w=pw); // half circle
         translate([0,-sb,0])
            rotate([0,0,180])
            rotate_extrude(angle=180,$fn=90)
            translate([h/2,0,0]) loopprofile(d=pd,w=pw); // half circle

         rotate([90,0,0])
            linear_extrude(height=sb) // straight bit
         {
            translate([h/2,0,0]) loopprofile(d=pd,w=pw);
            mirror([1,0,0]) translate([h/2,0,0]) loopprofile(d=pd,w=pw);
         }
      }
   }

   flh=12;
   flw = (spooldd-23<40)?spooldd-23:40;
   fld=(dist-bhw)/2-flw/2; // distance to filament loop
   pd=3;
   pw=4;
   translate([1*(bhw+fld),0,10])
      filamentlooploop(w=flw,h=flh,pd=pd,pw=pw);

   // clip to loop
   if (dualside)
      box([bhw,0,0],[dist-bhw,4,4]);
   else
      box([bhw,0,0],[fld+flw/2+8,4,4]);

   // plate to hold the loop
   flpw=40;
   box([bhw+fld+flw/2-8,0.5],[16,flpt,13]);
   box([bhw+fld+flw/2-flpw/2,0],[flpw,0.6,11]);
   //box([bhw-1,0,0],[fld+flw/2+5,flpt+20,2]);
}

// PFTE tube size (diameter)
pftesize=4.2;

// PFTE tube friction point size
pftef=0.2;

// PFTE tube holder length
pftehh=20;

// PFTE tube holder thickness
pfteht=2.0;

// PFTE tube holder clip thickness
pftehe=0.8;

// PFTE tube holder clip margin
pftehm=0.2;

// PFTE tube holder width
pftehw=10;

module pfte_clip()
   translate([0,pftehe,0.5])
   rotate([0,0,180])
{
   pd=3;
   pw=4;
   h=12+pd+0.4;
   e1=4;
   e2=12;
   
   difference()
   {
      union()
      {
         cyl_y([0,0,0],h=pftehh-pfteht,r=pftesize/2+pfteht,$fn=24);
         box([-pftehw/2,0,-h/2-e1],
             [pftehw,pftehe,h+e1+e2]);

         translate([0,pftehh-pfteht,0])
         intersection()
         {
            rotate([90,0,0])
               torus(r1=pftesize/2+pfteht,r2=pfteht,$fn=48);
            cyl_y([0,0,0],h=pftehh-pfteht,r=pftesize/2+pfteht,$fn=24);
         }

         intersection()
            {
         cyl_y([0,0,0],h=pftehh-pfteht,r=pftesize/2+pfteht,$fn=24);
               
         translate([0,pftehh/2,0])
            scale([(pftesize/2-pftef)/(pftesize/2),1,1])
         rotate([90,0,0])
            torus(r1=pftesize/2+pfteht,r2=pfteht,$fn=48);
         }

         for (z=[-h/2,h/2])
         {
            translate([0,pd/2+pftehe+0.1,z])
            rotate([0,(z<0)?0:180,0])
               translate([-pftehw/2,0,0])
               difference()
               {
                  union()
                     {
                        z2=h/2+0.01;
                        y0=-pd/2-pftehe-0.1;
                        y1=-pd*0.1;
                        y2=y1+2;

                        rotate([0,90,0])
                        linear_extrude(height=pftehw)
                           polygon([[0,y0],
                                    [0,y1],
                                    [-2,y2],
                                    [-z2,y2],
                                    [-z2,y0]]);
                  }
                  translate([-1,0,0])
                     cyl_x(r=pd/2+0.1,h=pftehw+2,$fn=36);
               }
         }
         
         
      }
      cyl_y([0,-1,0],h=pftehh+2,r=pftesize/2,$fn=72);
      cyl_y([0,-1,0],h=1+pfteht,r=pftesize/2+pfteht-0.2,$fn=72);

      
   }

   intersection()
   {
      rotate([90,0,0])
         torus(pos=[0,0,-pfteht],r1=pftesize/2+pfteht,r2=pfteht,$fn=48);
      cyl_y([0,0,0],h=pftehh-pfteht,r=pftesize/2+pfteht,$fn=24);
   }

}

module demo()
{
   wheelplate(bearing=true);
   translate([spooldd,0,0]) wheelplate(bearing=true);
   
   translate([0,0,wh])  wheelclip($fn=30,type=3);
   translate([bhw,0,wh]) mirror([1,0,0]) wheelclip($fn=30,type=3);
   
   translate([bhw/2,0,wh])  wheel($fn=180);

  # sidebar();

 # translate([spooldd/2+bhw/2,bhd/2,spoold/2+spoolhoff]) spooldemo($fn=180);

   translate([0,-bbb-fche-flpt,0]) filamentloop();   
   translate([spooldd/2+bhw/2,-bbb-fche-flpt+3,fchh]) pfte_clip();
}

module testprint()
{
//   wheelplate();
//   rotate([0,0,90]) sidebar();
//   translate([50,0,0]) rotate([0,0,90]) rotate([90,0,0]) filamentloop();
//   rotate([0,-90,0]) bearing_demo($fn=180);
   translate([10,0,0]) rotate([0,-90,0]) translate([bwc/2,0,0]) wheel($fn=120);
//   translate([10,30,0]) rotate([0,-90,0]) translate([1,0,0])  wheelclip($fn=30,type=3);
//   translate([-10,30,0]) rotate([0,-90,0]) translate([1,0,0])  wheelclip($fn=120);
}

module testwheel()
{
   rotate([0,-90,0]) bearing_demo($fn=180,efr=1);
   translate([-20,0,-(bwc-bew)/2]) rotate([0,-90,0]) translate([bwc/2,0,0]) wheel($fn=120);
}

if (part=="demo")
   demo();

if (part=="wheel holder") wheelplate();
if (part=="wheel clip") rotate([0,-90,0]) wheelclip($fn=120,type=3);
if (part=="wheel") rotate([0,-90,0]) translate([bwc/2,0,0]) wheel($fn=120);
if (part=="filament loop/front") translate([50,0,0]) rotate([0,0,90]) rotate([90,0,0]) filamentloop();

if (part=="holder to holder clip") rotate([0,0,90]) sidebar();
if (part=="pfte clip") translate([50,0,0]) rotate([0,0,90]) rotate([-90,0,0]) pfte_clip();

// pfte clip number
// translate([50-16,0,0])
// rotate([0,0,90])
// linear_extrude(height=0.3)
// text("1",size=8,halign="center",valign="center");


if (part=="all parts" || part=="parts (abs)")
{
   translate([-bhw*2-20,0,0]) wheelplate();
   translate([-bhw*1-10,0,0]) wheelplate();

   translate([-bhw*2-ssd-30,0,0]) rotate([0,0,90]) sidebar();
   translate([-bhw*2-20,0,0]) rotate([0,0,90]) sidebar();

   translate([-bhw*3-ssd*2-40,spoolw+bbb,0]) rotate([0,0,-90]) rotate([90,0,0])
      filamentloop();
}

if (part=="all parts" || part=="wheels (pet)")
{
   for (i=[0:1:3])
      translate([(bwd+ti)/2,i*(ti*2+bwd+10),0])
         rotate([0,90,0]) wheel($fn=120);
}

if (part=="all parts" || part=="clips (pla)")
{
   d=0.5; // distance between clips
   cld=1; // back clip depth
   clw=1; // back clip extra width
   m=wcbm;
   w1=(bhw-bew-bht*2)/2-m;
   w2=(bhw/2-d/2-(bht+m)-w1);
   
   for (j=[0:1:3])
      for (i=[0:1:1])
         translate([(bwd+ti)+15+i*(w1+10),j*(w2+10),0])
            rotate([0,-90,0]) wheelclip($fn=120,type=3);
}

//testprint();
//testwheel();

