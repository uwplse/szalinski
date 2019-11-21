A = 35;
B = 33;

difference() {
minkowski(5){
sphere (10, $fn=50); 
cube(A, center=true );
}
sphere(B, $fn=100); 
}
translate ([0,0,2.5]){
sphere (30, center=true, $fn=100);
}