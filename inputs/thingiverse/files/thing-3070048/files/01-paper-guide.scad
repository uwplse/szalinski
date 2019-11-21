// Author: Dieter Vanderfaeillie
// Leitz 5036 measure tool
// Licensed under a Creative Commons Attribution-ShareAlike 3.0 International License.
// Adjusted by Jonas "frdmn" Friedmann <j@frd.mn>

$fn = 70;
LENGTH = 135; //Length of the tool
DEPTH = 11;   //Depth of the tool
HEIGHT = 5;   //Heigth of the tool
LABELS = 1;   //Display of labels on the tool

// Following code should be better document...
translate([2,DEPTH,HEIGHT]){
  rotate(a=180,v=[1,0,0]){
    difference(){
      base();
      union(){
        roundingv();
        roundingh(0);
        roundingh(1);
        //888
        translate([23,0,0]){
          cut();
          emboss("88");
        }
        //A6
        translate([29,0,0]){
          cut();
          emboss("A6");
        }
        //A5
        translate([59,0,0]){
          cut();
          emboss("A5");
        }
        //US
        translate([93,0,0]){
          cut();
          emboss("US");
        }
        //A4
        translate([103,0,0]){
          cut();
          emboss("A4");
        }
      }
    }
  }
}

module rest(){
  innerwidth = 10;
  innerheight = 2.5;
  translate([0,1.5,0]){
    mirror([0,0,1]){
      difference(){
        cube([innerwidth,DEPTH-3,innerheight]);
        translate([innerwidth,0,innerheight]){
          rotate(a=-90,v=[1,0,0]){
            resize([innerwidth*2,0,0]){
              cylinder(r=innerheight, h=DEPTH-3);
            }
          }
        }
      }
    }
  }
}

module roundingh(right){
  RADIUS = 1.5;
  translateCube = right ? [0,-RADIUS,-RADIUS] : [0,0,-RADIUS];
  translateTotal = right ? [0,RADIUS,RADIUS] : [0,DEPTH-RADIUS,RADIUS];
  translate(translateTotal){
    difference(){
      translate(translateCube){
        cube([LENGTH,RADIUS,RADIUS]);
      }
      rotate(a=90,v=[0,1,0]){
        cylinder(r=RADIUS,h=LENGTH);
      }
    }
  }
}

module roundingv(){
  RADIUS = 5;
  translate([LENGTH-RADIUS,0,RADIUS]){
    difference(){
      translate([0,0,-RADIUS]){
        cube([RADIUS,DEPTH,RADIUS]);
      }
      rotate(a=-90,v=[1,0,0]){
        cylinder(r=RADIUS,h=DEPTH);
      }
    }
  }
}

module emboss(text){
  if(LABELS){
    translate([-11,DEPTH-8,0]){
      difference(){
        cube([5,8,0.8]);
        placeText(text);
      }
    }
  }
}

module placeText(text) {
  translate([0.5,4,0]){
    mirror([0,1,0]){
      rotate(a=-90,v=[0,0,1]){
        linear_extrude(1)
            text(text=text,size=4,halign="center",font="Liberation Sans:style=Bold Italic");
      }
    }
  }
}

module sidegrip(){
  sideDepth = 2;
  union(){
    cube([sideDepth,DEPTH,DEPTH]);
    translate([0,DEPTH/2,DEPTH]){
      rotate(a=90,v=[0,1,0]){
        cylinder(r=DEPTH/2,h=sideDepth);
      }
    }
  }
}

module cut(){
  cutdepth = 0.9;
  translate([0,0,HEIGHT-3]){
    union(){
      cube([3.75,cutdepth,3.75]);
      translate([0,DEPTH-cutdepth,0]){
        cube([3,cutdepth,3]);
      }
    }
  }
}

module base(){
  rest();
  wallThickness = 1.5;
  difference(){
    cube([LENGTH,DEPTH,HEIGHT]);
    translate([wallThickness,wallThickness,2]){
      cube([LENGTH-wallThickness*2, DEPTH-wallThickness*2,HEIGHT-2]);
    }
  }
  translate([14,0,0]){
    cube([2,DEPTH,HEIGHT]);
    translate([0,DEPTH/2-1,0]){
      cube([3,2,HEIGHT]);
    }
  }
  translate([-2,DEPTH,HEIGHT]){
    rotate(a=180,v=[1,0,0]){
      sidegrip();
    }
  }
}