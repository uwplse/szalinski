// 
// Customizable Twisted Strands v2
// version 1.0   7/3/2016
// by Steve Van Ausdall 
// (DaoZenCiaoYen @ Thingiverse)
//

// preview[view:south, tilt:top diagonal]

/* [Main] */
// in mm
height = 60 ; // [20:5:200]
// each twist is 180 degrees
num_twists = 2 ; // [1:4]
// where "include center" is true
center_rotation = 0 ; // [-90:90]
// strand options
strand_options = 2 ; // [0:Single,1:Double,2:Mirrored,3:Double Mirrored]
// radius of individual strands
strand_radius = 2 ; // [1.5:0.25:10]
// stretch results in oval strand cross sections
strand_stretch = 1.4 ; // [1:0.1:5]
// initial rotation of individual strands
strand_rotation = 45 ; // [-90:90]
// facets per shape
resolution = 24 ; // [4:2:64]
// slices per shape
slices = 24 ; // [4:2:64]
// color (preview only)
model_color = 8 ; // [0:Black,1:White,2:Grey,3:Red,4:DarkRed,5:Orange,6:SaddleBrown,7:Goldenrod,8:Gold,9:Yellow,10:GreenYellow,11:Green,12:DarkGreen,13:DodgerBlue,14:Blue,15:MediumBlue,16:DarkBlue,17:Indigo,18:Violet]

// Number of inner spokes (X)
num_x = 3 ; // [1:12]
// include center shape
include_center_x = 0 ; // [0:False,1:Copy Y,2:True,3:True and Copy Y]
// x radius  / distance
x_radius = 6 ; // [0:30]
// initial angle of model
x_angle = 0 ; // [-90:90]

// number of outer spokes (Y)
num_y = 3 ; // [1:12]
// include center of each Y shape
include_center_y = 0 ; // [0:False,1:True]
// y radius / distance
y_radius = 12 ; // [-20:30]
// initial angle of y groups
y_angle = 0 ; // [-90:90]

// number of strands per origin (Z)
num_z = 2 ; // [1:12]
// radius of individual strand twists (in mm)
z_radius = 8 ; // [0:30]
// initial angle of z groups
z_angle = 0 ; // [-90:90]

/* [Build Plate] */
// set to True to see the shape on your build plate
show_build_plate = 0 ; // [0:False,1:True]
// for display only, doesn't contribute to final object
build_plate_selector = 2 ; // [0:Replicator 2,1:Replicator,2:Thingomatic,3:Manual]
// Build plate x dimension for "Manual" (in mm)
build_plate_manual_x = 100 ; // [50:5:500]
// Build plate y dimension for "Manual" (in mm)
build_plate_manual_y = 100 ; // [50:5:500]

/* [Hidden] */

use <utils/build_plate.scad> ;

$fn = resolution ;
colors=[
  "Black", // 0
  "White", // 1
  "Grey", // 2
  "Red", // 3
  "DarkRed", // 4
  "Orange", // 5
  "SaddleBrown", // 6
  "Goldenrod", // 7
  "Gold", // 8
  "Yellow", // 9
  "GreenYellow", // 10
  "Green", // 11
  "DarkGreen", // 12
  "DodgerBlue", // 13
  "Blue", // 14
  "MediumBlue", // 15
  "DarkBlue", // 16
  "Indigo", // 17
  "Violet" // 18
];

main();

module main()
{
  color(colors[model_color])
  shape();
}

module shape()
{
  rotate([0,0,x_angle])
  radial_copy(num_x, x_radius, include_center_x)
  rotate([0,0,y_angle])
  radial_copy(num_y, y_radius, include_center_y)
  rotate([0,0,z_angle])
  z_group();
  if (include_center_x == 2 || include_center_x == 3) {
    rotate([0,0,center_rotation])
    z_group();
  }
}

module z_group()
{
  for (i = [0 : 360/num_z : 359])
  {
    strand(num_twists,i);
    if (strand_options == 1 || strand_options == 3) {
      strand(num_twists,i+180);
    }
    if (strand_options == 2 || strand_options == 3) {
      strand(-num_twists,i);
    }
    if (strand_options == 3) {
      strand(-num_twists,i+180);
    }
  }
}

module strand(t,i)
{
  rotate([0,0,i])
  translate([-z_radius,0,0])
  linear_extrude(
    height = height, 
    center = false, 
    convexity = 10, 
    twist = t*180, 
    slices = slices)
  translate([z_radius, 0, 0])
  base_shape();
}

module base_shape()
{
  rotate([0,0,strand_rotation])
  scale([strand_stretch,1,1])
  circle(r = strand_radius);
}

module radial_copy(copies,radius,include_center)
{
  if (copies > 1)
  {
    for (i = [0: 360/copies : 359])
    {
      rotate([0,0,i])
      translate([radius,0,0])
      children(0);
    }
  }
  
  if (copies == 1 || include_center == 1 || include_center == 3)
  {
    rotate([0,0,center_rotation])
    children(0);
  }
}

if (show_build_plate==1)
{
  build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
}
