// Olfa Knife Cap by Hans Loeblich
// License: CC BY (Creative Commons Attribution)

// Wall thickness of cap
th = 0.8;
// Diameter of knife where cap will friction-fit
baseD = 11.2;
// Length of base section which friction fits onto knife
baseLength = 6;
// Amount of indentation per side after base section (interior space for blade will be baseD - 2*baseIndent)
baseIndent = 0.8;
// Length of cap extending beyond the base (internal dimension)
tipLength = 36;
view_cutaway = false;

/* [Hidden] */
$fs = 0.4;
$fa = 0.1;

id = baseD-baseIndent*2;
r1 = id/4;
r2 = r1+th;


points = concat(
  arc(r=r2,angle=90, offsetAngle=0, c=[baseD/2-baseIndent-r1,baseLength+tipLength+th-r2]),
  [
    [0,baseLength+tipLength+th], [0,baseLength+tipLength]
  ],
  arc(r=r1,angle=-90, offsetAngle=90, c=[baseD/2-baseIndent-r1,baseLength+tipLength+th-r2]),
  [
    [baseD/2-baseIndent, baseLength], [baseD/2, baseLength],
    [baseD/2,th/2],
    [baseD/2+th/2,0], [baseD/2+th,0],
    [baseD/2+th,baseLength+th], [baseD/2+th-baseIndent,baseLength+baseIndent+th]
  ]
);

if (view_cutaway) {
  polygon(points);
} else { 
  //rotate([180,0,0])
    rotate_extrude() polygon(points);
}

// create arc shaped list of points (from FunctionalOpenSCAD)
function arc(r=1, angle=360, offsetAngle=0, c=[0,0], center=false, internal=false, d, fragments, endpoint) = 
  let (
    r1 = d==undef ? r : d/2,
    fragments = fragments==undef ? ceil((abs(angle) / 360) * fragments(r1,$fn)) : fragments,
    step = angle / fragments,
    a = offsetAngle-(center ? angle/2 : 0),
    R = internal ? to_internal(r1) : r1,
    last = endpoint==undef ? (abs(angle) == 360 ? 1 : 0) : (endpoint ? 0 : 1)
  )
  [ for (i = [0:fragments-last] ) let(a2=i*step+a) c+R*[cos(a2), sin(a2)] ];

function fragments(r=1) = ($fn > 0) ? 
  ($fn >= 3 ? $fn : 3) : 
  ceil(max(min(360.0 / $fa, r*2*PI / $fs), 5));
