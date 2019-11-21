//  NOSE CONE LIBRARY, version 1.0
//  by Garrett Goss, 2015, published 9/16
//
//  I dedicate any and all copyright interest in this software to the public domain.
//  I make this dedication for the benefit of the public at large and to the
//  detriment of my heirs and successors. I intend this dedication to be an overt
//  act of relinquishment in perpetuity of all present and future rights to this
//  software under copyright law. See <http://unlicense.org> for more info.
//
//  This library implements each of the nose cones described at
//  https://en.wikipedia.org/wiki/Nose_cone_design, itself derived largely from
//  Gary A. Crowell Sr. "The Descriptive Geometry Of Nose Cones" (dedicated by author
//  to the public domain following publication). Reference these if you"re looking
//  for more depth.
//
// 
// MORE EXPLANATION NEEDED HERE
//The type of nosecone to be generated (e.g. conical, parabolic, ogive)
cone_type = "sears-haack"; //[conical, blunted_cone, parabolic, sears-haack, power_series, elliptical, secant_ogive, tangent_ogive, sphere_blunted_tangent_ogive, biconic]
//The radius of the base of the nosecone
radius = 10;
//The height of the nosecone
length = 40;
//This influences the shape of parabolic, Sears-Haack, power series, elliptical, and secant ogive nosecones. Between 0 and 1 for everything except ogives and Sears-Haack, but for ogives it is: for a bulging cone, Length/2 < parameter < (Radius^2 + Length^2)/(2Radius), otherwise: parameter > (Radius^2 + Length^2)/(2Radius), and for Sears-Haack it is between 0 and 0.3333 - other things make it super weird
shape_parameter = 0;
//This influences the figure's polygon count - how smooth or choppy it looks.
resolution = 128;
//This affects the radius of the blunting sphere on sphere-blunted nosecones, and the radius of the top cone on biconic nosecones.
nose_radius = 5;
//For biconic nosecones only: the length of the top cone.
length_2 = 4;
//This determines whether or not to generate a shoulder on the nosecone.
generate_shoulder = true;//[true, false]
//The diameter of the shoulder to generate.
shoulder_diameter = 9.6;
//The length of the shoulder.
shoulder_length = 20;

module cone_cone(R = 5, L = 10, s = 500){
// CONICAL NOSE CONE
//
// Formula: y = x * R / L; 
//
//     but there"s an easier way...

echo(str("CONICAL NOSE CONE"));    
echo(str("R = ", R)); 
echo(str("L = ", L)); 
echo(str("s = ", s)); 

cylinder(h = L, r1 = R, r2 = 0, center = false, $fn = s);
    
}

module cone_blunted(R = 5, R_nose = 2, L = 15, s = 500){
// SPHERICALLY BLUNTED CONE
//     A conical nose capped with a segment of a sphere
//

echo(str("SPHERICALLY BLUNTED CONE"));
echo(str("R = ", R));
echo(str("R_nose = ", R_nose)); 
echo(str("L = ", L));
echo(str("s = ", s)); 
    
x_t = (pow(L,2) / R) * sqrt(pow(R_nose,2) / (pow(R,2) + pow(L,2)));
y_t = x_t * (R/L);
x_o = x_t + sqrt(pow(R_nose,2) - pow(y_t,2));
x_a = x_o - R_nose;

TORAD = PI/180;
TODEG = 180/PI;
inc = 1/s;
    
s_x_t = round((s * x_t) / L);

rotate_extrude(convexity = 10, $fn = s)
union(){
    for (i = [s_x_t : s]){

        x_last = L * (i - 1) * inc;
        x = L * i * inc;

        y_last = x_last * (R/L);

        y = x * (R / L);

        rotate([0, 0, -90]) polygon(points = [[x_last - L, 0], [x - L, 0], [x - L, y], [x_last - L, y_last]], convexity = 10);
    }

    translate([0, L-x_o, 0]) difference(){
        circle(R_nose, $fn = s);
        translate([-R_nose, 0, 0]) square((2 * R_nose), center = true);
    }
}
}
        
