// 
// Random Mineral
// version 1.0   11/12/2015
// by Steve Van Ausdall (DaoZenCiaoYen @ Thingiverse)
//

// preview[view:northwest, tilt:top]

/* [Main] */
// radius (in mm) of center polygon
center_size = 12 ; // [5:5:100]
// Number of outer gems
count = 24 ; // [0:40]
// each seed results in a random arrangement
set_seed = 3 ; // [1:100]
// minimum number of sides per shape
min_polysides = 4 ; // [3:9]
// maximum number of sides per shape
max_polysides = 6 ; // [3:9]
// minimum size of outer shapes (percentage of center)
min_size_pct = 30 ; // [10:10:150]
// maximum size of outer shapes
max_size_pct = 70 ; // [10:10:150]
// height is the middle length (percent of size)
min_height_pct = 50 ; // [10:10:150]
max_height_pct = 90 ; // [10:10:150]
// length of sloped parts (percent of height)
min_tip_pct = 80 ; // [10:10:150]
max_tip_pct = 120 ; // [10:10:150]
//  percentage of the tip to clip off
clip_tip_pct = 0 ; // [0:10:80]
// how much to randomize the angles
angle_rand = 30 ; // [0:10:90]
// how many axes to mirror
mirror_axes = 0 ; // [0:3]
// degrees to rotate (prior to mirror)
rotate_x = 0 ; // [-180:10:180]
rotate_y = 0 ; // [-180:10:180]
rotate_z = 0 ; // [-180:10:180]
// adjusts size of clipping boxes
max_size_adjust_pct = 120 ; // [50:10:200]
// include just half of the shape
clip_top_half = "Yes" ; // [Yes,No]

/* [Hidden] */
ff = 0.01 ;
center_tip = 0.75 ; 
t = clip_tip_pct / 100 ;
use_random_seed = false ; // [true,false]
max_size_adjust = max_size_adjust_pct/100 ;
min_size = center_size*min_size_pct/100 ;
max_size = center_size*max_size_pct/100 ;
min_tip = min_tip_pct/100;
max_tip = max_tip_pct/100;
min_height = min_height_pct/100 ;
max_height = max_height_pct/100 ;
center_box = 
  gem_box(center_size,center_tip,t,center_size);
outer_box = 
  gem_box(max_size*max_height,max_tip,t,max_size);
random_seed = floor(rands(0,100,1)[0]) ;
seed = use_random_seed ? random_seed : set_seed ;
echo(seed=seed);
ra = rands(0,100,10,seed) ;
rf = rands(min_polysides,max_polysides,count+1,ra[0]);
rh = rands(min_height,max_height,count+1,ra[1]);
rs = rands(min_size,max_size,count+1,ra[2]);
rm = rands(min_tip,max_tip,count+1,ra[3]);
rx = rands(0,360,count+1,ra[4]);
ry = rands(0,360,count+1,ra[5]);
rz = rands(0,360,count+1,ra[6]);
rax = rands(-angle_rand,angle_rand,count+1,ra[7]);
ray = rands(-angle_rand,angle_rand,count+1,ra[8]);
raz = rands(-angle_rand,angle_rand,count+1,ra[9]);
tsize = max_size_adjust*(center_box+outer_box);
show_clip_box = false ; //show_clip_box = true ;

use <utils/build_plate.scad> ;
show_build_plate=false;

main();

module main()
{
  if (clip_top_half == "Yes") {
    above_z() mgems();
  } else {
    mgems();
  } ;
  if (show_clip_box) {
    clip_box();
  }
}

module mgems()
{
  rotate([0,0,0]) reflect(3) 
    rotate([0,90,0]) reflect(2) 
    rotate([90,0,0]) reflect(1) 
    rotate([rotate_z,rotate_x,rotate_y])
    gems(center_size) ;
}

module gems(r)
{
  // center 
  rotate([rax[0],ray[0],raz[0]])
    translate([0,0,-r/2]) 
    gem(r,center_tip,t) 
    ngon(floor(rf[0]),r);
  // outer gems
  if (count > 0)
    rgems(r);
}

module rgems(r)
{
  for (i = [ 1 : count ] ) 
  {
    rotate([rx[i],ry[i],rz[i]])
      translate([0,0,r-(rh[i]*rs[i]/2)])
      rotate([rax[i],ray[i],raz[i]])
      gem(rh[i]*rs[i],rm[i],t) 
      ngon(floor(rf[i]),rs[i]);
  }
}

module reflect(a)
{
  if (mirror_axes >= a)
  {
    translate([0,0,-ff])
      above_z() children(0);
    mirror([0,0,1]) 
      above_z() children(0) ;
  }
  else
  {
    children(0);
  }
}

module above_z()
{
  intersection()
  {
    clip_box();
    children(0);
  }
}

module clip_box() 
{
  translate([0,0,tsize/4]) 
    cube([tsize,tsize,tsize/2],center=true);
}

module gem(h,f,t)
{
  translate([0,0,h])
    linear_extrude(h*f,scale=t) children(0);
  linear_extrude(h) children(0);
  rotate([0,180,0])
    linear_extrude(h*f,scale=t) children(0);
}

module ngon(n,r)
{
  points = 
  [ 
    for ( i = [0 : 360/n : 360] ) 
      let (x = r * sin(i), y = r * cos(i)) [ x, y ] 
  ] ;
  polygon(points);
}

function gem_box(h,f,t,r) = max(h+(h*f*t*2),r*2) ;


if (show_build_plate)
{
  //for display only, doesn't contribute to final object
  build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
  //when Build Plate Selector is set to "manual" this controls the build plate x dimension
  build_plate_manual_x = 120.65; //[100:400]
  //when Build Plate Selector is set to "manual" this controls the build plate y dimension
  build_plate_manual_y = 120.65; //[100:400]

  build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
}
