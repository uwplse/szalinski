
/* [Common] */

part="all"; //[clip:Clip, board:Board, all: Clip and Board]

thickness=3; //[1:5]

/* [Clip] */
clip_length=50;
clip_gap=12;

/* [Toothbrush holder] */

//tbh = tooth brush holder
tbh_width=100;
tbh_height=100;

width_upper_clip_width=tbh_width;
width_lower_clip_width=tbh_width-20;

// How many toothbrushes?
tb_cutouts_num = 4;

// Holes for the toothbrushes, has to be lower than board_holder_length
tb_cutouts_diameter=20;

//to save some time/PLA/ABS
board_cutouts_num = 5;

//
board_cutouts_width=10;

board_upper_holder_thickness=thickness;
board_lower_holder_thickness=10;

// has to be higher than tb_cutouts_diameter
board_holder_length=30;

board_upper_holder_height=70;

/*   [Hidden]   */
$fn=100;



create_tooth_brush_holder();

module create_tooth_brush_holder() {
  if(part=="clip" || part=="all") {
    clip();
  }

  if(part=="board"|| part=="all") {
    holder();
  }
}

/*
  creates the clip
*/
module clip() {

  width_delta = width_upper_clip_width-width_lower_clip_width;

// top clip part
   hull(){
    translate([0,0,clip_gap+thickness])
      cube(
          size=[thickness,width_upper_clip_width,thickness/2],
          center=false
      );
    translate([clip_length,0,clip_gap+thickness])
      cube(
          size=[thickness,width_upper_clip_width,thickness],
          center=false
      );

        translate([thickness/2,0,clip_gap+thickness*1.5]) rotate ([-90,0,0]) cylinder(h=width_upper_clip_width,d=thickness);

  }

  translate([0,0,0]) {
    cube(
        size=[thickness/2,tbh_width,clip_gap+thickness],center=false
    );
  };

  //lower part of clip
  translate([0,width_delta/2,0]) {
      cube(
          size=[
              clip_length+thickness,
              width_lower_clip_width,
              thickness
          ],
          center=false
      );
  };
}

module holder() {
    difference() {
        translate([0,0,-tbh_height+clip_gap+thickness*2]) _holder_with_cutouts();
        clip();
    }
 }

module _holder_with_cutouts() {
     difference() {
      _board();
      translate([-board_holder_length/2,0,board_lower_holder_thickness/2]) _toothbrush_cutouts(tbh_width,tb_cutouts_num,tb_cutouts_diameter);
     }
 }

 module _toothbrush_cutouts(width,num,diameter) {
  echo (num);
  displacement=(width-num*diameter)/(num+1);
  color("blue")
  translate([0,diameter/2+displacement,0]) {
    for ( i = [0 : num-1] ){
      translate([0, (displacement+diameter)*i, 0]) {
        cylinder(h=tbh_height, d = diameter);
      }

      // small holes as drain
      translate([0, (displacement+diameter)*i, -board_lower_holder_thickness]) {
        cylinder(h=tbh_height, d = 4);
      }
    }
  }
}

module _board_cutouts(num,diameter) {
  width_single_cutout=diameter;
  displacement=(tbh_width-num*width_single_cutout)/(num+1);
  translate([-thickness/2,displacement,0]) {
    for ( i = [0 : num-1] ){
      translate([0, (displacement+width_single_cutout)*i, 0]) {
        cube(size=[thickness*2,width_single_cutout,tbh_height-clip_gap-thickness*4],center=false);
      }
    }
  }
}


module _board() {
  union() {
    difference() {
      cube(
          size=[
              thickness,
              tbh_width,
              tbh_height-thickness
          ],
          center=false
      );
      _board_cutouts(board_cutouts_num,board_cutouts_width);

    }
      //bottom
      single_brush_holder(0,board_lower_holder_thickness);
      //top
      single_brush_holder(board_upper_holder_height,board_upper_holder_thickness);
    }
 }

 module single_brush_holder(z_pos,board_holder_thickness){
  color("red")
  hull(){
    translate([-board_holder_length+thickness/2,thickness/2,z_pos]) cylinder(h = board_holder_thickness, d=thickness);
    translate([-board_holder_length+thickness/2,tbh_width-thickness/2,z_pos]) cylinder(h = board_holder_thickness, d=thickness);

    // small displacement (0.1), so there is really a connection bet
    translate([0,0,z_pos])   cube([thickness,thickness,board_holder_thickness]);

    // small displacement (0.1), so there is really a connection
    translate([0+0.1,tbh_width-thickness,z_pos]) cube([thickness,thickness,board_holder_thickness]);
  }
}
