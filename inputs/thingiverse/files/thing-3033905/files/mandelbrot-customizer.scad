// The Mandelbrot Set.
// It's not procrastinating if it's educational!
//
// Andreas Schuderer, 4 August 2018
// Creative Commons Attribution Share-Alike Non-Commercial

/* [Size, Detail and Height Scaling] */
// Dimension your mandelbrot set (you can change the coarseness/resolution separately)
xWidth = 45; //[500]
yDepth = 30; //[500]
zHeight = 10; //[300]

// Size-independent resolution (small numbers = coarse, high numbers = fine). Higher values combined with high sizes will take really long to render!
resolution = 2.8; //[1.0:0.1:30.0]

// Scale the height of the points nonlinearly using this number to make it look better and more printable. Lower number = Less scaling and high features are really high while low features are invisible. Higher number = More scaling so that all high and low features are closer to each other. A negative number inverts the profile. [newZ = (origZ^(1/scalePower))]
heightPowerScale = 8;

/* [Zoom and Pan through the Mandelverse] */
// Zoom level (1.0 = normal; under 1.0 = zoomed out; over 1.0 = zoomed in)
zoom = 1.0; //[0.1:0.1:200.0]

// Pan around on the surface. 0.5 = centered, lower = move left, higher = move right
xMove = 0.5; //[0.001:0.001:0.999]
// Pan around on the surface. 0.5 = centered, lower = move to back, higher = move to front
yMove = 0.5; //[0.001:0.001:0.999]

/* [Mandelbrot-Specific Parameters] */
// Value which determines "ok, this is going to infinity"
maxValue = 1000.0;

// Number of iterations after which to stop trying to square value to infinity
maxIterations = 50;


xResolution = xWidth * resolution;
yResolution = yDepth * resolution;

aspectRatio = xWidth/yDepth;
width = (aspectRatio <= 3.0/2.5 ? 3.0 : 3.0 * aspectRatio/(3.0/2.5)) / zoom;
height = (aspectRatio >= 3.0/2.5 ? 2.5 : 2.5 / aspectRatio*(3.0/2.5)) / zoom;

centerX = map(xMove, 1.0, 0.0, -2.0, 1.0);
centerY = map(yMove, 1.0, 0.0, -1.25, 1.25);
xWindowMin = -2.0/zoom + (centerX - centerX / zoom);
xWindowMax = 1.0/zoom + (centerX - centerX / zoom);
yWindowMin = -1.25/zoom + (centerY - centerY / zoom);
yWindowMax = 1.25/zoom + (centerY - centerY / zoom);

/*
xWindowMin = (-xMove / 0.5 * 2/3) * width;
xWindowMax = (1.0-xMove / 0.5 * 2/3) * width;
yWindowMin = -yMove * height;
yWindowMax = (1.0-yMove) * height;
*/
mbset = [for (y=[0:yResolution-1])
            [for (x=[0:xResolution-1])
              pow(countIters(map(x, 0, xResolution, xWindowMin, xWindowMax),
                             map(y, 0, yResolution, yWindowMin, yWindowMax),
                             0, 0, 0, maxValue, maxIterations),
                  1/heightPowerScale)
            ]
        ];
surface_chart(mbset, size=[xWidth,yDepth,zHeight]);
function countIters(c_re, c_im, reNew, imNew, iter, maxVal, maxIters) =
  iter > maxIters || abs(reNew+imNew) >= maxVal ?
        iter :
        countIters(c_re, c_im,
                   (reNew*reNew - imNew*imNew) + c_re, // squaring
                   (2 * reNew * imNew) + c_im, // squaring
                   iter+1, maxVal, maxIters);

// Some data vis related functionality
//
// Andreas Schuderer, 4 August 2018

// General helpers
function lerp(a, b, fraction) = a + fraction * (b-a);
function map(x, minA, maxA, minB, maxB) =  
    minB + (maxB - minB)/(maxA - minA) * (x - minA);

// Polyhedron
module surface_chart(the_data, size=[1,1,1]) {
    rows = len(the_data);
    cols = len(the_data[0]);
    maxval = max([for (r=[0:rows-1]) max(the_data[r]) ]);
    scale_c = size[0] / (cols-1);
    scale_r = size[1] / (rows-1);
    scale_h = size[2] / maxval;
    
    function getPoint(r, c) = r * cols + c;

    polypoints = concat(
                   [ for (r=[0:rows-1], c=[0:cols-1]) 
                         [scale_r*r, scale_c*c, scale_h*the_data[r][c]] ], // data points
                   [ [0, 0, 0], [0, scale_c*(cols-1), 0], [scale_r*(rows-1), scale_c*(cols-1), 0], [scale_r*(rows-1), 0, 0] ] // four base corners
                 );
    //echo(polypoints);
    polyfaces1 = [ for (r=[0:rows-2], c=[0:cols-2]) 
                       [getPoint(r,c), getPoint(r,c+1), getPoint(r+1,c)] ];
    polyfaces2 = [ for (r=[0:rows-2], c=[0:cols-2]) 
                       [getPoint(r,c+1), getPoint(r+1,c+1), getPoint(r+1,c)] ];
    polyface_front = concat(
                       [ for (c=[cols-1:-1:0]) getPoint(0, c) ],
                       len(polypoints)-4,
                       len(polypoints)-3
                     );
    polyface_back = concat(
                       [ for (c=[0:cols-1]) getPoint(rows-1, c) ],
                       len(polypoints)-2,
                       len(polypoints)-1
                     );
    polyface_right = concat(
                       [ for (r=[rows-1:-1:0]) getPoint(r, cols-1) ],
                       len(polypoints)-3,
                       len(polypoints)-2
                     );
    polyface_left = concat(
                       [ for (r=[0:rows-1]) getPoint(r, 0) ],
                       len(polypoints)-1,
                       len(polypoints)-4
                     );
    polyface_base = [len(polypoints)-1, len(polypoints)-2, len(polypoints)-3, len(polypoints)-4];

    //for (p=polypoints) color("red") translate(p) sphere(1);
    rotate([0, 0, -90]) polyhedron(points = polypoints, faces=concat(polyfaces1, polyfaces2, [polyface_front], [polyface_back], [polyface_left], [polyface_right], [polyface_base]));
}