module cone_parabolic(R = 5, L = 10, K = 0.5, s = 500){
// PARABOLIC NOSE CONE
//
// Formula: y = R * ((2 * (x / L)) - (K * pow((x / L),2)) / (2 - K);
//
// Parameters:
// K = 0 for cone
// K = 0.5 for 1/2 parabola
// K = 0.75 for 3/4 parabola
// K = 1 for full parabola

echo(str("PARABOLIC NOSE CONE"));
echo(str("R = ", R)); 
echo(str("L = ", L)); 
echo(str("K = ", K)); 
echo(str("s = ", s)); 
    
if (K >= 0 && K <= 1){

    inc = 1/s;

    rotate_extrude(convexity = 10, $fn = s)
    for (i = [1 : s]){
        
        x_last = L * (i - 1) * inc;
        x = L * i * inc;

        y_last = R * ((2 * ((x_last)/L)) - (K * pow(((x_last)/L), 2))) / (2 - K);
        y = R * ((2 * (x/L)) - (K * pow((x/L), 2))) / (2 - K);

        polygon(points = [[y_last, 0], [y, 0], [y, L - x], [y_last, L - x_last]], convexity = 10);
    }
} else echo(str("ERROR: K = ", K, ", but K must fall between 0 and 1 (inclusive)."));
}

module cone_haack(C = 0, R = 5, L = 10, s = 500){

// SEARS-HAACK BODY NOSE CONE:
//
// Parameters:
// C = 1/3: LV-Haack (minimizes supersonic drag for a given L & V)
// C = 0: LD-Haack (minimizes supersonic drag for a given L & D), also referred to as Von Kármán
//
// Formulae (radians):
// theta = acos(1 - (2 * x / L));
// y = (R / sqrt(PI)) * sqrt(theta - (sin(2 * theta) / 2) + C * pow(sin(theta),3));

echo(str("SEARS-HAACK BODY NOSE CONE"));
echo(str("C = ", C)); 
echo(str("R = ", R)); 
echo(str("L = ", L)); 
echo(str("s = ", s)); 

TORAD = PI/180;
TODEG = 180/PI;

inc = 1/s;

rotate_extrude(convexity = 10, $fn = s)
for (i = [1 : s]){
    x_last = L * (i - 1) * inc;
    x = L * i * inc;

    theta_last = TORAD * acos((1 - (2 * x_last/L)));
    y_last = (R/sqrt(PI)) * sqrt(theta_last - (sin(TODEG * (2*theta_last))/2) + C * pow(sin(TODEG * theta_last), 3));

    theta = TORAD * acos(1 - (2 * x/L));
    y = (R/sqrt(PI)) * sqrt(theta - (sin(TODEG * (2 * theta)) / 2) + C * pow(sin(TODEG * theta), 3));

    rotate([0, 0, -90]) polygon(points = [[x_last - L, 0], [x - L, 0], [x - L, y], [x_last - L, y_last]], convexity = 10);
}
}


module cone_power_series(n = 0.5, R = 5, L = 10, s = 500){
// POWER SERIES NOSE CONE:
//
// Formula: y = R * pow((x / L), n) for 0 <= n <= 1
//
// Parameters:
// n = 1 for a cone
// n = 0.75 for a 3/4 power
// n = 0.5 for a 1/2 power (parabola)
// n = 0 for a cylinder

echo(str("POWER SERIES NOSE CONE"));
echo(str("n = ", n)); 
echo(str("R = ", R)); 
echo(str("L = ", L)); 
echo(str("s = ", s)); 

inc = 1/s;

rotate_extrude(convexity = 10, $fn = s)
for (i = [1 : s]){

    x_last = L * (i - 1) * inc;
    x = L * i * inc;

    y_last = R * pow((x_last/L), n);
    y = R * pow((x/L), n);

    rotate([0, 0, 90]) polygon(points = [[0,y_last],[0,y],[L-x,y],[L-x_last,y_last]], convexity = 10);
}
}

