$fn=128; 

tube_length=2.5;
tube_radius=6;
hex_count_per_layer=30;
tube_wall_thickness=3;
hex_distance=0.1;
solid_top_and_bottom_layers=1; // 0, 1

// idea from: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_the_2D_Subsystem#regular_polygon
module reg_polygon(sides,radius) {
  circle(r=radius,$fn=sides);
}

//calculating relation between:
// hex_radius*2 = distance between two opposite corners of hexagon
// hex_width = distance between two opposite sides of hexagon
// hex_width = side length of an enscribed equilateral triangle
// using forumlas from https://en.wikipedia.org/wiki/Circular_segment
// hex_width = 2*hex_radius*sin(360/6)

module hexTubeCut(height, tube_radius, hex_count, hex_distance) {
  //tube_radius=tube_radius+1;
  circumference = 2*tube_radius*PI;
  //hex_distance = 0;
  hex_width = (circumference - hex_count*hex_distance) / hex_count;
  //hex_width=1.35;
  //echo( (hex_width+hex_distance)*hex_count);
  hex_radius = hex_width/(2*sin(360/6));
  echo(sin(360/6), sin(360/12));
  
  //translate([0,0,-0.3]) 
  //#rotate([0,0,6]) cube([hex_width,tube_radius*2,0.5], center=true);
  //#rotate([0,90,0]) cylinder(d=hex_width,h=tube_radius*2, center=true);
  //#translate([0,0,-0.17]) rotate([0,90,0]) cylinder(r=hex_radius,h=tube_radius*2, center=true,$fn=6);
    
  center_size = 0.0001;
  scale = hex_radius/center_size;
  //hex_count = floor( circumference / (hex_width+hex_distance));
  angle = 360/hex_count;
    
  echo("circumference=", circumference, "; scale=", scale, "; hex_count=", hex_count, "; hex_width=", hex_width, "; hex_radius=", hex_radius, "; angle=", angle);
  
  //level_height = hex_width;
  //level_height = hex_radius + (hex_width/(2*sin(360/12)))/2;
  level_height = hex_radius*1.5+hex_distance;
  for(j=[0 : level_height : height+hex_radius*2]) {
    q=j / level_height;
    for(i=[0:angle:360])
      translate([0,0,j])
      //echo("q=", q, "; q%2=", q%2)
      rotate([i+q%2*angle/2,90,0])
      //linear_extrude(height = tube_radius, convexity = 10, scale=scale)
      linear_extrude(height = tube_radius, convexity = 10, scale=[1.3,scale])
      scale([scale/1.3,1])
      reg_polygon(6,center_size);
  }
}
//rendering with reg_polygon(6,center_size); = 1 minutes, 31 seconds

module hexTube(height, radius, hex_count, wall_thickness, hex_distance, edge) {
  difference() {
    cylinder(h=height,r=radius);
    translate([0,0,-1]) cylinder(h=height+2,r=radius-wall_thickness);
    hexTubeCut(height, radius, hex_count, hex_distance);
  }
  if(edge) difference() {
    cylinder(h=height,r=radius);
    translate([0,0,-1]) cylinder(h=height+2,r=radius-wall_thickness);
    translate([0,0,hex_distance]) cylinder(h=height-hex_distance*2,r=radius+1);
  }
}

//hexTube(height=2.5, radius=6, hex_count=30, wall_thickness=3, hex_distance=0.1, edge=1);
hexTube(height=tube_length, radius=tube_radius, hex_count=hex_count_per_layer, wall_thickness=tube_wall_thickness, hex_distance=hex_distance, edge=solid_top_and_bottom_layers);

//hexTubeCut(height=10.6, radius=6, hex_radius=0.9, hex_distance=0.1);