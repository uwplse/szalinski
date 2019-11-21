/* Improved Auto Coin Sorter V5                     */
/* - Obsolete image decoration code removed         */
/* - Unused dovetail code removed                   */
/* - Unused box/tube emptier code removed           */
/* https://www.thingiverse.com/thing:3203049        */
/* by Bikecyclist                                   */
/* https://www.thingiverse.com/Bikecyclist          */
/*                                                  */
/* Remixed from                                     */
/*                                                  */
/* Customized Auto Coin Sorter PLN                  */
/* (No longer on Thingiverse)                       */
/* by Seveneq                                       */
/* https://www.thingiverse.com/Seveneq              */
/*                                                  */
/* Improved Auto Coin Sorter V4, V3, V2, V1         */
/* https://www.thingiverse.com/thing:3203049        */
/* by Bikecyclist                                   */
/* https://www.thingiverse.com/Bikecyclist          */
/*                                                  */
/* Auto Coin Sorter for All Currencies              */
/* https://www.thingiverse.com/thing:499177         */
/* by Youngcat                                      */
/* https://www.thingiverse.com/youngcat             */

/* [General] */

// Choose a currency you use.
currency = "usd"; // [usd:USD - US dollar, eur:EUR - Euro, chf:CHF - Swiss franc, cad:CAD - Canadian dollar, pen:PEN - Peruvian Sol, pln:PLN - Polish Zloty, sek:SEK - Swedish Krona, thb:THB - Thai Baht, other:Other (See "Slot customization" tab)]

// How tall is the the shortest tube? In millimeters (80 mm for EUR):
height = 70; // [10:150]

// Choose a pattern for the back side.
pattern = "mesh"; // [no:Solid without pattern, chncoin:Chinese ancient coin pattern, mesh:Mesh pattern]

// Which one would you like to see?
part = "all_unassembled"; // [all:All these three parts assembled together,all_unassembled:All these three parts unassembled,basebox:Base box only,topboard:Top board only,tuberack:Tube rack only, tubes:Tubes only]

/* [Slot customization] */

// In this tab you're able to customize your coins. Here below, you may have up to 10 slots, each for one kind of coin. For each slot you're going to define it's diameter and thickness. Note that the coins should be ordered from biggest to smallest in diameter. You may want to collect information about the diameters and thicknesses of your coins from wikipedia before you continue.
understand = 1; // [1:Yes I understand,0:Yes I said understand]

// in millimeters. For the first (and biggest) coin.
coin_1_diameter = 30.61;
// in millimeters.
coin_1_thickness = 2.15;
// number in one roll
coin_1_roll_count = 20;
// The second coin. Remember: this 2nd coin should always be smaller than the 1st coin.
coin_2_diameter = 26.50;
coin_2_thickness = 2.00;
coin_2_roll_count = 20;
// The 3rd coin.
coin_3_diameter = 24.26;
coin_3_thickness = 1.75;
coin_3_roll_count = 40;
// 4th coin.
coin_4_diameter = 21.21;
coin_4_thickness = 1.95;
coin_4_roll_count = 40;
// 5th coin. If you don't need more coins, simply set the remaining to 0.
coin_5_diameter = 0;
coin_5_thickness = 0;
coin_5_roll_count = 0;
// 6th coin.
coin_6_diameter = 0;
coin_6_thickness = 0;
coin_6_roll_count = 0;
// 7th coin.
coin_7_diameter = 0;
coin_7_thickness = 0;
coin_7_roll_count = 0;
// 8th coin.
coin_8_diameter = 0;
coin_8_thickness = 0;
coin_8_roll_count = 0;
// 9th coin.
coin_9_diameter = 0;
coin_9_thickness = 0;
coin_9_roll_count = 0;
// 10th coin.
coin_10_diameter = 0;
coin_10_thickness = 0;
coin_10_roll_count = 0;

/* [Hidden] */

//             2.00   0.50   1.00   0.20   0.05   0.10   0.02   0.01
eur_coins = [[25.75, 24.25, 23.25, 22.25, 21.25, 19.75, 18.75, 16.25],
             [ 2.20,  2.38,  2.33,  2.14,  1.67,  1.93,  1.67,  1.67],
             [   25,    20,    25,    40,    50,    40,    50,    50]];
             
//             0.50   1.00   0.25   0.05   0.01   0.10
usd_coins = [[30.61, 26.50, 24.26, 21.21, 19.05, 17.91],
             [ 2.15,  2.00,  1.75,  1.95,  1.55,  1.35],
             [   20,    25,    40,    40,    50,    50]];
             
