// type
type="print"; // ["print","270 degrees","profile"]

// outer diameter
od=21;

// inner diameter (hole)
id=8;

// width
w=7;

// outer height/depth of roller
b1w=2.0;

// outer size of roller
b1=4.6;

// inner size of roller
b2=2.5;

// inner height/depth of roller
b2w=1.0;

// inner roller margin
m2=0.3;

// outer roller margin
m1=0.4;

// minimum distance between rollers (approximate)
bd=0.3;

// precision
fn=180;

// ---

// outer radius
or=od/2;

// inner radius
ir=id/2;

// ball center radius
bcr=(od+id)/4;

// number of rollers
drol=max(b1,b2)+bd;
nrol=floor((3.14159*bcr*2)/drol);

// angle for rollers
arol=360/nrol;

// ball center outer radii
bco1=bcr+b1/2+m1;
bco2=bcr+b2/2+m2;

// ball center inner radii
bci1=bcr-b1/2-m1;
bci2=bcr-b2/2-m2;

module parameters_stop_here() {}

// polygon height levels
h1=0;
h2=b1w;
h3=(w-b2w)/2;
h4=(w+b2w)/2;
h5=w-b1w;
h6=w;

hx1=(b1>b2?-1:1)*m2/8;
hx2=(b1>b2?-1:1)*m1/8;

module outer_profile()
{
   polygon( [[bco1,h1],
            [bco1,h2-hx1],
            [bco2,h3-hx2],
            [bco2,h4+hx2],
            [bco1,h5+hx1],
            [bco1,h6],
            [or,w],
            [or,0]] );
}

module inner_profile()
{
   polygon( [[bci1,h1],
            [bci1,h2-hx1],
            [bci2,h3-hx2],
            [bci2,h4+hx2],
            [bci1,h5+hx1],
            [bci1,h6],
            [ir,w],
            [ir,0]] );
}

module roller_profile()
{
   polygon( [[0,0],
            [b1/2,h1],
            [b1/2,h2],
            [b2/2,h3],
            [b2/2,h4],
            [b1/2,h5],
            [b1/2,h6],
            [0,h6]] );
}

module roller()
{
   rotate_extrude() roller_profile();
}

if (type=="profile")
{
   linear_extrude(height=5) outer_profile();
   linear_extrude(height=5) inner_profile();
   
   translate([bcr,0,0]) linear_extrude(height=5) roller_profile();
   translate([bcr,0,0]) mirror([1,0,0]) linear_extrude(height=5) roller_profile();
}
else
{
   rotate_extrude(angle=(type=="270 degrees")?270:360,$fn=fn)
   {
      outer_profile();
      inner_profile();
   }
   for (a=[0:arol:360-0.001])
      rotate([0,0,a])
         translate([bcr,0,0])
         roller($fn=fn);
}

