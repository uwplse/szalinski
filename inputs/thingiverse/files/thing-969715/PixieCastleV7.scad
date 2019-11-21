$fn=64*1;

//CUSTOMIZER VARIABLES

//Set the approximate height of you castle in mm :
CastleHeight = 65;	//	[30:150]

//Choose sand mold or lantern. (If you print as Lantern with transparent filament and a height above 38mm, you can fit a LED tea light inside.) 
CastleType = "SandMold";//[SandMold,Lantern]

//Choose the shape of your castle.
CastleShape = "Quadrilateral";//[Solitary,Outpost,Triangle,Quadrilateral,Pentagon,Hexagon,Tee,Cross,Line]

//Choose the type of your Pixie Castle, or Pixie Wall element. (The wall element should be printed with the same height setting as the Castle to make them fit together, eg. both at 65mm.)
CastleVariation = "PixieEye";//[PixieEye,PixieFlower,PixieShell,PixieIce,PixieWall]

// This setting only affects the Pixie Flower Castle. It specifies the angle of the Fibonacci pattern, see text.
OnlyPixieFlower = 137.5;//[ 135.0 , 135.5 , 136.0 , 136.5 , 137.0 , 137.5 , 138.0 , 138.5 , 139.0 , 139.5 , 140]

//CUSTOMIZER VARIABLES END

PrintThickness = 1.5*1;//mm
CastleBase   = CastleHeight/1.6;
CastleTop    = CastleHeight/1.8;
DoorWidth    = CastleHeight*0.6;
DoorHeight   = CastleHeight*0.7;
DoorDepth    = CastleHeight*0.17;
WalkWay      = CastleHeight*0.22;
WalkWayDepth = CastleHeight*0.15;
WallLength   = (CastleTop*0.9+DoorDepth)*2;

if(CastleVariation!="PixieWall"){
    if(CastleType == "SandMold"){
        difference(){
            NegativeEye();
            union(){ 
                PositiveEye();
                anglestamp();
           }
       }
        
    }else{
        difference(){
            PositiveEye();
            insidelantern();
        }
    }
}




if(CastleVariation == "PixieWall"){
    
    if(CastleType == "SandMold"){
        difference(){
            basewall(true); 
            PositiveWall();
        }
    }else{
        difference(){
           PositiveWall();
           InsideWall();
        }
    }
        
}



module insidelantern(){
   translate([0,0,-0.1]){
    sph = CastleHeight*0.7;
   /* translate([0,0,-0.1]){
        difference(){
            cylinder(r1=CastleBase*0.88, r2=CastleTop*0.88, h=CastleHeight);
            translate([-50,-50,CastleHeight*0.7]){cube([100,100,100]);}
        }
    }*/
    intersection(){
        cylinder(r1=CastleBase*0.88, r2=CastleTop*0.88, h=CastleHeight);
        translate([0,0,-sph+CastleHeight*0.8]){
            sphere(r=sph);
        }
    }
    }
}


module InsideWall(){
    difference(){
        intersection(){
            translate([PrintThickness,PrintThickness,-0.1]){
                cube([  WallLength-PrintThickness*2,
                    DoorWidth-PrintThickness*2,
                    DoorHeight-WalkWayDepth-PrintThickness]);
                }
                //
                ra = CastleHeight/2;
                rotate([0,90,0]){
                translate([-DoorHeight+WalkWayDepth+ra+PrintThickness,DoorWidth/2,0]){
                    cylinder(r=ra,h=WallLength+0.2);
                }
        }
                
                }
            
            
            union(){
                
                translate([-0.1,-20+PrintThickness,0]){
                    rotate([-3,0,0]){
                       cube([WallLength+0.2,20,CastleHeight]);
                    }
                }
                translate([-0.1,DoorWidth-PrintThickness,0]){
                    rotate([+3,0,0]){
                       cube([WallLength+0.2,20,CastleHeight]);
                    }
                } 
           }
            
        }
        
}