chf_coins = [[31.45, 27.40, 23.20, 21.05, 19.15, 18.20, 17.15],
             [ 2.35,  2.15,  1.15,  1.65,  1.45,  1.25,  1.25],
             [   20,    20,    50,    50,    50,    50,    50]];
             
cad_coins = [[28.00, 27.13, 26.50, 23.88, 21.20, 19.05, 18.03],
             [ 1.80,  1.95,  1.75,  1.58,  1.76,  1.45,  1.22],
             [   20,    20,    50,    50,    50,    50,    50]];
             
pen_coins = [[25.50, 24.38, 23.00, 22.30, 22.00, 20.50, 18.00],
             [ 1.65,  2.13,  1.26,  2.07,  1.65,  1.26,  1.26],
             [   20,    20,    50,    50,    50,    50,    50]];
             
pln_coins = [[24.00, 23.00, 21.50, 20.50, 19.50, 18.50, 17.50, 16.50, 15.50],
             [ 2.00,  1.70,  2.00,  1.70,  1.40,  1.70,  1.40,  1.70,  1.40],
             [   20,    20,    50,    50,    50,    50,    50,    50,    50]];
             
sek_coins = [[23.75, 22.50, 20.50, 19.50],
             [ 1.97,  1.79,  1.79,  2.90],
             [   20,    20,    50,    50]];
             
thb_coins = [[26.00, 24.05, 22.05, 20.01],
             [ 2.16,  2.13,  1.48,  1.38],
             [   20,    20,    50,    50]];

other_coins_d_t = [
  [coin_1_diameter, coin_1_thickness, coin_1_roll_count], [coin_2_diameter, coin_2_thickness, coin_2_roll_count],
  [coin_3_diameter, coin_3_thickness, coin_3_roll_count], [coin_4_diameter, coin_4_thickness, coin_4_roll_count],
  [coin_5_diameter, coin_5_thickness, coin_5_roll_count], [coin_6_diameter, coin_6_thickness, coin_6_roll_count],
  [coin_7_diameter, coin_7_thickness, coin_7_roll_count], [coin_8_diameter, coin_8_thickness, coin_8_roll_count],
  [coin_9_diameter, coin_9_thickness, coin_9_roll_count], [coin_10_diameter, coin_10_thickness, coin_10_roll_count]];

other_coins = [[for (i=other_coins_d_t) if(i[0] > 0) i[0]],
               [for (i=other_coins_d_t) if(i[0] > 0) i[1]],
               [for (i=other_coins_d_t) if(i[0] > 0) i[2]]];

//
// MAIN
//

coins = currency == "usd" ? usd_coins :
        currency == "eur" ? eur_coins :
        currency == "chf" ? chf_coins :
        currency == "cad" ? cad_coins :
        currency == "pen" ? pen_coins :
        currency == "pln" ? pln_coins :
        currency == "sek" ? sek_coins :
        currency == "thb" ? thb_coins : other_coins;

coins_d = coins[0];
coins_thickness = coins[1];
coins_n = coins [2];

enable_box = (part == "all" || part == "all_unassembled" || part == "basebox");
  enable_mesh = (pattern != "no");
enable_top_board = (part == "all" || part == "all_unassembled" || part == "topboard");
enable_tubes = (part == "all" || part == "all_unassembled" || part == "tubes");
enable_tuberack = (part == "all" || part == "all_unassembled" || part == "tuberack");
enable_tuberack_scale = true;
assembled = (part != "all_unassembled");
lay_flat = (part != "all" && part != "all_unassembled");

sorter_min_height = height;
board_thickness = 2.0;
board_left_padding = 2;
board_right_padding = 13;
board_primary_slope = 16;
board_secondary_slope = 15;
horizontal_guard_width = 3;
coin_padding = 0.4;
coin_padding_top_board = 0.25;
nozzle_size = 0.4;
nozzle_size_upbound = 0.41;

tuberack_shorter = 5;
tuberack_front_back_cut = 2;
tuberack_base_thickness = 4.0;
tuberack_back_thinner = 1;
tuberack_scale_depth = 0.4;
tuberack_scale_height = 0.8;

unassembled_top_board_lift = 45;
unassembled_tuberack_lift = 20;
unassembled_tubes_lift = 40;

$fa = 6;  // default: 12
$fs = 1;  // default: 2

coin_count = len(coins_d);
coin_max_index = coin_count - 1;

