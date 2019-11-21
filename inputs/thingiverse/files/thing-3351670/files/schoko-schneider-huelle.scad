// berechnet mit https://www.arndt-bruenner.de/mathe/scripts/kreissehnen.htm
$fn=120;

schneidlaenge=130;
biegung=8;
breite=30;

radius=268.0625;
alpha=28.066;

module messer() {
translate([-(radius-40),0,0])
difference() {
intersection() {
cylinder(r=radius,h=2);
translate([0,-schneidlaenge/2-5,0]) cube([radius,schneidlaenge+10,2]);
}
translate([radius,schneidlaenge/2+30,0]) cylinder(r=30,h=3);
translate([radius,-schneidlaenge/2-30,0]) cylinder(r=30,h=3);

translate([40,0,0]) cylinder(r=radius-breite-40,h=2);
}
}

difference() {
intersection() {
translate([-5,-schneidlaenge/2-5,-3]) cube([50,schneidlaenge+10,8]);
translate([-radius+40,0,-3]) cylinder(r=radius+5,h=8);
}

messer();
translate([-5,-schneidlaenge/2-5,0]) cube([15,schneidlaenge+10,.3]);

translate([20,0,4.5]) rotate([0,0,90]) linear_extrude(1) text("Wir lieben Schokolade",halign="center");
}