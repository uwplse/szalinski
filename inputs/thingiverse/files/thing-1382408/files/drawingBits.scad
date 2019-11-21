$fn=20;

//2*3 MATRICE EXAMPLE
/*test = [[0,1],[1,0],[1,1]];
nbCasesW = 2;
nbCasesL = 3;
*/
/*
//5*5 MATRICE EXAMPLE
test = [[0,1,0,1,0],
        [1,0,1,0,1],
        [1,0,0,0,1],
        [0,1,0,1,0],
        [0,0,1,0,0]];
nbCasesW = 5;
nbCasesL = 5;
*/

//5*5 MATRICE EXAMPLE
test = [[0,1,0,0,1,1,1,0,0,1,1,0,0,1,0,0,0,1,1],
        [1,0,1,0,0,1,0,0,1,0,1,0,1,0,1,0,1,0,1],
        [1,0,1,0,0,1,0,0,0,1,1,0,1,1,1,0,1,1,1],
        [1,0,1,0,0,1,0,0,1,0,1,0,1,0,1,0,1,0,1],
        [0,1,0,0,0,1,1,0,1,0,1,0,1,0,1,0,1,1,1]];
nbCasesW = 19;
nbCasesL = 5;

marge=0.5;
podW=4;
podL=4;
podH=4;

baseH = 4;
baseL = nbCasesW*podW;
baseW = nbCasesL*podL;

rCylinder=0.9;

//SELECT THE SHAPE OF PODS
rounded_pod = false;
squared_pod = false;
rounded_squared_pod = true;


//BASE
%scube([baseL,baseW,baseH]);

for (a =[0:nbCasesL-1]) {
    for (b =[0:nbCasesW-1]) {
        if (test[a][b] == 1) {
            echo( test[a][b]);    
            translate( [b*podW, a*podW, 0] ) 
            pods();
        }
    }
}


// PODS
module pods() {
    translate([marge/2,marge/2,baseH])
    if (rounded_pod == true) rounded_pod();
    else if (squared_pod == true) squared_pod();
    else rounded_squared_pod();
}

module rounded_pod() {
    translate([(podW-marge)/2,(podW-marge)/2,0])
    cylinder(h = podH/2+(podW-marge)/2, r1 = (podW-marge)/2, r2 = (podW-marge)/2, center = false);

    translate([(podW-marge)/2,(podW-marge)/2,podH/2+(podW-marge)/2])
    sphere(r = (podW-marge)/2);
}


module squared_pod() {
    cube([podW-marge,podL-marge,podH]);
}

module rounded_squared_pod() {
    hull() {
    translate([rCylinder/2,rCylinder/2,0])
    cylinder(h = podH-marge, r1 =rCylinder, r2 = rCylinder, center = false);
    
    translate([podW-rCylinder*2,rCylinder/2,0])
    cylinder(h = podH-marge, r1 = rCylinder, r2 = rCylinder, center = false);
    
    translate([rCylinder/2,podW-rCylinder*2,0])
    cylinder(h = podH-marge, r1 = rCylinder, r2 = rCylinder, center = false);
    
    translate([podW-rCylinder*2,podW-rCylinder*2,0])
    cylinder(h = podH-marge, r1 = rCylinder, r2 = rCylinder, center = false);
    }
}