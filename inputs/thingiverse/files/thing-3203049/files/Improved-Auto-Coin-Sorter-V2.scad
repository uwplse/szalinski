/* Improved Auto Coin Sorter V2                     */
/* https://www.thingiverse.com/thing:3203049        */
/* by Bikecyclist                                   */
/* https://www.thingiverse.com/Bikecyclist          */
/*                                                  */
/* Remixed from Auto Coin Sorter for All Currencies */
/* https://www.thingiverse.com/thing:499177         */
/* by Youngcat                                      */
/* https://www.thingiverse.com/youngcat/about       */


/* [General] */

// Choose a currency you use.
currency = "eur"; // [usd:USD - US dollar, eur:EUR - Euro, chf:CHF - Swiss franc, cad:CAD - Canadian dollar, sek:SEK- Swedish Krona, thb:THB - Thai Baht, other:Other (See "Slot customization" tab above)]

// How tall is the the shortest tube? In millimeters:
height = 50; // [10:150]

// Choose a pattern for the back side.
pattern = "mesh"; // [no:Solid without pattern, chncoin:Chinese ancient coin pattern, mesh:Mesh pattern]

// Would you like Tom-and-Jerry pictures on the left side and right side? (Not fully supported; may only work with OpenSCAD version 2014.09 ~ 2014.12.)
image = 0; //// [1:Yes please, 0:No thanks]

// Which one would you like to see?
part = "all_unassembled"; // [all:All these three parts assembled together,all_unassembled:All these three parts unassembled,basebox:Base box only,topboard:Top board only,tubes:Tubes only]

/* [Slot customization] */

// In this tab you're able to customize your coins. Here below, you may have up to 10 slots, each for one kind of coin. For each slot you're going to define it's diameter and thickness. Note that the coins should be ordered from biggest to smallest in diameter. You may want to collect information about the diameters and thicknesses of your coins from wikipedia before you continue.
understand = 1; // [1:Yes I understand,0:Yes I said understand]

// in millimeters. For the first (and biggest) coin.
coin_1_diameter = 30.61;
// in millimeters.
coin_1_thickness = 2.15;
// The second coin. Remember: this 2nd coin should always be smaller than the 1st coin.
coin_2_diameter = 26.50;
coin_2_thickness = 2.00;
// The 3rd coin.
coin_3_diameter = 24.26;
coin_3_thickness = 1.75;
// 4th coin.
coin_4_diameter = 21.21;
coin_4_thickness = 1.95;
// 5th coin. If you don't need more coins, simply set the remaining to 0.
coin_5_diameter = 0;
coin_5_thickness = 0;
// 6th coin.
coin_6_diameter = 0;
coin_6_thickness = 0;
// 7th coin.
coin_7_diameter = 0;
coin_7_thickness = 0;
// 8th coin.
coin_8_diameter = 0;
coin_8_thickness = 0;
// 9th coin.
coin_9_diameter = 0;
coin_9_thickness = 0;
// 10th coin.
coin_10_diameter = 0;
coin_10_thickness = 0;

/* [Hidden] */

usd_coins = [[30.61, 26.50, 24.26, 21.21, 19.05, 17.91],
             [ 2.15,  2.00,  1.75,  1.95,  1.55,  1.35]];
eur_coins = [[25.75, 24.25, 23.25, 22.25, 21.25, 19.75, 18.75, 16.25],
             [ 2.20,  2.38,  2.33,  2.14,  1.67,  1.93,  1.67,  1.67]];
chf_coins = [[31.45, 27.40, 23.20, 21.05, 19.15, 18.20, 17.15],
             [ 2.35,  2.15,  1.15,  1.65,  1.45,  1.25,  1.25]];
cad_coins = [[28.00, 27.13, 26.50, 23.88, 21.20, 19.05, 18.03],
             [ 1.80,  1.95,  1.75,  1.58,  1.76,  1.45,  1.22]];
sek_coins = [[23.75, 22.50, 20.50, 19.50],
             [ 1.97,  1.79,  1.79,  2.90]];             
