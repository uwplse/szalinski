// depth behind clip: 6
// clip deep 8
// depth in front of clip: 9
// from clip to edge 19
// edge width 9

part="both"; // ["upper","lower","both"]

// clip size
clw=8.8;

// clip depth
cld=9;

// from clip to front (total)
cltf=19.8;

// clip angle
a=20;

// outer angle
a2=10;

// thickness
clt=2;

// height
clh=2;

// front diameter
dd=9;

// temperature sensor size, width
tsw=45.6;

// temperature sensor size, depth
tsd=20.6;

// temperature sensor "upper" clip to bottom distance
tsch=61;

// basket/ring thickness
bt=1.6; // basket thickness



cltfd=cltf-dd/2;

module clip_profile(top)
{
   rotate(a2)
      translate([0,dd/2])
      square([10,clt]);
   
   rotate(-a)
   {
      mirror([0,1])
         translate([0,dd/2])
         difference()
      {
         intersection()
         {
            square([100,100]);
            union()
            {
               square([cltfd+clw+clt,clt]);
               translate([cltfd-clt*0,0])
                  rotate(-a)
                  translate([-clt,0])
                  square([clw+clt*2,cld+clt]);
            }
         }
         if (!top)
            translate([cltfd,0])
               rotate(-a)
               translate([0,-1])
               square([clw,cld+1]);
      }
   }
}


module door_clip(clh,top=true)
   rotate([0,0,180])
   translate([-cltfd,dd/2,0])
   rotate([0,0,a])
{
   linear_extrude(height=clh)
      clip_profile(0);

   if (top)
   translate([0,0,clh])
   linear_extrude(height=clt)
      clip_profile(1);
   
   rotate([0,0,90+a2])
      rotate_extrude(angle=180-a-a2,$fn=36)
   {
      translate([dd/2,0])
         square([clt,clh+(top?clt:0)]);
   }

}

module basket(nobottom,bh=5)
{
   translate([0,0,nobottom?0:bt])
   difference()
   {
      translate([0,0,nobottom?0:-bt])
         cube([tsw+bt*2,tsd+bt*2,nobottom?bh:bh+bt]);
      translate([bt,bt,nobottom?-0.5:0])
         cube([tsw,tsd,bh+1]);
      translate([bt,bt,-bt-1])
         cube([2,tsd,bh+2]);
      translate([bt+tsw-2,bt,-bt-1])
         cube([2,tsd,bh+2]);
   }
}

module lower_clip()
{
   bclh=30;
   door_clip(clh=bclh,top=1);
   translate([0,-bt+clt,0])
   basket(0,bh=12);
}

module upper_clip()
   translate([0,0,-6])
{
   bclh=20;
   translate([0,0,-(bclh-4)])
   door_clip(clh=bclh,top=1);
   translate([0,-bt+clt,0])
   basket(1,bh=6);
}

if (part!="upper") lower_clip();
if (part!="lower")
   translate([0,tsd*2+10,0]) rotate([0,180,180]) upper_clip();