board_length = (board_left_padding + board_right_padding
                + sum_coins_d()
                + coin_padding * coin_count * 2
                + board_thickness * (coin_count + 3));

board_width = coins_d[0] + coin_padding + board_thickness * 3;

slope_height = tan(board_secondary_slope) * board_width
               + tan(board_primary_slope) * board_length;

sorter_max_height = sorter_min_height + slope_height + board_thickness;
echo("board_length:", board_length);
echo("board_width:", board_width);
echo("sorter_min_height:", sorter_min_height);
echo("sorter_max_height:", sorter_max_height);

main();

module main() {
  top_board_lift = assembled ? 0 : unassembled_top_board_lift;
  tuberack_lift = assembled ? 0 : unassembled_tuberack_lift;
  tubes_lift = assembled ? 0 : unassembled_tubes_lift;
  if (lay_flat) {
    main_impl_flat(top_board_lift, tuberack_lift, tubes_lift);
  } else {
    main_impl(top_board_lift, tuberack_lift, tubes_lift);
  }
}
module main_impl(top_board_lift=0, tuberack_lift=0, tubes_lift=0) {
  if (enable_box) {
    base_box(false);
  }
  if (enable_top_board) {
    translate([0, 0, top_board_lift]) top_board();
  }
  if (enable_tuberack) {
    translate([0, 0, tuberack_lift]) tuberack();
  }
  if (enable_tubes) {
    translate([0, 0, tubes_lift]) tubes();
  }
}
module main_impl_flat(top_board_lift=0, tuberack_lift=0, tubes_lift=0) {
  if (enable_box) {
    rotate([-90, 0, 0]) base_box(false);
  }
  if (enable_top_board) {
    translate([0, 0, top_board_lift])
    untransform_top_board(sorter_min_height)
    top_board();
  }
  if (enable_tuberack) {
    translate([0, 0, tuberack_lift]) tuberack();
  }
    if (enable_tubes) {
    translate([0, 0, tubes_lift]) tubes();
  }
}


//
// BASE BOX
//

// Component: the box.
module base_box() {
  render(convexity=2)
  difference() {
    union() {
      box_empty();
    }
    if (enable_mesh) {
      board_back_hollow(board_thickness * 1.5);
    }
  }

  if (enable_mesh) {
    intersection() {
      board_back_mesh();
      union() {
        board_back_hollow();
        box_back_fill();
      }
    }
  } else {
    box_back_fill();
  }
}

function box_size(fatter=0, thicker=0, altitude=0, fronter=0, taller=0) =
  [board_length + fatter*2 + thicker*2,
   board_width + fatter*2 + thicker*2 + fronter,
   sorter_max_height + fatter*2 + thicker*2 + taller];

module box_move(fatter=0, thicker=0, altitude=0, fronter=0, taller=0) {
  translate([-fatter-thicker,
             -fatter-thicker-fronter,
             altitude-fatter-thicker]) {
    children();
  }
}

module box_empty() {
  cut_top_side() {
    box_empty_tall();
  }
}
module box_empty_tall(fatter=0, thicker=0, altitude=0) {
  difference() {
    box_outer_solid_tall(fatter, thicker, altitude);
    box_inner_solid_tall(fatter, thicker, altitude);
  }
}
module box_outer_solid_tall(fatter=0, thicker=0, altitude=0,
                            fronter=0, taller=0) {
  box_move(fatter, thicker, altitude, fronter, taller) {
    cube(box_size(fatter, thicker, altitude, fronter, taller));
  }
}
module box_inner_solid_tall(fatter=0, thicker=0, altitude=0) {
  box_outer_solid_tall(
      fatter - board_thickness - thicker, thicker, altitude,
      board_thickness + thicker + 0.1,
      board_thickness + thicker + 0.1);
}

module board_back_hollow(thicker=0) {
  xyz = box_size(fatter = -board_thickness - thicker);
  cut_top_side(altitude = -thicker)
  box_move(fatter = -board_thickness - thicker)
  translate([0, xyz[1] + thicker/2, 0]) {
    cube([xyz[0], board_thickness + thicker, xyz[2]]);
  }
}
module box_back_fill(thicker=0) {
  cut_top_side(altitude = -thicker) {
    box_back_fill_tall();
  }
}
module box_back_fill_tall() {
  linear_extrude(height=sorter_max_height, center=false, convexity=2)
  translate([0, coin_padding*2])
  difference() {
    polygon(tuberack_cut_back_complete());
    for (i = [0 : coin_max_index]) {
      coin_hole_plain(i);
    }
  }
}

