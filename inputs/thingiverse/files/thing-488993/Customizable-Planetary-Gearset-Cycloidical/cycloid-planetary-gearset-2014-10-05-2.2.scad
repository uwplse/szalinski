/*
date: 2014-10
author: Lukas Süss aka mechadense
title: cycloidical bearing
license: CC-BY


## Instructions:

If you print splitted parts you need their mirrored versions too.

The grooves on the outside of the ring are for blocking rotation with pieces of filament. The cylinder where the bearing goes in needs to have matching grooves.

Use jitter if your slicer offers this option.
Printing parts seperately for post assembly makes stringing impossible and may allow for tighter tolerances. But keep the minimum time per layer high enough for the small planets to not deform.
Use nylon if you have such filament at hand.

The 45° bevel cutoffs help preventing fusion of planets with sun and ring when the part is printed assambled and the first layer is squished.
The bevel cutoffs also can aid assembly when the part is printed in seperate pieces.
They look nice too but also weaken the bearings strenght a bit and make it harder to judge the choosen clearance by eye.


## Description:


A bit about some hidden logic in planetary gears:

Not every combination of tooth numbers allows to distribute the planets equally around the circumference. If the combination allows equal (equiangular) distribution it can be that the planets are a multiple of the minimal mounting distance away from one another (they are not maximally closely packed) making the bearing weaker than it could be.

To allow more tooth number combinations and have the planets as closely/tightly packed as possible the planets can be organised in groups (which is done here). For this the greatest common divisor of the gear teeth numbers defines the number of planet groups (starting points for filling). The number of sun and planet teeth is then defined by multiplicators to that common divisor.

The cycloidical shape of the teeth allows (and requires for small prints) toothnumbers smaller than in involute gears. The compatible tooth number combinations thus become more sparse. Groupling planets by the gcd value and distributing then in patches around the circumference allows more options.


Cycloidical profile pros and cons:
  + smaller toothnumber possible - more compact design possible
  + stronger for same pitch - less fragile teeth than involute profile
  (-) pressure angle can't be adjusted
  (+) it has less parameters than "normal" gears
  (-) pressure angle is varying max-zero-max -> potential vibration -> more wear & friction
  (+) wider contact area (concave on convex) -> less wear & friction
  ? more efficient than involute profile ?
  (-) distance between axles is not continuously variable (irrelevent here)
  (-) harder for subtractive manufacturing 
  + smooth profile -> allows higher printing speeds



---------------------

minimal_angle_between_mounting_positions = 360° / (sunteeth + ringteeth)
angle_for_equidistant_planets = 360° / number_of_planets
ringteeth = sunteeth +2*planetteeth

How to modify the cycloid gear base formula for clearances:
dpitch = dbase * nteeth
dbase_ = dbase-clr/nteeth => dpitch_ = dpi//set 0.05 for flickering supression - may be 
rbase_ = rbase-(clr/2)/nteeth => rpitch_ = rpitch - clr/2

##################


TODO:

* crashes on bad height basesize cmbinations - why ??

* make coupling part sun to planets 
if secoupled -> mechanical least resistance sistribution nodes (multidifferentials)
if coupled -> planetary geartrains



maybe later:

* echo outer gear diameter if active ...
* measure angles from vertical instead of horizontal
* understand how and why the meshing correction turn angle for the sun gear works
* port to a library version?
* keep outer bevel size equal to inner ones or not ?
  stacking plate allowing for multidifferentials
  (== mechanical multipath distribution nodes) or gearboxes
* add angle offsets at shifted excenter position (prepared but opted to not include them)
* find out what exactly in the filtered out crash cases 1X1
* detect (& filter out) cases of unavoidable overlapping gears (check FRINGE CASES!!)

ISSUE:
creating a second part with 
the same radius for the planet centers but other parameters may be problematic

*/


echo("-------------------------------");

/* [resolution] */

//set 0.05 for flickering supression - may be bad for some slicers
eps = 0;
// clearing
clr = 0.3; // 0.2 too vew for direct print 0.4 too much
// angle per edge
$fa = 5;
// minimal length per edge
$fs = 0.2;

pi = 3.141592653*1;


info1 = "Note the tab bar above!";


