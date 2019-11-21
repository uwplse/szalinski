// "Whatchamagear" provided by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// under Creative Commons License, Attribution (BY)
//
// Remix of "non-circular gear" by Stellar Innovation
//
// Changes:
// 2019-08-31 Original version
// 2019-08-31 "All Parts" view now correctly rotates "second gear" 
// 2019-09-27 Increased distance between gears in "All Parts"

// Part to print
partToPrint = 0; // [0: show assembled, 1: all parts, 2: first gear, 3: second gear, 4 : holder]

// Axle diameter 
axleDiameter = 30; // [20:50]

// Thickness of gear
gearThickness = 8; // [5:25]

// Eccentricity of reference gear (0=circle, 1 would be unbounded)
refEccentricity = 0.25; // [0:0.01:0.8]

// Number of teeth per lobe
numTeethPerLobe = 9;  // [5:2:49]

// Number of lobes, first gear
numLobes1 = 3; // [1:12]

// Number of lobes, second gear
numLobes2 = 4; // [1:12]

//
// More parameters (fixed in Customizer)
//

// desired axle distance
desiredAxleDistance = 1.6*axleDiameter;

// Normal backlash [mm] (there gotta be some!)
normalBacklash = 1*0.4; // [0:0.1:0.9]

// Axle clearance
axleClearance = 1*0.2;

// Holder thickness
holderWallThickness = 1*2.4;

// number of subdivisions of a half-lobe (when computing arc length)
Nsamples = 1*100;  

// true to echo gear specification
printSpec = (1+1==2);

// Pressure angle
pressureAngle = 1*20;

rad2deg = 180/PI;
deg2rad = PI/180;

// Convert eccentricity and scale from reference gear to given num. lobes
refNumLobes = 1*1; // Reference gear has a single lobe
eccentricity1 = computeEccentricity(refEccentricity, refNumLobes, numLobes1);
eccentricity2 = computeEccentricity(refEccentricity, refNumLobes, numLobes2);
refScaleFactor1 = computeScaleFactor(refEccentricity, refNumLobes, eccentricity1, numLobes1);
refScaleFactor2 = computeScaleFactor(refEccentricity, refNumLobes, eccentricity2, numLobes2);


// reference min. radius
refMinRadius = min(refScaleFactor1/(1+eccentricity1), refScaleFactor2/(1+eccentricity2));

// modulus of the reference gear
refModulus = computeReferenceModulus(refEccentricity);

// At least a scale factor, s, such that
// s(minRadius - 1.25m) > axleDiameter/2 + margin
minScaleFactor = (0.5*axleDiameter + holderWallThickness + axleClearance)/max(refMinRadius - 1.25*refModulus, 0.001);

// reference axle distance
refAxleDistance = refScaleFactor1/(1+eccentricity1) + refScaleFactor2/(1-eccentricity2);

// Or, choose a scale factor to get the desiredAxleDistance
refScaleFactor = max(desiredAxleDistance/refAxleDistance, minScaleFactor);
scaleFactor1 = refScaleFactor*refScaleFactor1;
scaleFactor2 = refScaleFactor*refScaleFactor2;

axleDistance = refScaleFactor*refAxleDistance;

if (printSpec) {
  echo("num Lobes: ", numLobes1, numLobes2);
  echo("scale: ", scaleFactor1, scaleFactor2);
  echo("eccentricity: ", eccentricity1, eccentricity2);
  echo("min Radius: ", scaleFactor1/(1+eccentricity1), scaleFactor2/(1+eccentricity2));
  echo("max Radius: ", scaleFactor1/(1-eccentricity1), scaleFactor2/(1-eccentricity2));
  echo("axle Distance: ", axleDistance);
  echo("modulus: ", refScaleFactor*refModulus);
}

if (partToPrint==0)
  ShowAssembled();
else if (partToPrint==1)
  AllParts();
else if (partToPrint==2)
  color([0,1,0])
    NonCircularGearPart(scaleFactor1, eccentricity1, numLobes1);
else if (partToPrint==3)
  color([0,0,1])
    NonCircularGearPart(scaleFactor2, eccentricity2, numLobes2); 
else
  color([0,0,0])
    HalfAHolderPart();  

