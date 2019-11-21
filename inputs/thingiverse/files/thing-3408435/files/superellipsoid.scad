// This generates super-ellipses and super-ellipsoids, generated entirely in
// OpenSCAD. I have seen other super-ellipsoids, but they depended on python
// code to generate the scad file.
// This is based on the formulas found in:
// https://en.wikipedia.org/wiki/Superellipsoid
// Creative Commons - Attribution - Share Alike License
// http://creativecommons.org/licenses/by-sa/3.0/

// super-ellipse or super-ellipsoid
shape = "superellipsoid"; // [superellipse:Extruded 2D super-ellipse,superellipsoid:3D super-ellipsoid]
// horizontal squareness
r = 3;
// vertical squareness
t = 3;
// X length
xLength = 100;
// Y length
yLength = 100;
// Z length
zLength = 100;
// Number of segments in a full circle
fragments = 64;
center = 0; // [0:false,1:true]

main(shape, r, t, xLength, yLength, zLength, fragments, center);

function xScale(scale) = scale == undef ? 1.0 : scale[0] == undef ? scale : scale[0];
function yScale(scale) = scale == undef ? 1.0 : scale[1] == undef ? scale : scale[1];
function zScale(scale) = scale == undef ? 1.0 : scale[2] == undef ? scale : scale[2];
function c(w, m) = sign(cos(w)) * pow(abs(cos(w)), m);
function s(w, m) = sign(sin(w)) * pow(abs(sin(w)), m);
function x(u, v, r, t, scale) = scale * c(v, (2 / t)) * c(u, 2 / r);
function y(u, v, r, t, scale) = scale * c(v, (2 / t)) * s(u, 2 / r);
function z(u, v, t, scale) = scale * s(v, (2 / t));

function xyz(u, v, r, t, scale) = [x(u, v, r, t, xScale(scale)), y(u, v, r, t, yScale(scale)), z(u, v, t, zScale(scale))];

function xy(u, r, scale) = [x(u, 0, r, 2, xScale(scale)), y(u, 0, r, 2, yScale(scale))];

module superEllipse(r, t, scale, $fn = 36) {
  deltaAngle = 360 / $fn;
  points = [ for (u = [ 0 : deltaAngle : 360 - deltaAngle ] ) xy(u, r, scale) ];
  polygon(points);
}

function layerCount(n) = ceil(n / 4) * 2 + 1; // always an odd number
function partLayerCount(n) = (layerCount(n) > 3) ? floor((layerCount(n) - 1) / 2) - 1 : 0;

function topPoint(scale) = [0, 0, zScale(scale)];
function bottomPoint(scale) = [0, 0, -zScale(scale)];
function middlePoints(n, r, t, scale) = [ for (slice = [ 0 : n - 1 ] ) xyz(u = 360 * slice / n, v = 0, r = r, t = t, scale = scale) ];
function topPoints(n, r, t, scale) = (partLayerCount(n) == 0) ? [] :
  [ for (layer = [ 1 : partLayerCount(n) ], slice = [ 0 : n - 1 ] ) xyz(u = 360 * slice / n, v = layer * 360 / n, r = r, t = t, scale = scale) ];

function bottomPoints(n, r, t, scale) = (partLayerCount(n) == 0) ? [] :
  [ for (layer = [ 1 : partLayerCount(n) ], slice = [ 0 : n - 1 ] ) xyz(u = 360 * slice / n, v = -layer * 360 / n, r = r, t = t, scale = scale) ];

function getPoints(n, r, t, scale) = concat(
  [topPoint(scale), bottomPoint(scale)],
  middlePoints(n, r, t, scale),
  topPoints(n, r, t, scale),
  bottomPoints(n, r, t, scale)
);

function getPointIndex(layer, slice, n) =
  (layer == partLayerCount(n) + 1) ? 0 :
  (layer == -(partLayerCount(n) + 1)) ? 1 : 
  (layer == 0) ? 2 + (slice % n) :
  (layer > 0) ? 2 + (layer * n + slice % n) :
  (layer < 0) ? 2 + partLayerCount(n) * n + (-layer * n + slice % n) : 0;

function getTopFaces(n) = [ for (slice = [ 0 : n - 1 ]) [getPointIndex(partLayerCount(n), slice, n), getPointIndex(partLayerCount(n), slice + 1, n), getPointIndex(partLayerCount(n) + 1, slice, n)] ];

function getMiddleFaces(n) = partLayerCount(n) == 0 ? [] :
  [ for (layer = [ -partLayerCount(n) : partLayerCount(n) - 1 ], slice = [ 0 : n - 1 ]) [getPointIndex(layer, slice, n), getPointIndex(layer, slice + 1, n), getPointIndex(layer + 1, slice + 1, n), getPointIndex(layer + 1, slice, n)] ];

function getBottomFaces(n) = [ for (slice = [ 0 : n - 1 ]) [getPointIndex(-partLayerCount(n), slice + 1, n), getPointIndex(-partLayerCount(n), slice, n), getPointIndex(-(partLayerCount(n) + 1), slice, n)] ];

function getFaces(n) = concat(getBottomFaces(n), getMiddleFaces(n), getTopFaces(n));

module superEllipsoid(r, t, scale, $fn = 64) {
  // n should be a multiple of 4
  n = ceil($fn / 4) * 4;
  points = getPoints(n = n, r = r, t = t, scale = scale);
  //echo("n", n);
  //echo("points", points);
  faces = getFaces(n = n);
  //echo("faces", faces);
  polyhedron(points, faces);
}

module main(shape, r, t, xLength, yLength, zLength, fragments, center) {
  translate([0, 0, (1 - center) * zLength / 2]) {
    if (shape == "superellipse") {
      linear_extrude(height = zLength, center = true) {
        superEllipse(r = r, scale = [xLength / 2, yLength / 2], $fn = fragments);
      }
    } else {
      superEllipsoid(r = r, t = t, scale = [xLength / 2, yLength / 2, zLength / 2], $fn = fragments);
    }
  }
}
