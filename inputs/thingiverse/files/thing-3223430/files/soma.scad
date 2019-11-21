//Unit cube size in mm
unit=30;
//Rounding takes the sharpness off of the edges and corners.
rounding=20;//[4:20]
//This angle changes the Soma puzzle into a rhombic Rhoma puzzle
theta=0;//[-30:30]

/* [Hidden] */
faces=20;
spacing=unit/10;

M = [ [ 1 , 0 , sin(theta) , 0 ],
      [ 0 , 1 , sin(theta) , 0 ],  
      [ 0 , 0 ,          1 , 0 ],
      [ 0 , 0 ,          0 , 1 ] ] ;
module z() {
   cube(unit-2*unit/rounding,center=true);   
   translate([0,-.5*unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([0,-1*unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([.5*unit,-1*unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([1*unit,-1*unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([1*unit,-1.5*unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([1*unit,-2*unit,0])cube(unit-2*unit/rounding,center=true);     
}    

module t() {
   cube(unit-2*unit/rounding,center=true);   
   translate([0,-.5*unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([0,-unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([0,-1.5*unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([0,-2*unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([0,-unit,.5*unit])cube(unit-2*unit/rounding,center=true); 
   translate([0,-unit,unit])cube(unit-2*unit/rounding,center=true);     
}    

module left() {
   cube(unit-2*unit/rounding,center=true);   
   translate([0,-.5*unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([0,-unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([.5*unit,-unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([unit,-unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([unit,-unit,.5*unit])cube(unit-2*unit/rounding,center=true); 
   translate([unit,-unit,unit])cube(unit-2*unit/rounding,center=true);     
} 

module right() {
   cube(unit-2*unit/rounding,center=true);   
   translate([.5*unit,,00])cube(unit-2*unit/rounding,center=true); 
   translate([unit,0,0])cube(unit-2*unit/rounding,center=true); 
   translate([unit,-.5*unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([unit,-unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([unit,-unit,.5*unit])cube(unit-2*unit/rounding,center=true); 
   translate([unit,-unit,unit])cube(unit-2*unit/rounding,center=true);     
}

module l() {
   cube(unit-2*unit/rounding,center=true);   
   translate([.5*unit,0,0])cube(unit-2*unit/rounding,center=true); 
   translate([unit,0,0])cube(unit-2*unit/rounding,center=true); 
   translate([unit,0,.5*unit])cube(unit-2*unit/rounding,center=true); 
   translate([unit,0,1*unit])cube(unit-2*unit/rounding,center=true); 
   translate([unit,0,1.5*unit])cube(unit-2*unit/rounding,center=true); 
   translate([unit,0,2*unit])cube(unit-2*unit/rounding,center=true);     
}

module small() {
   cube(unit-2*unit/rounding,center=true);   
   translate([0,0,.5*unit])cube(unit-2*unit/rounding,center=true); 
   translate([0,0,unit])cube(unit-2*unit/rounding,center=true); 
   translate([.5*unit,0,0])cube(unit-2*unit/rounding,center=true); 
   translate([unit,0,0])cube(unit-2*unit/rounding,center=true);   
}

module corner() {
   cube(unit-2*unit/rounding,center=true);   
   translate([0,-.5*unit,.0])cube(unit-2*unit/rounding,center=true); 
   translate([0,-1*unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([.5*unit,-1*unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([1*unit,-1*unit,0])cube(unit-2*unit/rounding,center=true); 
   translate([0,-1*unit,.5*unit])cube(unit-2*unit/rounding,center=true); 
   translate([0,-1*unit,1*unit])cube(unit-2*unit/rounding,center=true);     
}

translate([spacing,spacing,0])minkowski() {
   multmatrix(M)z();
   sphere(unit/rounding,$fn=faces,center=true);
}

translate([0,-2*unit,0])minkowski() {
   multmatrix(M)corner();
   sphere(unit/rounding,$fn=faces,center=true);
}
translate([2*unit+2*spacing,-unit,0])minkowski() {
   multmatrix(M)t();
   sphere(unit/rounding,$fn=faces,center=true);
}

translate([unit+2*spacing,2*spacing,0])minkowski() {
   multmatrix(M)small();
   sphere(unit/rounding,$fn=faces,center=true);
}

translate([-2*unit,2*spacing,0])minkowski() {
   multmatrix(M)right();
   sphere(unit/rounding,$fn=faces,center=true);
}

translate([-2*unit-spacing,-unit+spacing,0])minkowski() {
   multmatrix(M)left();
   sphere(unit/rounding,$fn=faces,center=true);
}

translate([-2*unit-spacing,-3*unit,0])minkowski() {
   multmatrix(M)l();
   sphere(unit/rounding,$fn=faces,center=true);
}