thb_coins = [[26.00, 24.05, 22.05, 20.01],
             [ 2.16,  2.13,  1.48,  1.38]];

other_coins_d_t = [
  [coin_1_diameter, coin_1_thickness], [coin_2_diameter, coin_2_thickness],
  [coin_3_diameter, coin_3_thickness], [coin_4_diameter, coin_4_thickness],
  [coin_5_diameter, coin_5_thickness], [coin_6_diameter, coin_6_thickness],
  [coin_7_diameter, coin_7_thickness], [coin_8_diameter, coin_8_thickness],
  [coin_9_diameter, coin_9_thickness], [coin_10_diameter, coin_10_thickness]];

other_coins = [[for (i=other_coins_d_t) if(i[0] > 0) i[0]],
               [for (i=other_coins_d_t) if(i[0] > 0) i[1]]];


//  .88b  d88.   .d8b.   d888888b  d8b   db
//  88'YbdP`88  d8' `8b    `88'    888o  88
//  88  88  88  88ooo88     88     88V8o 88
//  88  88  88  88~~~88     88     88 V8o88
//  88  88  88  88   88    .88.    88  V888
//  YP  YP  YP  YP   YP  Y888888P  VP   V8P

coins = currency == "usd" ? usd_coins :
        currency == "eur" ? eur_coins :
        currency == "chf" ? chf_coins :
        currency == "cad" ? cad_coins :
        currency == "sek" ? sek_coins :
        currency == "thb" ? thb_coins : other_coins;

coins_d = coins[0];
coins_thickness = coins[1];

enable_box = (part == "all" || part == "all_unassembled" || part == "basebox");
  enable_dovetail = true;
  enable_box_emptier = false;
  enable_mesh = (pattern != "no");
  enable_image = (image == 1);
enable_top_board = (part == "all" || part == "all_unassembled" || part == "topboard");
enable_tubes = (part == "all" || part == "all_unassembled" || part == "tubes");
  enable_tube_scale = true;
  enable_tube_emptier = false;
  inspect_tube_inside = false;
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

dovetail_count = 4;
dovetail_back_max_width = 10;
dovetail_back_min_width = 9;
dovetail_side_max_width = 10;
dovetail_side_min_width = 9;
dovetail_femail_margin = 0.5;

image_left_size = 25;
image_right_size = 30;
image_dir = "";

tubes_shorter = 5;
tubes_front_back_cut = 2;
tubes_base_thickness = 4.0;
tubes_back_thinner = 1;
tubes_scale_depth = 0.4;
tubes_scale_height = 0.8;

unassembled_top_board_lift = 25;
unassembled_tubes_lift = 20;

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
  tubes_lift = assembled ? 0 : unassembled_tubes_lift;
  if (lay_flat) {
    main_impl_flat(top_board_lift, tubes_lift);
  } else {
    main_impl(top_board_lift, tubes_lift);
  }
}
module main_impl(top_board_lift=0, tubes_lift=0) {
  if (enable_box) {
    base_box(false);
  }
  if (enable_top_board) {
    translate([0, 0, top_board_lift]) top_board();
  }
  if (enable_tubes) {
    translate([0, 0, tubes_lift]) tubes();
  }
}
module main_impl_flat(top_board_lift=0, tubes_lift=0) {
  if (enable_box) {
    rotate([-90, 0, 0]) base_box(false);
  }
  if (enable_top_board) {
    translate([0, 0, top_board_lift])
    untransform_top_board(sorter_min_height)
    top_board();
  }
  if (enable_tubes) {
    translate([0, 0, tubes_lift]) tubes();
  }
}


//  d8888b.  .d8b.  .d8888. d88888b      d8888b.  .d88b.  db    db
//  88  `8D d8' `8b 88'  YP 88'          88  `8D .8P  Y8. `8b  d8'
//  88oooY' 88ooo88 `8bo.   88ooooo      88oooY' 88    88  `8bd8'
//  88~~~b. 88~~~88   `Y8b. 88~~~~~      88~~~b. 88    88  .dPYb.
//  88   8D 88   88 db   8D 88.          88   8D `8b  d8' .8P  Y8.
//  Y8888P' YP   YP `8888Y' Y88888P      Y8888P'  `Y88P'  YP    YP

