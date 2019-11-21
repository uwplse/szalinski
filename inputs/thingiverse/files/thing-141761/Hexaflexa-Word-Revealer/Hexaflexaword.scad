// Hexaflaxaword revealer by whpthomas

use <MCAD/fonts.scad>

hexaflexaword();

/* [Words] */

// the word to display on face one (6 letters max)
word1="Smile";

// the word to display on face two (6 letters max)
word2="AndBe";

// the word to display on face three (6 letters max)
word3="Happy";

/* [Triangles] */

// the length of the triangle edges
tri_length=24; // [24:44]

// the height and radius of the triangles
tri_height=6; // [5:10]

// the hinge tolerance
tolerance=0.2;

/* [Hidden] */

$fn=20;

// font

the_font = 8bit_polyfont();
font_width = the_font[0][0];
font_height = the_font[0][1];
font_scale = tri_length/24;
indicies1 = search(word1,the_font[2],1,1);
indicies2 = search(word2,the_font[2],1,1);
indicies3 = search(word3,the_font[2],1,1);
word_len1 = len(indicies1);
word_len2 = len(indicies2);
word_len3 = len(indicies3);

// triangle

tri_depth=tri_height+tolerance;
tri_rad=tri_height/2;
tri_adj=tri_length/2;
tri_opp=(tri_length/2)*tan(30);
tri_hyp=sqrt( (tri_adj*tri_adj) + (tri_opp*tri_opp));

// hinge

hinge_len=tri_length*0.4;
hinge_rad=tri_rad-0.4;

// link

link_len=hinge_len-tolerance;
plate_offset=tri_length + tri_depth/tan(30);

module hexaflexaword() rotate([0,0,180]) translate([-plate_offset,0,0]) {
  echo("Pause @ zPos", 1);
  echo("Pause @ zPos", tri_rad*2 - 1);
  echo("Length", plate_offset*5);
  translate([plate_offset*3,0,0]) pair(tw1=1, to1=0, tw2=1, to2=1, bw1=2, bo1=0, bw2=3, bo2=0);
  translate([plate_offset*2,0,0]) pair(tw1=2, to1=1, tw2=2, to2=2, bw1=3, bo1=1, bw2=1, bo2=2);
  translate([plate_offset,0,0]) pair(tw1=3, to1=2, tw2=3, to2=3, bw1=1, bo1=3, bw2=2, bo2=3);
  pair(tw1=1, to1=4, tw2=1, to2=5, bw1=2, bo1=4, bw2=3, bo2=4);
  translate([-plate_offset,0,0]) single(top_word=2, top_ordinal=5, bottom_word=3, bottom_ordinal=5, bottom_set=1, slit=1);
}

module pair(tw1=1, to1=0, bw1=1, bo1=0, tw2=1, to2=0, bw2=1, bo2=0) {
single(top_word=tw1, top_ordinal=to1, top_set=0, bottom_word=bw1, bottom_ordinal=bo1, bottom_set=1);
rotate([0,0,30]) translate([-tri_opp-tri_depth,0,0])
mirror([0,1,0]) translate([-tri_opp,0,0]) rotate([0,0,30]) {
single(top_word=tw2, top_ordinal=to2, top_set=1, bottom_word=bw2, bottom_ordinal=bo2, bottom_set=0);
}}

module single(top_word=1, top_ordinal=0, top_set=0, bottom_word=1, bottom_ordinal=0, bottom_set=0, slit=0) {
tri(top_word, top_ordinal, top_set, bottom_word, bottom_ordinal, bottom_set);
link(slit);
}

module tri(top_word=1, top_ordinal=0, top_set=0, bottom_word=1, bottom_ordinal=0, bottom_set=0) {
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
  topBadge(word=top_word, ordinal=top_ordinal, set=top_set);
  bottomBadge(word=bottom_word, ordinal=bottom_ordinal, set=bottom_set);
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

module topBadge(word=1, ordinal=0, set=0) {
translate([0,font_height/3,tri_rad-0.5])
rotate([0,set ? 180 : 0,set ? -60 : 180]) {
  if(word==1 && ordinal < word_len1) badge1(ordinal);
  if(word==2 && ordinal < word_len3) badge3(ordinal);
  if(word==3 && ordinal < word_len2) badge2(ordinal);
}}

module bottomBadge(word=1, ordinal=0, set=0) {
translate([0,font_height/3,0.5-tri_rad])
rotate([0,set ? 180 : 0, set ? -60 : 180]) {
  if(word==1 && ordinal < word_len1) badge1(ordinal);
  if(word==2 && ordinal < word_len3) badge3(ordinal);
  if(word==3 && ordinal < word_len2) badge2(ordinal);
}}

module badge1(ordinal=0) {
translate([-font_width/2*font_scale,-font_height/2*font_scale,-0.6])
linear_extrude(height=1.2)
scale(font_scale)
polygon(points=the_font[2][indicies1[ordinal]][6][0], paths=the_font[2][indicies1[ordinal]][6][1]);
}

module badge2(ordinal=0) {
translate([-font_width/2*font_scale,-font_height/2*font_scale,-0.6])
linear_extrude(height=1.2)
scale(font_scale)
polygon(points=the_font[2][indicies2[ordinal]][6][0], paths=the_font[2][indicies2[ordinal]][6][1]);
}

module badge3(ordinal=0) {
translate([-font_width/2*font_scale,-font_height/2*font_scale,-0.6])
linear_extrude(height=1.2)
scale(font_scale)
polygon(points=the_font[2][indicies3[ordinal]][6][0], paths=the_font[2][indicies3[ordinal]][6][1]);
}