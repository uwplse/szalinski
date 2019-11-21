// variables
side_length = 10; // [10:400]
height = 30; // [1:400]
wallthickness = 1; // [1:30]
// calculations
scale = (side_length*(sqrt(3)/2)-(3*wallthickness))/(side_length*(sqrt(3)/2));
// model
linear_extrude(height=height) difference(){
polygon(points=[[-side_length/2,-tan(30)*side_length/2],[side_length/2,-tan(30)*side_length/2],[0,side_length/2/cos(30)]]);
scale([scale,scale,0]) polygon(points=[[-side_length/2,-tan(30)*side_length/2],[side_length/2,-tan(30)*side_length/2],[0,side_length/2/cos(30)]]);
}
