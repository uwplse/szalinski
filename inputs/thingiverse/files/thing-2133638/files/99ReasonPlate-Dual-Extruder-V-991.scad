//Generate Bottom or Lower part (dual extruder)

// Which one would you like to see?
part = "both"; // [lower:lower part only,upper:upper part only ,both:lower and upper part]

// Enter your text Line 1
    text_box1 = "Line 1";
// Enter your text Line 2
    text_box2 = "Line 2";
// Enter your text Line 3
    text_box3= "Line 3";
// Enter text size
    text_size= 11; 
 
 
CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left

CubePointslower = [
   [  0,  0,  0 ],  //0
  [ 85,  0,  0 ],  //1
  [ 85,  85,  0 ],  //2
  [  0,  85,  0 ],  //3
  [  1,  1,  1 ],  //4
  [84,  1,  1 ],  //5
  [ 84,  84,  1 ],  //6
  [  1,  84,  1 ]]; //7
  
CubePointsHigher = [
[  1,  1,  1 ],  //0
[ 84,  1,  1 ],  //1
[ 84,  84,  1 ],  //2
[  1,  84,  1 ],  //3
[  2,  2,  2 ],  //4
[83,  2,  2 ],  //5
[ 83,  83,  2 ],  //6
[  2,  83,  2 ]]; //7


//CubePointsZwisp = [
//   [  0,  0,  0 ],  //0
//  [ 85,  0,  0 ],  //1
//  [ 85,  85,  0 ],  //2
//  [  0,  85,  0 ],  //3
//  [  2,  2,  2 ],  //4
//  [83,  2,  2 ],  //5
//  [ 83,  83,  2 ],  //6
//  [  2,  83,  2 ]]; //7

//START GENERATING THE OBJECCT
rotate (a=[0,180,0])
translate([0,0,-2]) 
{
{
//GENERATE THE LOWER PLATE
if (part=="both" || part == "upper")
{
color("crimson"){
// create poly
polyhedron( CubePointsHigher, CubeFaces );
}
}
//GENERATE THE UPPER PLATE WITH TEXT
if (part=="both" || part == "lower")
{
difference() {
    // create poly
polyhedron( CubePointslower, CubeFaces );

// text(scale) {
font1 = "Archivo Black"; // here you can select other font type

translate ([45,56,40]) {
rotate ([0,180,0]) {
linear_extrude(height = 60) {
text(text_box1, font = font1, size = text_size, halign="center",  direction = "ltr", spacing = 1 );
    ;
}
}
}
translate ([45,40,40]) {
rotate ([0,180,0]) {
linear_extrude(height = 60) {
text(text_box2, font = font1, size = text_size, halign="center",  direction = "ltr", spacing = 1 );
    ;
}
}
}
translate ([45,24,40]) {
rotate ([0,180,0]) {
linear_extrude(height = 60) {
text(text_box3, font = font1, size = text_size, halign="center",  direction = "ltr", spacing = 1 );
    ;
}
}
}
}
}
}
}