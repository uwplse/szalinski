
// 2013-01 Lukas Süss (C)

/*
Snap In Connector doublesided (c) by Lukas Süss

"Snap In Connector doublesided" is licensed under a
Creative Commons Attribution 3.0 Unported License.

See <http://creativecommons.org/licenses/by-nc-sa/3.0/>.
*/

//################################

/*
Description:
A reversible quick connector tho hold bags baloons or other stuff.
They hooks snap in very pleasently  and can take quite a bit of force.
You may use it in conjunction with:
http://www.thingiverse.com/thing:45219

Instructions:
Keep the U hooks long and thinn enough to flex.
Print two U-Hooks one Snap in Unit and two Lock-Blocks.
The lock blocks should stay in by friction. If they don't use adhesive tape to hold them in.  
*/

// Choose Part (you'll need: U-Hook, Snap-In-Unit, Lock-Block)
_0_part = "U-Hook"; // [U-Hook,Snap-In-Unit,Lock-Blocks,Assembled]

// Diameter of the U shaped hooks
_1_diameter_of_wire = 5; // 5

// Gap between U hook pegs
_2_maximal_diameter_of_counter_hook = 6; 
// Length of the U hooks (they have to bee long enough to flex)

//Length of the straight part of the hooks (not the opening length)
_3_length = 20; // 25

// overall scaling factor
_4_scale = 1;
f = _4_scale;


$fa = 5*1;
$fs = 0.5*1;
//clr=0.15*1;

_5_wall_thickness= 1.75;
t = _5_wall_thickness;

a = 0*1;
lgroove = 3*1;
lcoupler = 3*lgroove+_1_diameter_of_wire+3*lgroove+2*a;


//_0_part = "U-Hook";
//_0_part = "Snap-In-Unit";
//_0_part = "Lock-Blocks";
//_0_part = "Assembled";

if(_0_part == "U-Hook") scale([f,f,f]) hook();
if(_0_part == "Snap-In-Unit") rotate(90,[0,1,0]) scale([f,f,f]) coupler();
if(_0_part == "Lock-Blocks") scale([f,f,f]) fixblocks();
if(_0_part == "Assembled") scale([f,f,f]) assembled();


module assembled()
{
  c2 = 0.9; // 0.5
  c1 = 0.8; // 0.3
  color([c1,c1,c1]) coupler();
  color([c2,c2,c2])
  {
    translate([-_3_length-_1_diameter_of_wire/2-0,0,0])
      hook();
    scale([-1,1,1]) translate([-_3_length-_1_diameter_of_wire/2-0,0,0])
      hook();
  }
  color([c2,c2,c2]) fixblocks();
}



module coupler(d=_1_diameter_of_wire,
               clr=0.15,
               di=_2_maximal_diameter_of_counter_hook,
               l=_3_length,
               f=0.85)
{

  intersection()
  {
  difference()
  {
    hull()
    {
      translate([0,di/2+d/2,0]) rotate(90,[0,1,0])
        cylinder(r=d/2+t,h=lcoupler,center=true);
      translate([0,-(di/2+d/2),0]) rotate(90,[0,1,0])
        cylinder(r=d/2+t,h=lcoupler,center=true);
    }
    cube([lcoupler*1.2,di+d,d*f],center=true);

    translate([-l-d/2-a,0,0])  hook(5+clr,clr);
    scale([-1,1,1])
    translate([-l-d/2-a,0,0])  hook(5+clr,clr);
    
    /*
    rotate(45,[0,0,1])
    cylinder(r=di/2*sqrt(2),h=d+2*t,center=true,$fn=4);
    translate([-lcoupler/2,0,0])
      cylinder(r=di/2,h=d+2*t,center=true);
    translate([lcoupler/2,0,0])
      cylinder(r=di/2,h=d+2*t,center=true);
    */

    fixblocks();
  }
  //cube([lcoupler*1.2,di+2*d+2*t,(d+2*t)*f],center=true);
  bbox2(lcoupler,di+2*d+2*t,(d+2*t)*f,1*t); // t?
  }
}


module fixblocks(d=_1_diameter_of_wire,
               clr=0.15,
               di=_2_maximal_diameter_of_counter_hook,
               l=_3_length,
               f=0.85)
{
    eps=0.05;
    translate([(lcoupler/2-3*t)/2+t,0,0])
      bbox2(lcoupler/2-3*t,di,(d+2*t)*f+eps,t);
    translate([-( (lcoupler/2-3*t)/2+t),0,0])
      bbox2(lcoupler/2-3*t,di,(d+2*t)*f+eps,t);
}



module hook(d=_1_diameter_of_wire,
            clr=0,
            di=_2_maximal_diameter_of_counter_hook,
            l=_3_length,
            f=0.85) // wire diameter
{
  //d .. wire diameter
  tgroove = 1.5;
  //lgroove = 3;
  //l ... length of straight section
  //di ... counter diameter
  s = di/2+d; // helper value
  //f=0.85;


  intersection()
  {
  union()
  {
    difference()
    {
      torus(di/2+d/2,d/2);
      translate([s/2,0,0]) cube([s,2*s,d],center=true);
    }
    difference()
    {
      rotate(90,[0,1,0])
      {
        translate([0,di/2+d/2,0]) sphcyl(d,l);
        translate([0,-(di/2+d/2),0]) sphcyl(d,l);
      }
      translate([l-3-clr,+(1.5*tgroove+di/2+d-tgroove)+clr,0])
        groovecutter(lgroove,tgroove,d);
      translate([l-3-clr,-(1.5*tgroove+di/2+d-tgroove)+clr,0])
        groovecutter(lgroove,tgroove,d);
    }
  }
  translate([-(d/2+l+di/2+d)/2+l+d/2,0,0])
  cube([d/2+l+di/2+d, di+2*d,d*f],center=true);
  }
}


module sphcyl(d,l)
{
  eps = 0.05;
  cylinder(r=d/2,h=l);
  //translate([0,0,l]) sphere(d/2);
  translate([0,0,l-eps])  // cones are nicer
    cylinder(r1=d/2,r2=d/2*0.5,h=d/2*0.61803);   
}

module groovecutter(lgroove,tgroove,d)
{
    hull()
    {
       translate([-lgroove/2,0,0]) 
         cube([lgroove, 3*tgroove,1.2*d],center=true);
       translate([-lgroove/2-tgroove/2,0,0]) 
         cube([lgroove+tgroove, tgroove,1.2*d],center=true);
    }
}
// ###########################

module bbox2(x,y,z,b)
{
  hull()
  {
    cube([x-b,y,z],center=true);
    cube([x,y-b,z],center=true);
  }
}

module torus(rbig,rsmall)
{
  rotate_extrude(convexity=6)
  translate([rbig,0,0])
  circle(r=rsmall);
}