// variables
length = 10; // [10:400]
width = 10; // [10:400]
height = 30; // [1:400]
wallthickness = 1; // [1:30]
// model
difference(){
cube(size=[length,width,height],center=true);
cube(size=[length-2*wallthickness,width-2*wallthickness,height],center=true);
}
