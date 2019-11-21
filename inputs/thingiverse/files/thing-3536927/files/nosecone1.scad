
// Basic style of the nose cone
Cone_Style = 3;  // [0:conic, 1:blunted conic, 2:bi-conic, 3:ogive, 4:blunted ogive, 5:secant ogive, 6:elliptical, 7:parabolic, 8:power series, 9:Haack Series]

// Radius at shoulder
Cone_Radius = 3;  // [0:0.01:200]

// Length from tip to shoulder
Cone_Length = 21;  // [0:0.01:1000]

// Thickness of the cone walls
Wall_Thickness = 0.125;  // [0.0:0.01:25]


// Radius of rounded tip or bi-conic tip, if applicable
Tip_Radius = 0.5; // [0:0.01:200]

// Length of the bi-conic tip
Tip_Length = 3; // [0:0.01:400]

// Shape of secant ogive bulge, 0.5 = tangent ogive
Secant_Ogive_Shape = 0.5; // [0:0.01:1]

// "K'" parameter for parabolic cones
Parabolic_K = 0.5; // [0:0.01:1]

// Power series exponent "n"
Power_Series_N = 0.5; // [0:0.01:1]

// Haack series control "C":  0=LD-Haack(Von Karman), 1/3=LV-Haack, 2/3=Tangent
Haack_Series_C = 0; // [0:0.01:1.5]


// Length of the shoulder
Shoulder_Length = 6;  // [0:0.01:200]

// Inset of the shoulder from the nose cone
Shoulder_Inset = 0.25;  // [0:0.01:25]

// If checked, includes a cap over the bottom of the shoulder.
Shoulder_Base = false;  // [ false, true ]

// If checked, the nose will be generated in one pice, regardless of the printer's size.
Ignore_Printer_Size = false;  // [false, true]

// Walls thinner than this will cause gussets to be generated
Gusset_Threshold = 0.15; // [0.01:0.01:25]

// The width of the gussets
Gusset_Width = 0.25; // [0:0.01:25]

// The thickness of the gussets
Gusset_Thickness = 0.1; // [0:0.01:25]

// The length of the vertical alignment tabs
Tab_Length = 0.25; // [0:0.01:25]

// The thickness of the vertical alignment tabs
Tab_Thickness = 0.1; // [0:0.01:25]

// Air gap between the face of an alignment tab and the inner nose cone wall
Tab_hGap = 0.02; // [0:0.005:5]

// Air gap between the top and bottom of vertical alignment tabs and the nearby gussets
Tab_vGap = 0.05; // [0:0.005:5]

// Units of measurement
Base_Units = 25.4;  // [1:mm, 25.4:inches]

// Fineness of the rendering
Smoothness = 25;  // [1:100]

// Length of print area X-axis
Printer_X = 11; // [0.01:0.01:250]

// Length of print area Y-axis
Printer_Y = 11; // [0.01:0.01:250]

// Length of print area Z-axis
Printer_Z = 18; // [0.01:0.01:350]

/* [Hidden] */

// a tiny x-value used to force sort order in any tight corners of the inside shell
EPSILON = 0.00001 / Base_Units;


TORAD = PI / 180;
TODEG = 180 / PI;

// Outer shell parameters
R = Cone_Radius;
L = Cone_Length;
R_t = Tip_Radius;
L_t = Tip_Length;
W_t = Wall_Thickness;

// full length of the final object
FullLen = Cone_Length + Shoulder_Length;

// increments for any code walking up or down the cone wall
x_step = FullLen / (10 * Smoothness);

// Don't bother with any inside sections less than this radius
Minimum_Inside_Gap = 0.5 / Base_Units; // 0.5mm

function sqr(x) = x * x;

function tip_sphere_y(x, x_center) = sqrt(sqr(R_t) - sqr(x_center - x));

function quicksortPts(arr) = (len(arr) <= 1) ? arr : let(
    pivot   = arr[floor(len(arr)/2)].x,
    lesser  = [ for (pt = arr) if (pt.x  < pivot) pt ],
    equal   = [ for (pt = arr) if (pt.x == pivot) pt ],
    greater = [ for (pt = arr) if (pt.x  > pivot) pt ]
) concat(
    quicksortPts(lesser), equal, quicksortPts(greater)
);

