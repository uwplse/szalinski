holding_tude_diameter=36.;
tube_wall_distance=28.;
thickness=4.;
supported=true;
percent_opening=52.0/60.0;//degree
height=10.0;
screw_radius=2.0;
//internal parameters
screw_head_radius=screw_radius*2;
spacer_width=holding_tude_diameter*0.5;

difference(){
    union(){
   //around the tube
translate([tube_wall_distance+holding_tude_diameter*0.5,0,0])cylinder(h=height,r=holding_tude_diameter*0.5+thickness,$fn=100);
   //Spacer between the wall and the tube
translate([0,-spacer_width*0.5,0])cube([tube_wall_distance+holding_tude_diameter*0.5,
        spacer_width,
        height]);
   //Support for the spacer
polyhedron( points =  [
  [ 0,-spacer_width*0.5,height ],  //0
  [ tube_wall_distance,-spacer_width*0.5,height ],  //1
  [ 0,-spacer_width*0.5,height + tube_wall_distance],  //2
  [ 0,+spacer_width*0.5,height ],  //3
  [ tube_wall_distance,+spacer_width*0.5,height ],  //4
  [ 0,+spacer_width*0.5,height + tube_wall_distance ]], 
  faces =   [
  [0,2,1],  // bottom
  [1,2,5,4],  // front
  [3,4,5],  // top
  [0,1,4,3],  // right
  [2,0,3,5]] // left 
  );
    //opening lip 1
translate([tube_wall_distance,thickness*0.5,0])rotate ([00,00,atan(percent_opening/2)])translate([(holding_tude_diameter+thickness*1)*0.5,0,height*0.5])cube([holding_tude_diameter+thickness*1,
        thickness,
        height],center=true);
    //opening lip 2
translate([tube_wall_distance,-thickness*0.5,0])rotate ([00,00,-atan(percent_opening/2)])translate([(holding_tude_diameter+thickness*1)*0.5,0,height*0.5])cube([holding_tude_diameter+thickness*1,
        thickness,
        height],center=true);
    };
    union(){
//the holde for the tube
    translate([tube_wall_distance+holding_tude_diameter*0.5,0,0])cylinder(h=height,r=holding_tude_diameter*0.5);
//screw hole
    translate([0,0,height*0.5])rotate ([00,90,0])cylinder(h=tube_wall_distance+holding_tude_diameter*0.5,r=screw_radius);
//screw head cylindrical hole
    translate([tube_wall_distance,0,height*0.5])rotate ([00,90,0])cylinder(h=holding_tude_diameter*0.5,r=screw_head_radius);
//screw head conical hole
    translate([tube_wall_distance-screw_head_radius,0,height*0.5])rotate ([00,90,0])cylinder(h=screw_head_radius,r1=0,r2=screw_head_radius);
//the opening for the tube to enter the holder
    polyhedron( points =  [
  [  tube_wall_distance,0,0 ],  //0
  [ tube_wall_distance+holding_tude_diameter+thickness*2,  
  (holding_tude_diameter+thickness*2)*percent_opening/2,  0 ],  //1
  [ tube_wall_distance+holding_tude_diameter+thickness*2,
  -(holding_tude_diameter+thickness*2)*percent_opening/2,  0 ],  //2
  [ tube_wall_distance,0,  height ],  //3
  [ tube_wall_distance+holding_tude_diameter+thickness*2,
  (holding_tude_diameter+thickness*2)*percent_opening/2,  height ],  //4
  [ tube_wall_distance+holding_tude_diameter+thickness*2,
  -(holding_tude_diameter+thickness*2)*percent_opening/2,  height ]], 
  faces =   [
  [0,2,1],  // bottom
  [1,2,5,4],  // front
  [3,4,5],  // top
  [0,1,4,3],  // right
  [2,0,3,5]] // left 
  );}}
    
    //translate([tube_wall_distance+holding_tude_diameter*0.5,-holding_tude_diameter*(1-closure_percent)*0.5,0])cube([holding_tude_diameter*(1-closure_percent),holding_tude_diameter*(1-closure_percent),height]);
