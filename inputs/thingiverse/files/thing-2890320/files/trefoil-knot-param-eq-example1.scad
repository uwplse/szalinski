//!OpenSCAD

function x(t) = sin(t) + 2 * sin((2 * t));

function y(t) = cos(t) - 2 * cos((2 * t));

function z(t) = -sin((3 * t));

function doHsvMatrix(h,s,v,p,q,t,a=1)=[h<1?v:h<2?q:h<3?p:h<4?p:h<5?t:v,h<1?t:h<2?v:h<3?v:h<4?q:h<5?p:p,h<1?p:h<2?p:h<3?t:h<4?v:h<5?v:q,a];
function hsv(h, s=1, v=1,a=1)=doHsvMatrix((h%1)*6,s<0?0:s>1?1:s,v<0?0:v>1?1:v,v*(1-s),v*(1-s*((h%1)*6-floor((h%1)*6))),v*(1-s*(1-((h%1)*6-floor((h%1)*6)))),a);

// A trefoil knot can be described by these parametric equations:
// x(t) = sin(t) + 2sin(2t)
// y(t) = cos(t) - 2cos(2t)
// z(t) = -sin(3t)
// Each equation is represented by a module.  Given an input value of t, they return values for x, y, and z.
// These x,y,z values are used to translate a "point", which here is a cube.  Hulling the loop connects the points.
//
// To make the rainbow color, each cube is given a different hue in the chain hull loop.  Since the hue can run between 0 and 100, and the loop runs between 0 and 360, i is divided by (360 / 100) = 3.6.  You can get the rainbow loop twice through if you divide by 1.8.
// X size in mm
size_X = 10;
// Y size in mm
size_Y = 10;
// Z size in mm
size_Z = 10;

scale([size_X, size_Y, size_Z]){
  // chain hull
  for (i = [0 : abs(15) : 365 - 15]) {
    hull() {
    translate([(x(i)), (y(i)), (z(i))]){
      color(hsv(.01 * (i / 3.6), .01 * (100), .01 * (100))){
        cube([0.6, 0.6, 0.6], center=true);
      }
    }
    translate([(x((i + 15))), (y((i + 15))), (z((i + 15)))]){
      color(hsv(.01 * ((i + 15) / 3.6), .01 * (100), .01 * (100))){
        cube([0.6, 0.6, 0.6], center=true);
      }
    }
    }  // end hull (in loop)
   } // end loop

}