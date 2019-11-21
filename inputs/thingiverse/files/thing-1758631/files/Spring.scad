/*
  3D Printed Spring
  Copyright Nir Dobovizki 2016
  Provided under the Creative Commons Attribution-NonCommercial 4.0 International (CC-BY-NC)
  Contact me at nir@nbdtech.com
*/

// Number of sides
sides = 20;
// Inner radius of the loops
radius = 5;
// Number of loops
loops = 7;
// Loops width
width = 2;
// Loop thickness
height = 1.6;
// distance between loops
loopHeight = 5;
 
ptOuter = ngon(sides,radius+width);
ptInner = ngon(sides,radius);

rotate([0,270,0])
union(){

for(i=[0:loops-1])
{
    base = loopHeight*i;

    for(j=[1:sides])
    {
        polyhedron(
            points = [
                [ptOuter[(j-1)%sides][0],ptOuter[((j-1)%sides)%sides][1],base+(j*(loopHeight/sides))],
                [ptOuter[j%sides][0],ptOuter[j%sides][1],base+((j+1)*(loopHeight/sides))],
                [ptOuter[(j-1)%sides][0],ptOuter[(j-1)%sides][1],base+height+(j*(loopHeight/sides))],
                [ptOuter[j%sides][0],ptOuter[j%sides][1],base+height+((j+1)*(loopHeight/sides))],
                [ptInner[(j-1)%sides][0],ptInner[(j-1)%sides][1],base+(j*(loopHeight/sides))],
                [ptInner[j%sides][0],ptInner[j%sides][1],base+((j+1)*(loopHeight/sides))],
                [ptInner[(j-1)%sides][0],ptInner[(j-1)%sides][1],base+height+(j*(loopHeight/sides))],
                [ptInner[j%sides][0],ptInner[j%sides][1],base+height+((j+1)*(loopHeight/sides))]
                ],
            faces = [
                [0,1,2],[1,3,2], //right
                [1,0,4],[4,5,1], //bottom
                [2,4,0],[2,6,4], //back
                [6,5,4],[6,7,5], //left
                [1,5,7],[7,3,1], //front
                [3,7,6],[6,2,3]  //top
        ]);
    }
    for(j=[sides/4+1:(sides/4)*3-1])
    {
        polyhedron(
            points = [
                [-(radius+width),ptOuter[((j-1)%sides)%sides][1],base+(j*(loopHeight/sides))],
                [-(radius+width),ptOuter[j%sides][1],base+((j+1)*(loopHeight/sides))],
                [-(radius+width),ptOuter[(j-1)%sides][1],base+height+(j*(loopHeight/sides))],
                [-(radius+width),ptOuter[j%sides][1],base+height+((j+1)*(loopHeight/sides))],
                [ptOuter[(j-1)%sides][0],ptOuter[((j-1)%sides)%sides][1],base+(j*(loopHeight/sides))],
                [ptOuter[j%sides][0],ptOuter[j%sides][1],base+((j+1)*(loopHeight/sides))],
                [ptOuter[(j-1)%sides][0],ptOuter[(j-1)%sides][1],base+height+((j)*(loopHeight/sides))],
                [ptOuter[j%sides][0],ptOuter[j%sides][1],base+height+((j+1)*(loopHeight/sides))]
                ],
            faces = [
                [0,1,2],[1,3,2], //right
                [1,0,4],[4,5,1], //bottom
                [2,4,0],[2,6,4], //back
                [6,5,4],[6,7,5], //left
                [1,5,7],[7,3,1], //front
                [3,7,6],[6,2,3]  //top
        ]);
    }
}
 
 }
// Simple list comprehension for creating N-gon vertices
function ngon(num, r) = 
  [for (i=[0:num-1], a=i*360/num) [ r*cos(a), r*sin(a) ]];