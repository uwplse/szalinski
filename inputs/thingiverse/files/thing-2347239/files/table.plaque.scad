// Cartel para mesa

$fn = 50;
text = "Pedro";
long = len (text)*8+6;
scale (2) {
rotate ([55, 0, 0]) {
linear_extrude(3) text(text, halign = "center", valign ="center", font = "Liberation Mono");

linear_extrude (1.2) offset (r=2) square ([long, 16], center = true );
linear_extrude (2.0) offset (r=1.6) square ([long-2, 14], center = true );
}
translate ([0, 2, -8.15]) linear_extrude (1.2) offset (r=2) square ([8, 16], center = true );

}