// Transformation: cut the right, left, back and front side.
module cut_sides(fatter=0, thicker=0) {
  intersection() {
    union() {
      children();
    }
    box_outer_solid_tall(fatter, thicker, taller=sorter_max_height);
  }
}

module cut_top_side(fatter=0, thicker=0, altitude=0) {
  difference() {
    union() {
      children();
    }
    top_side(sorter_min_height + fatter + altitude);
  }
}

//
// MESH
//

module board_back_mesh() {
  diag_len = sqrt(board_length * board_length +
                  sorter_max_height*sorter_max_height);

  if (pattern == "mesh") {
    board_back_mesh_grids(
        nozzle_size_upbound, 15, ceil(diag_len / 15) + 1, 45,
        [board_length / 2, board_width * 0.7, sorter_max_height / 2],
        "y", board_width);

  } else if (pattern == "chncoin") {
    board_back_mesh_ancient_coins(
        nozzle_size_upbound, 18, ceil(diag_len / 18 / 2) + 2,
        [board_length / 2, board_width * 0.7, sorter_max_height / 2],
        "y", board_width);
  }
}

module mesh_extrude(
    center=[0,0,0], normal_direction="z", height=10, convexity=10) {
  translate(center) {
    rotate(normal_direction=="x" ? [0,90,0] :
           normal_direction=="y" ? [-90,0,0] : [0,0,0]) {
      linear_extrude(height, center=true, convexity=convexity) {
        children();
      }
    }
  }
}

module board_back_mesh_grids(
    thickness, gap, count, rotate_angle=0,
    center=[0,0,0], normal_direction="z", height=10) {
  length = (thickness + gap) * (count - 1) + thickness;
  mesh_extrude(center, normal_direction, height, convexity=3)
  rotate([0, 0, rotate_angle])
  translate([-length/2, -length/2]) {
    for (i = [0 : count - 1]) {
      translate([(thickness + gap) * i, 0]) {
        square([thickness, length]);
      }
      translate([0, (thickness + gap) * i]) {
        square([length, thickness]);
      }
    }
  }
}

module board_back_mesh_ancient_coins(
    thickness, radius, count,
    center=[0,0,0], normal_direction="z", height=10) {
  sqrt2 = sqrt(2);
  mesh_extrude(center, normal_direction, height, convexity=3)
  translate([-sqrt2 * radius * (count - 1) / 2,
             -sqrt2 * radius * (count - 1) / 2]) {
    for (i = [0 : count - 1])
    for (j = [0 : count - 1]) {
      translate([sqrt2 * radius * i, sqrt2 * radius * j]) {
        render(convexity=2)
        difference() {
          circle(r=radius + thickness / 2);
          circle(r=radius - thickness / 2);
        }
      }
    }
  }
}

//
// TOP BOARD
//

// Component: the solid board on top.
module top_board() {
  difference() {
    // the board itself
    
    union ()
    {
        cut_sides()
            transform_top_board(sorter_min_height)
                cube([board_length*2, board_width*2, board_thickness]);

        
        difference ()
        {
            transform_top_board(sorter_min_height)
            translate ([0, 0, -10 + board_thickness - 0.01])
                linear_extrude (10)
                    offset (5)
                    scale ([1.05, 1.05, 1])
                    projection (cut = false)
                        cut_sides()
                            transform_top_board(sorter_min_height)
                                cube([board_length*2, board_width*2, board_thickness]);
                            
                        
            cut_sides()
                transform_top_board(sorter_min_height)
                    cube([board_length*2, board_width*2, board_thickness]);
            
            translate ([0, 0, 0.01])
                hull ()
                    base_box (false);
        }
    }
    // holes and cuts
    for (i = [0 : coin_max_index]) {
      coin_hole(i, bigger_r=coin_padding_top_board-coin_padding);
      slope_cut_for_coin(i, bigger_r=coin_padding_top_board-coin_padding);
    }
  }

  vertical_guard();
  horizontal_guard();
}

// Component: the guard on top of the top board.
module vertical_guard() {
  difference() {
    intersection() {
      cube([board_length, board_thickness, sorter_max_height * 2]);
      top_side(sorter_min_height + board_thickness - 0.1);
    }
    top_side(sorter_min_height + board_thickness * 2);
  }
}

// Component: the guard crossing the holes.
module horizontal_guard() {
  // should be similar to top_board()
  cut_sides()
  transform_top_board(sorter_min_height) {
    cube([board_length*2,
          horizontal_guard_width + board_thickness,
          board_thickness]);
  }
}

