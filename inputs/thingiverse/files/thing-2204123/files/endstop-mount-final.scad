//use <../Libraries/drawPath.scad>

// Width of base
wBase = 20;
// Length of base
lBase = 25;
// Thickness of base
thBase = 5;
// Fillet radius
rFillet = 1;
// Thickness under bolt head
thBoltBase = 3;

// Length of switch body
lSwitch = 20;
// Width of switch body
wSwitch = 10;
// Thickness of switch body
thSwitch = 6;
// Distance between centers of holes on switch
boltSpacing = 9.57;
// Diameter of bolt holes on switch
dSwitchBolt = 2.5;

// Switch holding arms are offset from edge of the base to give better clearance from potential bolt heads on carriage
clearanceOffset = 2;

// Diameter of counterbore for bolt head
dBoltHead = 10;
// Diameter of bolt hole
dBolt = 5.3;

// Thickness of cable tie channel
thCableTie = 1.5;
// Width of cable tie channel
wCableTie = 5;

// Angle in degreess between bump edge and surface, around the edge of the bump
bumpAngle = 45; 

// Width across flats of nut
//wSwitchNut = 4;

/* [Hidden] */
$fa=2;
$fs=0.1;
err = 0.002;

// calculated
h0 = 10-thSwitch/2;
y0 = wSwitch+rFillet*2;

// distance from bolt counterbore to edge
wBoltPadding = (lBase-wSwitch-dBoltHead)/2;
// width of "pad" profile that is extruded to form the switch-holding arms
wPad = (wBase-thSwitch)/2-clearanceOffset;

// diameter of sphere used to make bump for the given bumpAngle
dSphere = dSwitchBolt/cos(bumpAngle);
// distance to set sphere into the arms for the given bumpAngle
sphereInset = dSphere*sin(bumpAngle)/2;

// Max width across points of nut
//dSwitchNut = 2*(wSwitchNut)/sqrt(3); // M2




endstopMount();

// display switch body mockup
//translate([(wBase+thSwitch-err)/2,0,thBase]) rotate([0,-90,0]) microswitch();







module endstopMount() {
  difference() {
    union() {
      linear_extrude(thBase, convexity=2) {
        baseProfile();
      }
      
      // right brace
      translate([wBase-wPad-clearanceOffset,0,thBase-err]) {
        linear_extrude(lSwitch-wPad+thCableTie, convexity=2) padProfile();
        translate([0,wSwitch,lSwitch-wPad+thCableTie]) rotate([90,0]) rotate_extrude2(angle=90, convexity=2)
          padProfile();
      }
      
      // left brace
      translate([clearanceOffset,0,thBase-err]) {
        linear_extrude(lSwitch-wPad+thCableTie, convexity=2) mirror([1,0]) translate([-wPad,0]) padProfile();
        translate([wPad,wSwitch,lSwitch-wPad+thCableTie]) rotate([90,0]) rotate(180) rotate_extrude2(angle=-90) padProfile();
      }
      
      // nubs for lining up holes
      for (i=[-1,1], j=[-1,1])
        translate([wBase/2+j*(thSwitch/2+sphereInset),wSwitch-(1.25+dSwitchBolt/2),thBase+lSwitch/2+i*boltSpacing/2]) 
          sphere(d=dSphere);
    }
    translate([wBase/2,lBase-wBoltPadding-dBoltHead/2]) 
      mountBolt();
    
    // radius'd cable tie channel
    r1 = wPad-thCableTie;
    translate([wPad+clearanceOffset+err,wCableTie/2+wSwitch/2,r1+thBase])rotate([90,0]) 
      rotate(180) rotate_extrude2(angle=90, convexity=2) translate([r1,0]) square([thCableTie,wCableTie]);
    // straight through cable tie channel
    translate([wBase-wPad-clearanceOffset,wCableTie/2+wSwitch/2,thBase])
      rotate([0,90,0]) translate([0,-wCableTie,-err]) linear_extrude(wPad+2*err, convexity=2) 
        square([thCableTie,wCableTie]);
  }
}


