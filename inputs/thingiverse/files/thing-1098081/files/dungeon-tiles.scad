/*

Alternative Pocket Dungeons tiles procedurally generated so I can have a
corridor with a fork off in one direction only.

*/

part = "all"; // [dead_end, straight, bend, hairpin, Y, fork_left, fork_right, T, trident, X, K, tree, star, room_end, room_straight, room_bend, room_hairpin, room_Y, room_fork_left, room_fork_right, room_T, room_trident, room_X, room_K, room_tree, room_star, all]

/* [Hidden] */

draft = false;
$fs = draft ? 1 : 0.1;
$fa = 2;

print = "fork_left";
print = "room_hairpin";
print = "bend";
print = "nothing";
print = part;


q = 0.02;


total_thickness = 2;
path_width = 5;
path_thickness = 1;

tile_radius = 15; // mm from one corner of a tile to the opposite corner


module part (name)
{
  if (print=="all" || print== name)
    children ();
}


module hexgaon (r)
{
  circle (r= r, $fn= 6);
}


module bricks ()
{
  corner_radius = 0.5;
  width = 4.3;
  height = 2.2;
  between_bricks = 0.7;
  dx = width + between_bricks;
  dy = height + between_bricks;
  rows = floor (tile_radius*2 / dy / 2) * 2; // /2 then *2 to get even number so /2 later on doesn't yield fraction
  columns = floor (tile_radius*2 / dx / 2) * 2;

  module brick ()
  {
    hull ()
    for (y= [-1, +1])
    for (x= [-1, +1])
    translate ([(width / 2 - corner_radius) * x, (height / 2 - corner_radius) * y])
      circle (r= corner_radius);
  }

  for (y= [-rows/2 : +rows/2])
  {
    offset = y % 2 == 0 ? dx/2 : 0;
    for (x= [-columns/2 : +columns/2])
    translate ([offset + dx*x, dy*y])
      brick ();
  }
}


module slice (offset, height, bricks)
{
  translate ([0, 0, offset])
  linear_extrude (height= height)
  difference ()
  {
    intersection ()
    {
      hexgaon (tile_radius);
      if (bricks)
        bricks ();
    }
    children ();
  }
}


module path (a)
{
  hull ()
  {
    circle (r= path_width/2);
    rotate (-a)
    translate ([0, tile_radius])
      circle (r= path_width/2);
  }
}


module tile (name, angles, room, xpos, ypos)
{
  SAND = [0.9, 0.7, 0.3];
  GRAY = [0.4, 0.4, 0.4];
  LIGHT_GRAY = [0.6, 0.6, 0.6];

  lip = 0.5;

  module space ()
  {
    union ()
    {
      for (a= angles)
        path (a);
      if (room)
        square ([15.8, 15.8], center=true);
    }
  }
  part (name)
  translate (print == name ? [0, 0] : [32*xpos, 32*ypos])
  {
    color (SAND)
      slice (0, path_thickness, false);
    color (GRAY)
    slice (path_thickness, lip, false)
      space ();
    color (LIGHT_GRAY)
    slice (path_thickness + lip, total_thickness - path_thickness - lip, true)
      space ();
  }
}


TILES = [
[
  [
    ["dead_end",        [ 180 ],                          false ],
  ],
  [
    ["straight",        [ 180, 0 ],                       false ],
    ["bend",            [ 180, -60 ],                     false ],
    ["hairpin",         [ 180, -120 ],                    false ],
  ],
  [
    ["Y",               [ 180, -60, +60 ],                false ],
    ["fork_left",       [ 180, 0, -60 ],                  false ],
    ["fork_right",      [ 180, 0, +60 ],                  false ],
    ["T",               [ 180, -120, -60 ],               false ],
  ],
  [
    ["trident",         [ 180, -60, 0, +60 ],             false ],
    ["X",               [ 180, -60, 0, 120 ],             false ],
    ["K",               [ 180, 0, 60, 120 ],              false ],
  ],
  [
    ["tree",            [ 180, -120, -60, +60, +120 ],    false ],
  ],
  [
    ["star",            [ 180, -120, -60, 0, +60, +120 ], false ],
  ],
],
[
  [
    ["room_end",        [ 180 ],                          true ],
  ],
  [
    ["room_straight",   [ 180, 0 ],                       true ],
    ["room_bend",       [ 180, -60 ],                     true ],
    ["room_hairpin",    [ 180, -120 ],                    true ],
  ],
  [
    ["room_Y",          [ 180, -60, +60 ],                true ],
    ["room_fork_left",  [ 180, 0, -60 ],                  true ],
    ["room_fork_right", [ 180, 0, +60 ],                  true ],
    ["room_T",          [ 180, -60, -120 ],               true ],
  ],
  [
    ["room_trident",    [ 180, 0, -60, +60 ],             true ],
    ["room_X",          [ 180, 0, -60, +120 ],            true ],
    ["room_K",          [ 180, 0, +60, +120 ],            true ],
  ],
  [
    ["room_tree",       [ 180, -60, -120, +60, +120 ],    true ],
  ],
  [
    ["room_star",       [ 180, 0, -60, -120, +60, +120 ], true ],
  ],
]
];

for (class= [0 : len (TILES) - 1])
{
  tiles = TILES [class];
  for (group= [0 : len (tiles) - 1])
  {
    tiles = tiles [group];
    for (i= [0 : len (tiles) - 1])
    {
      tile = tiles [i];
      tile (tile [0], tile [1], tile [2], 5 * class + i, group);
    }
  }
}