module PositiveWall(){
    hole = CastleHeight/10;
    wwa = CastleHeight*0.02;//walkwayslope
    difference(){
        basewall(false);
        
        union(){
            
            if(CastleType == "SandMold"){
                
                rotate([0,2,0]){
                    translate([-20,0,0]){
                        cube([20,DoorWidth,DoorHeight*1.2]);
                    }
                }
                translate([WallLength,0,0]){
                        rotate([0,-2,0]){
                        cube([20,DoorWidth,DoorHeight*1.2]);
                    }
               }
            }
            
            
            
            translate([-0.1,DoorWidth/2,DoorHeight-WalkWayDepth+0.1]){
                rotate([90,0,90]){
                    linear_extrude(height=WallLength+0.2){
                        polygon(points=[ [-WalkWay/2,0],
                        [-WalkWay/2-wwa,WalkWayDepth],
                        [WalkWay/2+wwa,WalkWayDepth],
                        [WalkWay/2,0]  ]);
                    }
                }
            }
            sp = WallLength/4;
            rotate([-90,0,0]){
                translate([0,-DoorHeight,-0.1]){
                    cylinder(r=hole,h=DoorWidth+0.2);
                }
                translate([sp,-DoorHeight,-0.1]){
                    cylinder(r=hole,h=DoorWidth+0.2);
                }
                translate([sp*2,-DoorHeight,-0.1]){
                    cylinder(r=hole,h=DoorWidth+0.2);
                }
                translate([sp*3,-DoorHeight,-0.1]){
                    cylinder(r=hole,h=DoorWidth+0.2);
                }
                translate([sp*4,-DoorHeight,-0.1]){
                    cylinder(r=hole,h=DoorWidth+0.2);
                }
                
            }
            translate([-0.1,-20,0]){
                rotate([-3,0,0]){
                   cube([WallLength+0.2,20,CastleHeight]);
                }
            }
            translate([-0.1,DoorWidth,0]){
                rotate([+3,0,0]){
                    cube([WallLength+0.2,20,CastleHeight]);
                }
            }
        }
    }  
}





module basewall(extend){
    if(extend){
        translate([-PrintThickness,-PrintThickness,0.1]){
            cube([WallLength+PrintThickness*2,DoorWidth+PrintThickness*2,DoorHeight+PrintThickness]); 
        }     
    }else{
        cube([WallLength,DoorWidth,DoorHeight]);
    }
}


module anglestamp(){
    if(CastleShape == "Triangle"){
        translate([0,0,CastleHeight+PrintThickness]){
            rotate([90,0,45+150]){
                cylinder(r=0.6,h=CastleHeight);
            }
            rotate([90,0,45+90]){
                cylinder(r=0.6,h=CastleHeight);
            }
            rotate([0,0,+45]){
                translate([CastleHeight/8,CastleHeight/15,-0.6]){
                   linear_extrude(height = 1.2) { 
                       text("60°", size=CastleHeight/8,center=false);
                   }
                }
                translate([0,-CastleHeight/6,-0.6]){
                   linear_extrude(height = 1.2) { 
                       text("Triangle", size=CastleHeight/9,center=false);
                   }
                }
            }
        }
    }
    
    if(CastleShape == "Quadrilateral"){
        translate([0,0,CastleHeight+PrintThickness]){
            rotate([90,0,45+180]){
                cylinder(r=0.6,h=CastleHeight);
            }
            rotate([90,0,45+90]){
                cylinder(r=0.6,h=CastleHeight);
            }
            rotate([0,0,+45]){
                translate([CastleHeight/8,CastleHeight/15,-0.6]){
                   linear_extrude(height = 1.2) { 
                       text("90°", size=CastleHeight/8,center=false);
                   }
                }
                translate([-CastleHeight/5,-CastleHeight/6,-0.6]){
                   linear_extrude(height = 1.2) { 
                       text("Quadrilateral", size=CastleHeight/9,center=false);
                   }
                }
            }
        }
    }
    
    if(CastleShape == "Pentagon"){
        translate([0,0,CastleHeight+PrintThickness]){
            rotate([90,0,45+198]){
                cylinder(r=0.6,h=CastleHeight);
            }
            rotate([90,0,45+90]){
                cylinder(r=0.6,h=CastleHeight);
            }
            rotate([0,0,+45]){
                translate([CastleHeight/8,CastleHeight/15,-0.6]){
                   linear_extrude(height = 1.2) { 
                       text("108°", size=CastleHeight/8,center=false);
                   }
                }
                translate([0,-CastleHeight/6,-0.6]){
                   linear_extrude(height = 1.2) { 
                       text("Pentagon", size=CastleHeight/9,center=false);
                   }
                }
            }
            
        }
    }
    
