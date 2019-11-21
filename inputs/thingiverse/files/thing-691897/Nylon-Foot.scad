//Nylon foot creator
//Diameter of foot
Diameter = 25;
//How many feet?
Quantity = 1;

difference() {
  // A sphere with a variable diameter
  sphere(d=Diameter, $fn=100); 
  // Move 
  translate(v=[0,0,-(Diameter/2)]) {
    //The cube for cutting 
    cube(size = Diameter, center = true);
   }
}