// Component: the box.
module base_box(show_dovetails = true) {
  render(convexity=2)
  difference() {
    union() {
      box_empty();
    }
    if (enable_image) {
      image_left_subtraction();
      image_right_subtraction();
    }
    if (enable_mesh) {
      board_back_hollow(board_thickness * 1.5);
    }
    if (enable_box_emptier) {
      board_left_hollow(fatter=board_thickness * 1.5,
                        thicker=-nozzle_size_upbound * 2);
      board_right_hollow(fatter=board_thickness * 1.5,
                         thicker=-nozzle_size_upbound * 2);
      board_bottom_hollow(fatter=board_thickness * 2,
                          thicker=-nozzle_size_upbound * 2);
    }
  }

  if (enable_dovetail && show_dovetails) {
    base_box_dovetails();
  }

  if (enable_image) {
    image_left();
    image_right();
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
    polygon(tube_cut_back_complete());
    for (i = [0 : coin_max_index]) {
      coin_hole_plain(i);
    }
  }
}

module board_left_hollow(fatter=0, thicker=0) {
  xyz = box_size(fatter = -board_thickness - fatter);
  cut_top_side(altitude = -fatter)
  box_move(fatter = -board_thickness - fatter)
  translate([-board_thickness - fatter - thicker/2, 0, 0]) {
    cube([board_thickness + thicker, xyz[1], xyz[2]]);
  }
}

module board_right_hollow(fatter=0, thicker=0) {
  xyz = box_size(fatter = -board_thickness - fatter);
  cut_top_side(altitude = -fatter)
  box_move(fatter = -board_thickness - fatter)
  translate([xyz[0] + fatter - thicker/2, 0, 0]) {
    cube([board_thickness + thicker, xyz[1], xyz[2]]);
  }
}

