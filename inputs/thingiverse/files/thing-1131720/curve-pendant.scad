/*
 * Customizable rose pendant
 *
 * Author : Youness Alaoui <kakaroto@kakaroto.homelinux.net>
 * Code for the loophole was taken from wouterglorieux :
 * http://www.thingiverse.com/thing:47020
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License
 */
// preview[view:south, tilt:top]
use <utils/build_plate.scad>

// Parameter 'a' of the curve
a=10; // [1:50]
// Parameter 'b' of the curve
b=2; // [1:50]
// Parameter 'c' of the epitrochoid and hypotrochoid curves
c=10; // [1:50]
// Rhodonea curve : (x=cos(a/b*t)*sin(t); y=cos(a/b*t)*cos(t)
// Epicycloid  : x=(a+b)*cos(t)-b*cos(((a/b)+1)*t); y=(a+b)*sin(t)-b*sin(((a/b)+1)*t)
// Epitrochoid : x=(a+b)*cos(t)-c*cos(((a/b)+1)*t); y=(a+b)*sin(t)-c*sin(((a/b)+1)*t)
// Hypocycloid : x=(a-b)*cos(t)+b*cos(((a/b)-1)*t); y=(a-b)*sin(t)-b*sin(((a/b)-1)*t)
// Hypotrochoid: x=(a-b)*cos(t)+c*cos(((a/b)-1)*t); y=(a-b)*sin(t)-c*sin(((a/b)-1)*t)
// The curve to draw (See instructions for curve equation and parameters)
curve="rhodonea"; // ["rhodonea":Rhodonea curve, "epicycloid":Epicycloid, "epitrochoid":Epitrochoid, "hypocycloid":Hypocycloid, "hypotrochoid":Hypotrochoid]
// Thickness in millimeters of the rose
rose_thickness=1; // [1:10]
// The height in millimeters of the rose
rose_height=5; // [1:50]
// Size in millimeters of the radius of the generated rose
rose_radius=25; // [10:100]
// Adjust internal design size so it fits within the pendant's ring
ring_adjustment=0; // [-50:50]

//Display only, does not contribute to final object
buildPlateType = 0; // [0:Replicator 2, 1:Replicator, 2:Thingomatic]

// Must iterate b*2*pi to draw the whole shape
iterations=360 * b;
 // Normalized tree can't have more than 4000 elements, otherwise openSCAD aborts the rendering
increment= iterations / 1000;
adjustment = ring_adjustment / 10;

k = a / b;
amb = a - b;
apb = a + b;
kp1 = k + 1;
km1 = k - 1;
ab2 = a + b * 2 - adjustment;
abc = a + b + c - adjustment;
amb2 = (a < b ? a - b * 2 : a) - adjustment;
ambc = (a < b ? a - b - c : a - b + c) - adjustment;

function rhodoneax(t) = cos(k * t) * sin (t);
function rhodoneay(t) = cos(k * t) * cos (t);
function epicycloidx(t) = (apb * cos(t) - b * cos(kp1 * t)) / ab2;
function epicycloidy(t) = (apb * sin(t) - b * sin(kp1 * t)) / ab2;
function epitrochoidx(t) = (apb * cos(t) - c * cos(kp1 * t)) / abc;
function epitrochoidy(t) = (apb * sin(t) - c * sin(kp1 * t)) / abc;
function hypocycloidx(t) = (amb * cos(t) + b * cos(km1 * t)) / amb2;
function hypocycloidy(t) = (amb * sin(t) - b * sin(km1 * t)) / amb2;
function hypotrochoidx(t) = (amb * cos(t) + c * cos(km1 * t)) / ambc;
function hypotrochoidy(t) = (amb * sin(t) - c * sin(km1 * t)) / ambc;