    if(CastleShape == "Hexagon"){
        translate([0,0,CastleHeight+PrintThickness]){
            rotate([90,0,45+210]){
                cylinder(r=0.6,h=CastleHeight);
            }
            rotate([90,0,45+90]){
                cylinder(r=0.6,h=CastleHeight);
            }
            rotate([0,0,+45]){
                translate([CastleHeight/8,CastleHeight/15,-0.6]){
                   linear_extrude(height = 1.2) { 
                       text("120°", size=CastleHeight/8,center=false);
                   }
                }
                translate([0,-CastleHeight/6,-0.6]){
                   linear_extrude(height = 1.2) { 
                       text("Hexagon", size=CastleHeight/9,center=false);
                   }
                }
            }
        }
    }
    
}


module NegativeEye(){
    translate([0,0,0.1]){
        basecone(true);
        if(CastleShape=="Outpost"){
            basedoor(0,true);
        }
        if(CastleShape=="Triangle"){
            basedoor(0,true);
            basedoor(60,true);
        }
        if(CastleShape=="Quadrilateral"){
            basedoor(0,true);
            basedoor(90,true);
        }
        if(CastleShape=="Pentagon"){
            basedoor(0,true);
            basedoor(108,true);
        }
        if(CastleShape=="Hexagon"){
            basedoor(0,true);
            basedoor(120,true);
        }
        if(CastleShape=="Tee"){
            basedoor(0,true);
            basedoor(90,true);
            basedoor(180,true);
        }
        if(CastleShape=="Cross"){
            basedoor(0,true);
            basedoor(90,true);
            basedoor(-90,true);
            basedoor(180,true);
        }
        if(CastleShape=="Line"){
            basedoor(0,true);
            basedoor(180,true);
        }
    }
}

/*
module PositiveFlower(){
    baseA();  
    intersection(){
        basecone(false);
        translate([0,0,CastleHeight*0.8-0.1]){
            fibonacci();
        }
    }
 }
*/


module PositiveEye(){
    baseA();  
    intersection(){
        basecone(false);
        translate([0,0,CastleHeight*0.8-0.1]){
            
            if(CastleVariation == "PixieEye"){hexagonpattern();}
            if(CastleVariation == "PixieFlower"){fibonacci();};
            if(CastleVariation == "PixieShell"){nautilus();};
            if(CastleVariation == "PixieIce"){koch();};
        }
    } 
    if(CastleShape=="Outpost"){
            basedoor(0,false);
        }
        if(CastleShape=="Triangle"){
            basedoor(0,false);
            basedoor(60,false);
        }
        if(CastleShape=="Quadrilateral"){
            basedoor(0,false);
            basedoor(90,false);
        }
        if(CastleShape=="Pentagon"){
            basedoor(0,false);
            basedoor(108,false);
        }
        if(CastleShape=="Hexagon"){
            basedoor(0,false);
            basedoor(120,false);
        }
        if(CastleShape=="Tee"){
            basedoor(0,false);
            basedoor(90,false);
            basedoor(180,false);
        }
        if(CastleShape=="Cross"){
            basedoor(0,false);
            basedoor(90,false);
            basedoor(-90,false);
            basedoor(180,false);
        }  
        if(CastleShape=="Line"){
            basedoor(0,false);
            basedoor(180,false);
        }
}





module basecone(extend){
    if(extend){
        cylinder(r1=CastleBase+PrintThickness,r2=CastleTop+PrintThickness,h=CastleHeight+PrintThickness);
     }else{
        cylinder(r1=CastleBase,r2=CastleTop,h=CastleHeight);
    }
}



