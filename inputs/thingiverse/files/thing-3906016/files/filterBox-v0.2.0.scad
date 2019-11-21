//External diameter of the filter
externalFilterDiameter = 44;
//Thread diameter of the filter
filterDiameter = 37;
//Filter number in X
filtersInX = 2;
//Filter number in Y
filtersInY = 1;
//Filter height
filterHeight = 11;
//Margin between the wall and the filter hole
margin = 1.6;
//Wall size
wall = 0.8;
//Finger hole for easy extract
fingerHoles = true;

//Tolerance
tolerance = 0.25;
//Type of hinge: Flat: A single layer of filament so that it folds easily, like plastic box. Normal: A standard hinge printed in one piece (need bigger tolerance). Filament: A standard hinge that use a filament (1.75 mm) for the axis.
hingeType = "Flat"; //[Flat: Flat {Recomended}), Filament: With a Filament axis {Bigger that flat, requiere supports}, Normal: Normal {experimental}]


/* [Hidden] */
threadHeight = 2.5;
boxHeight = (filterHeight/2) + wall;
boxBorder = boxHeight*0.66;
holeHeight = boxHeight+boxBorder;
holeSize = externalFilterDiameter + tolerance*2 + (margin*2);
boxWidth = (holeSize * filtersInX) + (wall*2)+tolerance*2;
boxDepth = (holeSize * filtersInY) + (wall*2)+tolerance*2;

hingeNum = hingeType != "Flat"? filtersInX > 2 ? 2:filtersInX: 1;
hingeSep = 1.5;
diameter= 1.75;
hd = hingeType != "Flat"?(diameter/2) * 3 +tolerance*2: 0;
hingeDiameter = hd > 0 && hd < 5.5 ? 5.5:hd;
$fn=60;
create();

module create(){
  echo(hingeType);
   hingeWidth = hingeType != "Flat"? holeSize - holeSize*0.10: boxWidth- boxWidth*0.10;
   sep =  hingeType != "Flat"? 0:0;
   union(){
      translate([0,-boxDepth/2 - hingeSep - hingeDiameter/2,0]){
         create_base();
      }
      translate([0,boxDepth/2 + hingeSep + hingeDiameter/2 + sep,-boxBorder/2]){
         create_top();
      }
      moveX = hingeNum >1 ? -boxWidth/4: 0;
      for(i=[0:hingeNum-1]){
         translate([i>0 ? -moveX:moveX,0,(boxHeight-boxBorder)/2]){
            hinge(hingeWidth);
         }
      }

   }
}
module create_base(){
   x=-boxWidth/2 + wall+holeSize/2;
   y=-boxDepth/2 + wall+holeSize/2;
   union() {
      difference() {
         union(){
            cube([boxWidth-(wall*2)-tolerance*2,boxDepth-(wall*2)-tolerance*2,boxHeight+boxBorder-wall],center=true);
            translate([0,0,-boxBorder/2]){
              cube([boxWidth,boxDepth,boxHeight],center=true);
            }
         }
         for(i=[0:filtersInX-1]){
            for(j=[0:filtersInY-1]){
               let (x = x +(holeSize*i) , y=y+(holeSize*j)){
                     filter_hole(x, y);

               }
            }
         }

      }
     translate([0,-boxDepth/2+wall+wall/4,boxBorder/2]){
         rotate([0,90,0]){
            closure();
         }
      }
      translate([-boxWidth/2+wall+wall/4,0,boxBorder/2]){
         rotate([90,0,0]){
            closure();
         }
      }
      translate([boxWidth/2-wall-wall/4,0,boxBorder/2]){
         rotate([90,0,0]){
            closure();
         }
      }

   }
}



module create_top(){
   union(){
      difference() {
         cube([boxWidth,boxDepth,boxHeight],center=true);
         translate([0,0,wall]){
            cube([boxWidth-(wall*2),boxDepth-(wall*2),boxHeight],center=true);
         }
      }
      translate([0,boxDepth/2+wall,boxHeight/2-wall/2]){
         cube([boxWidth/5,wall*2,wall],center=true);
      }
   }
}

module filter_hole(x,y){
   translate([x,y,wall]){
     union(){
        translate([0,0,threadHeight ]){
           cylinder(holeHeight-threadHeight-wall, d=externalFilterDiameter + tolerance*2, center=true);
         }
        cylinder(holeHeight, d=filterDiameter+tolerance*2, center=true);
     }
     if(fingerHoles){
       for(i=[1:4]){
         rotate([0, 0, 90*i]) {
           fingerHole();
         }
       }
     }
  }
}

