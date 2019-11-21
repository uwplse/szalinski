
/*
FingerGrip for HexHeadScrew (c) by Lukas Süss (2013)

FingerGrip for HexHeadScrew is licensed under a
Creative Commons Attribution 3.0 Unported License.

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/3.0/>.
*/



// outer diameter of screw thread (default: Fotoscrew 1/4''+ 0.2mm clearing)
dscrew = 6.55;
// wrench width (default: Fotoscrew 7/16''+ 0.2mm clearing)
sscrewhead = 11.3125;
// hight of head (default: Fotoscrew 4mm) only used for thinn designs
hscrewhead = 4;

// hight of grip without protrusion
hgrip = 7.5;
// outermost diameter of grip
dgrip = 30;
// how much sould the edge be broken
bevel = 1.25;
// hight of protrusion
hprotrus = 3;
// how far to shift the fingerdents outward (in %)
shift = 82; //  [80.0:100.0]


eps=0.05*1;
$fa=5*1;
$fs=0.2*1;

screwhead(hgrip,dgrip,bevel);


module screwhead(hknob,dknob,t) // f=0.85
{
  translate([0,0,hscrewhead]) scale([1,1,-1])
  difference()
  {
    rotate(45*1,[0,0,1]) //screw retainment? glue?  <<<< ??
    union()
    { 
      translate([0,0,0]) screwheadbasebody(t,dknob,t,0);
      translate([0,0,t]) screwheadbasebody(hknob-2*t,dknob,0,0);
      translate([0,0,hknob-t]) screwheadbasebody(t,dknob,0,t);
      scale([1,1,-1]) cylinder(r=14/2,h=hprotrus);
    } 
    headcutter(hknob);
  }
}
module screwheadbasebody(hknob,dknob,t1,t2)
{
  difference()
  {
    union()
    {
      cylinder(h=hknob,r1=dknob/2-t1,r2=dknob/2-t2);
    }
    for(i=[0:3])
    {
      rotate(90*i+15*0,[0,0,1]) translate([dknob*shift/100,0,-eps])
        cylinder(h=hknob+2*eps,r1=dknob/2+t1,r2=dknob/2+t2);
    }
  }
}
module headcutter(hknob)
{
   translate([0,0,-hprotrus-0.3]) cylinder(h=hknob-hscrewhead+hprotrus,r=dscrew/2);
   translate([0,0,min(2*hscrewhead,hknob-hscrewhead)])
     cylinder(h=hknob*1.2,r=sscrewhead/2/cos(30),$fn=6);
}
