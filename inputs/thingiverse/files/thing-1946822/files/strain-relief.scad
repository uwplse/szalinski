// grahampheath

// Default 0.5. "is the minimum size of a fragment"
part_quality=.5; // [0.1:0.1:1]

splice_cavety_diameter=7.5;
splice_width_diameter=12.5;
splice_length=15;

ziptie_channel_width=2.2;
ziptie_channel_height=1.1;

in_wire_opening_length=3.45;
in_round_wire_opening=true;
in_round_wire_opening_diameter=3.45;
in_square_wire_opening=false;
in_square_wire_opening_width=7.1;
in_square_wire_opening_height=3.45;

out_wire_opening_length=1;
out_round_wire_opening=false;
out_round_wire_opening_diameter=3.45;
out_square_wire_opening=true;
out_square_wire_opening_width=7.1;
out_square_wire_opening_height=3.45;

zipties=2;
ziptie_spacing=12.75;

/* [Hidden] */
$fa=1;
$fs=part_quality;
in_round_wire_opening_radius=in_round_wire_opening_diameter/2;
out_round_wire_opening_radius=out_round_wire_opening_diameter/2;
splice_cavety_radius=splice_cavety_diameter/2;
splice_width_radius=splice_width_diameter/2;


module cylinder_outer(radius,height,center, fn=90) {
  fudge = 1/cos(180/fn);
  cylinder(r=radius*fudge,h=height,center=center,$fn=fn);
}


module splice_opening(
    height=2,
    outer_radius=10,
    round=true,
    round_radius=2,
    square=false,
    square_width=3,
    square_height=4) {

  difference() {
    translate([0, 0, height/2]) {
      cylinder_outer(radius=outer_radius, height=height, center=true);
    }

    e=0.2;
    if (round) {
      translate([0, 0, height/2]) {
        cylinder_outer(radius=round_radius, height=height, center=true);
      }
    }

    if (square) {
      translate([-square_width/2, -square_height/2, 0]) {
        cube(size=[square_width, square_height, height], center=false);
      }
    }
  }

}

module splice_jacket() {
  cylinder_outer(radius=splice_width_radius, height=splice_length, center=false);
}

module splice_cavety() {
  cylinder_outer(radius=splice_cavety_radius, height=splice_length, center=false);
}

module ziptie() {
  translate([0, 0, ziptie_channel_width/2]){
    difference() {
      cylinder_outer(radius=splice_width_radius, height=ziptie_channel_width, center=true);
      cylinder_outer(radius=splice_width_radius-ziptie_channel_height, height=ziptie_channel_width, center=true);
    }
  }
}

module splice_hull() {
  difference() {
    difference() {
      splice_jacket();
      splice_cavety();
    }

    translate([0, 0, 0]){
      ziptie();
    }

    translate([0, 0, splice_length-ziptie_channel_width]){
      ziptie();
    }
  }
}


module strain_relief() {
  union(){
    translate([0, 0, 0]) {
      splice_opening(
        height=in_wire_opening_length,
        outer_radius=splice_width_radius,
        round=in_round_wire_opening,
        round_radius=in_round_wire_opening_radius,
        square=in_square_wire_opening,
        square_width=in_square_wire_opening_width,
        square_height=in_square_wire_opening_height
      );
    }
    translate([0, 0, in_wire_opening_length]) {
      splice_hull();
    }
    translate([0, 0, splice_length + in_wire_opening_length]) {
      splice_opening(
        height=out_wire_opening_length,
        outer_radius=splice_width_radius,
        round=out_round_wire_opening,
        round_radius=out_round_wire_opening_diameter,
        square=out_square_wire_opening,
        square_width=out_square_wire_opening_width,
        square_height=out_square_wire_opening_height
      );

    }
  }
}

rotate([0, 270, 0]) {
  splice_length_sum=splice_length+in_wire_opening_length + out_wire_opening_length;
  translate([0, 0, -splice_length_sum/2]) {

    intersection() {
      translate ([0,-splice_width_diameter/2,0]) {
        cube([10,splice_width_diameter,splice_length_sum]);
      }
      strain_relief();
    }
  }
}
