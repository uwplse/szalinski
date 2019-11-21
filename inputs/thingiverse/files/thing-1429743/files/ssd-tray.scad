
text="Linux";
textSize=6;

offsetToCase = 2.9;

totalDepth = 123;
totalWidth = 75.6;
totalHeight = 10;

armWidth = 2.9;
armLength = 112;
armLengthInner = 101.4;
armHeight = 8.9;

headTotalDepth =22.7;
headMetalDepth =11;

offsetHeight = 0.3;


slitHeight = 6;
slitWith = 3;
slitDistance=2;

screwholeDiameter = 3.3;
screwholeDistanceToEnd = 14.3;
screwholeDistance = 76.5;
screwholeHeight = 3.3;

//raw form

union(){
difference(){
 cube([totalWidth,headTotalDepth-offsetToCase+armLengthInner,totalHeight]);

 translate([-10,headTotalDepth-headMetalDepth-offsetToCase,totalHeight-offsetHeight]){
  color("blue"){
   cube([totalWidth+20,armLength+10,offsetHeight+10]);
  }
 }
 translate([armWidth,headTotalDepth-offsetToCase,-10]){
  color("red"){
   cube([totalWidth-2*armWidth,armLengthInner+10,40]);
  }
 }
 translate([-10,headTotalDepth-offsetToCase,armHeight]){
  color("green"){
   cube([totalWidth+20,armLength+10,offsetHeight+10]);
  }
 }
 translate([-10,totalDepth,-10]){
  rotate([40,0,0]){
   color("purple"){
    cube([totalWidth+20,10,10]);
   }
  }
 }

 translate([-10,totalDepth,5.8]){
  rotate([50,0,0]){
   color("purple"){
    cube([totalWidth+20,10,10]);
   }
  }
 }
 translate([totalWidth/2-(slitWith+slitDistance)*4,0,totalHeight/2]){
  cube([slitWith,50,slitHeight],center=true);
 }
 translate([totalWidth/2-(slitWith+slitDistance)*3,0,totalHeight/2]){
  cube([slitWith,50,slitHeight],center=true);
 }
 translate([totalWidth/2-(slitWith+slitDistance)*2,0,totalHeight/2]){
  cube([slitWith,50,slitHeight],center=true);
 }
 translate([totalWidth/2-(slitWith+slitDistance)*1,0,totalHeight/2]){
  cube([slitWith,50,slitHeight],center=true);
 }
 translate([totalWidth/2,0,totalHeight/2]){
  cube([slitWith,50,slitHeight],center=true);
 }
 translate([totalWidth/2+(slitWith+slitDistance)*1,0,totalHeight/2]){
  cube([slitWith,50,slitHeight],center=true);
 }
 translate([totalWidth/2+(slitWith+slitDistance)*2,0,totalHeight/2]){
  cube([slitWith,50,slitHeight],center=true);
 }
 translate([totalWidth/2+(slitWith+slitDistance)*3,0,totalHeight/2]){
  cube([slitWith,50,slitHeight],center=true);
 }
 translate([totalWidth/2+(slitWith+slitDistance)*4,0,totalHeight/2]){
  cube([slitWith,50,slitHeight],center=true);
 }
 translate([totalWidth/2,totalDepth-screwholeDistanceToEnd,screwholeHeight]){
  rotate([0,90,0]){
   cylinder(h=totalWidth+20, r=screwholeDiameter/2, center=true, $fn = 20);
  }
 }
 translate([totalWidth/2,totalDepth-screwholeDistanceToEnd-screwholeDistance,screwholeHeight]){
  rotate([0,90,0]){
   cylinder(h=totalWidth+20, r=screwholeDiameter/2, center=true, $fn = 20);
  }
 }
 
 translate([0-armWidth/3,totalDepth-screwholeDistanceToEnd-screwholeDistance,screwholeHeight]){
  rotate([0,90,0]){
   cylinder(h=armWidth, r1=screwholeDiameter*1.2,r2=screwholeDiameter/2, center=false, $fn = 20);
  }
 }
 translate([0-armWidth/3,totalDepth-screwholeDistanceToEnd,screwholeHeight]){
  rotate([0,90,0]){
   cylinder(h=armWidth, r1=screwholeDiameter*1.2,r2=screwholeDiameter/2, center=false, $fn = 20);
  }
 }
 translate([totalWidth+armWidth/3,totalDepth-screwholeDistanceToEnd-screwholeDistance,screwholeHeight]){
  rotate([0,-90,0]){
   cylinder(h=armWidth, r1=screwholeDiameter*1.2,r2=screwholeDiameter/2, center=false, $fn = 20);
  }
 }
 translate([totalWidth+armWidth/3,totalDepth-screwholeDistanceToEnd,screwholeHeight]){
  rotate([0,-90,0]){
   cylinder(h=armWidth, r1=screwholeDiameter*1.2,r2=screwholeDiameter/2, center=false, $fn = 20);
  }
 }
  translate([armWidth,headTotalDepth-offsetToCase,(totalHeight-offsetHeight)/2]){
  rotate([0,90,0]){
   cylinder(h=totalWidth-armWidth*2, r=(totalHeight-offsetHeight)*0.43, center=false, $fn = 70);
  }
 }
 translate([armWidth+4,headTotalDepth-headMetalDepth,totalHeight-1]){
 linear_extrude(height = 1) {
  color("yellow"){
   text(text,size=textSize,font = "Liberation Sans");
  }
  }
}

cube([1,277,277],center=true);
translate([totalWidth,0,0])cube([1,277,277],center=true);
}

difference(){
translate([3,-totalHeight/6,totalHeight/2]){
 cube([5,totalHeight,totalHeight],center = true);
}
translate([3,-totalHeight/6,totalHeight/2]){
 cube([6,totalHeight-3,totalHeight-3],center = true);
}
}

difference(){
translate([totalWidth-3,-totalHeight/6,totalHeight/2]){
 cube([5,totalHeight,totalHeight],center = true);
}
translate([totalWidth-3,-totalHeight/6,totalHeight/2]){
 cube([6,totalHeight-3,totalHeight-3],center = true);
}
}
}