function quicksort(arr) = (len(arr) <= 1) ? arr : let(
    pivot   = arr[floor(len(arr)/2)],
    lesser  = [ for (y = arr) if (y  < pivot) y ],
    equal   = [ for (y = arr) if (y == pivot) y ],
    greater = [ for (y = arr) if (y  > pivot) y ]
) concat(
    quicksort(lesser), equal, quicksort(greater)
);

function reverse(vec) = [ for (i = [len(vec)-1:-1:0]) vec[i] ];

function valueList(n, minVal, maxVal) = [ for (i = [minVal : (maxVal-minVal)/n : maxVal]) i ];

function fillCurve(vec) = quicksort(concat( valueList(max(5, Smoothness / 2), vec[0], vec[1]), vec));

function genPts(r, minX, maxX) = [ for (x = [ minX : x_step : maxX + x_step ]) [ x, r ] ];

function selectPts(pts, minX, maxX) =
  [ for (pt = pts) if (minX <= pt.x && pt.x <= maxX) pt ];

function findPtY(pts, y, i) =
  (i >= len(pts)) ? len(pts) : (pts[i].y >= y) ? i : findPtY(pts, y, i+1);

function findPtX(pts, x, i) =
  (i >= len(pts)) ? len(pts) : (pts[i].x >= x) ? i : findPtX(pts, x, i+1);

function interpolatePoint(x, a, b) =
  let (dy = b.y - a.y,  dx = b.x - a.x)
  (dx == 0) ? [ x, (a.y + b.y)/2 ]
            : [ x, a.y + (x - a.x) * dy / dx ];

function interpolatePt(pts, x) =
  let (i = findPtX(pts, x, 0))
    (i == 0)        ? pts[0]
  : (i >= len(pts)) ? pts[len(pts)-1]
  : (pts[i].x == x) ? pts[i]
  :                   interpolatePoint(x, pts[i-1], pts[i]);

function findPrevPt(pts, i) =
  (i <= 0) ? 0 : (pts[i].x != pts[i-1].x) ? i-1 : findPrevPt(pts, i-1);

function findNextPt(pts, i) =
  (i >= len(pts)-1) ? i : (pts[i].x != pts[i+1].x) ? i+1 : findNextPt(pts, i+1);

function conic(x) = x * R / L;
conic_name = "conic";
conic_domain = [ 0, L ];

x_tan = sqr(L) / R * sqrt(sqr(R_t) / (sqr(R) + sqr(L)));
y_tan = conic(x_tan);
x0_tip = x_tan + sqrt(sqr(R_t) - sqr(y_tan));
x_apex = x0_tip - R_t;
function blunted_conic(x) =
  (x < x_apex) ? 0 : (x < x_tan) ? tip_sphere_y(x, x0_tip) : conic(x);

blunted_conic_name = str("blunted-conic(R_tip=", R_t, ")");
blunted_conic_domain = fillCurve([ x_apex, x_tan, L ]);

function biconic(x) =
  (x < L_t) ? x * R_t / L_t : R_t + (x - L_t) * (R - R_t) / (L - L_t);

biconic_name = str("bi-conic(tipR=", Tip_Radius, ", tipL=", Tip_Length, ")");
biconic_domain = [ 0, L_t, L ];

rho = (sqr(R) + sqr(L)) / (2 * R);
function ogive(x) =
  sqrt(sqr(rho) - sqr(L - x)) + R - rho;

ogive_name = "ogive";
ogive_domain = fillCurve([ 0, L / 20, L ]);


bto_x0 = L - sqrt(sqr(rho - R_t) - sqr(rho - R));
bto_y_tan = R_t * (rho - R) / (rho - R_t);
bto_x_tan = bto_x0 - sqrt(sqr(R_t) - sqr(bto_y_tan));
bto_apex = bto_x0 - R_t;
function bto(x) =
  (x < bto_apex) ? 0 : (x < bto_x_tan) ? tip_sphere_y(x, bto_x0) : ogive(x);

bto_name = str("blunted-ogive(tipR=", R_t, ")");
bto_domain = fillCurve([ bto_apex, bto_x_tan, L ]);


