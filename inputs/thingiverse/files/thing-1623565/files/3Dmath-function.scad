// draw and print 3D math function
// written by Arnaud SECHER
// 13/06/2016


//////////////////////////////////////
// Variables
slice=0.2;
width=10;
depth=10;
thickness=0.5;


// Function
function zed(x,y) = cos(100*x)+cos(100*y);


/////////////////////////////////////
// RENDERS

for(i=[0:slice:width-slice])
    for(j=[0:slice:depth-slice])
        miniface(i,j);


/////////////////////////////////////
// MODULES

module miniface(i,j){

    CubePoints = [
      [ i,j, zed(i,j) ],  //0
      [ i+slice,j, zed(i+slice,j) ],  //1
      [ i+slice,j+slice, zed(i+slice,j+slice) ],  //2
      [ i,j+slice, zed(i,j+slice) ],  //3
      [ i,j, zed(i,j) + thickness ],  //4
      [ i+slice,j, zed(i+slice,j) + thickness ],  //5
      [ i+slice,j+slice, zed(i+slice,j+slice) + thickness ],  //6
      [ i,j+slice, zed(i,j+slice) + thickness ]]; //7
   
    CubeFaces = [
     [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3] ];  // left

    polyhedron( CubePoints, CubeFaces);
}





