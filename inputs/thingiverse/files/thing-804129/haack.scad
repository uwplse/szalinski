// Length of cone
L = 30;
// Radius of cone at base
R = 10;
// Haack coefficient. LD-Haack (Von Kármán): 0, LV-Haack = .3333
C = 0;
// Number of longitudinal faces to calculate.
num_faces = 45;
// Number of radial faces for the rotate extrude.
$fn = 80;



function theta(x) = acos(1 - 2*x/L);
function y(x) = R * sqrt(theta(x)*PI/180 - sin(2*theta(x))/2 + C * pow(sin(theta(x)), 3)) / sqrt(PI);

pts = concat([[0, 0]], [ for (i = [0 : num_faces]) let (x = i * L / num_faces) [y(L - x), x] ]);
rotate_extrude() polygon(points = pts);

