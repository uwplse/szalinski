// nosecone_factory.scad
// library for parametric model rocket nosecone
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: November 2018


// Body tube OUTSIDE diameter (in mm)
Tube_Outside_Diameter = 19; //

// Body tube INSIDE diameter (in mm)
Tube_Inside_Diameter = 18; //

// Nosecone Type (See List Below)
Cone_Type = 8; // [1:Basic Cone,2:Blunt Cone,3:Parabolic Cone,4:SEARS-HAACK Cone,5:Power Series Cone,6:Eliptical Cone,7:Secant Ogive Cone,8:Tangent Ogive Cone,9:Blunt Tangent Ogive Cone,10:Biconic Cone]

// Nosecone height (in mm)
Cone_Height = 60; //

// Modifies some types (Blunt, Parabolic, SEARS-HAACK, Power Series, Secant Ogive, Blunt Tangent Ogive and Biconic)
Parameter_A = 50; // [1:100]

// Modifies some types (Biconic)
Parameter_B = 50; // [1:100]

/* [Hidden] */

TZT_TOR=Tube_Outside_Diameter/2;
TZT_TIR=Tube_Inside_Diameter/2;
TZT_HGT=Cone_Height;
TZT_PA=Parameter_A;
TZT_PB=Parameter_B;
$fn=100;
TZT_fn=$fn;

union () {
    TZT_Sleave ();
    if (Cone_Type==1) {
        cone_cone(R = TZT_TOR, L = TZT_HGT, s = TZT_fn);
    } else if (Cone_Type==2) {
        cone_blunted(R = TZT_TOR, R_nose = TZT_PA*.08, L = TZT_HGT, s = TZT_fn);
    } else if (Cone_Type==3) {
        cone_parabolic(R = TZT_TOR, L = TZT_HGT, K = TZT_PA*.01, s = TZT_fn);
    } else if (Cone_Type==4) {
        cone_haack(C = TZT_PA*.1, R = TZT_TOR, L = TZT_HGT, s = TZT_fn);
    } else if (Cone_Type==5) {
        cone_power_series(n = TZT_PA*.01, R = TZT_TOR, L = TZT_HGT, s = TZT_fn);
    } else if (Cone_Type==6) {
        cone_elliptical(R = TZT_TOR, L = TZT_HGT, s = TZT_fn);
    } else if (Cone_Type==7) {
        cone_ogive_sec(rho = TZT_HGT*.6+TZT_PA*TZT_TOR, R = TZT_TOR, L = TZT_HGT, s = TZT_fn);
    } else if (Cone_Type==8) {
        cone_ogive_tan(R = TZT_TOR, L = TZT_HGT, s = TZT_fn);
    } else if (Cone_Type==9) {
        cone_ogive_tan_blunted(R_nose = 1+TZT_PA*.08, R = TZT_TOR, L = TZT_HGT, s = TZT_fn);
    } else if (Cone_Type==10) {
        cone_biconic(R = TZT_TOR, R_nose = TZT_TOR+(TZT_TOR*TZT_PB/100)-TZT_TOR/2, L1 = TZT_HGT*(TZT_PA/100), L2 = TZT_HGT*(1-(TZT_PA/100)), s = TZT_fn);
    }    
}

module TZT_Sleave () {   
    translate ([0,0,-TZT_TOR+TZT_TIR]) cylinder (TZT_TOR-TZT_TIR,TZT_TIR,TZT_TOR);
    translate ([0,0,-TZT_TIR*2]) {
        difference () {
            cylinder (TZT_TIR*2,TZT_TIR,TZT_TIR);
            translate ([0,0,-TZT_TIR*.1]) cylinder (TZT_TIR*2.1,TZT_TIR*.9,0);
        }
        translate ([0,0,TZT_TIR*.2]) {
            for (TZT_i=[0:90:90]) {
                rotate ([0,90,TZT_i]) cylinder (TZT_TIR*1.9,TZT_TIR*.1,TZT_TIR*.1,true);
                rotate ([0,90,TZT_i]) translate ([TZT_TIR*.1,0,0]) cube ([TZT_TIR*.2,TZT_TIR*.2,TZT_TIR*1.9],true);
            }
        }
    }
}

// ----------------------------------------------------------------------------------
// Everything below is mostly pickup (albeit cleaned up) of work done by Garrett Goss
// ----------------------------------------------------------------------------------

//  NOSE CONE LIBRARY, version 1.0
//  by Garrett Goss, 2015, published 9/16

// 1
module cone_cone (R = 5, L = 10, s = 500){
    cylinder(h = L, r1 = R, r2 = 0, center = false, $fn = s);    
}