// 146 testprinted :S
// some nice main parameter combinations: >this<
// 122 >>125<< 128
// 124
// 122 >125< 128 -- ((131)) >>133<< >135< 137 -- (144) >146< >>148<< -- 
// (152) (153) 158 -- 164 167 -- (172) 175 
// (212) >>213<< 214 222 (i223i) >224< (i225i) 226 
// (411) (412) 413 (422) (423) 424 (311) >312< i313i (314) ((322)) (321) 323 >331<



/* [config] */


// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// Infos: Pink output means parameters would lead to crash and have been rectified. Red plantes mean they do overlap. This may happen when mplanet >> msun.
info2 = "error modes";
// number of planet groups - greatest common divisor of gears
  gcd_ = 1;
// number of planet teeth per planet group
  mplanet_ = 4;
// number of sun teeth per planet group
  msun_ = 6;
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

// random parameters for overriding
/*
  gcd_ =     round( rands(1,6,3)[0] );
  mplanet_ = round( rands( (gcd==1) ? 2 : 1 ,7,3)[1] );
  msun_ =    round( rands( (gcd==1) ? 2 : 1 ,7,3)[2] );
*/

// rectifying bad inputs sice:
// crash: 111 121 131 141 151 ...
gcd = abs(round(gcd_));
crashconfig = (gcd_==1 && msun_==1); // colors output pink
mplanet = mplanet_;
msun    = crashconfig ? abs(round(msun_))   +1 : abs(round(msun_));


/* [main] */

part= "assembled"; // [assembled,planet,sun,ring,splitplanet,splitsun,splitring]

// base size - tooth rolling circle diameter
dbase = 1.25; 
rbase = dbase/2;

// total hight of the bearing
htot = 12;
h = htot/2;
// angle of the gear teeth from horizontal
twistangle = 45;
echo("number of teeth twisted: ",h/(tan(twistangle))/(2*pi));
echo("-------------------------------");

// htot=8 && base=2 crashes :S custmoizer makes strange preview ???



/* [ring] */

// choose type of outer circumference
  ringshape = "dents"; // [dents,gear,plain]
// dents/plain: ring thickness
  twall = 4;
// (todo: make option for straight teeth ??)
//gear: number of additional teeth than ringteeth
  nadd = 4;
// dents: number of grooves on the ring
  nringgrooves = 12;
// dents: diameter of grooves on the ring
  dgroove = 3.4; // todo: rename to dringgroove 
// gear: angle of the gear teeth from horizontal (sign swaps direction)
 twistangleout = -60;



/* [sun] */

// choose shape hole in the sun gear - cuts are rsunhole/sqrt(2)
0sunholeshape = "doublecut"; // [nocut,singlecut,doublecut,polygon,dents]

// dents: number of grooves on the sun bore (use for big diameter sun gears)
 nsungrooves = 3;
// dents: diameter of grooves on sun bore circumference
 dsungroove = 3.4;
// polygon: edge number of polygonal hole in sun gear
  npolygon = 6; 

// rotation offset for hole in sun gear
  asunoffset = 0;

// diameter of center hole (or wrench width if polygon is choosen)
  dsunhole = 6.4;
  rsunhole=dsunhole/2; // not in use yet

// ...cut: "yes"-> cut of at 45° axle overhangs | "no"-> use cutoff_
cutoff45 = "yes"; // [yes,no]
// ...cut: used if cutoff45 = "no"
cutoff_ = 0;



/* [planets] */

// diameter of holes in planets
  dplanethole = 3.5; // 3.2 way too less for filament 3.4 friction fit
// minimal clearance gap between planets (often no visible effect - floor's)
//  planetgap = 1; not in use -> 0 allowed
// add further parameters analog to sun ?







nsun    = gcd * msun; 
nplanet = gcd * mplanet; // 1 crashes - even ... bad  even make problems
nring = nsun+nplanet*2;
  echo("input:(gcd,mplanet,msun):",gcd,mplanet,msun);
  echo("number of teeth (planet,sun,planet,ring):",nplanet,nsun,nring);
  echo("number of outermost teeth (if used): ",nring+nadd);


// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
echo("-------------------------------");
// using the tooth size as basdesize makes gears interchangable
// cycloidical base-diameter (adding one tooth asss this much inter axle distance)

rsun  = rbase*2*nsun;
  echo("pitch radius of sun gear: ",rsun);

twistsun = h/(rsun*2*pi)*360 / tan(twistangle);

nsunringgap = nplanet*2;
rplanet = nplanet*2*rbase;
  echo("pitch radius of planet gears: ",rplanet);
