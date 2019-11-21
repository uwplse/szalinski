//torsion funnel
//embudo torsionado
//define 3 radius dimensions
//define 3 heigths 
//define thickness
/*[Funnel Settings]*/
//Number of sides
Sides=5;
//Lower section radius in mm
R1=40;
//Intermediate section radius in mm
R2=10;
//top section radius in mm
R3=9;
//Lower section height
H0=5;
//Intermediate section height
H1=30;
//top section height
H2=25;

//to avoid overhangs verify that
//H1>R1-R2 
//H2>R2-R3

//Funnel thickness you might want to take into account your nozzle size
thick=0.8;

//Angle rotated from bottom to top in degrees (can be negative or positive)
Angle=-90;

LayerH=0.1; 
//layer height

torsion=Angle/(H0+H1+H2);
//torsion=-360/Sides/(H1+H2);//torsion angle between R1 and R2 (deg/mm)


linear_extrude(height = H0, twist = torsion*H0, slices = H0/LayerH, scale = 1) {
rotate ( [0,0,torsion*H0])
difference () {
    circle(r=R1,$fn=Sides);
    circle(r=R1-thick,$fn=Sides);
}
}


translate([0,0,H0]) 
linear_extrude(height = H1, twist = torsion*H1, slices = H1/LayerH, scale = R2/R1) {
difference () {
    circle(r=R1,$fn=Sides);
    circle(r=R1-thick,$fn=Sides);
}
}

translate([0,0,H0+H1]) 
linear_extrude(height = H2, twist = torsion*H2, slices = H2/LayerH, scale = R3/R2) {
rotate ( [0,0,-torsion*H1])
difference () {
    circle(r=R2,$fn=Sides);
    circle(r=R2-thick,$fn=Sides);
}
}