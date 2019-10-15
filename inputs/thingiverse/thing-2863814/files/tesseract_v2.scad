// Resolution
$fn=30;
// Side Length
sideLength=40;
// Post Radius
postR=2;
// Inside Cube Length
insideLength_=20;

module hidden(){}
insideLength=insideLength_-postR-postR;
il=sideLength/2;
os=il-insideLength/2;


//bottom
module Corner1a(){
    translate([postR,postR,postR]) sphere(postR);
}

module Corner2a(){
    translate([sideLength-postR,postR,postR]) sphere(postR);
}

module Corner3a(){
    translate([sideLength-postR,sideLength-postR,postR]) sphere(postR);
}

module Corner4a(){
    translate([postR,sideLength-postR,postR]) sphere(postR);
}
//top
module Corner5a(){
    translate([postR,postR,sideLength-postR]) sphere(postR);
}

module Corner6a(){
    translate([sideLength-postR,postR,sideLength-postR]) sphere(postR);
}

module Corner7a(){
    translate([sideLength-postR,sideLength-postR,sideLength-postR]) sphere(postR);
}

module Corner8a(){
    translate([postR,sideLength-postR,sideLength-postR]) sphere(postR);
}

// INSIDE //


//bottom
module Corner1b(){
    translate([os,os,os]) sphere(postR);
}

module Corner2b(){
    translate([os+insideLength,os,os]) sphere(postR);
}

module Corner3b(){
    translate([os+insideLength,os+insideLength,os]) sphere(postR);
}

module Corner4b(){
    translate([os,os+insideLength,os]) sphere(postR);
}

//top
module Corner5b(){
    translate([os,os,os+insideLength]) sphere(postR);
}

module Corner6b(){
    translate([os+insideLength,os,os+insideLength]) sphere(postR);
}

module Corner7b(){
    translate([os+insideLength,os+insideLength,os+insideLength]) sphere(postR);
}

module Corner8b(){
    translate([os,os+insideLength,os+insideLength]) sphere(postR);
}




//--Outside--//
//bottom
hull(){
    Corner1a();
    Corner2a();
}

hull(){
    Corner2a();
    Corner3a();
}

hull(){
    Corner3a();
    Corner4a();
}

hull(){
    Corner4a();
    Corner1a();
}
//top
hull(){
    Corner5a();
    Corner6a();
}

hull(){
    Corner6a();
    Corner7a();
}

hull(){
    Corner7a();
    Corner8a();
}

hull(){
    Corner8a();
    Corner5a();
}
//sides
hull(){
    Corner1a();
    Corner5a();
}

hull(){
    Corner2a();
    Corner6a();
}

hull(){
    Corner3a();
    Corner7a();
}

hull(){
    Corner4a();
    Corner8a();
}
//--Inside--//
//bottom
hull(){
    Corner1b();
    Corner2b();
}

hull(){
    Corner2b();
    Corner3b();
}

hull(){
    Corner3b();
    Corner4b();
}

hull(){
    Corner4b();
    Corner1b();
}

//top
hull(){
    Corner5b();
    Corner6b();
}

hull(){
    Corner6b();
    Corner7b();
}

hull(){
    Corner7b();
    Corner8b();
}

hull(){
    Corner8b();
    Corner5b();
}
//sides
hull(){
    Corner1b();
    Corner5b();
}

hull(){
    Corner2b();
    Corner6b();
}

hull(){
    Corner3b();
    Corner7b();
}

hull(){
    Corner4b();
    Corner8b();
}


//connectors
hull(){
    Corner1a();
    Corner1b();
}

hull(){
    Corner2a();
    Corner2b();
}

hull(){
    Corner3a();
    Corner3b();
}

hull(){
    Corner4a();
    Corner4b();
}

hull(){
    Corner5a();
    Corner5b();
}

hull(){
    Corner6a();
    Corner6b();
}

hull(){
    Corner7a();
    Corner7b();
}

hull(){
    Corner8a();
    Corner8b();
}