twistplanet = -h/(rplanet*2*pi)*360 / tan(twistangle);
rroll = rsun+rplanet;
circroll = rroll*2*pi;
dplanetout = 2*(rplanet+rbase);

rring = rsun+2*rplanet;
  echo("pitch radius of ring gear: ",rring);
rtotal = rring+2*rbase+0+2*rbase+twall;
twistring = -h/(rring*2*pi)*360 / tan(twistangle);


twistringout = -h/(rtotal*2*pi)*360/tan(twistangleout);


// to next position where teeth match
  minang1 = 360/(nsun+nring);
// to next position where planet gears do not overlap
  minang2 = 2*asin((rplanet+2*rbase)/(rsun+rplanet));
  // too low in some cases -> why ??
// finding the first whole multiple of minang1 that does not make the planets overlap
  minang = ceil(minang2/minang1+0)*minang1;

echo("---------------------------------------------");
echo("minimal angle between: ");
echo("   1) adjacent unrestricted mountig locations: ",minang1);
echo("   2) adjacent planets to not overlap: ",minang2);
echo("   3) adjacent planets on mounting location: ",minang);
numplanet = 360/minang; // not used anymore
echo("the number of equidistant planets would be: ",numplanet);


  function rr(i) = i*minang;   
  ngroup = floor( (360/gcd) / minang);
  ratio = ((rsun+rplanet)/rplanet);


i0 = nsun/nring;
echo("-------------------------------");
echo("transmission ratios: ");
echo("sun to ring, ring to sun: ", i0, 1/i0);
echo("sun to plnts, plnts to sun: ", (1-i0), 1/(1-i0) );
echo("ring to plnts, plnts to ring: ", (1-(1/i0)), 1/(1-(1/i0)));

echo("-------------------------------");
echo("space usage: ");

usedangle = gcd*ngroup*minang2;
angleuseefficiency = usedangle/360;
echo("angle occupied by planets:", usedangle);
echo("planet density in %:",angleuseefficiency*100);
echo("############################################");

/* [bevels] */
// yet unused .............

// recommendation: activate for bigger planets
bevelplanets = "no"; // [no,yes]
bevelsun = "yes"; // [yes,no]
bevelring = "yes"; // [yes,no]
bevelringoutward = "yes"; // [yes,no]


/* [excentericiies] */

// distance of main axle from center
eaxle = 0;
// corrsponding angle offset
eaaxle = 0;
// distance of planet axles from planet centers
eplanet = 0;
// corresponding angle offset
eaplanet = 0;
// shift of ring center from global center
ering = 0;
// corresponding angle offset
earing = 0;


//pure angle offsets
//not yet in use - may be too nuch parameters
// asun = 0;
// aplanet = 0;
// aring = 0;







// ###########################################################
// ###########################################################
// ###########################################################


module suncuttershape(ss,hh)
{
  rpoly = ss/cos(360/(2*npolygon));
  cutoff = (cutoff45=="yes") ? ss/sqrt(2) : cutoff_ ;

  rotate(asunoffset,[0,0,1])
  if(0sunholeshape == "polygon")
  {
    cylinder(r=rpoly,h=hh,$fn=npolygon);
  }
  else
  { 
    difference()
    {
      cylinder(r=ss,h=hh); // cut circular hole  "nocut"
      // cutoff first side
     if(0sunholeshape == "singlecut" || 0sunholeshape == "doublecut" )
      { 
        translate([+(ss+cutoff),0,(hh+2)/2-1])
          cube([2*ss,2*ss,hh+2],center=true);
      }
      // cutoff second side
      if(0sunholeshape == "doublecut")
      { 
        translate([-(ss+cutoff),0,(hh+2)/2-1])
          cube([2*ss,2*ss,hh+2],center=true);
      }
    }
    // add dentcutters on circumference
    if(0sunholeshape == "dents")
    {
      for(i=[0:nsungrooves-1])
      {
        rotate(360/nsungrooves*i,[0,0,1]) translate([ss,0,0])
        cylinder(r=dsungroove/2,h=hh);
      }
    }
  }
}


//translate([20,0,20]) color("red") cube([10,10,10]); //size estimation cube


if(crashconfig)
 { color([1,0,1]) part(part); }
 else
 { part(part); }




module part(part)
{
  if(part =="assembled"){ stack() halvepart(); }