// Submodule: the upper solid box that is rotated the same as the top board.
module top_side(altitude = 0) {
  // rotate it and raise it
  transform_top_board(altitude) {
    // a big box
    translate([-board_length/2, -board_width/5, 0]) {
      cube([board_length*2, board_width*2, sorter_max_height]);
    }
  }
}

// Transformation: do the rotation.
module transform_top_board(lift_z=0) {
  translate([0, 0, lift_z]) {
    rotate(a=board_secondary_slope, v=[1, 0, tan(board_primary_slope)])
    rotate([0, -board_primary_slope, 0]) {
      children();
    }
  }
}

module untransform_top_board(lift_z=0) {
  rotate([0, board_primary_slope, 0])
  rotate(a=-board_secondary_slope, v=[1, 0, tan(board_primary_slope)]) {
    translate([0, 0, -lift_z]) {
      children();
    }
  }
}


//
// COIN CUT
//

// Submodule: the coin holes.
module coin_hole(n, bigger_r=0) {
  translate([coin_center_x(n), coin_center_y(n), board_thickness+0.1]) {
    cylinder(h = sorter_max_height,
             r = coins_d[n] / 2 + coin_padding + bigger_r);
  }
}

// Submodule: the coin holes, in a plain.
module coin_hole_plain(n) {
  translate([coin_center_x(n), coin_center_y(n)]) {
    circle(coins_d[n] / 2 + coin_padding);
  }
}

// Submodule: the solid tube, in a plain.
module coin_hole_plain_thicker(n) {
  translate([coin_center_x(n), coin_center_y(n)]) {
    circle(coins_d[n] / 2 + coin_padding + board_thickness);
  }
}

// Submodule: the slope cuts.
module slope_cut_for_coin(n, bigger_r=0) {
  render(convexity=2) {
    intersection() {
      // the (too big) actual slope cut
      transform_top_board(sorter_min_height) {
        a = board_primary_slope;
        th = board_thickness;
        cut_length = coins_d[n] * 1.5;
        move_x = coin_left_x(n+1) - cut_length;
        cut_length_rotated = cut_length / cos(a);
        move_x_rotated = move_x / cos(a) + th * tan(a) + 1;

        translate([move_x_rotated, 0, 0]) {  // move rightwards
          // make a triangle-box
          rotate([0, -atan(th / cut_length_rotated), 0]) {
            cube([cut_length_rotated * 2, board_width, th * 2]);
          }
        }  // translate, move rightwards
      }  // transform_top_board

      // limiting box
      translate([coin_center_x(n), 1, 0]) {
        cube([coins_d[0],
              coin_top_y(n) - 1 + bigger_r,
              sorter_max_height]);
      }
    }
  }
}

//
// COIN TUBE RACK
//

// Component: the tuberack.
module tuberack() {
  linear_extrude(height=tuberack_base_thickness+0.01, center=false, convexity=2) {
    tuberack_base_2();
  }
  difference() {
    translate([0, 0, tuberack_base_thickness]) {

      tuberack_body_3();
    }

    if (enable_tuberack_scale) {
      translate([0, 0, tuberack_base_thickness]) {
        tuberack_scales();
      }
    }
    translate([0, -1, sorter_min_height - tuberack_shorter]) {
      rotate([0, -board_primary_slope, 0]) {
        cube([board_length * 2, board_width * 2, sorter_max_height]);
      }
    }
  }
}

// Submodule: the "last coins" and the tube connecting part.
module tuberack_base_2() {
  polygon(concat(
      [[tuberack_cut_x_x(0)[0], tuberack_front_cut_y()],
       [tuberack_left_x(), tuberack_front_y()],
       [tuberack_left_x()+tuberack_back_thinner, tuberack_back_y()]],
      tuberack_cut_back_xys(),
      [[tuberack_right_x()-tuberack_back_thinner, tuberack_back_y()],
       [tuberack_right_x(), tuberack_front_y()],
       [tuberack_cut_x_x(coin_max_index)[1], tuberack_front_cut_y()]]));
}

// Submodule: the tube connecting part subtracted by coin holes.
module tuberack_base_3() {
  difference() {
    tuberack_base_2();
    for (i = [0 : coin_max_index]) {
      offset (0.75)
      coin_hole_plain(i);
    }
  }
}

