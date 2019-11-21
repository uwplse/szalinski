show_top = true;
show_bottom = true;
show_vtulku = true;

wall = 3;
usb_width = 14;
usb_depth = 17;
usb_petal_depth_pos = 8.6;
usb_metal_depth = 11.5;
usb_height = 6;

petal_hole_width = 2;
petal_hole_depth = 3;
petal_hole_height = 5;

bolt_d = 5;
bolt_head_d = 7;

wire_hole_d = 6;
vtulka_pad = 0.6;
vtulka_skirt = 0.8;
vtulka_wall = 1.2;
  
module usb_female_case(){
  difference(){
    translate(v=[wall, wall, 0]) {
      minkowski(){
        cube(size=[usb_width+wall, usb_depth, usb_height+wall]);
        sphere(r=wall, $fn=30);  
      }
    }
    // to cut out bottom excess
    translate(v=[0,0, -wall]) {
      cube(size=[usb_width+3*wall,usb_depth+3*wall, wall]);
    }
    
    translate(v=[wall+wall/2, 0, petal_hole_height]) {
      cube(size=[usb_width, usb_depth, usb_height]);
    }
    translate(v=[wall+wall/2, 2, petal_hole_height-1]) {
      cube(size=[usb_width, usb_depth-2, usb_height]);
    }
    translate(v=[wall+wall/2, usb_metal_depth, petal_hole_height-4]) {
      cube(size=[usb_width, usb_depth-usb_metal_depth, usb_height]);
    }
    
     // holes for usb female petals
    for(pos=[0, usb_width-petal_hole_width]) {
      translate(v=[wall*1.5+pos, usb_petal_depth_pos-petal_hole_depth/2, 0]) {
          cube(size=[petal_hole_width, petal_hole_depth, petal_hole_height]);
          hull() {
            translate(v=[0, 0, wall/2]) {
              cube(size=[petal_hole_width, petal_hole_depth, 1]);
            }
            translate(v=[-2, 0, 0]) {
              cube(size=[petal_hole_width+4, petal_hole_depth, 1]);
            }
          }
      }
    }
    // wire_hole
    translate(v=[(usb_width+wall+2*wall)/2, usb_depth, -1]) {
      cylinder(h=wall+wall, d=wire_hole_d, $fn=100);
    }
    translate(v=[(usb_width+wall+2*wall)/2, usb_depth, 1]) {
      cylinder(h=wall+wall, d=wire_hole_d + vtulka_skirt+vtulka_pad+0.4, $fn=100);
    }
  }
  translate(v=[usb_width+3*wall-0.1,usb_depth/2+3,0]) {
    ushko();
  }
  translate(v=[0.1,usb_depth/2+3,0]) rotate(a=[0,0,180]) {
    ushko();
  }
  
}
module ushko(){
  r1 = bolt_d/2;
  r2 = bolt_head_d/2;
  h = wall;
  translate(v=[r2, 0, 0])
    difference(){
      minkowski(){
        cylinder(h=h, r=r2+wall, $fn=3);
        sphere(r=wall, $fn=30);  
      }
      // to cut out excess
      translate(v=[-r2-2*wall,-r2-2*wall, -wall]) {
        cube(size=[10*(r2+wall), 10*(r2+wall), wall]);
      }
      // hole for bolt
      translate(v=[2,0, wall]) {
        cylinder(r1=r1, r2=r2, h=h, $fn=60);
      }
      translate(v=[2,0, 0]) {
        cylinder(r=r1, h=wall, $fn=60);
      }
    }
}

module vtulka(){
    $fn=100;
    difference(){
      union(){
        cylinder(h=0.4, d=wire_hole_d+vtulka_skirt);    
        cylinder(h=10, d=wire_hole_d-vtulka_pad);
      }
      cylinder(h=10, d=wire_hole_d-vtulka_wall-vtulka_pad);
  }
}


module slice(bottom=true){
  z = (bottom)?wall+wall+0.2:0;
  offset = (bottom)?0:0.4;

  module cut(){
    difference(){
      usb_female_case();
      translate(v=[-50,-50, z]) {
        cube(size=[100, 100, usb_height]);
      }
    }
  }
  module pazz(){
    translate(v=[(usb_width+wall+2*wall)/2-7-(1.2+offset), 5-offset/2, 6]) {
      cube(size=[1.2+offset,10+offset,2+offset]);
    }
    translate(v=[(usb_width+wall+2*wall)/2+7, 5-offset/2, 6]) {
      cube(size=[1.2+offset,10+offset,2+offset]);
    }
  }

  if(bottom){
    cut(); 
    pazz(); 
  }else {
    difference(){
     cut();
     color("red")
      pazz(); 
    }
  }

}

if(show_top)
  translate([0, 0, 5])
    slice(bottom=false); //top

if(show_bottom)
  color("red", 0.9)
    slice(bottom=true); //bottom

if(show_vtulku)
  translate([-10, 0, 0])
    vtulka();
