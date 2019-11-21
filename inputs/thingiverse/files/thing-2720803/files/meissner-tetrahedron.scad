$fn=100;

P1=[0,0,0];
P2=[1,0,0];
P3=[1/2,sqrt(3)/2,0];
P4=[1/2,1/2*tan(30),sqrt(6)/3];

module pyramid(){
    polyhedron( points=[P1,P2,P3,P4],
                 faces=[[0,1,2],[0,3,1],[1,3,2],[0,2,3]]);
}
            
module elipsoid() {
    rotate ([0,90,0]) rotate_extrude(angle=360) rotate([0,0,90]) difference() {
        translate([P3[0],P3[1],0]) circle(r=1);
        translate([-2,0]) square(4);
        }
}

module meissner_tetrahedron(diameter=10) {
    scale(diameter) union() {
        translate([-P4[0],-P4[1],0]) difference() {      
            intersection() {
                translate(P1) sphere(r=1);
                translate(P2) sphere(r=1);
                translate(P3) sphere(r=1);
                translate(P4) sphere(r=1);
            }
            translate([0,0,0])             rotate([180,0,0]) pyramid();
            translate([P3[0],P3[1],P3[2]]) rotate([180,0,0]) pyramid();
            translate([-P3[0],P3[1],0])    rotate([180,0,0]) pyramid();
        }
        
        for (i=[0,120,240]) rotate([0,0,i]) translate([-P4[0],-P4[1],0]) elipsoid();
    }
}

//Create a tetrahedron with a diameter of 10mm:
meissner_tetrahedron(diameter=10);