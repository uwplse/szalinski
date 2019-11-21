
height=70;
sizex=120;
sizey=90;
radius=20;
thickness=0.6;
bottom_thickness_factor=1.6;
text_contents="Your Text";
text_size=10;
text_engravement_factor=1; // 1 = 100%, 0.5 = 50%


/// ----------------------- MODULES ------------------------


// helper module for drawing rectangles with rounded borders
//
// (c) 2013 Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
// Lincensed under the terms of the GNU General Public License
// version 3 (or later).

module rounded_square(dim, corners=[10,10,10,10], center=false){
  w=dim[0];
  h=dim[1];

  if (center){
    translate([-w/2, -h/2])
    rounded_square_(dim, corners=corners);
  }else{
    rounded_square_(dim, corners=corners);
  }
}

module rounded_square_(dim, corners, center=false){
  w=dim[0];
  h=dim[1];
  render(){
    difference(){
      square([w,h]);

      if (corners[0])
        square([corners[0], corners[0]]);

      if (corners[1])
        translate([w-corners[1],0])
        square([corners[1], corners[1]]);

      if (corners[2])
        translate([0,h-corners[2]])
        square([corners[2], corners[2]]);

      if (corners[3])
        translate([w-corners[3], h-corners[3]])
        square([corners[3], corners[3]]);
    }

    if (corners[0])
      translate([corners[0], corners[0]])
      intersection(){
        circle(r=corners[0]);
        translate([-corners[0], -corners[0]])
        square([corners[0], corners[0]]);
      }

    if (corners[1])
      translate([w-corners[1], corners[1]])
      intersection(){
        circle(r=corners[1]);
        translate([0, -corners[1]])
        square([corners[1], corners[1]]);
      }

    if (corners[2])
      translate([corners[2], h-corners[2]])
      intersection(){
        circle(r=corners[2]);
        translate([-corners[2], 0])
        square([corners[2], corners[2]]);
      }

    if (corners[3])
      translate([w-corners[3], h-corners[3]])
      intersection(){
        circle(r=corners[3]);
        square([corners[3], corners[3]]);
      }
  }
}



/// ----------------- END OF MODULES --------------------


difference() {
    linear_extrude(height) rounded_square([sizex,sizey],corners=[radius,radius,radius,radius],center=true) ;
    translate([0,0,thickness*bottom_thickness_factor]) linear_extrude(height-thickness*bottom_thickness_factor) rounded_square([sizex-2*thickness,sizey-2*thickness],corners=[radius,radius,radius,radius],center=true); 
    translate([0,-sizey/2+thickness*text_engravement_factor,height/2]) rotate([90,0,0]) linear_extrude(thickness) text(text_contents,size=text_size,halign="center",valign="center");
}