  if(part =="planet"){ stack() planet(bevelplanets); }
  if(part =="sun")   { stack() sun(bevelsun); }
  if(part =="ring")  { stack() ring(bevelring); }

  if(part =="splitplanet"){ planet(bevelplanets); }
  if(part =="splitsun")   { sun(bevelsun); }
  if(part =="splitring")  { ring(bevelring); }

  //if(part =="explosion"){ stack() halvepart(-1,-3,-5);}
  if(part =="explosion"){ stack() halvepart(-5,-3,-1);}

  module stack()
  { child();  translate([0,0,htot]) scale([1,1,-1]) child(); }

  module halvepart(a=0,b=0,c=0)
  { 
    translate([0,0,h*a]) sun(bevelsun); 
    translate([0,0,h*b]) planets(bevelplanets); 
    translate([0,0,h*c]) ring(bevelring);
  }

  //module explosion()
  //{ sun(bevelsun); planets(bevelplanets); ring(bevelring); }
}




module sun(bevel="yes")
{
  
  difference()
  {
    rotate( ((gcd*mplanet)%2==0) ? (360/(2*nsun)) : 0,[0,0,1]) // why?
    intersection()
    {
      linear_extrude(twist=twistsun,height=h,convexity=3) 
        profile(rbase-(clr/2)/nsun,nsun);
      if (bevel=="yes") cyl45(rsun+2*rbase-(clr/2),h,4*rbase);
    }

    // axle hole
    rotate(eaaxle,[0,0,1]) translate([eaxle,0,0]) rotate(0,[0,0,1])
    {
      translate([0,0,-h*0.1])
      suncuttershape(dsunhole/2,h*1.2);
    }
  }
}


// todo split off single planet
module planets(bevel="yes")
{
  for(j=[0:gcd-1])
  {
    for(i=[0:ngroup-1])
    {
      color( (ngroup>0) ? "orange" : "red")
      translate([0,0,-2*eps])
      planet(bevel,i,j);
    }
  } 
}
module planet(bevel="yes",i=0,j=0)
{
     difference()
      {
        rotate( +(i*minang + 360/gcd*j) ,[0,0,1])
        translate([rroll,0,0])
        rotate( -(i*minang + 360/gcd*j) ,[0,0,1]) // compensate
        rotate( i*minang*ratio ,[0,0,1])
        intersection()
        {
          linear_extrude(twist=twistplanet,height=h+0*eps,convexity=3)
            profile(rbase-(clr/2)/nplanet,nplanet);
          if (bevel == "yes") cyl45(rplanet+2*rbase -(clr/2),h+0*eps,4*rbase);
        }

        // cut holes
        rotate( +(i*minang + 360/gcd*j) ,[0,0,1])
        translate([rroll,0,0])
        rotate( -(i*minang + 360/gcd*j) ,[0,0,1]) // compensate
        rotate(eaplanet,[0,0,1]) translate([eplanet,0,0]) rotate(0,[0,0,1])
        translate([0,0,-h]) cylinder(r=dplanethole/2,h=3*h);
      }
  // maybe todo: splitoff unmoved planet
}




module ring(bevel="yes", bevelout="yes")
{
  rout = (ringshape == "gear") ? rring+1 : rtotal;

  difference()
  {

    rotate(earing,[0,0,1]) translate([ering,0,0]) // excentricity
    rotate(0,[0,0,1]) // angular offset
    {
      if(ringshape =="gear")
      {
        intersection()
        {
          //cylinder(r=rring+rbase*1.5*nadd,h=h-eps);
          if (bevelringoutward=="yes")
          { cyl45(rbase*2*(nring+nadd)+2*rbase, h+0, 4*rbase); } else
          { cylinder(r = rbase*2*(nring+nadd)+2*rbase, h = h+0); } // yet untested
          linear_extrude(twist=+twistringout, height=h+2*eps, convexity=3)
            profile(rbase-0, nring+nadd); // -(clr/2)/(nring+nadd) ?
        }
      }
      else
      {

        difference()
        {
          //cylinder(r=rtotal,h=h-eps);
          if (bevelringoutward=="yes") 
          { cyl45(rtotal,h+0,dgroove/2); } else
          { cylinder(r=rtotal,h+0); }
    
          // mounting dents
          if(ringshape=="dents")
          {
            for(i=[0:nringgrooves-1])
            {
              rotate(360/nringgrooves*i,[0,0,1])
              translate([rtotal,0,-h])
                cylinder(r=dgroove/2,h=3*h);
            }
          }

        }

      } // end test gear or other outer shape
    } // end offsets

    // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    // cut inner ring teeth
    translate([0,0,-eps])
    linear_extrude(twist=+twistring,height=h+2*eps,convexity=3)
      // offset(2*clr) // bad deforms profile -> thus modifying radius instead 
      profile(rbase+(clr/2)/nring,nring);

    // cut inner ring bevel
    translate([0,0,2*dbase])
    scale([1,1,-1])
    if (bevel=="yes") cyl45(rring+2*rbase +(clr/2),h,4*rbase);
  }
}