module AllParts() {
  isEven = (numLobes2 % 2) == 0;
  rot2 = (isEven)? 180/numLobes2 : 0;
  m = refScaleFactor*refModulus;
  maxR1 = scaleFactor1/(1-eccentricity1);
  maxR2 = scaleFactor2/(1-eccentricity2);
  maxR = max(maxR1, maxR2);
  axleR = 0.5*axleDiameter + holderWallThickness;  
  andSome = 1;
    
  translate([-maxR1-m-andSome,0])
    rotate(180/numLobes1)
      color([0,1,0])
        NonCircularGearPart(scaleFactor1, eccentricity1, numLobes1);
  translate([maxR2+m+andSome,0])
    rotate(rot2)
      color([0,0,1])
        NonCircularGearPart(scaleFactor2, eccentricity2, numLobes2);
  y0 = axleR+maxR+m+andSome;
  for (y=[-y0,+y0])
    translate([-0.5*axleDistance, y])
      color([0,0,0])
        HalfAHolderPart();
}

module ShowAssembled() {
  z0 = holderWallThickness + 0.8;
  isEven = (numLobes2 % 2) == 0;
  rot2 = (isEven)? 180/numLobes2 : 0;
    
  color([0,0,0]) {
    HalfAHolderPart();
    translate([axleDistance,0,2*z0+gearThickness])
      rotate([180,0,180])
          HalfAHolderPart();
  }
  
  translate([0,0,z0])
    color([0,1,0])
      NonCircularGearPart(scaleFactor1, eccentricity1, numLobes1);
  translate([axleDistance,0,z0])
    color([0,0,1])
      rotate(rot2)
        NonCircularGearPart(scaleFactor2, eccentricity2, numLobes2);
}

module HalfAHolderPart() {
  HalfAHolder(axleDistance = axleDistance,
               axleDiameter = axleDiameter - axleClearance,
               axleLength = gearThickness,
               wallThickness = holderWallThickness);
}

module NonCircularGearPart(s, e, k) {
  linear_extrude(height = gearThickness) {
    NonCircularGear2D(s, e, k, 0.5*normalBacklash);
  }    
}

// 2D-rendering of the gear

module NonCircularGear2D(s, e, k, jn=0) {
  arcLength = computeArcLength(s, e, k);
  hll = arcLength[Nsamples];
  pitch = 2*hll/numTeethPerLobe;
  m = pitch/PI;
  
  difference() {
    union() {
      intersection() {
        polygon(traceGear(arcLength, s, e, k, jn));
        polygon(curveWithOffset(s, e, k, dH=m));
      }
      polygon(curveWithOffset(s, e, k, dH=-1.25*m));
    }
    
    circle(d=axleDiameter + axleClearance, $fn=60);
  }
}


function hypot(x, y) = sqrt(x*x+y*y);

function polar2xy(r, phi) = let (a = phi*rad2deg) [r*cos(a), r*sin(a)];

// r(phi), radius of the elliptic curve, phi in radians
function radius(s, e, k, phi) = s/(1-e*cos(k*rad2deg*phi));

function pointXY(s, e, k, phi) = polar2xy(radius(s, e, k, phi), phi);

// Intersection point of the lines p1-p2 and q1-q2
function intersect(p1, p2, q1, q2) = let (
  // Solve p1 + t(p2 - p1) = q1 + u(q2 - q1)
  x1 = p1[0], y1 = p1[1],
  dx1 = p2[0] - x1, dy1 = p2[1] - y1,
  x2 = q1[0], y2 = q1[1],
  dx2 = q2[0] - x2, dy2 = q2[1] - y2,
  det = dx1*dy2 - dx2*dy1,
  t = (-dy2*(x1-x2) + dx2*(y1-y2))/det 
)
  [ x1 + t*dx1, y1 + t*dy1];

// Tangent of the curve
function tangent(s, e, k, phi) = let (
  phi_deg = phi*rad2deg,
  r_s = 1/(1 - e*cos(k*phi_deg)),
  dr_s = -r_s*r_s*e*k*sin(k*phi_deg),
  cos_phi = cos(phi_deg),
  sin_phi = sin(phi_deg),
  dx = dr_s*cos_phi - r_s*sin_phi,
  dy = dr_s*sin_phi + r_s*cos_phi,
  u = 1/hypot(dx, dy)
)
  [u*dx, u*dy];
  
// Normal of the curve
function normal(s, e, k, phi) = let (t = tangent(s, e, k, phi))
  [t[1], -t[0]];