so_rho = (Secant_Ogive_Shape < 0.5) ? (Secant_Ogive_Shape * 2 * (rho - L / 2) + (L / 2))
                                    : ((Secant_Ogive_Shape - 0.5) * 4 * rho + rho);
so_alpha = atan(R / L) - acos(sqrt(sqr(L) + sqr(R)) / (2*so_rho));
so_cos = so_rho * cos(so_alpha);
so_sin = so_rho * sin(so_alpha);
function secant_ogive(x) =
  sqrt(sqr(so_rho) - sqr(so_cos - x)) + so_sin;

secant_ogive_name = str("secant-ogive(rho=", so_rho, ")");
secant_ogive_domain = fillCurve([ 0, L / 20, L ]);


function elliptical(x) =
  R * sqrt(1 - sqr(L - x)/sqr(L));

elliptical_name = "elliptical";
elliptical_domain = fillCurve([ 0, L / 20, L ]);

p_a = R / (2 - Parabolic_K);
p_b = p_a * 2 / L;
p_c = p_a * Parabolic_K / sqr(L);

function parabolic(x) =
  p_b * x - p_c * sqr(x);
//  R * ((2 * (x/L)) - (Parabolic_K * sqr(x/L))) / (2 - Parabolic_K);

parabolic_name = str("parabolic(K=", Parabolic_K, ")");
parabolic_domain = fillCurve([ 0, L / 20, L ]);


function power(x) =
  R * pow(x / L, Power_Series_N);

power_name = str("power-series(N=", Power_Series_N, ")");
power_domain = fillCurve([ 0, L / 20, L ]);


function haack(x) =
  let (theta = acos(1 - (2 * x / L)))
  (R/sqrt(PI)) * sqrt(TORAD * theta - (sin(2 * theta) / 2) + Haack_Series_C * pow(sin(theta), 3));

haack_name = str("Sears-Haack(C=", Haack_Series_C, ")");
haack_domain = fillCurve([ 0, L / 20, L ]);


cone_name = [
  conic_name,         // 0
  blunted_conic_name, // 1
  biconic_name,       // 2
  ogive_name,         // 3
  bto_name,           // 4
  secant_ogive_name,  // 5
  elliptical_name,    // 6
  parabolic_name,     // 7
  power_name,         // 8
  haack_name          // 9
][ Cone_Style ];

domain = [
  conic_domain,         // 0
  blunted_conic_domain, // 1
  biconic_domain,       // 2
  ogive_domain,         // 3
  bto_domain,           // 4
  secant_ogive_domain,  // 5
  elliptical_domain,    // 6
  parabolic_domain,     // 7
  power_domain,         // 8
  haack_domain          // 9
][ Cone_Style ];

function shell(x) =
    (Cone_Style == 0) ? conic(x)
  : (Cone_Style == 1) ? blunted_conic(x)
  : (Cone_Style == 2) ? biconic(x)
  : (Cone_Style == 3) ? ogive(x)
  : (Cone_Style == 4) ? bto(x)
  : (Cone_Style == 5) ? secant_ogive(x)
  : (Cone_Style == 6) ? elliptical(x)
  : (Cone_Style == 7) ? parabolic(x)
  : (Cone_Style == 8) ? power(x)
  : (Cone_Style == 9) ? haack(x)
  : 1;


Shoulder_outside = shell(L) - Shoulder_Inset;
Shoulder_inside = Shoulder_outside - W_t;

function outerPt(x) = [ x, max(0, shell(x)) ];

Outer_Shell =
  let (
    raw = [ for (x = [ 0 : x_step : L + x_step ]) outerPt(x) ],
    critical = [ for (d = [0 : len(domain) - 1]) outerPt(domain[d]) ],
    clipped = selectPts(concat(raw, critical), 0, L),
    shoulder = genPts(Shoulder_outside, L, FullLen)
  )
  quicksortPts(concat(clipped, shoulder));