module baseProfile() {
  path = concat(
    arcPath(r=rFillet,angle=90,c=[wBase-rFillet,lBase-rFillet]),
    arcPath(r=rFillet,angle=90,offsetAngle=90,c=[rFillet,lBase-rFillet]),
    arcPath(r=rFillet,angle=90,offsetAngle=180,c=[rFillet,wSwitch+rFillet]),
    arcPath(r=rFillet,angle=-90,offsetAngle=90,c=[clearanceOffset-rFillet,wSwitch-rFillet]),
    arcPath(r=rFillet,angle=90,offsetAngle=180,c=[clearanceOffset+rFillet,rFillet]),
    arcPath(r=rFillet,angle=90,offsetAngle=270,c=[clearanceOffset+wPad-rFillet,rFillet]),
    arcPath(r=rFillet,angle=-90,offsetAngle=180,c=[clearanceOffset+wPad+rFillet,wSwitch-rFillet]),
    arcPath(r=rFillet,angle=-90,offsetAngle=90,c=[wBase-wPad-clearanceOffset-rFillet,wSwitch-rFillet]),
    arcPath(r=rFillet,angle=90,offsetAngle=180,c=[wBase-wPad-clearanceOffset+rFillet,rFillet]),
    arcPath(r=rFillet,angle=90,offsetAngle=270,c=[wBase-clearanceOffset-rFillet,rFillet]),
    arcPath(r=rFillet,angle=-90,offsetAngle=180,c=[wBase-clearanceOffset+rFillet,wSwitch-rFillet]),
    arcPath(r=rFillet,angle=90,offsetAngle=270,c=[wBase-rFillet,wSwitch+rFillet])
  
  );
  polygon(path);
}

module padProfile() {
  path = square([wPad,wSwitch],r=rFillet);
  difference() {
    polygon(path);
    translate([wPad-thCableTie,wSwitch/2-wCableTie/2]) square([thCableTie+err,wCableTie]);
  }
}

module microswitch() {
  color([0.3,0.3,0.3,0.5+err]) linear_extrude(thSwitch-2*err) difference() {
    square([lSwitch,wSwitch]);
    bolts2d();
  }
}

module mountBolt() {
  translate([0,0,thBase-thBoltBase]) 
    cylinder(d=dBoltHead,h=thBase);
  translate([0,0,-1]) 
    cylinder(d=dBolt,h=thBase);
}

module bolts2d() {
  for (i = [-1,1]) {
    translate([lSwitch/2+i*boltSpacing/2,wSwitch-(1.25+dSwitchBolt/2)]) 
      circle(d=dSwitchBolt);
  }
}

module nuts2d() {
  for (i = [0,1]) {
    translate([5.15+i*boltSpacing,wSwitch-(1.25+dSwitchBolt/2)]) 
      rotate(0) circle(d=dSwitchNut,$fn=6);
  }
}

// use <../Libraries/rotate_extrude.scad>;

// older versions of OpenSCAD do not support "angle" parameter for rotate_extrude
// this module provides that capability even when using older versions (such as thingiverse customizer)
module rotate_extrude2(angle=360, convexity=2, size=max(wBase+2,lBase+2)/2) {

  module angle_cut(angle=90,size=1000) {
    x = size*cos(angle/2);
    y = size*sin(angle/2);
    translate([0,0,-size]) 
      linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
  }

