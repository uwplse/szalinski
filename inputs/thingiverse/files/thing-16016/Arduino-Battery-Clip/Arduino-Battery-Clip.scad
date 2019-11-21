UNO=false;
washers=true;
thickness=5;
width=7;

cX=53.3/2;
cY=68.6/2;
screw_r=3.2/2;

mainClip();

module washers(arrayLength,arrayWidth,washerLength,washerWidth,resolution){
  for(i=[-(arrayLength-1)/2:(arrayLength-1)/2]){
    for(j=[-(arrayWidth-1)/2:(arrayWidth-1)/2]){
      translate([i*10,j*10,0]){
        washer(washerLength,washerWidth,resolution);
      }
    }
  }
}

module washer(length,width,resolution){
  translate([0,0,length/2]){
    difference(){
      cylinder(r=width/2,h=length,center=true,$fn=resolution);
      cylinder(r=screw_r,h=length,center=true,$fn=resolution);
    }
  }
}

module mainClip(){
  translate([0,0,thickness/2]){
    cube([38.3,25,thickness],center=true);
  }
  batteryClip(0,thickness,true);
  arm(0,0,-(cX-7.6)+3.5,cY-2.5,width,thickness,0,100,true,false,1,-1);
  if(UNO) arm(0,0,-(cX-2.5),-(cY-14),width,thickness,0,100,true,false,1,1);
  arm(0,0,cX-15.2,cY-2.5,width,thickness,0,100,true,false,-1,-1);
  arm(0,0,cX-2.6+1.5,-(cY-15.3)-1.5,width,thickness,0,100,true,false,-1,1);
  if(washers){
    for(i=[-1.5:1.5]){
      translate([-25,5+i*8,0]){
        washer(5,width,100);
      }
    }
  }
}


module arm(startX,startY,endX,endY,width,height,zOffset,resolution,hole,leg,xs,ys){
  if(hole){
    difference(){
      armWithoutHole(startX,startY,endX,endY,width,height,zOffset,resolution,leg,xs,ys);
      translate([endX,endY,zOffset+height/2]){
        cylinder(r=screw_r,h=height,center=true,$fn=resolution);
      }
    }
  }else{
    armWithoutHole(startX,startY,endX,endY,width,height,zOffset,resolution,leg,xs,ys);
  }
}

module armWithoutHole(startX,startY,endX,endY,width,height,zOffset,resolution,leg,xs,ys){
  translate([startX,startY,zOffset+height/2]){
    cylinder(r=width/2,h=height,center=true,$fn=resolution);
  }
  translate([endX,endY,zOffset+height/2]){
    cylinder(r=width/2,h=height,center=true,$fn=resolution);
  }
  len=sqrt(pow(startX-endX,2)+pow(startY-endY,2));
  translate([(startX+endX)/2,(startY+endY)/2,zOffset+height/2]){
    rotate([0,0,-atan((startX+endX)/(startY+endY))]){
      cube([width,len,height],center=true);
    }
  }
  if(leg){
    translate([
        endX+((thickness)/(xs*sqrt((((startY-endY)*(startY-endY))/((startX-endX)*(startX-endX)))+1))),
        endY+((thickness)/(ys*sqrt((((startX-endX)*(startX-endX))/((startY-endY)*(startY-endY)))+1))),
        12.5+height
      ]){
      cylinder(r=thickness/2,h=25,center=true,$fn=resolution);
    }
  }
}

module batteryClip(xOffset,zOffset,center){
  xOffset = center? 76.7/2+xOffset: xOffset;
  //zOffset=0;
  
  batteryw = 25.4;
  batteryh = 16.4;
  ClipW = 6.5;  //width of the clip
  ClipL = 25; //length of the clip
  
  //internal constants
  dimh = 4.242641;  // dimensions of the 3 cube after rotating 45 degrees
  
  translate([xOffset/2 - batteryw/2 -ClipW ,0,0]){
    union(){
      translate([batteryw/2,0-ClipL/2,zOffset]) {
        cube ([ClipW, ClipL, batteryh+dimh/2]);
        translate([0-dimh/2,0,batteryh]){
          rotate([0,45,0]){	
            cube([3,25,3]);
          }
        }
      }
      rotate (a = [0,0,180]){
        translate([batteryw/2,0-ClipL/2,zOffset]) {
          cube ([ClipW, ClipL, batteryh+dimh/2]);
          translate([0-dimh/2,0,batteryh]){
            rotate([0,45,0]){	
              cube([3,25,3]);
            }
          }
        }
      }
    }
  }
}
