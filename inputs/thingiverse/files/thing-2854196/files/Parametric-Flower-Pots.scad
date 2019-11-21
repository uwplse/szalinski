/* [Global] */
nFaces = 8; // [1:100]
bottomRadius = 50; // [10:200]
topRadius = 90;
height = 80;

/* [Hidden] */
step = 360/nFaces;
minRadius = min(topRadius, bottomRadius);
minFaceSize = minRadius*sin(step/2)/2;
maxNLayers = floor(height / minFaceSize);

stepZ = height/maxNLayers;

deltaRadius = topRadius - bottomRadius;

// --- Utils --- //

// compute sum of vector from i to s
function sumv(v,i,s=0) = (i==s ? v[i] : v[i] + sumv(v,i-1,s));

// flatten vector
function flatten(l) = [ for (a = l) for (b = a) b ] ;

// invert triangle
function invertTriangle(t) = [ t[0], t[2], t[1]  ] ;

// invert triangles
function invertTriangles(triangles) = [ for(t=triangles) invertTriangle(t)] ;
    
// --- Compute points of a polygon / circle --- //

function points(step, radius, z, offset) = [ for (i = [0 : step : 360-step])[radius*cos(i+offset),radius*sin(i+offset),z]];

// --- Compute z step (height amount for each step) --- //

// the height of a layer is half the length of a side of the polygon / circle
function computeHeightSteps() = [ for(i=[0:maxNLayers]) let ( r = bottomRadius+(i/maxNLayers)*deltaRadius, faceSize = 2*r*sin(step/2)) faceSize*sqrt(3)/4 ];

// compute the heights by summing the height steps
function computeHeights(heights) = [ for(i=[0:maxNLayers]) sumv(heights, i, 0) ];

// compute the number of step necessary to reach the required height
function computeNZSteps(heights) = sumv([ for(h=heights) h<height ? 1 : 0 ], maxNLayers, 0);

// compute ideal heights (if the z increment equals perfectly faceSideSize / 2)
heightSteps = computeHeightSteps();
idealHeights = computeHeights(heightSteps);
nLayers = computeNZSteps(idealHeights);
idealHeight = idealHeights[nLayers-1];

// scale each step so that the total height equals the required height
heightRatio = height / idealHeight;

heights = [for(h=idealHeights) h*heightRatio];

// --- Compute all points --- //

// for each layer : compute a list of points
layerPoints = [ for (i = [0 : nLayers]) let ( r = bottomRadius+(i/nLayers)*deltaRadius, faceSize = 2*r*sin(step)) points(step, r, i==0 ? 0 : heights[i-1], i%2 == 0 ? 0 : step/2) ];

// flatten the list of points for each layers
p = flatten(layerPoints);

// --- Create layers --- //

// for each layer : 

//  bottom faces
function faces1(nFaces, layerIndex, offset) = [ for (i = [0 : nFaces-1])[i+layerIndex*nFaces,i < nFaces-1 ?  nFaces+i+offset+layerIndex*nFaces : nFaces+(1-offset)*(nFaces-1)+layerIndex*nFaces,i < nFaces-1 ? i+1+layerIndex*nFaces : 0+layerIndex*nFaces]];

// top faces
function faces2(nFaces, layerIndex, offset) = [ for (i = [0 : nFaces-1])[nFaces+i+layerIndex*nFaces, i < nFaces-1 ? nFaces+i+1+layerIndex*nFaces : nFaces+layerIndex*nFaces, i < nFaces-1 ? i+1-offset+layerIndex*nFaces : 0+offset*(nFaces-1)+layerIndex*nFaces]];

// contact bottom faces and top faces
function faces(nFaces, layerIndex, offset) = concat(faces1(nFaces, layerIndex, offset), faces2(nFaces, layerIndex, offset));

// create face indices (invert faces)
layerFaces = [ for (i = [0 : nLayers-1]) invertTriangles(faces(nFaces, i, i%2 == 0 ? 0 : 1)) ];

// flatten faces indices
f = flatten(layerFaces);

// create layer faces
polyhedron( points = p, faces = f, convexity = 1);

// --- Create top and bottom faces --- //

// create bottom center
p1 = concat(p, [[0, 0, 0]]);
bottomIndex = len(p1)-1;

// create top center
p2 = concat(p1, [[0, 0, height]]);
topIndex = len(p2)-1;

bottomFace = [for (i = [0 : nFaces-1]) invertTriangle([i, i < nFaces-1 ? i+1 : 0, bottomIndex]) ];
polyhedron( points = p2, faces = bottomFace, convexity = 1);

topFace = [for (i = [0 : nFaces-1]) [i+nLayers*nFaces, i < nFaces-1 ? i+1+nLayers*nFaces : 0+nLayers*nFaces, topIndex] ];
polyhedron( points = p2, faces = topFace, convexity = 1);
