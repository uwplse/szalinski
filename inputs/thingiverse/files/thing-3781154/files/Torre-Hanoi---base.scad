/// Base
translate([0,0,5]);
linear_extrude(height = 10, center = false, convexity = 0, twist = 0, $fn = 10)
square(size = [165, 55], center = true);

// Pino do meio
linear_extrude(height = 80, center = false, convexity = 0, twist = 0, $fn = 10)
translate([0,0,0])
circle(d=8, $fn = 50, $fa = 10, $fs = 10);

// Pino da direita
linear_extrude(height = 80, center = false, convexity = 0, twist = 0, $fn = 10)
translate([50.250,0,0])
circle(d=8, $fn = 50, $fa = 10, $fs = 10);

// Pino da esquerda
linear_extrude(height = 80, center = false, convexity = 0, twist = 0, $fn = 10)
translate([-50.250,0,0])
circle(d=8, $fn = 50, $fa = 10, $fs = 10);