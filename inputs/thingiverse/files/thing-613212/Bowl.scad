// variables
width = 75; // [20:400]
length = 50; // [20:400]
height = 25; // [20:400]
wallthickness = 2; // [2:10]
fragments = 100; // [100:200]
//scales
sx = width/height*((width-2*wallthickness)/width)*height/(height-2*wallthickness);
sy = length/height*(length-2*wallthickness)/length*height/(height-2*wallthickness);

scale(0.5) difference(){
	scale([width/height,length/height,1]) intersection(){
		sphere(r=height,$fn=fragments);
		if(width>length && width>height){
			translate([-width,-width,0]) cube(width*2);
		}
		if(length>width && length>height){
			translate([-length,-length,0]) cube(length*2);
		}
		if(height>length && height>width){
			translate([-height,-height,0]) cube(height*2);
		}
		if(width==length && height<length){
			translate([-length,-length,0]) cube(length*2);
		}
		if(width==length && height>length){
			translate([-height,-height,0]) cube(height*2);
		}
	}
	scale([sx,sy,1]) intersection(){
		sphere(r=height-2*wallthickness,$fn=fragments);
		if(width>length && width>height){
			translate([-width,-width,0]) cube(width*2);
		}
		if(length>width && length>height){
			translate([-length,-length,0]) cube(length*2);
		}
		if(height>length && height>width){
			translate([-height,-height,0]) cube(height*2);
		}
		if(width==length && height<length){
			translate([-length,-length,0]) cube(length*2);
		}
		if(width==length && height>length){
			translate([-height,-height,0]) cube(height*2);
		}
	}
}
