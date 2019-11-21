//The length of one side of the square (should be a little smaller than the size of your bed, for my 100mm bed i used 95mm) 
side_length = 95; 
//How wide should the line be?
width = .1;
//How thick should it be? 
thickness = .1;
difference(){
    linear_extrude(height=thickness)
    square(side_length,center=true);
    linear_extrude(height=thickness)
    square(side_length-width,center=true);
}