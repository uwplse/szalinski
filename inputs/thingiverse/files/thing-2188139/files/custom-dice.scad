// Dice size
size = 20; // [11:100]
// Edge curvature
curvature = 1.5; // [0:0.5:4]
// Engraving depth
depth = 1.25; // [0.5:0.25:3]
// Font
font = "Roboto Black"; // [Abel,Anton,Domine Bold,Fjalla,Bitter,Droid Serif,Inconsolata,Merriweather Black,Montserrat,Noto Sans,Pragati Narrow,Orbitron Bold,Roboto,Roboto Black,Roboto Condensed,Open Sans,Oswald,Space Mono,Sura,Sumana,Teko Semi-Bold]
// Label face 1
face_1 = "play";
// Label face 2
face_2 = "read";
// Label face 3
face_3 = "walk";
// Label face 4
face_4 = "swim";
// Label face 5
face_5 = "make";
// Label face 6
face_6 = "learn";

/* [Hidden] */
artefact = 0.05;
res = 100;

module dice() {
  minkowski() {
    size_int = (8 - curvature) * size / 8;
    size_ext = curvature * size / 8;
    cube([size_int, size_int, size_int]);
    translate([size_ext / 2, size_ext / 2, size_ext / 2]) sphere(d = size_ext, $fn = res);
  }
}

module letter(l) {
  fsize = ceil((size - 2 * curvature) / (len(l) + 0.5));
  linear_extrude(depth) {
    text(l, fsize, font, halign = "center", valign = "center", $fn = res);
  }
}

dmina = depth - artefact;
hs = size / 2;

difference() {
  dice();
  rotate([  0,   0,   0])  translate([ hs, hs, size-dmina])  letter(face_1);
  rotate([  0, 180,   0])  translate([-hs, hs,     -dmina])  letter(face_6);
  rotate([ 90,   0,   0])  translate([ hs, hs,     -dmina])  letter(face_2);
  rotate([270, 180,   0])  translate([-hs, hs, size-dmina])  letter(face_5);
  rotate([ 90,   0,  90])  translate([ hs, hs, size-dmina])  letter(face_3);
  rotate([ 90,   0, 270])  translate([-hs, hs,     -dmina])  letter(face_4);
}