function innerPt(i) =
  let (
    p = Outer_Shell[i],

 	a = findPrevPt(Outer_Shell, i),
	pa = Outer_Shell[a],
	b = (p.x != pa.x) ? i : findNextPt(Outer_Shell, i),
	pb = Outer_Shell[b],

    normalSlope = (pa.y == pb.y) ? -1 : (pa.x - pb.x) / (pb.y - pa.y),
    normalLength = sqrt(1 + sqr(normalSlope)),
    dx = W_t / normalLength,
    dy = - abs(dx * normalSlope),
	
	new_x = p.x + dx,
	new_y = p.y + dy
  )
  [  new_x, (new_y < Minimum_Inside_Gap) ? 0 : new_y ];

Inner_Shell =
  let (
    raw = [ for (i = [0 : len(Outer_Shell)-1]) innerPt(i) ],
    ledge_top = L - (Shoulder_Inset > 0 ? W_t : 0),
    ledge_corner = [[ ledge_top - EPSILON, shell(ledge_top)- W_t ]],
    clipped = selectPts(concat(raw, ledge_corner), 0, ledge_top),
    shoulder = genPts(Shoulder_inside, ledge_top, FullLen)
  )
  quicksortPts(concat(clipped, shoulder));

function getSubshell(pts, minX, maxX) =
  let (
    midPts = selectPts(pts, minX, maxX),
    minPt = interpolatePt(pts, minX),
    maxPt = interpolatePt(pts, maxX)
  )
  quicksortPts(concat(midPts, [ minPt, maxPt ]));

function inside(x) = interpolatePt(Inner_Shell, x).y;

module genSection(pts, degrees, nFaces) {
  rotate_extrude(angle=degrees, convexity=2, $fn=nFaces) {
    translate([0,FullLen,0]) {
	  // make the X-axis of pts the axis of rotation
      rotate([0,0,270]) {
        polygon(pts);
	  }
	}	  
  }
}

function buildPolyPts(outside_pts, inside_pts) =
  [ for (p = concat(outside_pts, reverse(inside_pts))) [ p.x, max(0, p.y) ] ];
	  
module doHorizontalTab(minX, maxX, maxR) {
  if (maxX - minX - 2 * Tab_vGap > Tab_Length) {
    base = getSubshell(Inner_Shell, minX + Tab_vGap, maxX - Tab_vGap);

    if (Tab_hGap > 0) {
      outer_shim = [ for (p = base) [ p.x, p.y + W_t / 2 ] ];
      inner_shim = [ for (p = base) [ p.x, p.y - Tab_hGap - Tab_Thickness / 2 ] ];
      shimPts = buildPolyPts(outer_shim, inner_shim);
      shimDegrees = atan(Tab_Length / maxR);
      genSection(shimPts, shimDegrees, 10);
	}
	
    outer_tab = [ for (p = base) [ p.x, p.y - Tab_hGap ] ];
    inner_tab = [ for (p = outer_tab) [ p.x, p.y - Tab_Thickness ] ];
    tabPts = buildPolyPts(outer_tab, inner_tab);
    tabDegrees = 2 * atan(Tab_Length / maxR);
    rotate([0, 0, -tabDegrees/2]) {
	  genSection(tabPts, tabDegrees, 10);
    }
  }
}

module doNoseCone(layer_id, minX, maxX) {
  doBase = Shoulder_Base && (maxX > FullLen - W_t);
  doTab = (maxX + 0.05 * (maxX-minX) < FullLen);
  doGusset = (W_t < Gusset_Threshold);
  doShoulderInset = (minX <= L) && (L < maxX);

  x0 = maxX + Tab_Length;
  y0 = min(inside(maxX), inside(x0)) - Tab_hGap;
  out0 = [ if (doTab) [ x0, y0 ]];
  in0  = [ if (doTab) [ x0, y0 - Tab_Thickness ]];

  x1 = maxX + EPSILON;
  out1 = [ if (doTab) [ x1, inside(x1) - Tab_hGap]];
  in1  = [ if (doTab) [ x1, inside(x1) - Tab_hGap - Tab_Thickness ]];

  in2  = [[ maxX, (doBase) ? 0 : (inside(maxX) - (doTab ? Tab_hGap + Tab_Thickness : 0)) ]];

  x3 = maxX - W_t;
  in3 = [ if (doBase) [ x3, 0 ]];

  x4 = maxX - Tab_Length;
  in4 = [[ x4, inside(x4) - (doTab ? Tab_hGap + Tab_Thickness : 0) ]];

