psu_mount_hole_distance = 50; // [0.0:200.0]
psu_mount_hole_d = 4;         // [0.0:10.0]
frame_mount_hole_d = 5;       // [0.0:10.0]
extra_hole_d_tenth = 3;       // [0.0:9.0]
middle_piece_width = 10;      // [0.0:180.0]
middle_piece_height = 10;     // [0.0:30.0]
bracket_width = 12;           // [0.0:30.0]
rill_width = 5;               // [0.0:10.00]
extra_rill_width_tenth = 7;   // [0.0:9.0]

/* [Hidden] */
rill_height = 2;
rill_round_edge = 1;
bracket_round_edge = 1.5;
bracket_height = 6;
bracket_length_beyond_psu_hole = 7.5;

rotate([90,0,0])
difference()
{
  
  extra_rill_width = extra_rill_width_tenth / 10;
  
  union()
  {
    // Middle piece
    translate([-middle_piece_width/2 - bracket_round_edge*2.25, 0, middle_piece_height])
      cube_fillet([middle_piece_width+bracket_round_edge*4.5, bracket_width, bracket_height], vertical=[0,0,0,0], top=[0,bracket_round_edge,0,bracket_round_edge]);

    length = sqrt(2 * pow(middle_piece_height, 2));

    // Angled piece (+x)
    translate([middle_piece_width/2+middle_piece_height,bracket_width,0])
      rotate([0,-45,180])
        translate([-bracket_round_edge/2,0,0])
          cube_fillet([length+4.11, bracket_width, bracket_height], vertical=[0,0,0,0], top=[0,0,0,bracket_round_edge], bottom=[0,bracket_round_edge,0,bracket_round_edge]);

    // Angled piece (-x)
    translate([-middle_piece_width/2-middle_piece_height,0,0])
      rotate([0,-45,0])
        translate([-bracket_round_edge/2,0,0])  
          cube_fillet([length+4.11, bracket_width, bracket_height], vertical=[0,0,0,0], top=[0,0,0,bracket_round_edge], bottom=[0,bracket_round_edge,0,bracket_round_edge]);

    outer_piece_l = (psu_mount_hole_distance-middle_piece_width)/2-middle_piece_height+bracket_length_beyond_psu_hole+bracket_round_edge/2;

    // Outer piece (+x)
    translate([middle_piece_height + middle_piece_width/2 - bracket_round_edge/2,0,0])
      cube_fillet([outer_piece_l, bracket_width, bracket_height], vertical=[0,0,0,0], top=[0,0,0,bracket_round_edge], bottom=[0,bracket_round_edge,0,bracket_round_edge]);

    // Outer piece (-x)
    rotate([0,0,180])
      translate([middle_piece_height + middle_piece_width/2 - bracket_round_edge/2,-bracket_width,0])
        cube_fillet([outer_piece_l, bracket_width, bracket_height], vertical=[0,0,0,0], top=[0,0,0,bracket_round_edge], bottom=[0,bracket_round_edge,0,bracket_round_edge]);

    // Rill
    translate([-(rill_width+extra_rill_width)/2,0,bracket_height + middle_piece_height])
      cube_fillet([rill_width+extra_rill_width, bracket_width, rill_height], vertical=[0,0,0,0], top=[0,rill_round_edge,0,rill_round_edge]);
  }

  extra_hole_d = extra_hole_d_tenth / 10;

  // PSU Mounting holes
  translate([psu_mount_hole_distance/2, bracket_width/2, -0.05])
    cylinder(d=psu_mount_hole_d+extra_hole_d, h = bracket_height + 0.1, $fn=18);

  translate([-psu_mount_hole_distance/2,bracket_width/2,-0.05])
    cylinder(d=psu_mount_hole_d+extra_hole_d, h = bracket_height + 0.1, $fn=18);

  // Frame mounting hole
  translate([0, bracket_width/2, middle_piece_height-0.05])
    cylinder(d=frame_mount_hole_d+extra_hole_d, h = bracket_height + rill_height + 0.1, $fn=18);
  
  // Hole in the rill
  rill_hole_width = frame_mount_hole_d + extra_hole_d + 3;
    translate([-(rill_width+extra_rill_width)/2 - 0.05, bracket_width / 2 - rill_hole_width / 2,bracket_height + middle_piece_height])
      cube([rill_width+extra_rill_width + 0.1, rill_hole_width, rill_height+ 0.05]);
}


// http://axuv.blogspot.nl/2012/05/openscad-helper-funcions-for-better.html
module fillet(radius, height=100, $fn=16) {
    //this creates negative of fillet,
    //i.e. thing to be substracted from object
    translate([-radius, -radius, -height/2-0.01])
        difference() {
            cube([radius*2, radius*2, height+0.02]);
            cylinder(r=radius, h=height+0.02, $fn=16);
        }
}

module cube_negative_fillet(
        size,
        radius=-1,
        vertical=[3,3,3,3], 
        top=[0,0,0,0],
        bottom=[0,0,0,0],
        $fn=0
    ){

    j=[1,0,1,0];

    for (i=[0:3]) {
        if (radius > -1) {
            rotate([0, 0, 90*i])
                translate([size[1-j[i]]/2, size[j[i]]/2, 0])
                    fillet(radius, size[2], $fn=$fn);
        } else {
            rotate([0, 0, 90*i])
                translate([size[1-j[i]]/2, size[j[i]]/2, 0])
                    fillet(vertical[i], size[2], $fn=$fn);
        }
        rotate([90*i, -90, 0])
            translate([size[2]/2, size[j[i]]/2, 0 ])
                fillet(top[i], size[1-j[i]], $fn=$fn);
        rotate([90*(4-i), 90, 0])
            translate([size[2]/2, size[j[i]]/2, 0])
                fillet(bottom[i], size[1-j[i]], $fn=$fn);
    }
}

module cube_fillet_inside(
         size,
        radius=-1,
        vertical=[3,3,3,3],
        top=[0,0,0,0],
        bottom=[0,0,0,0],
        $fn=0
    ){
    if (radius == 0) {
        cube(size, center=true);
    } else {
        difference() {
            cube(size, center=true);
            cube_negative_fillet(size, radius, vertical, top, bottom, $fn);
        }
    }
}

module cube_fillet(
        size,
        radius=-1,
        vertical=[3,3,3,3],
        top=[0,0,0,0],
        bottom=[0,0,0,0],
        center=false,
        $fn=0 
    ){
    if (center) {
        cube_fillet_inside(size, radius, vertical, top, bottom, $fn);
    } else {
        translate([size[0]/2, size[1]/2, size[2]/2])
            cube_fillet_inside(size, radius, vertical, top, bottom, $fn);
    }
}