module basedoor(angle,extend){
    if(extend){
        rotate([0,0,45+angle]){
            translate([CastleTop*0.9-PrintThickness,-DoorWidth/2-PrintThickness,0]){
                cube([
                    DoorDepth+PrintThickness*2,
                    DoorWidth+PrintThickness*2,
                    CastleHeight+PrintThickness]);
            }
        }
    }else{
        difference(){
            rotate([0,0,45+angle]){
                translate([CastleTop*0.9,-DoorWidth/2,0]){
                    cube([DoorDepth,DoorWidth,DoorHeight]);
                }
            }
            
            rotate([0,0,45+angle]){
                wwa = CastleHeight*0.02;//walkwayslope
                translate([0,0,DoorHeight-WalkWayDepth+0.1]){
                    rotate([90,0,90]){
                        linear_extrude(height=WallLength+0.2){
                            polygon(points=[ [-WalkWay/2,0],
                            [-WalkWay/2-wwa,WalkWayDepth],
                            [WalkWay/2+wwa,WalkWayDepth],
                            [WalkWay/2,0]  ]);
                        }
                    }
                }
                
                translate([0,DoorWidth/2,0]){
                    rotate([3,0,0]){
                        cube([CastleTop*2,20,DoorHeight*1.2]);
                    }
                }
                translate([0,-DoorWidth/2-20,0]){
                    rotate([-3,0,0]){
                        cube([CastleTop*2,20,DoorHeight*1.2]);
                    }
                } 
              
                sp = WallLength/6;
                hole = CastleHeight/10;
                rotate([-90,0,0]){
                translate([CastleTop*0.9+DoorDepth,-DoorHeight,-DoorWidth/2]){
                    cylinder(r=hole,h=DoorWidth+0.2);
                }
            }
                
                
                if(CastleType == "SandMold"){
                    translate([CastleTop*0.9+DoorDepth,-DoorWidth/2,0]){
                        rotate([0,-2,0]){
                            cube([DoorDepth,DoorWidth,DoorHeight*1.2]);
                        }
                    }
                }
                
            }       
        }
    }
}

module nautilus(){
    sc = CastleTop/11.4;
    scale([sc,sc,sc]){
    
        intersection(){
            cylinder(r=12,h=10);  
            translate([-1.4,1.8,0]){ // højre,op,    
                a=0.9;
                b=0.2;
                for(theta=[180:20:780]){
                    t = (theta/360)*2*3.14; 
                    d = a*exp(b*t);
                    rotate([0,0,theta]){
                        translate([d,0,0]){
                            translate([0,0,-t/6]){
                                sphere(r=t/2,$fa=10);
                            }
                        }
                    }
                }
            }
        }
    }
}


/*module nautilus(){
    translate([0,0,0]){
    a=CastleHeight*0.024;
    b=CastleHeight*0.004;
    for(theta=[0:20:360*2.5]){
        t = (theta/360)*2*3.14; 
        d = a*exp(b*t);
        rotate([0,0,theta]){
            translate([d,0,0]){
                sphere(r=(t/2)*(CastleHeight/50));
            }
        }
    }
}
}*/


module fibonacci(){
    c = CastleHeight/10;
    br = CastleHeight/7.3;
    hh = CastleHeight*0.2;
    
    for(a=[0:40]){ //40
   
        theta = a*OnlyPixieFlower;//137.5
        d = c*sqrt(a);
   
        rotate([0,0,theta]){
            translate([d,0,0]){
                //sphere(r=br,center=true);
                cylinder(r1=br,r2=0.0,h=hh);
                //cylinder(r1=2,r2=1,h=1); 
            }
        }
    }
}



module hexagonpattern(){
        difference(){
            hexagonpillars();
            translate([-100,-100,-50]){cube([200,200,50]);}
        }
    
    }



module hexagonpillars(){
    r = CastleHeight/6;
    h = CastleHeight/8;
    
    hexagon(0,0,         0.2*h,r);
    hexagon(0, r*1.72,    1.1*h,r);
    hexagon(0, r*1.72*2,  0.6*h,r);
    hexagon(0,-r*1.72,   1.2*h,r);
    hexagon(0,-r*1.72*2, 0.4*h,r);
    
    hexagon(r*1.48,r*0.86,    0.6*h,r);
    hexagon(r*1.48,r*0.86*3,  3*h,r);//!
    hexagon(r*1.48,-r*0.86,   0.2*h,r);
    hexagon(r*1.48,-r*0.86*3, 3*h,r);//!
    
    hexagon(-r*1.48,r*0.86,    0.8*h,r);
    hexagon(-r*1.48,r*0.86*3,  3*h,r);//!
    hexagon(-r*1.48,-r*0.86,   0.4*h,r);
    hexagon(-r*1.48,-r*0.86*3, 3*h,r);//!

    hexagon(r*2.95,r*1.72,     1.3*h,r);
    hexagon(r*2.95,0,          3*h,r);//!
    hexagon(r*2.95,-r*1.72,    0.4*h,r);
    