  x5 = x4 - EPSILON;
  in5 = [ if (!doBase) [ x5, inside(x5) - (doGusset ? Gusset_Width : 0) ]];

  x6 = x4 - Gusset_Thickness + EPSILON;
  in6 = [ if (doGusset && !doBase) [ x6, inside(x6) - Gusset_Width ]];

  x7 = x4 - Gusset_Thickness;
  in7 = [[ x7, inside(x7) ]];

  x8 = L + EPSILON;
  in8 = [ if (doShoulderInset) [ x8, inside(x8) ]];

  x9 = L;
  in9 = [ if (doShoulderInset) [ x9, inside(x9) ]];

  x10 = L - W_t;
  in10 = [ if (doShoulderInset) [ x10, inside(x10) ]];

  x10b = L - W_t - EPSILON;
  in10b = [ if (doShoulderInset) [ x10b, inside(x10b) ]];

  x12 = minX + Tab_Length + Gusset_Thickness;
  in12 = [[ x12, inside(x12) ]];

  x13 = x12 - EPSILON;
  in13 = [ if (doGusset) [ x13, inside(x13) - Gusset_Width ]];

  x14 = x12 - Gusset_Thickness + EPSILON;
  in14 = [ if (doGusset) [ x14, inside(x14) - Gusset_Width ]];

  x15 = x12 - Gusset_Thickness;
  in15 = [[ x15, inside(x15) ]];

  function obstructed(x) =
       (doTab && (x4 <= x && x <= x0))
    || (doGusset && (x7 <= x && x <= x4))
    || (doGusset && (x15 <= x && x <= x12))
    || (doShoulderInset && (x10b <= x && x <= x8));

  in11 = [ for (p = getSubshell(Inner_Shell, minX, maxX - EPSILON)) if (!obstructed(p.x)) p ];

  outside_pts = quicksortPts(concat(getSubshell(Outer_Shell, minX, maxX), out0, out1));
  inside_pts = quicksortPts(concat(in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10,
                                   in10b, in11, in12, in13, in14, in15));
  all_pts = buildPolyPts(outside_pts, inside_pts);

  allRadii = [ for (p = all_pts) p.y ];
  minR = min(allRadii);
  maxR = max(allRadii);

  minP = min(Printer_X, Printer_Y);
  maxP = max(Printer_X, Printer_Y);

  function fits(deg) =
    let (length = 2 * maxR * sin(deg), width = maxR - minR * cos(deg))
    ((length <= maxP) && (width <= minP)) || ((length <= minP) && (width <= maxP));

  function firstFit(n) = (fits(180/n) || (n > 35)) ? n : firstFit(n+1);

  nChunks = (Ignore_Printer_Size || 2 * maxR <= minP) ? 1 : firstFit(2);

  echo(str("Layer #", layer_id, " => ", nChunks, " sections,  radii=[ ", minR , " .. ", maxR, " ]"));
  genSection(all_pts, 360 / nChunks, 4 * Smoothness);

  if (nChunks > 1) {
    i = min(findPtY(inside_pts, 2 * Tab_Thickness, 0), len(inside_pts)-1);
    xa = max((doGusset) ? x12 : minX + Tab_Length, inside_pts[i].x);

    xb = (doBase) ? FullLen - W_t : (doGusset) ? x7 : (doTab) ? x4 : maxX;

    if (doShoulderInset) {
      doHorizontalTab(xa, min(xb, x10b), maxR);
      doHorizontalTab(max(xa, x10), xb, maxR);
    } else {
      doHorizontalTab(xa, xb, maxR);
    }
  }
}


scale([Base_Units, Base_Units, Base_Units]) {
  solidLength = FullLen - domain[0];
  nLayers = Ignore_Printer_Size ? 1 : ceil(solidLength / Printer_Z);
  layerHeight = solidLength / nLayers;
  layerGap = 25.4 / Base_Units; // == 1 inch

  echo(str("NOSE CONE: ", cone_name, "   R=", R, ", L=", L, ", Layers=", nLayers));
  for (layer = [1 : nLayers]) {
    translate([0,0,(nLayers - layer) * layerGap]) {
      doNoseCone(layer, (layer - 1) * layerHeight + domain[0], layer * layerHeight + domain[0]);
    }
  }
}
