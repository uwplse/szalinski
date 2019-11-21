//User preferences:
//Only works with integers. e.g. 1,2,3,4...
numberOfRows = 2;
//Only works with integers. e.g. 1,2,3,4...
numberOfColumns = 1;
//Only works with integers. e.g. 1,2,3,4...
numberOfVerticalDeviders = 1;
//Only works with integers. e.g. 1,2,3,4...
numberOfHorizontalDeviders = 2;

//The general thickness of the insert in mm
wallThickness = 1.5;
//The thickness of the inserts bottom in mm
bottomThickness = 2.5;


/* [Hidden] */
//Model Variables:
//preview[view:south, tilt:top]

sphereResolution = 100;
removeOffset = 0.1;

insertWidth = 54;
insertDepth = 54;
insertHeight = 45;

innerRadius = 3.5;
outerRadius = 5;
insertAngle = 1;
lidGuideHeight = 4.5;

//Build;
buildModel();

module buildModel(){
 buildDeviders();
 buildInsert();
}

//Functions:
module buildInsert(){
 difference(){
	buildRoundedBox(insertWidth * numberOfColumns, insertHeight, insertDepth * numberOfRows, 0, 0, outerRadius);
   buildRoundedBox(insertWidth * numberOfColumns, insertHeight+removeOffset, insertDepth * numberOfRows, wallThickness, bottomThickness, innerRadius);
 }
}

module buildDeviders(){
 if(numberOfVerticalDeviders != 0){
  for (i = [0 : numberOfVerticalDeviders-1]){
   buildVerticalDevider(insertWidth * numberOfColumns, insertDepth * numberOfRows, i);
  }
 }
 if(numberOfHorizontalDeviders != 0){
  for (i = [0 : numberOfHorizontalDeviders-1]){
   buildHorizontalDevider(insertDepth * numberOfRows, insertWidth * numberOfColumns, i);
  }
 }
}


//Parts:
module buildRoundedBox(width, height, depth, wallThickness, bottomThickness, radius){
 hull() {
  translate([(((width/2)-radius)-wallThickness -insertAngle),(((depth/2)-radius)-wallThickness -insertAngle),bottomThickness+radius]) 
   sphere(r = radius, $fn=sphereResolution);
  translate([-(((width/2)-radius)-wallThickness -insertAngle),(((depth/2)-radius)-wallThickness -insertAngle),bottomThickness+radius]) 
   sphere(r = radius, $fn=sphereResolution);
  translate([(((width/2)-radius)-wallThickness -insertAngle),-(((depth/2)-radius)-wallThickness -insertAngle),bottomThickness+radius]) 
   sphere(r = radius, $fn=sphereResolution);
  translate([-(((width/2)-radius)-wallThickness -insertAngle),-(((depth/2)-radius)-wallThickness -insertAngle),bottomThickness+radius]) 
   sphere(r = radius, $fn=sphereResolution);

  difference(){
   hull() {
    translate([(((width/2)-radius)-wallThickness),(((depth/2)-radius)-wallThickness),height]) 
     sphere(r = radius, $fn=sphereResolution); 
    translate([-(((width/2)-radius)-wallThickness),(((depth/2)-radius)-wallThickness),height]) 
     sphere(r = radius, $fn=sphereResolution); 
    translate([(((width/2)-radius)-wallThickness),-(((depth/2)-radius)-wallThickness),height]) 
     sphere(r = radius, $fn=sphereResolution);
    translate([-(((width/2)-radius)-wallThickness),-(((depth/2)-radius)-wallThickness),height]) 
     sphere(r = radius, $fn=sphereResolution);
   }
   translate([0,0,height+radius]) 
    cube(size = [width*2, depth*2, radius*2], center = true);
  }
 }
}

module buildVerticalDevider(width, depth, pos){
 deviderXCoordinate = (width/2)-(width/(numberOfVerticalDeviders+1)+((width/(numberOfVerticalDeviders+1))*pos));