module board_bottom_hollow(fatter=0, thicker=0) {
  xyz = box_size(fatter = -board_thickness - fatter);
  box_move(fatter = -board_thickness - fatter)
  translate([0, 0, -board_thickness - fatter - thicker/2]) {
    cube([xyz[0], xyz[1], board_thickness + thicker]);
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


//  d888888b .88b  d88.  d888b        dD  .88b  d88. d88888b .d8888. db   db
//    `88'   88'YbdP`88 88' Y8b      d8'  88'YbdP`88 88'     88'  YP 88   88
//     88    88  88  88 88          d8'   88  88  88 88ooooo `8bo.   88ooo88
//     88    88  88  88 88  ooo    d8'    88  88  88 88~~~~~   `Y8b. 88~~~88
//    .88.   88  88  88 88. ~8~   d8'     88  88  88 88.     db   8D 88   88
//  Y888888P YP  YP  YP  Y888P   C8'      YP  YP  YP Y88888P `8888Y' YP   YP

module image_left() {
  translate([0, (board_width - image_left_size) / 2,
             sorter_min_height * 0.4 - image_left_size / 2]) {
    translate([1, image_left_size, image_left_size])
    rotate([0, -90, 0])
    rotate([0, 0, -90])
    mirror([0, 1, 0])
    resize([image_left_size, image_left_size, 1]) {
      surface(file = str(image_dir, "TomHead_gray.1.dat"), convexity = 2);
    }

    translate([0, image_left_size-0.1, 0]) {
      cube([1, (board_width - image_left_size) / 2 - board_thickness,
            image_left_size]);
    }
  }
}

module image_left_subtraction() {
  translate([0,
             (board_width - image_left_size) / 2 + 0.01,
             sorter_min_height * 0.4 - image_left_size / 2 + 0.01]) {
    cube([0.99, image_left_size - 0.02, image_left_size - 0.02]);
  }
}

module image_right() {
  translate([board_length - 1,
             (board_width - image_right_size) / 2,
             sorter_max_height * 0.37 - image_right_size / 2]) {
    translate([0, 0, image_right_size])
    rotate([0, 90, 0])
    rotate([0, 0, 90])
    mirror([0, 1, 0])
    resize([image_right_size, image_right_size, 1]) {
      surface(file = str(image_dir, "Jerry_bw.dat"), convexity = 2);
    }

    translate([0, image_right_size-0.1, 0]) {
      cube([1, (board_width - image_right_size) / 2 - board_thickness,
            image_right_size]);
    }
  }
}

module image_right_subtraction() {
  translate([board_length - 0.99,
             (board_width - image_right_size) / 2 + 0.01,
             sorter_max_height * 0.37 - image_right_size / 2 + 0.01]) {
    cube([1, image_right_size - 0.02, image_right_size - 0.02]);
  }
}

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


//  d888888b  .d88b.  d8888b.      d8888b.  .d88b.   .d8b.  d8888b. d8888b.
//  `~~88~~' .8P  Y8. 88  `8D      88  `8D .8P  Y8. d8' `8b 88  `8D 88  `8D
//     88    88    88 88oodD'      88oooY' 88    88 88ooo88 88oobY' 88   88
//     88    88    88 88~~~        88~~~b. 88    88 88~~~88 88`8b   88   88
//     88    `8b  d8' 88           88   8D `8b  d8' 88   88 88 `88. 88  .8D
//     YP     `Y88P'  88           Y8888P'  `Y88P'  YP   YP 88   YD Y8888D'

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
    // the femail dovetails
    if (enable_dovetail && false) {
      top_board_dovetails();
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


//  d8888b.  .d88b.  db    db d88888b d888888b  .d8b.  d888888b db
//  88  `8D .8P  Y8. 88    88 88'     `~~88~~' d8' `8b   `88'   88
//  88   88 88    88 Y8    8P 88ooooo    88    88ooo88    88    88
//  88   88 88    88 `8b  d8' 88~~~~~    88    88~~~88    88    88
//  88  .8D `8b  d8'  `8bd8'  88.        88    88   88   .88.   88booo.
//  Y8888D'  `Y88P'     YP    Y88888P    YP    YP   YP Y888888P Y88888P

// Component: male dovetails on the base box
module base_box_dovetails() {
  render()
  intersection() {
    all_male_dovetails_too_long();
    box_empty_tall();
  }
}

// Component: female dovetails on the top board
module top_board_dovetails() {
  render()
  intersection() {
    all_female_dovetails_too_long();
    box_empty_tall(thicker=dovetail_femail_margin);
  }
}

// Submodule: a male dovetail.
module my_male_dovetail(
    rotate_x, rotate_y, rotate_z, thickness, max_width, min_width) {
  rotate([rotate_x, rotate_y, rotate_z]) {
    translate([0, -0.01, 0]) {
      male_dovetail(
          max_width=max_width, min_width=min_width,
          depth=board_thickness+0.01, height=thickness,
          cutout_width=0, cutout_depth=0);
    }
  }
}

// Submodule: a female dovetail.
module my_female_dovetail(
    rotate_x, rotate_y, rotate_z, thickness, max_width, min_width) {
  rotate([rotate_x, rotate_y, rotate_z]) {
    translate([0, -0.01, 0]) {
      female_dovetail_negative(
          max_width=max_width, min_width=min_width,
          depth=board_thickness+0.02, height=thickness,
          clearance=dovetail_femail_margin);
    }
  }
}

// Submodule: all the too-long male dovetail on the base box
module all_male_dovetails_too_long() {
  transform_top_board(sorter_min_height) {
    translate([0, board_width / 2, 0]) {
      my_male_dovetail(90, 0, 90, board_length * 2,
                       dovetail_side_max_width, dovetail_side_min_width);
    }
    for (i = [1 : dovetail_count]) {
      translate([
          board_length * (i-0.5) / dovetail_count / cos(board_primary_slope),
          board_width + board_thickness,
          0]) {
        my_male_dovetail(90, 0, 0, board_thickness * 2,
                         dovetail_back_max_width, dovetail_back_min_width);
      }
    }
  }
}

// Submodule: all the too-long female dovetail on the top board
module all_female_dovetails_too_long() {
  transform_top_board(sorter_min_height) {
    translate([0, board_width / 2, 0]) {
      my_female_dovetail(90, 0, 90, board_length * 2,
                         dovetail_side_max_width, dovetail_side_min_width);
    }
    for (i = [1 : dovetail_count]) {
      translate([
          board_length * (i-0.5) / dovetail_count / cos(board_primary_slope),
          board_width + board_thickness * 2,
          0]) {
        my_female_dovetail(90, 0, 0, board_thickness * 4,
                           dovetail_back_max_width, dovetail_back_min_width);
      }
    }
  }
}


//   .o88b.  .d88b.  d888888b d8b   db       .o88b. db    db d888888b
//  d8P  Y8 .8P  Y8.   `88'   888o  88      d8P  Y8 88    88 `~~88~~'
//  8P      88    88    88    88V8o 88      8P      88    88    88
//  8b      88    88    88    88 V8o88      8b      88    88    88
//  Y8b  d8 `8b  d8'   .88.   88  V888      Y8b  d8 88b  d88    88
//   `Y88P'  `Y88P'  Y888888P VP   V8P       `Y88P' ~Y8888P'    YP

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

//   .o88b.  .d88b.  d888888b d8b   db      d888888b db    db d8888b. d88888b
//  d8P  Y8 .8P  Y8.   `88'   888o  88      `~~88~~' 88    88 88  `8D 88'
//  8P      88    88    88    88V8o 88         88    88    88 88oooY' 88ooooo
//  8b      88    88    88    88 V8o88         88    88    88 88~~~b. 88~~~~~
//  Y8b  d8 `8b  d8'   .88.   88  V888         88    88b  d88 88   8D 88.
//   `Y88P'  `Y88P'  Y888888P VP   V8P         YP    ~Y8888P' Y8888P' Y88888P

// Component: the tubes.
module tubes() {
  linear_extrude(height=tubes_base_thickness+0.01, center=false, convexity=2) {
    tube_base_2();
  }
  difference() {
    translate([0, 0, tubes_base_thickness]) {

      if (enable_tube_emptier) {
        intersection() {
          tube_body_3();
          tube_stronger();
        }

        if (!inspect_tube_inside) {
          tube_body_4();
          if (enable_tube_scale) {
            intersection() {
              tube_body_3();
              tube_scale_replenishment();
            }
          }
        }

      } else {  // !enable_tube_emptier
        tube_body_3();
      }
    }

    if (enable_tube_scale) {
      translate([0, 0, tubes_base_thickness]) {
        tube_scales();
      }
    }
    translate([0, -1, sorter_min_height - tubes_shorter]) {
      rotate([0, -board_primary_slope, 0]) {
        cube([board_length * 2, board_width * 2, sorter_max_height]);
      }
    }
  }
}

// Submodule: the "last coins" and the tube connecting part.
module tube_base_2() {
  polygon(concat(
      [[tube_cut_x_x(0)[0], tube_front_cut_y()],
       [tube_left_x(), tube_front_y()],
       [tube_left_x()+tubes_back_thinner, tube_back_y()]],
      tube_cut_back_xys(),
      [[tube_right_x()-tubes_back_thinner, tube_back_y()],
       [tube_right_x(), tube_front_y()],
       [tube_cut_x_x(coin_max_index)[1], tube_front_cut_y()]]));
}

// Submodule: the tube connecting part subtracted by coin holes.
module tube_base_3() {
  difference() {
    tube_base_2();
    for (i = [0 : coin_max_index]) {
      coin_hole_plain(i);
    }
  }
}

// Submodule: the empty tube_base_3.
module tube_base_4() {
  difference() {
    tube_base_3();
    offset(delta = -nozzle_size_upbound) {
      tube_base_3();
    }
  }
}

module tube_body_3() {
  linear_extrude(height=sorter_max_height, center=false, convexity=2) {
    tube_base_3();
  }
}

module tube_body_4() {
  linear_extrude(height=sorter_max_height, center=false, convexity=2) {
    tube_base_4();
  }
}

module tube_stronger() {
  for (i = [0 : coin_max_index]) {
    x = coin_center_x(i);
    r = coins_d[i] / 2 + coin_padding;

    translate([x, coin_center_y(i), 0]) {
      cylinder(h = tube_height_at(x) * 0.33,
               r1 = r + board_thickness * 0.7,
               r2 = r + nozzle_size);
    }

    translate([x, coin_center_y(i), tube_height_at(x) * 0.67]) {
      cylinder(h = tube_height_at(x) * 0.4,
               r2 = r + board_thickness * 0.7,
               r1 = r + nozzle_size);
    }
  }

  translate([0, board_width, 0])
  rotate([90, 0, 0]) {
    th = board_thickness;

    linear_extrude(height=board_width, convexity=2) {
      polygon([
          [0, -0.1],
          [0, tube_connection_height(0) * 0.55],
          [coin_left_x(0) - th/2, th],
          [coin_left_x(coin_max_index) - th/2, th],
          [board_length - th*3, th],
          [board_length, tube_connection_height(coin_max_index) * 0.55],
          [board_length, -0.1],
      ]);
    }

    linear_extrude(height=board_width, convexity=2) {
      polygon([
          tube_x_height_at(0, 0.1),
          [0, tube_connection_height(0) * 0.45 - th],
          tube_x_height_at(coin_left_x(0) - th/2, -th),
          tube_x_height_at(coin_left_x(coin_max_index) - th/2, -th),
          tube_x_height_at(board_length - th*3, -th),
          [board_length, tube_connection_height(coin_max_index) * 0.50 - th],
          tube_x_height_at(board_length, 0.1),
      ]);
    }
  }
}

module tube_scales() {
  for (i = [0 : coin_max_index]) {
    render(convexity=2) {
      interval = (coins_thickness[i] > 1.5 ? 1 : 2);
      for (j = [interval : interval : sorter_max_height/coins_thickness[i]]) {
        translate([coin_center_x(i),
                   tube_front_cut_y() - 1,
                   j * coins_thickness[i] - tubes_scale_height / 2]) {
          length_offset = (j%10==0 ? 3 : j%2==0 ? 1 : -0.5);
          cube([tube_cut_half_width(i) + length_offset,
                tubes_scale_depth + 1,
                tubes_scale_height]);
        }
      }
    }
  }
}

module tube_scale_replenishment() {
  for (i = [0 : coin_max_index]) {
    translate([coin_center_x(i), tube_front_cut_y() - 1, 0]) {
      cube([tube_cut_half_width(i) + 3 + nozzle_size,
            tubes_scale_depth + 1 + nozzle_size,
            sorter_max_height]);
    }
  }
}


//  d88888b  db    db  d8b   db   .o88b.  .d8888.
//  88'      88    88  888o  88  d8P  Y8  88'  YP
//  88ooo    88    88  88V8o 88  8P       `8bo.
//  88~~~    88    88  88 V8o88  8b         `Y8b.
//  88       88b  d88  88  V888  Y8b  d8  db   8D
//  YP       ~Y8888P'  VP   V8P   `Y88P'  `8888Y'

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
function tube_left_x() = board_thickness + coin_padding;
function tube_right_x() = board_length - board_thickness - coin_padding;
function tube_front_y() = coin_padding;
function tube_back_y() = board_width - board_thickness - coin_padding;
function tube_front_cut_y() = coin_bottom_y(0) + tubes_front_back_cut;

function tube_cut_half_width(n) =
  sqrt(pow(coins_d[n] / 2 + coin_padding + board_thickness, 2)
       - pow(coins_d[n] / 2 + coin_padding - tubes_front_back_cut, 2));

function tube_cut_x_x(n) =
  [coin_center_x(n) - tube_cut_half_width(n),
   coin_center_x(n) + tube_cut_half_width(n)];

function tube_cut_back_xy_xy(n) =
  [[coin_center_x(n) - tube_cut_half_width(n),
    coin_top_y(n) - tubes_front_back_cut],
   [coin_center_x(n) + tube_cut_half_width(n),
    coin_top_y(n) - tubes_front_back_cut]];

function tube_cut_back_xys(first_n=coin_count) =
  first_n <= 0 ? [] :
  concat(tube_cut_back_xys(first_n - 1),
         tube_cut_back_xy_xy(first_n - 1));

function tube_cut_back_complete() =
  concat([[tube_left_x()+tubes_back_thinner, tube_back_y()]],
         tube_cut_back_xys(),
         [[tube_right_x()-tubes_back_thinner, tube_back_y()]]);

// Tube connections.
function tube_height_at(x) =
  sorter_min_height - tubes_shorter - tubes_base_thickness
  + x * tan(board_primary_slope);

function tube_x_height_at(x, z_delta=0) =
  [x, tube_height_at(x) + z_delta];

function tube_connection_height(n) =
  sorter_min_height - tubes_shorter - tubes_base_thickness + (
    n == 0 ? 0:
    coin_center_x(n-1) * tan(board_primary_slope));


// From: https://github.com/hugokernel/OpenSCAD_Dovetail.git
//
//  d8888b.  .d88b.  db    db d88888b d888888b  .d8b.  d888888b db
//  88  `8D .8P  Y8. 88    88 88'     `~~88~~' d8' `8b   `88'   88
//  88   88 88    88 Y8    8P 88ooooo    88    88ooo88    88    88
//  88   88 88    88 `8b  d8' 88~~~~~    88    88~~~88    88    88
//  88  .8D `8b  d8'  `8bd8'  88.        88    88   88   .88.   88booo.
//  Y8888D'  `Y88P'     YP    Y88888P    YP    YP   YP Y888888P Y88888P

module female_dovetail_negative(max_width=11, min_width=5, depth=5, height=30, clearance=0.25) {
  union() {
    translate([0,-0.001,-0.05])
      dovetail_3d(max_width+clearance,min_width+clearance,depth,height+0.1);
      translate([-(max_width+clearance)/2, depth-0.002,-0.5])
        cube([max_width+clearance,clearance/2,height+1]);
  }
}

module female_dovetail(max_width=11, min_width=5, depth=5, height=30, block_width=15, block_depth=9, clearance=0.25) {
    difference() {
      translate([-block_width/2,0,0]) cube([block_width, block_depth, height]);
      female_dovetail_negative(max_width, min_width, depth, height, clearance);
    }
}

module male_dovetail(max_width=11, min_width=5, depth=5, height=30, cutout_width=5, cutout_depth=3.5) {
  difference() {
    dovetail_3d(max_width,min_width,depth,height);
    translate([0.001,depth+0.001,-0.05])
      dovetail_cutout(cutout_width, cutout_depth, height+0.1);
  }
}

module dovetail_3d(max_width=11, min_width=5, depth=5, height=30) {
  linear_extrude(height=height, convexity=2)
    dovetail_2d(max_width,min_width,depth);
}

module dovetail_2d(max_width=11, min_width=5, depth=5) {
  angle=atan((max_width/2-min_width/2)/depth);
  //echo("angle: ", angle);
  polygon(paths=[[0,1,2,3]], points=[[-min_width/2,0], [-max_width/2,depth], [max_width/2, depth], [min_width/2,0]]);
}

module dovetail_cutout(width=5, depth=4, height=30) {
  translate([0,-depth+width/2,0])
    union() {
      translate([-width/2,0,0])
        cube([width,depth-width/2,height]);
      difference() {
        cylinder(r=width/2, h=height, $fs=0.25);
        translate([-width/2-0.05,0.05,-0.05]) cube([width+0.1,width+0.1,height+0.1]);
      }
    }
}

// http://patorjk.com/software/taag/#p=display&c=c%2B%2B&f=Basic&t=abc
