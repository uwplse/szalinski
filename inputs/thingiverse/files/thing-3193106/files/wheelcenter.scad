// motif source (SVG)
motif_file="T.svg";

// svg scale
motif_scale=0.46;

// motif height
motif_h=1.0;

// motif y motifier
motif_y=0.0;

// motif x motifier
motif_x=0.0;

// motif type
motif_type="extrude"; // ["none","extrude","part","negative","heightmap","heightmap_inverted","placeholder with hole"]

// print direction ("up" should print without supports, solid base, "down" flips it upside down)
print_direction="neutral"; // ["neutral","up","down"]

// trim the motif to fit the dimension
motif_trim="yes"; // ["yes","no"]

// clip ring diameter, 52mm = skoda/vw alloy originals
ird=52.0;

// clip ring height, 8mm = skoda original
irh=8.0;

// clip ring depth (radius)
irdd=2.0; 

// distance to clip from center ring, 3.5mm = skoda original
cld=3.5;

// clip height, 3.5mm = skoda original
clh=3.5;

// clip depth (added), 0.8mm = skoda original
clcd=1.0;

// clips total
clips=5;

// clips angle
clipa=20;

// clips angle distance to solid part 
cliprda=5;

// center ring height, 5mm = skoda original
crh=5.0;

// center ring diameter, 56mm = skoda original
crd=56.0;

// outer lid (motif) diameter, 56mm = skoda original
ord=56.0;

// outer lid height , 0.4mm = skoda original
orh=0.4;

// center thickness
mt=2.0;

// precision
fn=180;

// ================================================================

// z=0 lid/center ring border

// inner diameter
crid=min(ird-irdd*2,crd-0.8);

// inner corner radius
irr=crh-mt;

module center_ring()
{
   rotate_extrude()
   {
      if (print_direction=="up")
      {
         c=(crd-crid)/2;
         i=ird/2-crid/2;
         translate([crid/2,0,0])
            polygon([ [0,0],
                      [c,0],
                      [c,crh-(c-i)*0.8],
                      [i,crh],
                      [0,crh] ]);

         square([crid/2-2,crh+irh]);
      }
      else
         translate([crid/2,0,0])
            square([(crd-crid)/2,crh]);

      square([crd/2-0.01,mt]);

      difference()
      {
         translate([crid/2-irr,mt])
            square([irr,irr]);
         translate([crid/2-irr,mt+irr])
            circle(r=irr);
      }
   }
}

module clip_ring()
{
   tang=360/clips; // total angle per section
   
   for (a=[0:tang:360-0.01])
      rotate([0,0,a])
   {
      rotate_extrude(angle=clipa)
      {
         translate([ird/2-irdd,0])
            square([irdd,irh]);
         translate([ird/2,cld])
         {
            // \    clh
            //  \
            //   \  b
            //   |
            //   +  a
            // +/   0
            // 0 clcd

            a=clcd*0.7;
            b=a+clh/4;

            polygon([[0,0],
                     [clcd,a],
                     [clcd,b],
                     [0,clh]]);
            
            //square([clcd+irdd,clh]);
         }
      }
      rotate([0,0,clipa+cliprda])
         rotate_extrude(angle=tang-clipa-cliprda*2)
      {
         translate([ird/2-irdd,0])
            square([irdd,irh]);
      }
   }
}

module motif1(h=motif_h)
{
   translate([motif_x,motif_y,h/2])
   linear_extrude(center=true, height=h)
      scale(motif_scale)
      import(file=motif_file);
}

module motif(h=motif_h)
{
   if (motif_trim=="yes")
      intersection()
      {
         rotate_extrude() square([ord/2+0.001,h]);
         motif1(h);
      }
   else
      motif1(h);
}

module motif_heightmap(h=motif_h)
{
   intersection()
   {
      if (motif_trim=="yes") rotate_extrude() square([ord/2+0.001,h]);

      translate([motif_x,motif_y,(motif_type=="heightmap_inverted")?h:0])
         scale([motif_scale,motif_scale,h/100])
         surface(file = motif_file,
                 center = true,
                 invert = (motif_type=="heightmap_inverted"),
                 convexity = 5);
   }
}

module top()
{
   // top logo with base
   if (motif_type=="none")
   {
      rotate_extrude() square([ord/2,orh]);
   }
   else if (motif_type=="extrude")
   {
      rotate_extrude() square([ord/2,orh]);
      translate([0,0,orh]) motif();
   }
   else if (motif_type=="heightmap" ||
            motif_type=="heightmap_inverted")
   {
      rotate_extrude() square([ord/2,orh]);
      translate([0,0,orh]) motif_heightmap();
   }
   else if (motif_type=="negative")
   {
      difference()
      {
         rotate_extrude() square([ord/2,orh+motif_h]);
         translate([0,0,orh]) motif(h=motif_h+1);
      }
   }
   else if (motif_type=="part")
      translate([0,0,orh]) motif();
}

module wheelcenter()
{
   if (motif_type!="part")
      rotate([0,180,0])
      {
         center_ring();
         translate([0,0,crh]) clip_ring();
      }
   
   top();
}


if (motif_type=="placeholder with hole") difference()
{
rotate([0,180,0])
wheelcenter($fn=fn);
cube([4,12,40],center=true);
}
else
{
  rotate([0,(print_direction=="down")?180:0,0])
  wheelcenter($fn=fn);
}

//motif_heightmap();