// Outset (dH>0) or Inset (dH<0) of the curve
function pointWithOffset(s, e, k, dH, phi) = let (
  Pref = pointXY(s, e, k, phi),
  N = normal(s, e, k, phi)
)
  [Pref[0] + dH*N[0], Pref[1] + dH*N[1]];
  
// Curve rendered with an offset of dH
function curveWithOffset(s, e, k, dH, $fn=100) = [
  for (i=[0:$fn-1]) let (phi=2*PI*i/$fn) pointWithOffset(s, e, k, dH, phi)
];


// Conversion from reference gear to different number of lobes  
// ------------------------------------------------------------------------------

function computeEccentricity(e1, k1, k2) = let (
  C = k1*k1*e1*e1/(k2*k2*(1-e1*e1))
)
  sqrt(C/(1+C));

function computeScaleFactor(e1, k1, e2, k2) = 
  (e2==0)? (k2/k1) : (e1*(1-e2*e2)/(1-e1*e1)/e2);


function computeReferenceModulus(e) = let (
  arcLength = computeArcLength(1.0, e, 1),
  hll = arcLength[Nsamples],
  pitch = 2*hll/numTeethPerLobe
)
  pitch/PI;

// Arc length
// -------------

// Computes Nsamples+2 samples of arc length
// arcLength[0] = 0
// arcLength[Nsamples] = arc length of a half lobe
// arcLength[Nsamples+1] = arc length, one subdivision beyond a half-lobe

function computeArcLength(s, e, k) = let (
  rollLine = [ for (i=[0:Nsamples+1]) let (
                 phi = PI/k * i/Nsamples,
                 r = radius(s, e, k, phi)
               )
                 polar2xy(r, phi)
             ],
  segLength = [ for (i=[0:Nsamples]) let (
                   x1 = rollLine[i][0],
                   y1 = rollLine[i][1],
                   x2 = rollLine[i+1][0],
                   y2 = rollLine[i+1][1]
                 )
                   hypot(x2-x1, y2-y1)
               ]
)
  accumulate(segLength, Nsamples+1);

// returns a list of the n first accumulative sums of the elemens in seg
// First element is zero, then seg[0], then seg[0]+seg[1] and so on
function accumulate(seg, n) = let (
    a = (n==0)? [] : accumulate(seg, n-1),
    s = (n==0)? 0 : a[len(a)-1] + seg[n-1]
  )
    concat(a, [s]);

// computes phi (angle in radians) that corresponds to given arc length
// arcLength is the result of computeArcLength (a list of arc lengths),
// halfLobePhi = PI/number-of-lobes
// length = the given arc length (for which phi is determined)

function interpolPhi(arcLength, halfLobePhi, length) = let (
  lobeLength = 2*arcLength[Nsamples],
  nPeriods = floor(length/lobeLength + 0.5),
  remainder = length - nPeriods*lobeLength,
  s = sign(remainder),
  i = findIndex(arcLength, abs(remainder), 0, Nsamples+2),
  f = (abs(remainder) - arcLength[i])/(arcLength[i+1] - arcLength[i])
)
  (2*nPeriods + s*(i + f)/Nsamples) * halfLobePhi;

// find index, i, in accLength such that accLength[i] <= length < accLength[i+1]   
function findIndex(accLength, length, lo, hi) = let (m = floor((lo+hi)/2))
  (lo==m)? m 
  : ((length < accLength[m])? findIndex(accLength, length, lo, m)
  : findIndex(accLength, length, m, hi));
  
// computes arc length of given phi
// arcLength is the result of computeArcLength (a list of arc lengths),
// halfLobePhi = PI/number-of-lobes
// phi is angle in radians
function interpolLength(arcLength, halfLobePhi, phi) = let (
  halfLobeLength = arcLength[Nsamples],
  nPeriods = floor(0.5*phi/halfLobePhi + 0.5),
  remainder = phi - nPeriods*2*halfLobePhi,
  s = sign(remainder),
  i = floor(abs(remainder)*Nsamples/halfLobePhi),
  f = abs(remainder)*Nsamples/halfLobePhi - i
)
  (2*nPeriods + s*(i+f)/Nsamples) * halfLobeLength;
  
// Trace rack around curve
// -------------------------------

