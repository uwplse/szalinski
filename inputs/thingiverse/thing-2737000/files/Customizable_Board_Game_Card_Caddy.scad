// All measurements are in millimeters.

/* [Parameters] */

// The width of a card. We'll add buffer space later, so measure this as accurately as possible.
card_width = 44;

// The height of a card. We'll add buffer space later, so measure this as accurately as possible.
card_height = 68;

// The number of card wells.
number_of_wells = 3; // [1:6]

// The depth of the wells. 25 cards fit nicely per 10mm.
well_depth = 10;

/* [Tweaks] */

// The width of the border material around the edge of the caddy.
caddy_border_width = 5;

// The empty buffer space to leave around a card in a well.
card_well_buffer_spacing = 1; // [1.0: loose, 0.5: tight]

// The space between adjacent cards. (I.e., the width of the divider between cells plus double
// the card well buffer spacing.) The default value calculated here will result in a divider
// width that's equal to the outside caddy_border_width width. If this caddy is to be placed
// over existing markings on a board, it can be overridden with an explicit value. Must be a
// minimum of 1 + (card_well_buffer_spacing * 2).
card_padding = caddy_border_width + (card_well_buffer_spacing * 2);

// The well shelf is the edge around the bottom of the well that keeps the cards from falling out. This parameter controls its depth.
well_shelf_depth = 1;

// This parameter controls the well shelf width. Set it to a really big value if you want a solid shelf.
well_shelf_width = 3;

// The size of the finger cutout.
filger_cutout_size = 15;

// Used to finely tweak the finger cutout front/back location.
filger_cutout_y_tweak = 0;

// Used to finely tweak the finger cutout up/down location.
filger_cutout_z_tweak = well_shelf_depth;

// The height of the card wells.
card_well_height = card_height + (card_well_buffer_spacing * 2);

// The width of the card wells.
card_well_width = card_width + (card_well_buffer_spacing * 2);

// The space between card wells.
card_well_padding = card_padding - (card_well_buffer_spacing * 2);

// Resolution.
$fn = 50 * 1;

// preview[view:north east, tilt:top diagonal]

difference() {

  // base brick
  cube([
    (card_well_width * number_of_wells) + (card_well_padding * (number_of_wells - 1)) + (caddy_border_width * 2),
    card_well_height + (caddy_border_width * 2) + well_depth,
    well_depth + well_shelf_depth
  ]);

  for (i = [0 : number_of_wells - 1]) {

    x = (i * (card_well_width + card_well_padding)) + caddy_border_width;
    y = caddy_border_width + well_depth;

    // card well
    translate([x, y, well_shelf_depth]) {
      cube([card_well_width, card_well_height, well_depth + 1]);
    }

    // card well shelf
    translate([x + well_shelf_width, y + well_shelf_width, -well_shelf_width]) {
      cube([
        card_well_width - (2 * well_shelf_width),
        card_well_height - (2 * well_shelf_width),
        well_depth + well_shelf_depth + 1
      ]);
    }

    // bevel
    translate([x, y, well_shelf_depth]) {
      rotate([45, 0, 0]) {
        cube([card_well_width, well_depth, well_depth * 2]);
      }
    }

    // finger cutout
    translate([
      x + (card_well_width / 2),
      filger_cutout_size + filger_cutout_y_tweak,
      filger_cutout_size + filger_cutout_z_tweak
    ]) {
      sphere(filger_cutout_size);
    }
    
  }

}