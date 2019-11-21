//length of the ruler in mm
length=150; //[51:500]

//width of the ruler in mm
width=20; //[5:50]

//thickness
height=2; //[2:10]

//depth of the edge for cirular measurement
edgedepth=8; //[5:50]

//height of the pins
cylinderheight=5; //[5:20]

//diameter of the marker hole
holediameter=2; //[1:4]


cylinderdiameter=4+1;
cylinderradius=cylinderdiameter/2;



rotate(a=[0,0,45]){
    cube([height,(width*2),edgedepth+height]);
};

rotate(a=[0,0,-45]){
cube([height,width*2,edgedepth+height]);
};

xoffset=sqrt((width*width)/2)-sqrt(height);
yoffset=sqrt((width*width)/2)+sqrt((width*width)/2);


difference(){
	difference(){
		translate(v=[-(width-sqrt(height)),-sqrt(height),0]){
		cube([width,length,height]);
		}

		translate(v=[0,-yoffset,-1]){
			rotate(a=[0,0,45]){
				cube([width,(width*width)/2,height+2]);
			}
		}
	}
	// hole
	translate(v=[-(width/2)+(holediameter/2),(length/2),(height/2)]){
		cylinder(r=(holediameter/2), h=height, center=true, $fn=50);
	}
};
translate(v=[-(width/2)+cylinderradius/2,(width),-(cylinderheight/2)]){
    cylinder(r=cylinderradius, h=cylinderheight, center=true, $fn=50);
};

translate(v=[-(width/2)+cylinderradius/2,(length-width),-(cylinderheight/2)]){
    cylinder(r=cylinderradius, h=cylinderheight, center=true, $fn=50);
};



