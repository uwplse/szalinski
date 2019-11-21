$fn=128;

thickness = 2.5;
motor_distance = 75;
motor_diameter = 8.7;
hex_wall = 1;
motor_height = 20;

platform_width = 22;
platform_hex_size = 3;

hook_radius=3;
hook_distance=25;


motor_diameterR = motor_diameter+thickness;
motor_diagonal = sqrt(pow(motor_distance,2)*2);
od = 2* (motor_distance)*sin(45) - motor_diameterR;
offset = -(od + motor_diameterR)*sin(45);
//translate([0,motor_distance/2,0]) cube([motor_distance,1,1], center=true);


// ********************** arcs ******************
translate([offset,0,0]) squared_arc(od,90,thickness);
rotate([0,180,0]) translate([offset,0,0]) squared_arc(od,90,thickness);
rotate([0,0,90]) translate([offset,0,0]) squared_arc(od,90,thickness);
rotate([0,0,270]) translate([offset,0,0]) squared_arc(od,90,thickness);


// ********************** motor cylinders ******************
difference() {
  union() {
    translate([motor_distance/2, motor_distance/2, -thickness/2]) motor_cylinder();
    translate([motor_distance/2, -motor_distance/2, -thickness/2]) motor_cylinder();
    translate([-motor_distance/2, -motor_distance/2, -thickness/2]) motor_cylinder();
    translate([-motor_distance/2, motor_distance/2, -thickness/2]) motor_cylinder();
    walls_for_cuts();
  }
  rotate([0,0,45]) translate([0,0,motor_height/2])
    cube([thickness,motor_diagonal,motor_height+thickness*2], center=true);
  rotate([0,0,-45]) translate([0,0,motor_height/2])
    cube([thickness,motor_diagonal,motor_height+thickness*2], center=true);
}

// ********************** electronics plate ******************
a=platform_width;
b=motor_distance*sin(45)+thickness;
difference() {
  translate([-a/2-thickness,-b/2-thickness,-thickness/2])
    hex_plate(a,b,thickness, hex_wall);
  translate([0,offset,0]) cylinder(d=od, h=thickness*2, center=true);
  translate([0,-offset,0]) cylinder(d=od, h=thickness*2, center=true);
  translate([0,0,hex_wall]) cube([a,b,thickness], center=true);
}

// ********************** ribbon hooks ******************
/*translate([0,hook_distance/2,0]) hook(1);
translate([0,-hook_distance/2,0]) hook(0); //good
translate([0,-hook_distance/2,0]) rotate([180,180,0]) hook(1);
#translate([0,hook_distance/2,0]) rotate([180,180,0]) hook(0); 
*/
hook(hook_distance/2,0,1);
hook(-hook_distance/2,1,1);
hook(hook_distance/2,-1,0);
hook(-hook_distance/2,-2,0);

module hook(y,forward,left) {
  fb=(forward-0.5)*2;
  lr=(left-0.5)*2;
  translate([lr*(platform_width/2+thickness),y,0])
  //rotate([-90,45,0])
  rotate([0,0,45*fb])
  squared_arc(dia=hook_radius*2, ang=90, thickness=thickness);
}


module hex_plate(a, b, t, i) difference() {
  e=1;
  cube([a+2*t,b+2*t,t]);
  intersection() {
    translate([t,t,-e]) cube([a,b,t+2*e]);
    translate([0,0,-e]) hex(a+2*t,b+2*t,t+2*e,platform_hex_size,i);
  }
}
// ********************** End of Module ******************


module walls_for_cuts() intersection() {
  union() {
    translate([motor_distance/2, motor_distance/2, -thickness/2]) solid_motor_cylinder();
    translate([motor_distance/2, -motor_distance/2, -thickness/2]) solid_motor_cylinder();
    translate([-motor_distance/2, -motor_distance/2, -thickness/2]) solid_motor_cylinder();
    translate([-motor_distance/2, motor_distance/2, -thickness/2]) solid_motor_cylinder();
  }
  union() {
    rotate([0,0,45]) translate([0,0,motor_height/2])
      cube([thickness+1.5,motor_diagonal,motor_height+thickness*2], center=true);
    rotate([0,0,-45]) translate([0,0,motor_height/2])
      cube([thickness+1.5,motor_diagonal,motor_height+thickness*2], center=true);
  }
}
// ********************** End of Module ******************


