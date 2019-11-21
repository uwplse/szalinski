// ================

// bearings 8x22x7
// spools are 88 x (80+56+80 = d216 r108)

// SET THIS which spool are you using?
// spool width: 88mm = 1kg spool, 54mm = 700g spool, 65mm = 1kg Inland spools
spoolw=88; // 
// spoolw=54; 

// holder wheel width
bwc=10;

// wheel plate to filament loop clip material margin
flcm=0.15; 

// ================

// width of spool side wheel (for demo only)
spoolww=4;

spooldd=spoolw-spoolww; // center of side wheel to center of side wheel

// holder wheel margin to sides
bwcm=1;

// holder side thickness
bht=1.6;

// bottom plate thickness
bhp=1;

bhw=bwc+bwcm*2+bht*2; // total width


// filament clip holder height
fchh=20;

// filament loop plate thickness
flpt=2;

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


module holderfront()
{
   clt=1.2; // clip spring thickness
   cltq=2.0; // clip spring reinforcement
   box([0,0,0],[bhw,flpt-flcm,fchh+1]);
   box([bht+2.5,flpt-0.5,bhp+flcm],[bhw-bht*2-5,3,3]);
   module filamentloopclip()
   {
      box([flcm,flpt-0.5,bhp+1],[clt,7+0.5,fchh+1-bhp-1]);
      box([flcm-bht+1,2+flpt+flcm,bhp+1 +flcm], [1.0,5-flcm*2,5-flcm*2]); // filament clip holder
      box([flcm-bht+1,2+flpt+flcm,fchh-7+flcm], [1.0,5-flcm*2,5-flcm*2]); // filament clip holder

      difference()
      {
         box([flcm+clt,flpt-0.5,bhp+1],[cltq,cltq+0.5,fchh+1-bhp-1]);
         cyl_z([flcm+clt+cltq+0.1,flpt+cltq,bhp],h=fchh+1-bhp+1,r=cltq,$fn=18);
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

         intersection()
         {
            rotate_extrude($fn=90)
               translate([h/2,0,0]) loopprofile(d=pd,w=pw); // half circle
            box([-h,0,0],[h*2,h,pd]);
         }

         translate([0,-sb,0])
            rotate([0,0,180])
            intersection()
            {
            box([-h,0,0],[h*2,h,pd]);
            rotate_extrude($fn=90)
            translate([h/2,0,0]) loopprofile(d=pd,w=pw); // half circle
            }

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
   {
      box([bhw+0.2,0,0],[dist-bhw-0.4,4,4]);
      box([bhw+0.0,0,0],[dist-bhw-0.0,flpt-flcm,4]);
   }
   else
      box([bhw+0.2,0,0],[fld+flw/2+8,4,4]);

   // plate to hold the loop
   flpw=40;
   box([bhw+fld+flw/2-8,0.5],[16,flpt,13]);
   box([bhw+fld+flw/2-flpw/2,0],[flpw,0.6,11]);
   //box([bhw-1,0,0],[fld+flw/2+5,flpt+20,2]);
}


//testprint();
//testwheel();

rotate([90,0,0])
      filamentloop();
