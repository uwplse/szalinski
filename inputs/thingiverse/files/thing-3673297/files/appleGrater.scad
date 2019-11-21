/*
Parametric Apple Grater pattern generator.
Works fine also as very expensive computer enclosure venting grid

*/
$fn=50;

nCount=5;
mCount=7;
xMargin=3.5;
yMargin=3.5;

//Thickness of panel
thickness=1.5;
//wall thickness
wall=1.5;
//How deep holes are
zOffset=1.5;
//How much grater holes are apart
spacing=10;
domeDiameter=9;
holeDiameter=4.5;
holeAngle=35;


//module cheeseGrater(nX,nY,domeDiameter,gap){
module ballHoles(holeCount,domeDiameter,holeDiameter,holeAngle){
    sphere(d=domeDiameter);
        
    if(0<holeCount){
        rotate([holeAngle,0,0])
        cylinder(d=holeDiameter,h=domeDiameter*10);
    }
    if(1<holeCount){
        rotate([0,0,120])
        rotate([holeAngle,0,0])
        cylinder(d=holeDiameter,h=domeDiameter*10);
    }
    if(2<holeCount){
        rotate([0,0,-120])
        rotate([holeAngle,0,0])
        cylinder(d=holeDiameter,h=domeDiameter*3);
    }
}


module ballHolesGrid(nCount,mCount,spacing,domeDiameter,holeDiameter,holeAngle,makeHoles){
  for(nX=[0:nCount-2]){
    for(nY=[1:mCount-1]){
      if(nY%2==1){//Shift
        translate([(0.5+nX)*spacing,nY*spacing,0])
        ballHoles(3*makeHoles,domeDiameter,holeDiameter,holeAngle);
      }else{
        if(0<nX){
        translate([nX*spacing,nY*spacing,0])
        ballHoles(3*makeHoles,domeDiameter,holeDiameter,holeAngle);          
        }
      }
    }
  }
  

  for(nY=[1:mCount-1]){
    if(nY%2==0){
      translate([0,nY*spacing,0])
      ballHoles(2*makeHoles,domeDiameter,holeDiameter,holeAngle);
      translate([spacing*(nCount-1),nY*spacing,0])
      rotate([0,0,-120])
      ballHoles(2*makeHoles,domeDiameter,holeDiameter,holeAngle);
    }
  }

  //Top row
  for(nX=[1:nCount-2]){
      translate([nX*spacing,0,0])
      rotate([0,0,120])
      ballHoles(2*makeHoles,domeDiameter,holeDiameter,holeAngle);
  }

  rotate([0,0,120])
  ballHoles(1*makeHoles,domeDiameter,holeDiameter,holeAngle);
  
  translate([spacing*(nCount-1),0,0])
  rotate([0,0,-120])
  ballHoles(1*makeHoles,domeDiameter,holeDiameter,holeAngle);

}

module ballGrid(nCount,mCount,spacing,domeDiameter,holeDiameter,holeAngle,makeHoles){
  for(nX=[0:nCount-2]){
    for(nY=[0:mCount-1]){
        
      if(nY%2==1){//Shift
        translate([(0.5+nX)*spacing,nY*spacing,0])
        sphere(d=domeDiameter);
      }else{
        if(0<nX){
        translate([nX*spacing,nY*spacing,0])
        sphere(d=domeDiameter);
        }
      }
    }
  }
  

  for(nY=[1:mCount-1]){
    if(nY%2==0){
      translate([0,nY*spacing,0])
      sphere(d=domeDiameter);
      translate([spacing*(nCount-1),nY*spacing,0])
      rotate([0,0,-120])
      sphere(d=domeDiameter);
    }
  }

  //Top row
  for(nX=[1:nCount-2]){
      translate([nX*spacing,0,0])
      rotate([0,0,120])
      sphere(d=domeDiameter);
  }

  rotate([0,0,120])
  sphere(d=domeDiameter);
  
  translate([spacing*(nCount-1),0,0])
  rotate([0,0,-120])
  sphere(d=domeDiameter);
}


module cheeseGridPanel(nCount,mCount,xMargin,yMargin,thickness,zOffset,spacing,domeDiameter,holeDiameter,holeAngle){
    
    difference(){
        cube([xMargin*2+(nCount-1)*spacing+domeDiameter,yMargin*2+(mCount-1)*spacing+domeDiameter,thickness]);
        translate([xMargin+domeDiameter/2,yMargin+domeDiameter/2,zOffset])
        ballHolesGrid(nCount,mCount,spacing,domeDiameter,holeDiameter,holeAngle,1);   
    }
    
    translate([xMargin+domeDiameter/2,yMargin+domeDiameter/2,0])
    difference(){
        translate([0,0,zOffset])
        ballGrid(nCount,mCount,spacing,domeDiameter+wall*2,holeDiameter,holeAngle,0);   
        translate([0,0,zOffset])
        ballHolesGrid(nCount,mCount,spacing,domeDiameter,holeDiameter,holeAngle,1);   
        translate([-domeDiameter,-domeDiameter,-domeDiameter+0.05])
        cube([xMargin*2+nCount*spacing+domeDiameter,yMargin*2+mCount*spacing+domeDiameter,domeDiameter]);
    }

}

cheeseGridPanel(nCount,mCount,xMargin,yMargin,thickness,zOffset,spacing,domeDiameter,holeDiameter,holeAngle);