// Computes the 2D-coordinates of an entire gear 
// arcLength is the result of computeArcLength (a list of arc lengths),
// (s, e, k) are the parameters of the elliptic curve
// jn is the normal backlash
function traceGear(arcLength, s, e, k, jn) = let (
    pitch = 2*arcLength[Nsamples]/numTeethPerLobe,
    m = pitch/PI
)
  [ for (i=[0:k*numTeethPerLobe-1], 
        p=traceTooth(arcLength, s, e, k, m, jn, i*pitch)) p ];

// Computes the 2D-coordinates of a single tooth 
// arcLength is the result of computeArcLength (a list of arc lengths),
// (s, e, k) are the parameters of the elliptic curve
// m is the modulus
// jn is the normal backlash
// Ltip is the arc length at the tip of the tooth
function traceTooth(arcLength, s, e, k, m, jn, Ltip) = let (
  jt = 0.5*jn/cos(pressureAngle),
  halfMinus = traceHalfATooth(arcLength, s, e, k, m, Ltip+jt, -1),
  halfPlus =  traceHalfATooth(arcLength, s, e, k, m, Ltip-jt, +1),
  lastI = findTip(halfMinus, len(halfMinus)-1, halfPlus, len(halfPlus)-1),
  last1 = lastI[0],
  last2 = lastI[1],
  tip = (last1 < len(halfMinus)-1 && last2 < len(halfPlus)-1)?
       [ intersect(halfMinus[last1], halfMinus[last1+1],
                 halfPlus[last2], halfPlus[last2+1]) ]
        : []
  )
  concat([[0,0]], [ for (i=[0:last1]) halfMinus[i] ],  tip, [ for (i=[last2:-1:0]) halfPlus[i] ]);

// Finds the "last" indices prior to the tool tip
// Normally that is the last index of each traced half-tooth [end1, end2]
// In exceptional cases the traces intersect, in which case the two indices
// (one in ppt1, one in ppt2) immediately before the intersection is returned.
function findTip(ppt1, end1, ppt2, end2) = let (
  arg1 = atan2(ppt1[end1][1], ppt1[end1][0]),
  arg2 = atan2(ppt2[end2][1], ppt2[end2][0]),
  r1 = hypot(ppt1[end1][1], ppt1[end1][0]),
  r2 = hypot(ppt2[end2][1], ppt2[end2][0])
)
  ((arg1 < arg2 && arg1 > arg2-180) || arg1 > arg2+180)? [end1, end2]
  : ((r1 < hypot(ppt2[end2-1][1], ppt2[end2-1][0]))? findTip(ppt1, end1, ppt2, end2-1)
  : ((r2 < hypot(ppt1[end1-1][1], ppt1[end1-1][0]))? findTip(ppt1, end1-1, ppt2, end2)
  : findTip(ppt1, end1-1, ppt2, end2-1)));

// Computes the 2D-coordinates of a single tooth 
// arcLength is the result of computeArcLength (a list of arc lengths),
// (s, e, k) are the parameters of the elliptic curve
// m is the modulus
// Ltip is the arc length at the tip of the tooth (+/- backlash)
// dir is the "direction" of the half-tooth (+1 or -1)
function traceHalfATooth(arcLength, s, e, k, m, Ltip, dir) = let (
  pitch = m*PI,
  Lref = Ltip + 0.25*dir*pitch,
  dTfull = m/tan(pressureAngle),
  dLfull = dTfull + m*tan(pressureAngle),
  ppt = [ for (h=[-1:0.1:+1]) let (
      dL = h*dir*dLfull,
      phi = interpolPhi(arcLength, PI/k, Lref - dL),
      Pt = polar2xy(radius(s, e, k, phi), phi)
    )
    pressurePoint(Pt, tangent(s, e, k, phi), dT=h*dir*dTfull, dH=h*m)
  ],
  i0 = findUndercut(ppt),
  h0 = -1 + 0.1*i0,
  ucp = (i0==0)? [] : traceUndercut(arcLength, s, e, k, m, Lref, dir, h0, hypot(ppt[i0][0], ppt[i0][1])),
  p0 = (len(ucp)==0)? ppt[0] : ucp[0],
  fp = traceFillet(s, e, k, m, 0.1*m, p0, dir)
)
  concat(fp, ucp, [ for (i=[i0:len(ppt)-1]) ppt[i] ]);
   