  // support for angle parameter in rotate_extrude was added after release 2015.03 
  // Thingiverse customizer is still on 2015.03
  angleSupport = (version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
  // Using angle parameter when possible provides huge speed boost, avoids a difference operation

  if (angleSupport) {
    rotate_extrude(angle=angle,convexity=convexity)
      children();
  } else {
    rotate([0,0,angle/2]) difference() {
      rotate_extrude(convexity=convexity) children();
      angle_cut(angle, size);
    }
  }
}

// use <../Libraries/drawPath.scad>

// based on get_fragments_from_r documented on wiki
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language
function fragments(r=1) = ($fn > 0) ? 
  ($fn >= 3 ? $fn : 3) : 
  ceil(max(min(360.0 / $fa, r*2*PI / $fs), 5));

// Draw a circular arc with center c, radius r, etc.
// "center" parameter centers the sweep of the arc about the offsetAngle (half to each side of it)
// "internal" parameter does enables polyhole radius correction
function arcPath(r=1, angle=360, offsetAngle=0, c=[0,0], center=false, internal=false) = 
  let (
    fragments = ceil((abs(angle) / 360) * fragments(r,$fn)),
    step = angle / fragments,
    a = offsetAngle-(center ? angle/2 : 0),
    R = internal ? r / cos (180 / fragments) : r,
    last = (angle == 360 ? 1 : 0)
  )
  [ for (i = [0:fragments-last] ) let(a2=i*step+a) c+R*[cos(a2), sin(a2)] ];

function circle(r=1, c=[0,0], internal=false, d) = 
  let(r1 = d==undef ? r : d/2)
  arcPath(r=r1,c=c,angle=-360,internal=internal);

function square(size=1, center=false,r=0) =
  let(
    x = len(size) ? size.x : size, 
    y = len(size) ? size.y : size,
    o = center ? [-x/2,-y/2] : [0,0],
    d = r*2
  )
  //assert(d <= x && d <= y)
  translate(o, 
    (r > 0 ? 
      concat(
        arcPath(r=r, angle=-90, offsetAngle=0,   c=[x-r,  r]), 
        arcPath(r=r, angle=-90, offsetAngle=270, c=[  r,  r]), 
        arcPath(r=r, angle=-90, offsetAngle=180, c=[  r,y-r]), 
        arcPath(r=r, angle=-90, offsetAngle=90, c=[x-r,y-r])
      ) :
      [[0,0],[0,y],[x,y],[x,0]]
    )
  );

function translate(v, points) = [for (p = points) p+v];

function scale(v=1, points) = let(s = len(v) ? v : [v,v,v])
  len(points) && len(points[0]) == 3 ? 
    [for (p = points) [s.x*p.x,s.y*p.y,s.z*p.z]] : 
    [for (p = points) [s.x*p.x,s.y*p.y]];  

// rotate a list of 3d points by angle vector v
// vector v = [pitch,roll,yaw] in degrees
function rotate(v, points) = 
  let(
    lv = len(v),
    V = (lv == undef ? [0,0,v] : 
      (lv > 2 ? v : 
        (lv > 1 ? [v.x,v.y,0] :
          (lv > 0 ? [v.x,0,0] : [0,0,0])
        )
      )
    ),
    cosa = cos(V.z), sina = sin(V.z),
    cosb = cos(V.y), sinb = sin(V.y),
    cosc = cos(V.x), sinc = sin(V.x),
    Axx = cosa*cosb,
    Axy = cosa*sinb*sinc - sina*cosc,
    Axz = cosa*sinb*cosc + sina*sinc,
    Ayx = sina*cosb,
    Ayy = sina*sinb*sinc + cosa*cosc,
    Ayz = sina*sinb*cosc - cosa*sinc,
    Azx = -sinb,
    Azy = cosb*sinc,
    Azz = cosb*cosc
  )
  [for (p = points)
    let( pz = (p.z == undef) ? 0 : p.z )
    [Axx*p.x + Axy*p.y + Axz*pz, 
     Ayx*p.x + Ayy*p.y + Ayz*pz, 
     Azx*p.x + Azy*p.y + Azz*pz]
  ];

// rotate about z axis without adding 3rd dimension to points
function rotate2d(a=0, points) = 
  let(
    cosa = cos(a),
    sina = sin(a)
  )
  [for (p = points) [p.x * cosa - p.y * sina,p.x * sina + p.y * cosa]];