module cyl45(rr,hh,bb)
{
  hull()
  {
    cylinder(r=rr-bb,h=hh);
    translate([0,0,bb*1])
    cylinder(r=rr,h=hh-bb-bb*0);
  }
}


// ###########################
// ###########################
// ###########################


module profile(r0=1,m=2,vnert=360)
{
  con = m; // convexity
  ntot = 360; // do not change unless you change the things below too
  // list comprehension openscad 2012.QX
  m = (m<1) ? 1 : round(m);
  rbase = 10;

  // keep centerradius instead of loberadius constant??
  function ff(n) = epihypo(2*m*r0,r0,360/ntot*n); // <<<<<<<<<<<<<<<<<<<<<<<<<<<

  // http://en.wikibooks.org/wiki/OpenSCAD_User_Manual/List_Comprehensions
  // path = [ for (i = [0 : nvert]) i ]; // OpenSCAD 2014.QX
  // points = [ for (i = [0 : nvert) ff(i) ]; // OpenSCAD 2014.QX
  // no means to generate arrays from functions yet -> workaround:
/*
  path120 = 
    [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
     21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,
     41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,
     61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,
     81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,
     101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120];

  //haskell script for help: 
  //concat $ map (\x->",ff("++show x++")")[1..100]
  points120 = [
    ff(1),ff(2),ff(3),ff(4),ff(5),ff(6),ff(7),ff(8),ff(9),ff(10),
    ff(11),ff(12),ff(13),ff(14),ff(15),ff(16),ff(17),ff(18),ff(19),ff(20),
    ff(21),ff(22),ff(23),ff(24),ff(25),ff(26),ff(27),ff(28),ff(29),ff(30),
    ff(31),ff(32),ff(33),ff(34),ff(35),ff(36),ff(37),ff(38),ff(39),ff(40),
    ff(41),ff(42),ff(43),ff(44),ff(45),ff(46),ff(47),ff(48),ff(49),ff(50),
    ff(51),ff(52),ff(53),ff(54),ff(55),ff(56),ff(57),ff(58),ff(59),ff(60),
    ff(61),ff(62),ff(63),ff(64),ff(65),ff(66),ff(67),ff(68),ff(69),ff(70),
    ff(71),ff(72),ff(73),ff(74),ff(75),ff(76),ff(77),ff(78),ff(79),ff(80),
    ff(81),ff(82),ff(83),ff(84),ff(85),ff(86),ff(87),ff(88),ff(89),ff(90),
    ff(91),ff(92),ff(93),ff(94),ff(95),ff(96),ff(97),ff(98),ff(99),ff(100),
    ff(101),ff(102),ff(103),ff(104),ff(105),ff(106),ff(107),ff(108),ff(109),ff(110),
    ff(111),ff(112),ff(113),ff(114),ff(115),ff(116),ff(117),ff(118),ff(119),ff(120)];
*/
path360 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360];