// Computes pressure point = Pt + dT*tangent + dH*normal
function pressurePoint(Pt, tangent, dT, dH) = let (
)
  [Pt[0] + dT*tangent[0] + dH*tangent[1],
   Pt[1] + dT*tangent[1] - dH*tangent[0]];
  
// Identifies and removes unused points from coordinate trace
// (these points are replaced by the result of traceUndercut)
function findUndercut(points, i=0, lastR=undef) = let (
  r0 = (i==0)? hypot(points[i][0], points[i][1]) : lastR,
  r1 = hypot(points[i][0], points[i][1])
 )
(r0 < r1)? i : findUndercut(points, i+1, r1);
  
// Traces the tip/corner of the rack to create an undercut tooth
function traceUndercut(arcLength, s, e, k, m, Lref, dir, h0, r0) = let (
  L0 = m*dir*tan(pressureAngle),
  dLfull = m/cos(pressureAngle)/sin(pressureAngle),
  ucp = [ for (h=[h0:-0.1:-1]) let (
      dL = h*dir*dLfull,
      phi = interpolPhi(arcLength, PI/k, Lref - dL),
      Pt = polar2xy(radius(s, e, k, phi), phi)
    )
    pressurePoint(Pt, tangent(s, e, k, phi), dT=L0+dL, dH=-m)
  ],
  ucpLen = undercutLength(ucp, r0)   
)
  [ for (i=[0:ucpLen-1]) ucp[i] ];
  
// Number of points to use from the undercut trace
function undercutLength(ucp, r0, i=0) = 
  (len(ucp) == i || hypot(ucp[i][0], ucp[i][1]) > r0)? i : undercutLength(ucp, r0, i+1);

// Trace fillet at the base of the tooth
function traceFillet(s, e, k, m, rf, p0, dir) = let (
  phi = findPhi(s, e, k, p0),
  Pref = pointXY(s, e, k, phi),
  T = tangent(s, e, k, phi),
  hD = 1.25*m,
  h1 = hD - rf
)
[ [Pref[0] + dir*rf*T[0] - hD*T[1], Pref[1] + dir*rf*T[1] + hD*T[0]],
  [Pref[0] - h1*T[1], Pref[1] + h1*T[0]] ];

// find phi, such that a given point, p, lies on the normal from
// that point on the elliptic curve
function findPhi(s, e, k, p) = let (
  phi0 = atan2(p[1], p[0])*deg2rad,
  phi1 = normalIter(s, e, k, phi0, p)
)
  normalIter(s, e, k, phi1, p);
  
// Iteration to improve an approximation of phi
function normalIter(s, e, k, phi, p) = let  (
  Pref = pointXY(s, e, k, phi),
  T = tangent(s, e, k, phi),
  dT = T[0]*(Pref[0] - p[0]) + T[1]*(Pref[1] - p[1])
)
  atan2(Pref[1] - dT*T[1], Pref[0] - dT*T[0])*deg2rad;
 

// Debug code
// --------------

// Position the tooth of a linear rack on the trace
// arcLength is the result of computeArcLength (a list of arc lengths),
// (s, e, k) are the parameters of the elliptic curve
// Ltip is the arc length at the tip of the tooth (+/- backlash)
// dir is the "direction" of the half-tooth (+1 or -1)
// -1 <= h <= +1 is the "height" of the pressure point (in units of
// the modulus). h=-1 corresponds to the tip/corner of the rack, which
// is closest to the center of the gear. h=+1 corresponds to the base of
// the rack, which is furthest away. h=0 corresponds to the reference
// line of the rack.

module RackTooth(arcLength, s, e, k, Ltip=0, dir=1, h=0) {
    pitch = 2*arcLength[Nsamples]/numTeethPerLobe;
    m = pitch/PI;
    Lref = Ltip + 0.25*dir*pitch;
    dH = h*m;
    dT = h*m*dir/tan(pressureAngle);
    dL = h*m*dir/cos(pressureAngle)/sin(pressureAngle);
    phi = interpolPhi(arcLength, PI/k, Lref - dL);
    Pt = polar2xy(radius(s, e, k, phi), phi);
    tau = tangent(s, e, k, phi);
    ny = normal(s, e, k, phi);