    hexagon(-r*2.95,r*1.72,    1.1*h,r);
    hexagon(-r*2.95,0,         3*h,r);//!;
    hexagon(-r*2.95,-r*1.72,   1.1*h,r);
    }





module baseA(){
    difference(){
        intersection(){
            translate([-100,-100,]){cube([200,200,CastleHeight*0.8]);} 
            basecone(false);
        }
        pillars();
        }
    }



module pillars(){
    for(a=[0:30:360]){
        rotate([0,0,a]){
            translate([CastleHeight/1.59,0,-0.1]){
                //cylinder(r=CastleHeight/10,h=CastleHeight+2);
                //cube( [CastleHeight/10, CastleHeight/6, CastleHeight+2]);
                rotate([0,0,30]){
                linear_extrude(height = CastleHeight*2, center = true, convexity = 10, twist = 0){
                    circle(r = CastleHeight/15, $fn=6);
                }
            }
            }
        }
    }
}

module hexagon(x,y,h,radius){
   translate([x,y,0]){
        linear_extrude(height = CastleHeight/10+h, center = true, convexity = 10, twist = 0){
            circle(r = radius, $fn=6);
        }
    }
}


cx = 144.2276;
cy = 137.1114;

module koch(){
    rotate([0,0,-10]){
    resize([CastleTop*2,CastleTop*2,CastleHeight*0.2]){
        linear_extrude(height=20){
            difference(){
                koch2();
                scale([0.6,0.6,1]){ koch1(); }
            }
            scale([0.3,0.3,1]){ koch0(); }
        }
    }
    cylinder(r1=CastleTop*1.05, r2=CastleTop*0.8,  h=CastleHeight/7);
}
}


module koch0(){
    translate([-cx,-cy,0]){
    polygon(points=[
  [100.0000,  100.0000],
  [198.4808,  117.3648],
  [134.2020,  193.9693],
  [100.0000,  100.0000]]);
    }
}

module koch1(){
    translate([-cx,-cy,0]){
    polygon(points=[
  [100.0000,  100.0000],
  [132.8269,  105.7883],
  [155.0287,   75.8555],
  [165.6539,  111.5765],
  [198.4808,  117.3648],
  [177.0545,  142.8996],
  [191.8762,  177.0933],
  [155.6283,  168.4344],
  [134.2020,  193.9693],
  [122.8013,  162.6462],
  [ 85.7779,  158.3853],
  [111.4007,  131.3231],
  [100.0000,  100.0000]]);
}}

module koch2(){
    translate([-cx,-cy,0]){
    polygon(points=[
  [100.0000,  100.0000],
  [110.9423,  101.9294],
  [118.3429,   91.9518],
  [121.8846,  103.8588],
  [132.8269,  105.7883],
  [140.2275,   95.8107],
  [133.9502,   83.4213],
  [147.6281,   85.8331],
  [155.0287,   75.8555],
  [158.5704,   87.7625],
  [172.2483,   90.1743],
  [162.1121,   99.6695],
  [165.6539,  111.5765],
  [176.5962,  113.5060],
  [183.9967,  103.5284],
  [187.5385,  115.4354],
  [198.4808,  117.3648],
  [191.3387,  125.8764],
  [196.2793,  137.2743],
  [184.1966,  134.3880],
  [177.0545,  142.8996],
  [181.9951,  154.2975],
  [195.8633,  155.0559],
  [186.9356,  165.6954],
  [191.8762,  177.0933],
  [179.7936,  174.2070],
  [170.8660,  184.8465],
  [167.7109,  171.3207],
  [155.6283,  168.4344],
  [148.4862,  176.9461],
  [153.4267,  188.3439],
  [141.3441,  185.4577],
  [134.2020,  193.9693],
  [130.4018,  183.5282],
  [118.0606,  182.1079],
  [126.6016,  173.0872],
  [122.8013,  162.6462],
  [110.4602,  161.2259],
  [102.8693,  172.8569],
   [98.1191,  159.8056],
   [85.7779,  158.3853],
   [85.7779,  158.3853],
   [94.3188,  149.3646],
   [89.5686,  136.3133],
  [102.8598,  140.3438],
  [111.4007,  131.3231],
  [107.6004,  120.8821],
   [95.2593,  119.4618],
  [103.8002,  110.4410],
  [100.0000,  100.0000] ]);
  }
  }