// 2
module cone_blunted (R = 5, R_nose = 2, L = 15, s = 500) {
    x_t = (pow(L,2) / R) * sqrt(pow(R_nose,2) / (pow(R,2) + pow(L,2)));
    y_t = x_t * (R/L);
    x_o = x_t + sqrt(pow(R_nose,2) - pow(y_t,2));
    x_a = x_o - R_nose;
    TORAD = PI/180;
    TODEG = 180/PI;
    inc = 1/s;        
    s_x_t = round((s * x_t) / L);
    rotate_extrude(convexity = 10, $fn = s) {
        union () {
            for (i = [s_x_t : s]) {
                x_last = L * (i - 1) * inc;
                x = L * i * inc;
                y_last = x_last * (R/L);
                y = x * (R / L);
                rotate([0, 0, -90]) polygon(points = [[x_last - L, 0], [x - L, 0], [x - L, y], [x_last - L, y_last]], convexity = 10);
            }
            translate ([0, L-x_o, 0]) difference () {
                circle(R_nose, $fn = s);
                translate([-R_nose, 0, 0]) square((2 * R_nose), center = true);
            }
        }
    }
}

// 3       
module cone_parabolic (R = 5, L = 10, K = 0.5, s = 500) {  
    if (K >= 0 && K <= 1) {
        inc = 1/s;
        rotate_extrude(convexity = 10, $fn = s) {
            for (i = [1 : s]){                
                x_last = L * (i - 1) * inc;
                x = L * i * inc;
                y_last = R * ((2 * ((x_last)/L)) - (K * pow(((x_last)/L), 2))) / (2 - K);
                y = R * ((2 * (x/L)) - (K * pow((x/L), 2))) / (2 - K);
                polygon (points = [[y_last, 0], [y, 0], [y, L - x], [y_last, L - x_last]], convexity = 10);
            }
        }
    }
}

// 4
module cone_haack (C = 0, R = 5, L = 10, s = 500) {
    TORAD = PI/180;
    TODEG = 180/PI;
    inc = 1/s;
    rotate_extrude(convexity = 10, $fn = s) {
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
}

// 5
module cone_power_series (n = 0.5, R = 5, L = 10, s = 500) {
    inc = 1/s;
    rotate_extrude (convexity = 10, $fn = s) {
        for (i = [1 : s]){

            x_last = L * (i - 1) * inc;
            x = L * i * inc;

            y_last = R * pow((x_last/L), n);
            y = R * pow((x/L), n);

            rotate([0, 0, 90]) polygon(points = [[0,y_last],[0,y],[L-x,y],[L-x_last,y_last]], convexity = 10);
        }
    }
}

// 6
module cone_elliptical(n = 0.5, R = 5, L = 10, s = 500){
    inc = 1/s;
    rotate_extrude(convexity = 10, $fn = s) {
        for (i = [1 : s]) {
            x_last = L * (i - 1) * inc;
            x = L * i * inc;
            y_last = R * sqrt(1 - pow((x_last/L), 2));
            y = R * sqrt(1 - pow((x/L), 2));
            rotate([0,0,90]) polygon(points = [[0, y_last], [0, y], [x, y], [x_last, y_last]], convexity = 10);
        }
    }
}

// 7
module cone_ogive_sec (rho = 8, R = 5, L = 10, s = 500) {
    TORAD = PI/180;
    TODEG = 180/PI;   
    inc = 1/s;
    alpha = TORAD * atan(R/L) - TORAD * acos(sqrt(pow(L,2) + pow(R,2)) / (2*rho));
    rotate_extrude(convexity = 10, $fn = s) {
        for (i = [1 : s]){
            x_last = L * (i - 1) * inc;
            x = L * i * inc;
            y_last = sqrt(pow(rho,2) - pow((rho * cos(TODEG*alpha) - x_last), 2)) + (rho * sin(TODEG*alpha));
            y = sqrt(pow(rho,2) - pow((rho * cos(TODEG*alpha) - x), 2)) + (rho * sin(TODEG*alpha));
            rotate([0, 0, -90]) polygon(points = [[x_last - L, 0], [x - L, 0], [x - L, y], [x_last - L, y_last]], convexity = 10);
        }
    }
}

// 8
module cone_ogive_tan (R = 5, L = 10, s = 500) {
    rho = (pow(R,2) + pow(L,2)) / (2 * R);
    inc = 1/s;
    rotate_extrude(convexity = 10, $fn = s) {
        for (i = [1 : s]){
            x_last = L * (i - 1) * inc;
            x = L * i * inc;
            y_last = sqrt(pow(rho,2) - pow((L - x_last), 2)) + R - rho;
            y = sqrt(pow(rho,2) - pow((L - x), 2)) + R - rho;
            rotate([0, 0, -90]) polygon(points = [[x_last - L, 0], [x - L, 0], [x - L, y], [x_last - L, y_last]], convexity = 10);
        }
    }
}

// 9
module cone_ogive_tan_blunted (R_nose = 2, R = 5, L = 10, s = 500) {
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
    rotate_extrude(convexity = 10, $fn = s) union() {
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

// 10
module cone_biconic (R = 5, R_nose = 3, L1 = 6, L2 = 4, s = 500) {
    L = L1 + L2;
    s_intermediate = s * (L2/L);
    inc = 1/s;
    rotate_extrude(convexity = 10, $fn = s) translate([0, L, 0]) rotate([0, 0, -90]) union() {
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