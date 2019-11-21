// Hexaflaxagon by whpthomas

hexaflexagon();

//the length of the triangle edges
tri_length=30;

//the height and radius of the triangles
tri_height=6;

//the hinge tolerance
tolerance=0.2;

/////////////////////////////////////////////////////////////

tri_depth=tri_height+tolerance;
tri_rad=tri_height/2;
tri_adj=tri_length/2;
tri_opp=(tri_length/2)*tan(30);
tri_hyp=sqrt( (tri_adj*tri_adj) + (tri_opp*tri_opp));

hinge_len=tri_length*0.4;
hinge_rad=tri_rad-0.4;

link_len=hinge_len-tolerance;
plate_offset=tri_length + tri_depth/tan(30);
$fn=20*1;

module hexaflexagon() translate([-plate_offset,0,0]) {
  // 0 = triangle
  // 1 = star
  // 2 = circle
  echo("Pause @ zPos", 1);
  echo("Pause @ zPos", tri_rad*2 - 1);
  echo("Length", plate_offset*5);
  translate([-plate_offset,0,0]) single(top=0, bottom=1, slit=1);
  pair(t1=2, b1=1, t2=2, b2=0);
  translate([plate_offset,0,0]) pair(t1=1, b1=0, t2=1, b2=2);
  translate([plate_offset*2,0,0]) pair(t1=0, b1=2, t2=0, b2=1);
  translate([plate_offset*3,0,0]) pair(t1=2, b1=1, t2=2, b2=0);
}

module pair(t1=0, b1=0, t2=0, b2=0) {
single(top=t2, bottom=b2);
rotate([0,0,30]) translate([-tri_opp-tri_depth,0,0])
mirror([0,1,0]) translate([-tri_opp,0,0]) rotate([0,0,30]) {
single(top=t1, bottom=b1);
}}

module single(top=0, bottom=0, slit=0) {
tri(top, bottom);
link(slit);
}

module tri(top=0, bottom=0) {
translate([0,0,tri_rad]) {
difference() {
union() {
  triEdge();
  rotate([0,0,120]) triEdge();
  rotate([0,0,240]) triEdge();
  translate([0,0,-tri_rad]) linear_extrude(height=tri_rad*2) polygon([
    [tri_adj, tri_opp],
    [-tri_adj, tri_opp],
    [0, -tri_hyp]
  ]);
}
  rotate([0,0,120]) triHingeCutout();
  rotate([0,0,240]) triHingeCutout();
  topBadge(type=top);
  bottomBadge(type=bottom);
}}}

module triEdge() {
translate([0,tri_opp,0]) {
  rotate([0,90,0]) cylinder(h=tri_length,r=tri_rad,center=true);
  translate([tri_adj,0,0]) sphere(tri_rad);
}}

module triHingeCutout() {
union() {
  translate([-hinge_len/2,tri_opp-tri_depth/2,-tri_depth/2]) cube([hinge_len, tri_depth, tri_depth]);
  translate([0,tri_opp,0]) linkPin();
}}

module link(slit=0) {
translate([0,0,tri_rad]) rotate([0,0,120]) difference() { 
union() {
  translate([0,tri_opp,0]) linkPin(tolerance);
  translate([0,tri_opp+tri_depth,0]) linkPin(tolerance);
  translate([(tolerance-hinge_len)/2,tri_opp,-tri_rad]) cube([link_len, tri_depth, tri_rad*2]);
}
if(slit) translate([0,tri_opp+tri_depth,0]) rotate([0,90,0]) cylinder(h=hinge_len/6,r=tri_rad*3/2, center=true);
}}

module linkPin(tol=0) {
union() {
  if(tol==0) {
    translate([(hinge_len-tol-0.01)/2,0,0]) rotate([0,90,0]) cylinder(h=hinge_rad*4/3,r1=hinge_rad,r2=0);
    translate([(tol-hinge_len+0.01)/2,0,0]) rotate([0,270,0]) cylinder(h=hinge_rad*4/3,r1=hinge_rad,r2=0);
  }
  else {
    translate([(hinge_len-tol-0.01)/2,0,0]) rotate([0,90,0]) cylinder(h=hinge_rad,r1=hinge_rad,r2=hinge_rad/4);
    translate([(tol-hinge_len+0.01)/2,0,0]) rotate([0,270,0]) cylinder(h=hinge_rad,r1=hinge_rad,r2=hinge_rad/4);
  }
  translate([(tol-hinge_len)/2,0,0]) rotate([0,90,0]) cylinder(h=hinge_len-tol,r=tri_rad);
}}

module topBadge(type=0) translate([0,0,tri_rad-0.5]) {
  if(type==0) triBadge();
  if(type==1) strBadge();
  if(type==2) cirBadge();
}

module bottomBadge(type=0) translate([0,0,0.5-tri_rad]) {
  if(type==0) triBadge();
  if(type==1) strBadge();
  if(type==2) cirBadge();
}

module triBadge() translate([0,0,-0.6]) {
linear_extrude(height=1.2) polygon([
    [tri_adj/4, tri_opp/4],
    [-tri_adj/4, tri_opp/4],
    [0, -tri_hyp/4]
  ]);
}

module strBadge() {
cylinder(r=tri_length*0.15, h=1.2, center=true, $fn=3);
rotate([0,0,60]) cylinder(r=tri_length*0.15, h=1.2, center=true, $fn=3);
}

module cirBadge() {
cylinder(r=tri_length/9, h=1.2, center=true);
}