 difference(){
  translate([deviderXCoordinate,0,insertHeight/2]){
   hull(){
    rotate([0,-90,0]){
     linear_extrude(height = wallThickness+(innerRadius*2), center = true, convexity = 10, twist = 0){ 
      polygon([[(insertHeight/2)-lidGuideHeight,((depth/2)-(wallThickness/2))],[(insertHeight/2)-lidGuideHeight,-((depth/2)-(wallThickness/2))],[0,0]]);
      translate([-((insertHeight/2)-(innerRadius+(wallThickness/2))),(depth/2)-(wallThickness/2) -insertAngle -innerRadius,0]) 
       circle(innerRadius, $fn=sphereResolution);
      translate([-((insertHeight/2)-(innerRadius+(wallThickness/2))),-((depth/2)-(wallThickness/2) -insertAngle -innerRadius),0])
       circle(innerRadius, $fn=sphereResolution);
     }
    }
   }
  }

  hull() {
   translate([deviderXCoordinate+innerRadius+(wallThickness/2), depth/2-insertAngle-innerRadius-wallThickness, innerRadius+bottomThickness]) 
    sphere(r = innerRadius, $fn=sphereResolution); 
   translate([deviderXCoordinate+innerRadius+(wallThickness/2), -(depth/2-insertAngle-innerRadius-wallThickness), innerRadius+bottomThickness]) 
    sphere(r = innerRadius, $fn=sphereResolution);
   translate([deviderXCoordinate+innerRadius+(wallThickness/2), (depth/2-innerRadius-wallThickness), insertHeight]) 
    sphere(r = innerRadius, $fn=sphereResolution);
   translate([deviderXCoordinate+innerRadius+(wallThickness/2), -(depth/2-innerRadius-wallThickness), insertHeight]) 
    sphere(r = innerRadius, $fn=sphereResolution);
  }

  hull() {
   translate([deviderXCoordinate-innerRadius-(wallThickness/2), depth/2-insertAngle-innerRadius-wallThickness, innerRadius+bottomThickness]) 
    sphere(r = innerRadius, $fn=sphereResolution); 
   translate([deviderXCoordinate-innerRadius-(wallThickness/2), -(depth/2-insertAngle-innerRadius-wallThickness), innerRadius+bottomThickness]) 
    sphere(r = innerRadius, $fn=sphereResolution);
   translate([deviderXCoordinate-innerRadius-(wallThickness/2), (depth/2-innerRadius-wallThickness), insertHeight]) 
    sphere(r = innerRadius, $fn=sphereResolution);
   translate([deviderXCoordinate-innerRadius-(wallThickness/2), -(depth/2-innerRadius-wallThickness), insertHeight]) 
    sphere(r = innerRadius, $fn=sphereResolution);
  }
 }
}

module buildHorizontalDevider(width, depth, pos){
 deviderYCoordinate = (width/2)-(width/(numberOfHorizontalDeviders+1)+((width/(numberOfHorizontalDeviders+1))*pos));

 difference(){
  translate([0,deviderYCoordinate,insertHeight/2]){
   hull(){
    rotate([0,-90,90]){
     linear_extrude(height = wallThickness+(innerRadius*2), center = true, convexity = 10, twist = 0){ 
      polygon([[(insertHeight/2)-lidGuideHeight,((depth/2)-(wallThickness/2))],[(insertHeight/2)-lidGuideHeight,-((depth/2)-(wallThickness/2))],[0,0]]);
      translate([-((insertHeight/2)-(innerRadius+(wallThickness/2))),(depth/2)-(wallThickness/2) -insertAngle -innerRadius,0]) 
       circle(innerRadius, $fn=sphereResolution);
      translate([-((insertHeight/2)-(innerRadius+(wallThickness/2))),-((depth/2)-(wallThickness/2) -insertAngle -innerRadius),0])
       circle(innerRadius, $fn=sphereResolution);
     }
    }
   }
  }

rotate([0,0,90]){
  hull() {
   translate([deviderYCoordinate+innerRadius+(wallThickness/2), depth/2-insertAngle-innerRadius-wallThickness, innerRadius+bottomThickness]) 
    sphere(r = innerRadius, $fn=sphereResolution); 
   translate([deviderYCoordinate+innerRadius+(wallThickness/2), -(depth/2-insertAngle-innerRadius-wallThickness), innerRadius+bottomThickness]) 
    sphere(r = innerRadius, $fn=sphereResolution);
   translate([deviderYCoordinate+innerRadius+(wallThickness/2), (depth/2-innerRadius-wallThickness), insertHeight]) 
    sphere(r = innerRadius, $fn=sphereResolution);
   translate([deviderYCoordinate+innerRadius+(wallThickness/2), -(depth/2-innerRadius-wallThickness), insertHeight]) 
    sphere(r = innerRadius, $fn=sphereResolution);
  }
}

rotate([0,0,90]){
  hull() {
   translate([deviderYCoordinate-innerRadius-(wallThickness/2), depth/2-insertAngle-innerRadius-wallThickness, innerRadius+bottomThickness]) 
    sphere(r = innerRadius, $fn=sphereResolution); 
   translate([deviderYCoordinate-innerRadius-(wallThickness/2), -(depth/2-insertAngle-innerRadius-wallThickness), innerRadius+bottomThickness]) 
    sphere(r = innerRadius, $fn=sphereResolution);
   translate([deviderYCoordinate-innerRadius-(wallThickness/2), (depth/2-innerRadius-wallThickness), insertHeight]) 
    sphere(r = innerRadius, $fn=sphereResolution);
   translate([deviderYCoordinate-innerRadius-(wallThickness/2), -(depth/2-innerRadius-wallThickness), insertHeight]) 
    sphere(r = innerRadius, $fn=sphereResolution);
  }
}
 }
}