function x(t) = ((curve == "rhodonea") ? rhodoneax(t) :
                 (curve == "epicycloid") ? epicycloidx(t) :
                 (curve == "epitrochoid") ? epitrochoidx(t) :
                 (curve == "hypocycloid") ? hypocycloidx(t) :
                 (curve == "hypotrochoid") ? hypotrochoidx(t) :
                 rhodoneax(t));
function y(t) = ((curve == "rhodonea") ? rhodoneay(t) :
                 (curve == "epicycloid") ? epicycloidy(t) :
                 (curve == "epitrochoid") ? epitrochoidy(t) :
                 (curve == "hypocycloid") ? hypocycloidy(t) :
                 (curve == "hypotrochoid") ? hypotrochoidy(t) :
                 rhodoneay(t));

// Calculate the normal vector of two points on the curve.
function normx(y1, y2) = y1 - y2;
function normy(x1, x2) = x2 - x1;
function norm(x, y) = sqrt(pow(x, 2) + pow(y, 2));
function nx(x, normx, norm, thickness) = x + (normx / norm * thickness);
function ny(y, normy, norm, thickness) = y + (normy / norm * thickness);

// Draw the curve using a polygon of 10 points to lower the number of objects
// used. Use the normal vector from 2 points to shift the points by the right
// amount of thickness to make the curve a 3D form.
module draw_curve(t) {
  // Calculate thickness once, as it will depend on the scaling later
  assign(thickness = rose_thickness / rose_radius)
    // Calculate the next 10 iterations
    assign(t2 = t + increment)
    assign(t3 = t2 + increment)
    assign(t4 = t3 + increment)
    assign(t5 = t4 + increment)
    assign(t6 = t5 + increment)
    assign(t7 = t6 + increment)
    assign(t8 = t7 + increment)
    assign(t9 = t8 + increment)
    assign(t10 = t9 + increment)
    assign(t11 = t10 + increment)
    assign(t12 = t11 + increment)
    // Cache the points (x, y)
    assign(x0 = x(t))
    assign(y0 = y(t))
    assign(x1 = x(t2))
    assign(y1 = y(t2))
    // Pre calculate the normal vector from two points
    assign(normx0 = normx(y0, y1))
    assign(normy0 = normy(x0, x1))
    assign(norm0 = norm(normx0, normy0))
    // Calculate the points of the closing segment by shifting the point
    // depending on the normal vector, by the thickness we want
    assign(nx0 = nx(x0, normx0, norm0, thickness))
    assign(ny0 = ny(y0, normy0, norm0, thickness))
    assign(x2 = x(t3))
    assign(y2 = y(t3))
    assign(normx1 = normx(y1, y2))
    assign(normy1 = normy(x1, x2))
    assign(norm1 = norm(normx1, normy1))
    assign(nx1 = nx(x1, normx1, norm1, thickness))
    assign(ny1 = ny(y1, normy1, norm1, thickness))
    assign(x3 = x(t4))
    assign(y3 = y(t4))
    assign(normx2 = normx(y2, y3))
    assign(normy2 = normy(x2, x3))
    assign(norm2 = norm(normx2, normy2))
    assign(nx2 = nx(x2, normx2, norm2, thickness))
    assign(ny2 = ny(y2, normy2, norm2, thickness))
    assign(x4 = x(t5))
    assign(y4 = y(t5))
    assign(normx3 = normx(y3, y4))
    assign(normy3 = normy(x3, x4))
    assign(norm3 = norm(normx3, normy3))
    assign(nx3 = nx(x3, normx3, norm3, thickness))
    assign(ny3 = ny(y3, normy3, norm3, thickness))
    assign(x5 = x(t6))
    assign(y5 = y(t6))
    assign(normx4 = normx(y4, y5))
    assign(normy4 = normy(x4, x5))
    assign(norm4 = norm(normx4, normy4))
    assign(nx4 = nx(x4, normx4, norm4, thickness))
    assign(ny4 = ny(y4, normy4, norm4, thickness))
    assign(x6 = x(t7))
    assign(y6 = y(t7))
    assign(normx5 = normx(y5, y6))
    assign(normy5 = normy(x5, x6))
    assign(norm5 = norm(normx5, normy5))
    assign(nx5 = nx(x5, normx5, norm5, thickness))
    assign(ny5 = ny(y5, normy5, norm5, thickness))
    assign(x7 = x(t8))
    assign(y7 = y(t8))
    assign(normx6 = normx(y6, y7))
    assign(normy6 = normy(x6, x7))
    assign(norm6 = norm(normx6, normy6))
    assign(nx6 = nx(x6, normx6, norm6, thickness))
    assign(ny6 = ny(y6, normy6, norm6, thickness))
    assign(x8 = x(t9))
    assign(y8 = y(t9))
    assign(normx7 = normx(y7, y8))
    assign(normy7 = normy(x7, x8))
    assign(norm7 = norm(normx7, normy7))
    assign(nx7 = nx(x7, normx7, norm7, thickness))
    assign(ny7 = ny(y7, normy7, norm7, thickness))
    assign(x9 = x(t10))
    assign(y9 = y(t10))
    assign(normx8 = normx(y8, y9))
    assign(normy8 = normy(x8, x9))
    assign(norm8 = norm(normx8, normy8))
    assign(nx8 = nx(x8, normx8, norm8, thickness))
    assign(ny8 = ny(y8, normy8, norm8, thickness))
    assign(x10 = x(t11))
    assign(y10 = y(t11))
    assign(normx9 = normx(y9, y10))
    assign(normy9 = normy(x9, x10))
    assign(norm9 = norm(normx9, normy9))
    assign(nx9 = nx(x9, normx9, norm9, thickness))
    assign(ny9 = ny(y9, normy9, norm9, thickness))
    assign(x11 = x(t12))
    assign(y11 = y(t12))
    assign(normx10 = normx(y10, y11))
    assign(normy10 = normy(x10, x11))
    assign(norm10 = norm(normx10, normy10))
    assign(nx10 = nx(x10, normx10, norm10, thickness))
    assign(ny10 = ny(y10, normy10, norm10, thickness))
    linear_extrude(height=rose_height / rose_radius, convexity=10, slices=100)
    {
      polygon(points=[[x0, y0], [x1, y1], [x2, y2],
                      [x3, y3], [x4, y4], [x5, y5],
                      [x6, y6], [x7, y7], [x8, y8],
                      [x9, y9], [x10, y10],
                      [nx10, ny10], [nx9, ny9], [nx8, ny8],
                      [nx7, ny7], [nx6, ny6], [nx5, ny5],
                      [nx4, ny4], [nx3, ny3], [nx2, ny2],
                      [nx1, ny1], [nx0, ny0]],
              paths=[[0, 1, 2, 3,
                      4, 5, 6, 7,
                      8, 9, 10, 11,
                      12, 13, 14, 15,
                      16, 17, 18, 19,
                      20, 21, 0]]);
    }
}

module main() {
  scale(rose_radius)
    union()
    {
      for (t = [0:increment*10:iterations]) {
        draw_curve(t);
      }
    }
}


main();

linear_extrude(height=rose_height, convexity = 10, $fn=60)
difference() {
  circle(r = rose_radius + 2 * rose_thickness, $fn=60);
  circle(r = rose_radius + rose_thickness, $fn=60);
}

//loophole for chain
difference() {
  translate([0,rose_radius + rose_thickness * 2, rose_thickness * 2]) rotate([0,0,0]) scale([1,1.5,2]) translate([-3, 3, 0]) rotate_extrude(convexity = 10, , $fn=60) translate([3, 0, 0]) circle(r = 1, $fn=60);
  // Make it flat on the build plate
  translate([-5, rose_radius + rose_thickness * 2, -1]) cube([10, 10, 1]);
}

build_plate(buildPlateType, 0, 0);