module motor_cylinder() {
  difference(){
    cylinder(d=motor_diameterR+thickness,h=thickness);
    translate([0,0,(motor_diameterR-thickness)/2-0.4]) sphere(d=motor_diameterR-thickness);
  }
  translate([0,0,thickness-hex_wall]) hexTube(height=motor_height-thickness/2, radius= (motor_diameterR+thickness)/2, hex_count=7, wall_thickness=thickness, hex_distance=hex_wall, edge=1);
  //#cylinder(d=motor_diameterR,h=1);
}
// ********************** End of Module ******************


module solid_motor_cylinder() difference(){
    cylinder(d=motor_diameterR+thickness,h=motor_height);
    translate([0,0,-0.5]) cylinder(d=motor_diameterR-thickness,h=motor_height+1);
}
// ********************** End of Module ******************


module squared_arc (dia, ang, thickness)
intersection (){
  rotate_extrude(convexity = 10) translate([dia/2, 0, 0]) square(thickness, center=true);
  wedge (thickness, (od+thickness)/1.7,ang);
}
// ********************** End of Module ******************


module wedge (thickness, rad, ang) 
translate ([0,0,-(thickness/2)-1]) {
linear_extrude (height = thickness+2) {
polygon(points=[
	[rad*cos(ang/2),-rad*sin(ang/2)],
	[0,0],
	[rad*cos(ang/2),rad*sin(ang/2)],
	[rad*cos(ang/3),rad*sin(ang/3)],
	[rad*cos(ang/6),rad*sin(ang/6)],
	[rad,0],
	[rad*cos(ang/6),-rad*sin(ang/6)],
	[rad*cos(ang/3),-rad*sin(ang/3)]],
paths=[[0,1,2,3,4,5,6,7]]);}
}
// ********************** End of Module ******************


module hex(l,w,h,s,t) {
  for (i=[0:3*s+sqrt(3)*t:l+2*s]) for (j=[0:sqrt(3)*s+t:w+s]) {
    translate([i,j,0]) cylinder(h=h, r=s, $fn=6);
    translate([i+(3*s+sqrt(3)*t)/2,j+(sqrt(3)*s+t)/2,0]) cylinder(h=h, r=s, $fn=6);
  }
}
// ********************** End of Module ******************

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

module hexTubeCut(height, tube_radius, hex_count, hex_distance) {
  //tube_radius=tube_radius+1;
  circumference = 2*tube_radius*PI;
  //hex_distance = 0;
  hex_width = (circumference - hex_count*hex_distance) / hex_count;
  //hex_width=1.35;
  //echo( (hex_width+hex_distance)*hex_count);
  hex_radius = hex_width/(2*sin(360/6));
  //echo(sin(360/6), sin(360/12));
  
  //translate([0,0,-0.3]) 
  //#rotate([0,0,6]) cube([hex_width,tube_radius*2,0.5], center=true);
  //#rotate([0,90,0]) cylinder(d=hex_width,h=tube_radius*2, center=true);
  //#translate([0,0,-0.17]) rotate([0,90,0]) cylinder(r=hex_radius,h=tube_radius*2, center=true,$fn=6);
    
  center_size = 0.0001;
  scale = hex_radius/center_size;
  //hex_count = floor( circumference / (hex_width+hex_distance));
  angle = 360/hex_count;
    
  //echo("circumference=", circumference, "; scale=", scale, "; hex_count=", hex_count, "; hex_width=", hex_width, "; hex_radius=", hex_radius, "; angle=", angle);
  
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

module reg_polygon(sides,radius) {
  circle(r=radius,$fn=sides);
}
