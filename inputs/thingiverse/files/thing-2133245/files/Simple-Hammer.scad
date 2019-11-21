//The hammer head length
hammer_length=50;
//The hammer head width
hammer_width=30;
//The hammer head height
hammer_height=34;
//The cutted side length
side_length=5;
//The handle diameter
handle_diameter=10;
//The hand length
handle_length=130;
//The curvature precision
$fn=128;

SidePoints = [
  [  0,  0,  0 ],  //0
  [ side_length,  side_length,  side_length ],  //1
  [ side_length,  hammer_width-side_length,  side_length ],  //2
  [  0,  hammer_width,  0 ],  //3
  [  0,  0,  hammer_height ],  //4
  [ side_length,  side_length,  hammer_height-side_length ],  //5
  [ side_length,  hammer_width-side_length,  hammer_height-side_length ],  //6
  [  0,  hammer_width,  hammer_height ]]; //7
  
SideFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left

union(){
cube([hammer_length, hammer_width, hammer_height]);
translate([ hammer_length, 0, 0 ])
polyhedron( SidePoints, SideFaces);
translate([0,hammer_width,0])
rotate([0,0,180])
polyhedron( SidePoints, SideFaces );
translate([hammer_length/2, hammer_width/2, hammer_height])
cylinder(d=handle_diameter,h=handle_length);
    translate([hammer_length/2, hammer_width/2, hammer_height+handle_length])
    sphere(d=handle_diameter);
}