    translate(Pt)
    rotate(atan2(tau[1], tau[0]))
    translate([dL + (1+dir)*0.25*pitch, 0])
    { 
      y1 = m;
      x1 = m*tan(pressureAngle);
      y2 = 1.25*m;
      x3 = 0.25*pitch;
      y3 = y2+2;
      x4 = -0.75*pitch;
      x5 = -0.5*pitch - x1;
      x6 = -0.5*pitch + x1;
      polygon([[-x1, y1], [x1, -y1], [x1, -y2], [x3, -y2], [x3, -y3],
               [x4, -y3], [x4, -y2], [x5, -y2],  [x5, -y1], [x6, y1]]);
    }
    
   // white = reference point (on the gear)
   phi0 = interpolPhi(arcLength, PI/k, Lref);
   translate(polar2xy(radius(s, e, k, phi0), phi0))
     color([1, 1, 1])
       circle(d=1, $fn=12);
       
    // black = top/corner of rack profile
    tt = dL+m*dir*tan(pressureAngle);
    translate([Pt[0] + tt*tau[0] - m*ny[0], Pt[1] + tt*tau[1] - m*ny[1]])
      color([0, 0, 0])
        circle(d=1, $fn=12);
        
    // green = tangent point
    translate(Pt)
     color([0, 1, 0])
       circle(d=1, $fn=12);

    // blue = projection of pressure point onto tangent 
    translate([Pt[0] + dT*tau[0], Pt[1] + dT*tau[1]])
      color([0, 0, 1])
        circle(d=1, $fn=12);
        
    // red = pressure point
    translate([Pt[0] + dT*tau[0] + dH*ny[0], Pt[1] + dT*tau[1] + dH*ny[1]])
      color([1, 0, 0])
        circle(d=1, $fn=12);
  }

                 
module HalfAHolder(axleDistance, axleDiameter, axleLength, wallThickness) {
  hexDiameter = axleDiameter - 2*wallThickness;    
  twiceHexApothem = sqrt(0.75)*hexDiameter;
  innerDiameter = max(twiceHexApothem - 2*wallThickness, 0);
  discDiameter = axleDiameter + 2*wallThickness;
    
    
  rf = 0.25*(discDiameter-innerDiameter);
  r1 = 0.5*discDiameter + rf;
  y1 = 0.5*innerDiameter + rf;
  x1 = sqrt(r1*r1 - y1*y1);  
  x2 = axleDistance - x1;
  difference() {
    union() {
      // Hubs
      Hub(innerDiameter, hexDiameter, axleDiameter, discDiameter, axleLength, wallThickness, socket=true);
      translate([axleDistance, 0])
        Hub(innerDiameter, hexDiameter, axleDiameter, discDiameter, axleLength, wallThickness, socket=false);
      // Bar
      translate([0, -0.5*innerDiameter])
        cube([axleDistance, innerDiameter, wallThickness]);
      // Fillets
      linear_extrude(height=wallThickness) {
        polygon([[0,0], [x1,-y1], [x1, y1]]);
        polygon([[axleDistance,0], [x2,y1], [x2, -y1]]);
      }
    }

    // Holes
    for (x=[0, axleDistance])
      translate([x,0])
        cylinder(d=innerDiameter, h=axleLength + 2*wallThickness + 2.6, $fn=120);  
    // Fillets
    for (x=[x1, x2], y=[-y1,+y1])
      translate([x,y])
        cylinder(r=rf, h=wallThickness, $fn=30);
  }    
}

module Hub(innerDiameter, hexDiameter, axleDiameter, discDiameter, axleLength, wallThickness, socket) {
  tol = 0.2;
  z0 = wallThickness;       // floor
  h1 = 0.6;                 // disc
  z1 = z0 + h1;
  h2 = 0.5*axleLength + tol; // axle
  z2 = z1 + h2;
  h3 = 2;                  // connector
  z3_plus = z2 + h3;
  andSome = 0.6;
  z3_minus = z2 - h3 - andSome;
  
  hex_tol = tol/sqrt(0.75);
        
  difference() {
    union() {
      cylinder(d=axleDiameter, h=z2, $fn=120);
      cylinder(d=discDiameter, h=z1, $fn=120);
      if (!socket)
        cylinder(d=hexDiameter - hex_tol, h=z3_plus, $fn=6);
    }
 
    if (socket)
      translate([0,0,z3_minus]) 
        cylinder(d=hexDiameter + hex_tol, h=z3_plus, $fn=6);
  }
}
