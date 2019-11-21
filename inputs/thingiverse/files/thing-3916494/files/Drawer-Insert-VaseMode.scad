//User preferences:
//The Width of the insert in mm
insertWidth = 50;
//The Depth of the insert in mm
insertDepth = 100;
//The Height of the insert in mm
insertHeight = 35;

//The Angle of the insert wall in degrees - Top. Default=1
wallAngleTop = 1; //[0:.5:45]
//The Angle of the insert wall in degrees - Right. Default=1
wallAngleRight = 1; //[0:.5:45]
//The Angle of the insert wall in degrees - Left. Default=1
wallAngleLeft = 1; //[0:.5:45]
//The Angle of the insert wall in degrees - Bottom. Default=1
wallAngleBottom = 1; //[0:.5:45]

//The Outer Radius
outerRadius = 4; //[1:.1:10]

/* [Hidden] */
//Model Variables:
//preview[view:south, tilt:top]

sphereResolution = 100;
removeOffset = 0.1;

//Build;
buildRoundedBoxAngled(insertWidth, insertHeight, insertDepth, outerRadius, wallAngleTop, wallAngleRight, wallAngleLeft, wallAngleBottom);

module buildRoundedBoxAngled(width, height, depth, radius, angleTop, angleRight, angleLeft, angleBottom){
 hull() {
  // TRR -- TRT
  translate([(((width/2)-radius) -angleRight),(((depth/2)-radius) -angleTop),radius]) 
   sphere(r = radius, $fn=sphereResolution);
  // TLL .. TLT
  translate([-(((width/2)-radius) -angleLeft),(((depth/2)-radius) -angleTop),radius]) 
   sphere(r = radius, $fn=sphereResolution);
  // RBR.. RBB
  translate([(((width/2)-radius) -angleRight),-(((depth/2)-radius) -angleBottom),radius]) 
   sphere(r = radius, $fn=sphereResolution);
  //LBL .. LBB
  translate([-(((width/2)-radius) -angleLeft),-(((depth/2)-radius) -angleBottom),radius]) 
   sphere(r = radius, $fn=sphereResolution);

  difference(){
   hull() {
    translate([(((width/2)-radius)),((depth/2)-radius),height]) 
     sphere(r = radius, $fn=sphereResolution); 
    translate([-(((width/2)-radius)),((depth/2)-radius),height]) 
     sphere(r = radius, $fn=sphereResolution); 
    translate([(((width/2)-radius)),-((depth/2)-radius),height]) 
     sphere(r = radius, $fn=sphereResolution);
    translate([-(((width/2)-radius)),-((depth/2)-radius),height]) 
     sphere(r = radius, $fn=sphereResolution);
   }
   translate([0,0,height+radius]) 
    cube(size = [width*2, depth*2, radius*2], center = true);
  }
 }
}

