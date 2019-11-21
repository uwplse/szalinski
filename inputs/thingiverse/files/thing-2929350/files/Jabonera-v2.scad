// Width
    W=120;
// Depth
    D=80;  
// Height
    H=20;  
// Thickness
    T=1.5;
// Corner rounding radius
    R=1.5;
// $fn
    $fn=100;

// Jabonera 
difference() {
    union () {
        ribs();
        plano_inclinado();
        frontal();
    }
    desague();
    muesca_superior();
}

// Modules
module ribs () {
    for(y=[0:(W-T)/12:W]) {
        translate([0,y,0]) 
        minkowski(){
            if ((y > 0) && (y < W-T-1))      
                cube([D-2*R-5, T/2, H-2*R]);
            else
                cube([D-2*R, T/2, H-2*R]);
            translate([R,0,R]) rotate([-90,0,0])cylinder(r=R, h=T/2, center=false);
        }
    }
}  

module plano_inclinado () {
    Plano = [
    [R,0,H-R],       // 0 top left back
    [D,0,T],         // 1 top left front
    [D,W,H/4],       // 2 top right front
    [R,W,H-R],       // 3 top right  back
    [R,0,H-R-T],     // 4 bottom left back
    [D,0,0],         // 5 bottom left  front
    [D,W,H/4-T],     // 6 bottom right front 
    [R,W,H-T-R],     // 7 bottom right  back
    ];
    Caras = [
    [0,1,2,3],  // top
    [4,5,1,0],  // left
    [7,6,5,4],  // bottom
    [5,6,2,1],  // front
    [6,7,3,2],  // right
    [7,4,0,3]]; // back
    polyhedron(Plano, Caras, convexity=10);
}

module frontal () {
    difference(){
    translate([D-T,T,0]) cube([T,W-2*T,H-R]);
    translate([D-0.5,W/2,H/2-R])rotate([90,0,90])linear_extrude(height=0.5)text("SOAP", font="Herculanum", halign="center", valign = "center");}
    }
    
module desague () {translate([D-2*T,T,1.6*T]) rotate([0,15,0]) cube(5,5,5);}

module muesca_superior () {translate([D/2,T,0.84*H+1.19*D]) 
rotate([-90,0,0]) cylinder(h=W-2*T, r=1.19*D);}