module fingerHole(){
  radio = holeSize/5;
  zDiff = radio - (holeHeight-threadHeight-wall) > 0 ? holeHeight/2+(radio - (holeHeight-threadHeight-wall))+wall*2:holeHeight/2+radio/2;
  translate([radio,-radio,zDiff]){
    rotate([45,90,0]){
      union(){
        cylinder(h=holeSize/5,r=radio,center=true);
        translate([0,0,holeSize/10]){
          sphere(r=radio);
        }
      }
    }
  }
}

module hinge(width){
   if(hingeType == "Flat"){
     flatHinge(width);
   } else {
     bisagra_base(width, hingeType=="Filament");
     bisagra_top(width);
   }
}

module closure(){
      cylinder(d=wall/2, h=boxWidth/5, center=true);
}

module flatHinge(width){
    //espaciado de 2.5 mm en 0
    rotate(a=[00,90,0]){
        union(){
            translate([-2.4,1.5,0]){
                cuarto(width);
            }
            translate([-2.4,-1.5,0]){
                rotate(a=[180,0,0]){
                    cuarto(width);
                }
            }
        }
    }
}

module cuarto(width){
    difference(){
        cylinder(d=6.0,h=width, center=true);
        translate([-1,0,0]){
            cube([6.80,7,width+tolerance], center = true);
        }
        translate([0,hingeSep,0]){
            cube([7,3,width+tolerance], center = true);
        }
     }
}

// Bisabra
module bisagra_base(width,  hole){
   hingePartSize = width/3 - tolerance;
   union(){
     if(hole){
       difference(){
         rotate([90,90,90]){
             cylinder(hingePartSize,d=hingeDiameter, center = true);
          }
         rotate([90,90,90]){
          cylinder(width,d=diameter+tolerance*2, center = true);
         }

        }
     }else{
        union(){
          rotate([90,90,90]){
           cylinder(width,d=diameter, center = true);
          }
          rotate([90,90,90]){
              cylinder(hingePartSize,d=hingeDiameter, center = true);
           }
         }
     }
     rotate(a=[0,0,180]){
       soporte(hingeSep+(hingeDiameter-diameter)/2 ,0,hingePartSize);
     }
   }
}

module bisagra_top(width){
  hingePartSize = width/3 - tolerance;
   union(){
      difference(){
         union(){
            translate([-hingePartSize-tolerance,0,0]){
               rotate([90,90,90]){
                  cylinder(hingePartSize,d=hingeDiameter, center = true);
               }
            }
            translate([hingePartSize+tolerance,0,0]){
               rotate([90,90,90]){
                  cylinder(hingePartSize,d=hingeDiameter, center = true);
               }
            }
         }
         rotate([90,90,90]){
            cylinder(width,d=diameter+tolerance*2, center = true);
         }
      }
      translate([-hingePartSize-tolerance,0,0]){
         soporte(hingeSep+(hingeDiameter-diameter)/2 ,0,hingePartSize);
      }

      translate([hingePartSize+tolerance,0,0]){
         soporte(hingeSep+(hingeDiameter-diameter)/2 ,0,hingePartSize);
      }
   }
}

module soporte(width, length ,hingePartSize){
   di = width;
   s = tolerance-tolerance*0.25;
   difference(){
     translate([0 ,(width/2+diameter/2) + length ,s]){
        union(){
           difference(){
              translate([0,0,-(hingeDiameter/4)]){
                 cube([hingePartSize,width,hingeDiameter/2],center=true);
              }
              translate([0,diameter/2,+diameter/3]){
                 rotate(a=[-15,0,0]){
                    cube([hingePartSize+tolerance,(width),diameter/2+tolerance],center=true);
                 }
              }
              translate([0,0,-di+tolerance]){
                cube([hingePartSize+5,width+10,hingeDiameter/2],center=true);
              }
           }
           translate([0,0,-di+s/2]){
              difference(){
                 translate([0,di/4,di/4]){
                    cube([hingePartSize,di/2,di/2],center=true);
                 }
                 rotate(a=[0,90,0]){
                    cylinder(h=hingePartSize+tolerance*2,d=di,center=true);
                 }
              }
           }
           translate([0,-length/2-width/2,0-diameter/4]){
              cube([hingePartSize,length,diameter-tolerance],center=true);
           }
        }
      }
      rotate([0,90,0]){
        cylinder(hingePartSize*2,d=diameter+tolerance*2, center = true);
      }
    }


}