points360 = [ff(1),ff(2),ff(3),ff(4),ff(5),ff(6),ff(7),ff(8),ff(9),ff(10),ff(11),ff(12),ff(13),ff(14),ff(15),ff(16),ff(17),ff(18),ff(19),ff(20),ff(21),ff(22),ff(23),ff(24),ff(25),ff(26),ff(27),ff(28),ff(29),ff(30),ff(31),ff(32),ff(33),ff(34),ff(35),ff(36),ff(37),ff(38),ff(39),ff(40),ff(41),ff(42),ff(43),ff(44),ff(45),ff(46),ff(47),ff(48),ff(49),ff(50),ff(51),ff(52),ff(53),ff(54),ff(55),ff(56),ff(57),ff(58),ff(59),ff(60),ff(61),ff(62),ff(63),ff(64),ff(65),ff(66),ff(67),ff(68),ff(69),ff(70),ff(71),ff(72),ff(73),ff(74),ff(75),ff(76),ff(77),ff(78),ff(79),ff(80),ff(81),ff(82),ff(83),ff(84),ff(85),ff(86),ff(87),ff(88),ff(89),ff(90),ff(91),ff(92),ff(93),ff(94),ff(95),ff(96),ff(97),ff(98),ff(99),ff(100),ff(101),ff(102),ff(103),ff(104),ff(105),ff(106),ff(107),ff(108),ff(109),ff(110),ff(111),ff(112),ff(113),ff(114),ff(115),ff(116),ff(117),ff(118),ff(119),ff(120),ff(121),ff(122),ff(123),ff(124),ff(125),ff(126),ff(127),ff(128),ff(129),ff(130),ff(131),ff(132),ff(133),ff(134),ff(135),ff(136),ff(137),ff(138),ff(139),ff(140),ff(141),ff(142),ff(143),ff(144),ff(145),ff(146),ff(147),ff(148),ff(149),ff(150),ff(151),ff(152),ff(153),ff(154),ff(155),ff(156),ff(157),ff(158),ff(159),ff(160),ff(161),ff(162),ff(163),ff(164),ff(165),ff(166),ff(167),ff(168),ff(169),ff(170),ff(171),ff(172),ff(173),ff(174),ff(175),ff(176),ff(177),ff(178),ff(179),ff(180),ff(181),ff(182),ff(183),ff(184),ff(185),ff(186),ff(187),ff(188),ff(189),ff(190),ff(191),ff(192),ff(193),ff(194),ff(195),ff(196),ff(197),ff(198),ff(199),ff(200),ff(201),ff(202),ff(203),ff(204),ff(205),ff(206),ff(207),ff(208),ff(209),ff(210),ff(211),ff(212),ff(213),ff(214),ff(215),ff(216),ff(217),ff(218),ff(219),ff(220),ff(221),ff(222),ff(223),ff(224),ff(225),ff(226),ff(227),ff(228),ff(229),ff(230),ff(231),ff(232),ff(233),ff(234),ff(235),ff(236),ff(237),ff(238),ff(239),ff(240),ff(241),ff(242),ff(243),ff(244),ff(245),ff(246),ff(247),ff(248),ff(249),ff(250),ff(251),ff(252),ff(253),ff(254),ff(255),ff(256),ff(257),ff(258),ff(259),ff(260),ff(261),ff(262),ff(263),ff(264),ff(265),ff(266),ff(267),ff(268),ff(269),ff(270),ff(271),ff(272),ff(273),ff(274),ff(275),ff(276),ff(277),ff(278),ff(279),ff(280),ff(281),ff(282),ff(283),ff(284),ff(285),ff(286),ff(287),ff(288),ff(289),ff(290),ff(291),ff(292),ff(293),ff(294),ff(295),ff(296),ff(297),ff(298),ff(299),ff(300),ff(301),ff(302),ff(303),ff(304),ff(305),ff(306),ff(307),ff(308),ff(309),ff(310),ff(311),ff(312),ff(313),ff(314),ff(315),ff(316),ff(317),ff(318),ff(319),ff(320),ff(321),ff(322),ff(323),ff(324),ff(325),ff(326),ff(327),ff(328),ff(329),ff(330),ff(331),ff(332),ff(333),ff(334),ff(335),ff(336),ff(337),ff(338),ff(339),ff(340),ff(341),ff(342),ff(343),ff(344),ff(345),ff(346),ff(347),ff(348),ff(349),ff(350),ff(351),ff(352),ff(353),ff(354),ff(355),ff(356),ff(357),ff(358),ff(359),ff(360)];

  // add higher resoltiomns
  // http://en.wikipedia.org/wiki/Superior_highly_composite_number
  // 2,6,12,60,120,360,2520,5040,55440,720720
  //http://en.wikipedia.org/wiki/Superabundant_number
  //1, 2, 4, 6, 12, 24, 36, 48, 60, 120, 180, 240, 360, 720,
  //840, 1260, 1680, 2520, 5040, 10080, 15120, ...
  
  //scale([r0,r0,1])
  rotate(360/(2*m)*1/2,[0,0,1])
  polygon(points = points360, paths = [path360],convexity = con);
  // why no difference??

}

