// total height (to top of marker)
h=202;
// [202,293]

// cup height
hw=12;

// width of marker (and bell)
w=30;

// thickness of material
t=0.8;

// mininum thickness of meter
tm=0.15;

// cutout circles diameter
cd=24;

// cutout circle minimum distance
cdd=2;

// top marker area height
tl=38.5;

// slot for meter
slh=5;

// material margin
margin=0.2;

// distance between markers, 10.8mm = 0.5l for 25cm bucket, 7.5mm = 0.5l for 30cm bucket
mark_distance=10.0;
// [10.8,7.5]

// how much the weight of the stick pushes it down
mark_top_error=1.5;

// rail width
rw=2;

// marker height
mh=2;

d=w;

offs=w/4;
       
module cup()
{
   difference()
   {
      cylinder(h=hw,r=w/2);
 
      translate([offs-margin,-t/2-margin,hw-slh]) cube([w,t+margin*2,20]);
      translate([-offs-w+margin,-t/2-margin,hw-slh]) cube([w,t+margin*2,20]);

      difference()
      {
         translate([0,0,-t])
            cylinder(h=hw,r=w/2-t);

         translate([offs-t-margin,-t/2-t-margin,hw-slh-t]) cube([w,t*3+margin*2,20]);
         translate([-offs-w+t+margin,-t/2-t-margin,hw-slh-t]) cube([w,t*3+margin*2,20]);
      }
   }
}
  
module meter()
{
//   translate([-w/2,-t/2,0])
   {
      difference()
      {
         translate([0,0,hw])
            cube([w,tm,h-hw-tl]);

         {
            hexr=10;
            sx=hexr+2.8;
            sy=hexr*2-4.5;
            rat=0.70;
                  
            nx=1+h/sx;
                  
            for (j=[0:1:1+h/sy])
               for (i=[-2:1:2])
                  translate([w/2+i*sx + ((j%2)?0.5:0)*sx,t*3,j*sy])
                     scale([rat,1,1])
                     rotate([0,90,0])
                     rotate([90,0,0])
                     cylinder(h=5*4,r=hexr,$fn=6);
         }
         
      }

      translate([0,0,hw-slh]) cube([w/2-offs,t,3+slh]);
      translate([w/2+offs,0,hw-slh]) cube([w/2-offs,t,3+slh]);
      translate([0,0,hw]) cube([w,t,3]);

      // rails
      translate([0,0,hw]) cube([rw,t,h-hw]);
      translate([w-rw,0,hw]) cube([rw,t,h-hw]);

      // markers
      translate([0,0,h-tl]) cube([w,t,mh]);
      translate([0,0,h-mh]) cube([w,t,mh]);

   md=(w-cd)/2;
      
   if (1)
      for (i=[mark_distance-mark_top_error:mark_distance:tl])
         translate([0,0,h-i])
            cube([w,t,mh]);
   }
}

if (0) // combine
{
   cup($fn=180);

   translate([-w/2,-t/2,0])
      meter();
}
else if (1) // split
   rotate([0,0,90])
{
   if (h+w>240)
   translate([-w*1.1,-w,hw])
   rotate([180,0,0])
   cup($fn=180);
   else
   translate([0,w/4,hw])
   rotate([180,0,0])
   cup($fn=180);
   
   rotate([90,0,0])
   translate([-w/2,0,0])
      meter();
}
