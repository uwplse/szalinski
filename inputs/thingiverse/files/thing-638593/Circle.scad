// variables
diameter = 10; // [10:400]
height = 30; // [1:400]
wallthickness = 1; // [1:30]
// model
difference(){
cylinder(h=height,d=diameter,center=true,$fn=100);
cylinder(h=height,d=diameter-2*wallthickness,center=true,$fn=100);
}