// https://github.com/OskarLinde/scad-utils/blob/master/morphology.scad
// detour over 3D would help for old openscad version that customizer uses 
// but would make it too slow
// decision -> put all the clearance into the outset of the ring gear


module offset(s,v=24)
{ minkowski() { circle(r=s,$fn=v); child(); } }
module inset(s)
{ inverse() offset(d=s) inverse() child(); }
module inverse(hack = 1e6)
{ difference() { square(hack,center=true); child(); } }
module shell(){/**/}


// functions for generation of hypo- and epicycloids

//asserted: r1 > r2 (& divisible without remainder)!!
function hypo_cyclo(r1,r2,phi) = [
  (r1-r2)*cos(phi)+(r2)*cos(r1/r2*phi-phi),
  (r1-r2)*sin(phi)+(r2)*sin(-(r1/r2*phi-phi))];
function epi_cyclo(r1,r2,phi) = [
  (r1+r2)*cos(phi)-(r2)*cos(r1/r2*phi+phi),
  (r1+r2)*sin(phi)-(r2)*sin(r1/r2*phi+phi)];
// alternating hypo- and epicycloids
function epihypo(r1,r2,phi) = 
  pow(-1, 1+floor( (phi/360*(r1/r2)) )) <0 ?
    epi_cyclo(r1,r2,phi) :
    hypo_cyclo(r1,r2,phi);

/*
################################################################

// crash: 111 121 131 141 151 ....


// 112 113 114 115 116 ...
// good configurations with symmetry >=2 (at least by eye)
// 123 124 125 126 127 ...
// 133 136 139 13(12)         513
// 142 | 144 146 148 14(10) 14(12)
// 155 (?) 159 15(11) 15(13) 15(15) 15(17)
// 163 164 | 169 16(14) 16(19) 16(24)
// 175 | 178 17(11) 17(14) 17(17) 17(20)
// 186 | 18(13) 18(16) 18(19) 18(22)
// 193 | 19(12) 19(19) 19(26) 19(33)
// 1(10)6 | 1(10)(10) 1(10)(14) 1(10)(18)
// -----------------
// configurations: with no perceivable gaps between groups
// 211 | 212 (from 3 onwards more tightly packed)
// 221 222 | 224 226 228 22(10) 22(12)
// 231 232 | 237 23(12) 23(17) 23(22) 23(27)
// 241 242 243 | 248 24(11) 24(14) 24(17)
// 251 252 253 | 257 25(11) 25(15) 25(19)
// 261 262 263 264 | 26(12) 26(21) 26(30)
// -----------------
// 311 | 312 315 318 31(11)
// 321 322 323 | 328 32(13) 32(18)
// 331 332 333 334 | 33(11) 33(18)
// X341X 342 343 344 | 345 34(14) 24(23) - some good intermediates
// X351X 352 353 354 355 | 356 35(17) 35(28)
// 3(10)2 ...
// -----------------
// 411 | 412 413 [415] 417 419 41(11)
// X421X 422 | 423 424 427 42(10) 42(13)
// X431X 432 433 | 434 435 436 43(15) 43(24)
// X441X X442X{??} 443 444 445 446 447 448 [449] ~~ somehow further
// X462X{??} 463 ...
// -----------------
// X511X | 512 513 515 517 519
// X521X 522 | 523 524 525 526 52(10) 52(14)
// X531X X532X | 534 535 536 537 538 [53(14)] ~~ somehow further
// -----------------
// X611X | 612 613 614 619 61(14)
// X621X X622X{??} | 623 624 625 626 627 [62(12)] 62(16)
// X631X X632X X633X 634 635 636 637 638 639 63(10) _ ~~ somehow further
// -----------------
// X711X 712 713 714 715 718 71(11)
// X721X X722X 723 724 725 726 727 728 _ ~~ somehow further
// -----------------
// X811X 812 813 814 815 _ ~~ somehow further


too small planets -> excessive number of retraction moves

useful info (de)
http://books.google.at/books?id=HOdNCdD_DH8C&pg=PA43&lpg=PA43&dq=verteilung+der+planetenr%C3%A4der&source=bl&ots=Vj4I1vCtlb&sig=9yMBVscx3xZat7wVPMGql6JAN3U&hl=de&sa=X&ei=cBksVKfCC4T8ywPWw4HgAw&ved=0CC4Q6AEwAg#v=onepage&q=verteilung%20der%20planetenr%C3%A4der&f=false

*/
