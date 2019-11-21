//headphone holder mount
//dwu

holder_thickness = 5; // thickness
holder_width = 20; // width
holder_depth = 40; // how far in to extend

desk_thickness = 25.5; // thickness of desk
desk_underhang = 20; // how far under desk

peg_t = 5; // thickness
peg_l = 40; // length

rad = 2; // radius of edges

hold_t = holder_thickness - rad;
hold_w = holder_width - rad;
hold_d = holder_depth - rad;

desk_t = desk_thickness+rad*2;
desk_u = desk_underhang - rad;

$fn = 64; //smoothness

translate([-peg_l+1,desk_u*0.75,(hold_w/2)-(peg_t/2)]) {
  cube([peg_l,peg_t,peg_t]);
}

brace_pts = [
//main body
  [0,0],                             //0
  [0,desk_u+desk_t+(hold_t*2)],      //1
  [hold_d,desk_u+desk_t+(hold_t*2)], //2
  [hold_d,desk_u+desk_t+hold_t],     //3
  [hold_t,desk_u+desk_t+hold_t],     //4
  [hold_t,desk_u+hold_t],            //5
  [hold_d,desk_u+hold_t],            //6
//cutout
  [hold_t,desk_u],                   //7
  [hold_d-hold_t*3,desk_u],          //8
  [hold_t,hold_t*1.5]                //9
];

brace_paths = [
  [0,1,2,3,4,5,6],
  [7,8,9]
];

linear_extrude(height = hold_w, center = false) {
  offset(r=rad) {
      polygon(points = brace_pts, paths = brace_paths);
  }
}