module cone_elliptical(n = 0.5, R = 5, L = 10, s = 500){
// ELLIPTICAL NOSE CONE:
//
// Formula: y = R * sqrt(1 - pow((x / L), 2));

echo(str("ELLIPTICAL NOSE CONE"));    
echo(str("n = ", n)); 
echo(str("R = ", R)); 
echo(str("L = ", L)); 
echo(str("s = ", s)); 

inc = 1/s;

rotate_extrude(convexity = 10, $fn = s)
for (i = [1 : s]){

    x_last = L * (i - 1) * inc;
    x = L * i * inc;

    y_last = R * sqrt(1 - pow((x_last/L), 2));
    y = R * sqrt(1 - pow((x/L), 2));

    rotate([0,0,90]) polygon(points = [[0, y_last], [0, y], [x, y], [x_last, y_last]], convexity = 10);
}
}
module cone_ogive_sec(rho = 8, R = 5, L = 10, s = 500){
// SECANT OGIVE NOSE CONE:
//
// For a bulging cone (e.g. Honest John): L/2 < rho < (R^2 + L^2)/(2R)
// Otherwise: rho > (R^2 + L^2)/(2R)
//
// Formulae:
// alpha = TORAD * atan(R/L) - TORAD * acos(sqrt(pow(L,2) + pow(R,2)) / (2 * rho));
// y = sqrt(pow(rho,2) - pow((rho * cos(TODEG * alpha) - x),2)) + (rho * sin(TODEG * alpha));

echo(str("SECANT OGIVE NOSE CONE"));    
echo(str("rho = ", rho)); 
echo(str("R = ", R)); 
echo(str("L = ", L)); 
echo(str("s = ", s)); 

TORAD = PI/180;
TODEG = 180/PI;
    
inc = 1/s;

alpha = TORAD * atan(R/L) - TORAD * acos(sqrt(pow(L,2) + pow(R,2)) / (2*rho));

rotate_extrude(convexity = 10, $fn = s)
for (i = [1 : s]){

    x_last = L * (i - 1) * inc;
    x = L * i * inc;

    y_last = sqrt(pow(rho,2) - pow((rho * cos(TODEG*alpha) - x_last), 2)) + (rho * sin(TODEG*alpha));

    y = sqrt(pow(rho,2) - pow((rho * cos(TODEG*alpha) - x), 2)) + (rho * sin(TODEG*alpha));

    rotate([0, 0, -90]) polygon(points = [[x_last - L, 0], [x - L, 0], [x - L, y], [x_last - L, y_last]], convexity = 10);
}
}


module cone_ogive_tan(R = 5, L = 10, s = 500){
// TANGENT OGIVE
//
//

echo(str("TANGENT OGIVE"));    
echo(str("R = ", R)); 
echo(str("L = ", L)); 
echo(str("s = ", s)); 

rho = (pow(R,2) + pow(L,2)) / (2 * R);

inc = 1/s;

rotate_extrude(convexity = 10, $fn = s)
for (i = [1 : s]){
    x_last = L * (i - 1) * inc;
    x = L * i * inc;

    y_last = sqrt(pow(rho,2) - pow((L - x_last), 2)) + R - rho;

    y = sqrt(pow(rho,2) - pow((L - x), 2)) + R - rho;

    rotate([0, 0, -90]) polygon(points = [[x_last - L, 0], [x - L, 0], [x - L, y], [x_last - L, y_last]], convexity = 10);
}
}

