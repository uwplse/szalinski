//
// 
// Customizable Rounded Cube Pen Holder by Robert Halter
// Licensed: Creative Commons - Attribution - Non-Commercial - Share Alike (by-nc-sa)
// see: http://en.wikipedia.org/wiki/Creative_Commons
//
// parametrizable user values
// - outer dimension of hole Cube Pen Holder [mm]
// - factor for dimension to radius [Number]
// - wall thinkness [mm]
//
// author: Robert Halter - CH - 01.01.2015
//
// with:   OpenSCAD Version 2014.03
//
// History
// - adapted to http://customizer.makerbot.com/docs
// - translate to x, y, z = 0
// - inner rounded cube
// - color for visualisation


/* [Size] */

// parametrizable user values - change if you want

// outer dimension of hole Rounded Cube Pen Holder [mm]
dimension = 80; // [55:90]

/* [Hidden] */

// factor for dimension to radius [Number]
// This Number is the factor of radius to dimension
factorradius2dim = 12 / 80; // 0.15

// wall thinkness [mm]
wall = 2.0; // [2:3]

// color for visualisation i.e. dark blue
userColorRGB = [0/255, 48/255, 112/255];
// userColorRGB = [30/255, 55/255, 108/255];
// userColorRGB = "DarkBlue";
userColorAlpha = 255/255;

// preview[view:south east, tilt:top diagonal]

// calculated Values - do not change

// radius of outer eight spheres [mm]
radius = dimension * factorradius2dim; // 12 mm with dimension 80 mm and factor 0.15

// number of fragments 0, 3, 5 or bigger
// set to 15 for debugging
// $fn = 15;
// set to i.e. 50 for production
$fn = 50;

// offset for outer sphere translations
offset4sphere = dimension - (2 * radius);

// inner hull top extension
innerhulltopextension = wall + radius;

// radius of inner eight sphere
innerradius = radius - wall;



// begin of form

// color of following difference
color(userColorRGB, userColorAlpha)

// difference of 'difference' minus 'translated cube'
// to cut on top of the Cube the thin Wall Parts
difference() {

// translate to x, y, z = 0
translate([radius,radius,radius]) {

//  difference of 'Hull over outer eight spheres' minus 'Hull over inner eight spheres'
difference() {

  // hull over outer eight spheres
  hull() {

    // outer four bottom spheres
    translate([0,0,0]) {
      sphere(r = radius);
    }

    translate([offset4sphere,0,0]) {
      sphere(r = radius);
    }

    translate([0,offset4sphere,0]) {
      sphere(r = radius);
    }

    translate([offset4sphere,offset4sphere,0]) {
      sphere(r = radius);
    }

    // outer four top spheres
    translate([0,0,offset4sphere]) {
      sphere(r = radius);
    }

    translate([offset4sphere,0,offset4sphere]) {
      sphere(r = radius);
    }

    translate([0,offset4sphere,offset4sphere]) {
      sphere(r = radius);
    }

    translate([offset4sphere,offset4sphere,offset4sphere]) {
      sphere(r = radius);
    }

  } // hull

  // hull over inner eight spheres
  hull() {

    // inner four bottom spheres
    translate([0,0,0]) {
      sphere(r = innerradius);
    }

    translate([offset4sphere,0,0]) {
      sphere(r = innerradius);
    }

    translate([0,offset4sphere,0]) {
      sphere(r = innerradius);
    }

    translate([offset4sphere,offset4sphere,0]) {
      sphere(r = innerradius);
    }

    // inner four top spheres
    translate([0,0,offset4sphere + innerhulltopextension]) {
      sphere(r = innerradius);
    }

    translate([offset4sphere,0,offset4sphere + innerhulltopextension]) {
      sphere(r = innerradius);
    }

    translate([0,offset4sphere,offset4sphere + innerhulltopextension]) {
      sphere(r = innerradius);
    }

    translate([offset4sphere,offset4sphere,offset4sphere + innerhulltopextension]) {
      sphere(r = innerradius);
    }
  } // hull

} // difference

} // translate

translate([0,0,dimension - (radius * 4 / 5) + wall]) {
  cube([dimension,dimension, 2 * wall]);
}
} // difference

// end of form