module tuberack_body_3() {
  linear_extrude(height=sorter_max_height, center=false, convexity=2) {
    tuberack_base_3();
  }
}

module tuberack_scales() {
  for (i = [0 : coin_max_index]) {
    render(convexity=2) {
      interval = (coins_thickness[i] > 1.5 ? 1 : 2);
      for (j = [interval : interval : sorter_max_height/coins_thickness[i]]) {
        translate([coin_center_x(i),
                   tuberack_front_cut_y() - 1,
                   j * coins_thickness[i] - tuberack_scale_height / 2]) {
          length_offset = (j%10==0 ? 3 : j%2==0 ? 1 : -0.5);
          cube([tuberack_cut_half_width(i) + length_offset,
                tuberack_scale_depth + 1,
                tuberack_scale_height]);
        }
      }
    }
  }
}

//
// COIN TUBES
//

// Component: the tubes
module tubes() {
    translate([0, 0, tuberack_base_thickness])
    for (i = [0 : coin_max_index])
        color ("green")
        coin_tube (i); 
}

// Submodule: the coin tube
module coin_tube (n) {
  translate([coin_center_x(n), coin_center_y(n)]) {
    make_coin_tube (coins_d[n] + 2 * coin_padding, coins_thickness [n], coins_n [n]);
  }
}

module make_coin_tube (d_coin, h_coin, n_coins) {
    difference () {
        cylinder (d = 1 + d_coin, h = 0.5 + (n_coins + 0.5) * h_coin);
        
        translate ([0, 0, 0.5])
            cylinder (d = d_coin, h = 0.5 + (n_coins + 0.5) * h_coin + 0.01);
    }
}


//
// FUNCTIONS
//

// Accumulated coins' diameters.
function sum_coins_d(first_n=coin_count) =
  first_n <= 0 ? 0 :
  coins_d[first_n - 1] + sum_coins_d(first_n - 1);

// Coin positions.
function coin_center_x(n) =
  coin_left_x(n) + coins_d[n] / 2;

function coin_left_x(n) =
  board_left_padding + sum_coins_d(n)
  + coin_padding * (2 * n + 1)
  + board_thickness * (n + 2);

function coin_center_y(n) =
  coins_d[n] / 2 + coin_padding + board_thickness;

function coin_top_y(n) =
  coin_center_y(n) + coins_d[n] / 2 + coin_padding;

function coin_bottom_y(n) =
  coin_center_y(n) - coins_d[n] / 2 - coin_padding;

// Tube cuts.
function tuberack_left_x() = board_thickness + coin_padding;
function tuberack_right_x() = board_length - board_thickness - coin_padding;
function tuberack_front_y() = coin_padding;
function tuberack_back_y() = board_width - board_thickness - coin_padding;
function tuberack_front_cut_y() = coin_bottom_y(0) + tuberack_front_back_cut;

function tuberack_cut_half_width(n) =
  sqrt(pow(coins_d[n] / 2 + coin_padding + board_thickness, 2)
       - pow(coins_d[n] / 2 + coin_padding - tuberack_front_back_cut, 2));

function tuberack_cut_x_x(n) =
  [coin_center_x(n) - tuberack_cut_half_width(n),
   coin_center_x(n) + tuberack_cut_half_width(n)];

function tuberack_cut_back_xy_xy(n) =
  [[coin_center_x(n) - tuberack_cut_half_width(n),
    coin_top_y(n) - tuberack_front_back_cut],
   [coin_center_x(n) + tuberack_cut_half_width(n),
    coin_top_y(n) - tuberack_front_back_cut]];

function tuberack_cut_back_xys(first_n=coin_count) =
  first_n <= 0 ? [] :
  concat(tuberack_cut_back_xys(first_n - 1),
         tuberack_cut_back_xy_xy(first_n - 1));

function tuberack_cut_back_complete() =
  concat([[tuberack_left_x()+tuberack_back_thinner, tuberack_back_y()]],
         tuberack_cut_back_xys(),
         [[tuberack_right_x()-tuberack_back_thinner, tuberack_back_y()]]);

// Tube connections.
function tuberack_height_at(x) =
  sorter_min_height - tuberack_shorter - tuberack_base_thickness
  + x * tan(board_primary_slope);

function tuberack_x_height_at(x, z_delta=0) =
  [x, tuberack_height_at(x) + z_delta];

function tuberack_connection_height(n) =
  sorter_min_height - tuberack_shorter - tuberack_base_thickness + (
    n == 0 ? 0:
    coin_center_x(n-1) * tan(board_primary_slope));