module cone_ogive_tan_blunted(R_nose = 2, R = 5, L = 10, s = 500){
// SPHERICALLY BLUNTED TANGENT OGIVE
//
//

echo(str("SPHERICALLY BLUNTED TANGENT OGIVE"));    
echo(str("R_nose = ", R_nose)); 
echo(str("R = ", R)); 
echo(str("L = ", L)); 
echo(str("s = ", s)); 

rho = (pow(R,2) + pow(L,2)) / (2*R);

x_o = L - sqrt(pow((rho - R_nose), 2) - pow((rho - R), 2));
x_a = x_o - R_nose;
y_t = (R_nose * (rho - R)) / (rho - R_nose);
x_t = x_o - sqrt(pow(R_nose, 2)- pow(y_t, 2));

TORAD = PI/180;
TODEG = 180/PI;
    
inc = 1/s;
    
s_x_t = round((s * x_t) / L);

alpha = TORAD * atan(R/L) - TORAD * acos(sqrt(pow(L,2) + pow(R,2)) / (2*rho));

rotate_extrude(convexity = 10, $fn = s) union(){
    for (i=[s_x_t:s]){

        x_last = L * (i - 1) * inc;
        x = L * i * inc;

        y_last = sqrt(pow(rho,2) - pow((rho * cos(TODEG * alpha) - x_last),2)) + (rho * sin(TODEG * alpha));

        y = sqrt(pow(rho,2) - pow((rho * cos(TODEG * alpha) - x),2)) + (rho * sin(TODEG * alpha));

        rotate([0,0,-90])polygon(points = [[x_last-L,0],[x-L,0],[x-L,y],[x_last-L,y_last]], convexity = 10);
    }

    translate([0, L - x_o, 0]) difference(){
        circle(R_nose, $fn = s);
        translate([-R_nose, 0, 0]) square((2 * R_nose), center = true);
    }
}
}

module cone_biconic(R = 5, R_nose = 3, L1 = 6, L2 = 4, s = 500){

echo(str("BICONIC NOSE CONE")); 
echo(str("R = ", R));    
echo(str("R_nose = ", R_nose)); 
echo(str("L1 = ", L1));
echo(str("L2 = ", L2)); 
echo(str("s = ", s)); 
    
L = L1 + L2;
s_intermediate = s * (L2/L);
inc = 1/s;

rotate_extrude(convexity = 10, $fn = s) translate([0, L, 0]) rotate([0, 0, -90])
union(){
    for (i = [1 : s_intermediate]){

        x_last = L * (i - 1) * inc;
        x = L * i * inc;

        y_last = x_last * (R_nose/L2);
        y = x * (R_nose/L2);

        polygon(points = [[x_last, 0], [x_last, y_last], [x, y], [x, 0]], convexity = 10);
    }
    
    for (i=[s_intermediate:s]){

        x_last = L * (i - 1) * inc;
        x = L * i * inc;

        y_last = R_nose + ((x_last - L2) * (R - R_nose)) / L1;
        y = R_nose + ((x - L2) * (R - R_nose)) / L1;

        polygon(points = [[x_last, 0], [x_last, y_last], [x, y], [x, 0]], convexity = 10);
    }
}
}
union(){
if (cone_type == "conical") {
    cone_cone(radius, length, resolution);
}
if (cone_type == "blunted_cone") {
    cone_blunted(radius, nose_radius, length, resolution);
}
if (cone_type == "parabolic") {
    cone_parabolic(radius, length, shape_parameter, resolution);
}
if (cone_type == "sears-haack") {
    cone_haack(shape_parameter, radius, length, resolution);
}
if (cone_type == "power_series") {
    cone_power_series(shape_parameter, radius, length, resolution);
}
if (cone_type == "elliptical") {
    cone_elliptical(shape_parameter, radius, length, resolution);
}
if (cone_type == "secant_ogive") {
    cone_ogive_sec(shape_parameter, radius, length, resolution);
}
if (cone_type == "tangent_ogive") {
    cone_ogive_tan(radius, length, resolution);
}
if (cone_type == "sphere_blunted_tangent_ogive") {
    cone_ogive_tan_blunted(nose_radius, radius, length, resolution);
}
if (cone_type == "biconic") {
    cone_biconic(radius, nose_radius, length, length2, resolution);
}
if (generate_shoulder) {
    translate([0, 0, (-1 * shoulder_length)]) {
        cylinder(shoulder_length, shoulder_diameter, shoulder_diameter, $fn = resolution);
    }
}
}