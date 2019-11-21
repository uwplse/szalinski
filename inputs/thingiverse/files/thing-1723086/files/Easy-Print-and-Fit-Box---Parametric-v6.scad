/*
// dgazineu@gmail.com (Douglas Gazineu)
// Rev1: 2016-08-18 :: Initial Release
// Rev2: 2016-08-20 :: Removed Ring Shrinkage
// Rev3: 2016-08-22 :: Screw Holes option for Ring Lock, Internal Depth Correction
// Rev4: 2016-08-23 :: Internal support feet for boards, changed default walls orientation for printing it
// Rev5: 2016-08-24 :: Vents Option
// Rev6: 2016-12-02 :: Fix: Generate multiple parts at once
//
*/

// Part to be viewed
part = "all"; // [top:Top, bottom:Bottom, side:Sides, face: Front/Back, lock: Lock parts, all: Assembled View, exploded: Exploded View ]

/* [General Options] */
// Type of Lock
Lock_Type=2; //[1:Corners, 2:Rings]
// Reinforce Rings and provide screw hole
Ring_Screw_Holes = 1; //[0:No, 1:Yes]
// Internal Feet for boards 
Internal_Feet = 1; //[0:No, 1:Yes]
// Ventilation Openings 
Side_Vents = 1; //[0:No, 1:Yes]
Top_Vents = 1; //[0:No, 1:Yes]

/* [Dimensions] */
//Dimensions (Internal).
depth=80;
height=40;
width=60;
//Length of Lock parts/ring.
Lock_Length=11; // [3:50]
//Thickness of Walls
Wall_Thickness=2.5; // [2,2.5,3,3.5,4,4.5,5,5.5,6,7,8]
// Diameter of screw holes in mm
Ring_Screw_Diameter = 2.5; //[1.5,2,2.2,2.5,3,3.5,4,4.5,5]

/* [Internal Support Feet] */
// Internal Feet Separation (between center of holes)
Feet_Depth=20;
Feet_Width=30;
// Distances are cleared from walls on the reference side
Feet_Distance_From_Back = 5;
Feet_Distance_From_Side = 5;
Feet_Screw_Pole_Height = 5; //[1:10]
Feet_Screw_Pole_Diameter = 6; //[4:15]
Feet_Screw_Diameter = 2.2; //[1.5,2,2.2,2.5,3,3.5,4,4.5,5]

/* [Vents Options] */
Vents_Number=5;
Vents_Distance=1.5;
// Each vent length relative to width or height of panel
Vents_Relation=4; // [3:10]

/* [Fine Adjustments] */
// Avg Interval between anchor points for faces
Anchor_Interval=35; // [20,25,30,35,40,50,60,70,80,90,100]
// Gap between fittings, so no sanding should be needed
Gap=0.4;




module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}

module side(depth,width){
    Side_depth=depth+3*Wall_Thickness;
    Border_Distance= 2*Wall_Thickness+Ring_Screw_Diameter/2;
    Vent_Length = (width-2*Wall_Thickness)/Vents_Relation;
    difference(){
        plate(depth,width);
        if (Ring_Screw_Holes == 1) {
            if (Lock_Type==2){
                translate([Border_Distance,width/2,Wall_Thickness]) cylinder($fn= 20, h = 4*Wall_Thickness, r = Ring_Screw_Diameter/2, center=true);
               translate([Side_depth-Border_Distance,width/2,Wall_Thickness]) cylinder($fn= 20, h = 4*Wall_Thickness, r = Ring_Screw_Diameter/2, center=true);
                }
            }
           if (Side_Vents == 1){
               for (a=[0:1:Vents_Number-1]){
               translate([Lock_Length+(2*a*Vents_Distance)+Vents_Distance,Wall_Thickness,-Wall_Thickness]) cube([Vents_Distance,Vent_Length,3*Wall_Thickness]);
               translate([Lock_Length+(2*a*Vents_Distance)+Vents_Distance,width-Vent_Length-Wall_Thickness,-Wall_Thickness]) cube([Vents_Distance,Vent_Length,3*Wall_Thickness]);
               translate([depth-(Lock_Length+(2*(a+1)*Vents_Distance)-3*Wall_Thickness),Wall_Thickness,-Wall_Thickness]) cube([Vents_Distance,Vent_Length,3*Wall_Thickness]);
                 translate([depth-(Lock_Length+(2*(a+1)*Vents_Distance)-3*Wall_Thickness),width-Vent_Length-Wall_Thickness,-Wall_Thickness]) cube([Vents_Distance,Vent_Length,3*Wall_Thickness]);
               }
           }
        }
}

module bottom(depth,width){
    Bottom_depth=depth+3*Wall_Thickness;
    union(){
        plate(depth,width);
        if (Internal_Feet == 1){
            if (Lock_Type==2){
                for (x =[Feet_Distance_From_Back:Feet_Depth:Feet_Distance_From_Back+Feet_Depth]){
                    for (y = [Feet_Distance_From_Side:Feet_Width:Feet_Distance_From_Side+Feet_Width]){
                        translate([x+Feet_Screw_Pole_Diameter/2,y+Feet_Screw_Pole_Diameter/2,0]) ScrewPole();
                    }
                }
            }
        }
    }
}

module top(depth,width){
    Top_depth=depth+3*Wall_Thickness;
    Vent_Length = (width-2*Wall_Thickness)/Vents_Relation;
    difference(){
        plate(depth,width);
        if (Top_Vents == 1){
                for (a=[0:1:Vents_Number-1]){
             translate([Lock_Length+(2*a*Vents_Distance)+Vents_Distance,Wall_Thickness,-Wall_Thickness]) cube([Vents_Distance,Vent_Length,3*Wall_Thickness]);
              translate([Lock_Length+(2*a*Vents_Distance)+Vents_Distance,width-Vent_Length-Wall_Thickness,-Wall_Thickness]) cube([Vents_Distance,Vent_Length,3*Wall_Thickness]);
               translate([depth-(Lock_Length+(2*(a+1)*Vents_Distance)-3*Wall_Thickness),Wall_Thickness,-Wall_Thickness]) cube([Vents_Distance,Vent_Length,3*Wall_Thickness]);
                 translate([depth-(Lock_Length+(2*(a+1)*Vents_Distance)-3*Wall_Thickness),width-Vent_Length-Wall_Thickness,-Wall_Thickness]) cube([Vents_Distance,Vent_Length,3*Wall_Thickness]);
               }
        }
    }
}

module ScrewPole(){
    Border_Distance= 2*Wall_Thickness+Ring_Screw_Diameter/2;
    difference(){
               translate([Border_Distance,0,-(Feet_Screw_Pole_Height/2)+Wall_Thickness/2]) cylinder($fn= 30, h=Feet_Screw_Pole_Height+Wall_Thickness, r = Feet_Screw_Pole_Diameter/2, center=true);      
               translate([Border_Distance,0,-Wall_Thickness-1]) cylinder($fn= 20, h=Feet_Screw_Pole_Height+2, r = Feet_Screw_Diameter/2, center=true);
     }
}

module plate(depth,width) {
    depth=depth+3*Wall_Thickness;
    tmpcols = width % Anchor_Interval;
    cols=(width - tmpcols) / Anchor_Interval;
    sizecols = width / (cols+1.5);
   
    remain = depth - (2*Lock_Length);
    tmprows = remain % Anchor_Interval;
    rows=(remain - tmprows) / Anchor_Interval;
    sizerows = remain / (rows+1);
    
   difference(){
        union() {
          cube([depth, width, Wall_Thickness]);
          translate([depth,0,Wall_Thickness])     rotate([0,0,90])   prism(Lock_Length,-Wall_Thickness,-Wall_Thickness);
          translate([Lock_Length,0,Wall_Thickness])   rotate([0,0,90])    prism(Lock_Length,-Wall_Thickness,-Wall_Thickness);
      if (Lock_Type == 1){
              difference(){
                 union(){      
                      translate([depth,Wall_Thickness,Wall_Thickness]) rotate([0,0,90]) prism(Lock_Length,-2*Wall_Thickness,Wall_Thickness);     
                      translate([Lock_Length,Wall_Thickness,Wall_Thickness]) rotate([0,0,90]) prism(Lock_Length,-2*Wall_Thickness,Wall_Thickness);
                 }
                 translate([0,-Wall_Thickness,1.5*Wall_Thickness])  cube([depth, 2*Wall_Thickness, 0.5*Wall_Thickness]);
              }
       }
          translate([0,width,Wall_Thickness])  rotate([0,0,270]) prism(Lock_Length,-Wall_Thickness,-Wall_Thickness);
          translate([depth-Lock_Length,width,Wall_Thickness])  rotate([0,0,270]) prism(Lock_Length,-Wall_Thickness,-Wall_Thickness);
          union(){
             for (a =[0:sizerows:depth-(sizerows+(2*Lock_Length))]) {
              translate([a+Lock_Length+(Gap/2),-Wall_Thickness,0])
                   cube([(sizerows/2)-(Gap/2),2*Wall_Thickness,Wall_Thickness]);
              }
              for (a =[0:sizerows:depth-(sizerows+(2*Lock_Length))]) {
              translate([a+Lock_Length+(sizerows/2)+(Gap/2),-Wall_Thickness+width,0])
                   cube([(sizerows/2)-(Gap/2),2*Wall_Thickness,Wall_Thickness]);
              }
           }
      if (Lock_Type == 1){
         difference(){
                  union(){
                      translate([0,width-Wall_Thickness,Wall_Thickness]) rotate([0,0,270]) prism(Lock_Length,-2*Wall_Thickness,Wall_Thickness);
                      translate([depth-Lock_Length,width-Wall_Thickness,Wall_Thickness]) rotate([0,0,270]) prism(Lock_Length,-2*Wall_Thickness,Wall_Thickness);
                  }
                  translate([0,width-Wall_Thickness,1.5*Wall_Thickness]) cube ([depth, 2*Wall_Thickness, 0.5*Wall_Thickness]);
                  }
                  
            }
        }
        union(){
            for (a =[0:sizecols:width-sizecols]) {
              translate([Wall_Thickness-(Gap/2),(a+sizecols/2)-(Gap/2),-1])
                cube([Wall_Thickness+Gap,sizecols/2+Gap,2*Wall_Thickness]);
            }
            for (a =[0:sizecols:width-sizecols]) {
              translate([(depth-(2*Wall_Thickness))-(Gap/2),(a+sizecols/2)-(Gap/2),-1])
                cube([Wall_Thickness+Gap,sizecols/2+Gap,2*Wall_Thickness]);
            }
        }
    }
    
}

module corner(Wall_Thickness){
    length = Lock_Length;
    color("teal")
    difference(){
        difference(){
            rotate([0,0,45]) translate([-3*Wall_Thickness,-3*Wall_Thickness,0]) cube([5*Wall_Thickness,6*Wall_Thickness,length+1]);
            translate([0.9*Wall_Thickness,0.9*Wall_Thickness,1]) edge(length,Wall_Thickness);
        }
          union(){
            rotate([0,0,45])
            translate([-6*Wall_Thickness,-3*Wall_Thickness,-1]) cube([5.5*Wall_Thickness,5.5*Wall_Thickness,length+2+Wall_Thickness]);        
            translate([-2*Wall_Thickness,2.5*Wall_Thickness,-1]) rotate([0,0,180]) cube([6*Wall_Thickness,4*Wall_Thickness,length+2+Wall_Thickness]);
            translate([2.5*Wall_Thickness,-2*Wall_Thickness,-1]) rotate([0,0,180]) cube([6*Wall_Thickness,4*Wall_Thickness,length+2+Wall_Thickness]);  
            translate([-3*Wall_Thickness,2*Wall_Thickness,-1]) cube([6*Wall_Thickness,6*Wall_Thickness,length+2+Wall_Thickness]);
            translate([2*Wall_Thickness,-3*Wall_Thickness,-1]) cube([6*Wall_Thickness,6*Wall_Thickness,length+2+Wall_Thickness]);
             
         }
     }
}


module ring(height, width){
    Border_Distance= 2*Wall_Thickness+Ring_Screw_Diameter/2;
    
    color("teal")
    
    difference(){
        union(){
            translate([-Gap/2-1.5*Wall_Thickness,-Gap/2-1.5*Wall_Thickness,-1]) cube([height+Gap+3*Wall_Thickness, width+Gap+3*Wall_Thickness, Lock_Length+1]); // Ring Shell
            if (Ring_Screw_Holes == 1) {
                hull(){
                 translate([height/2,width/2,Border_Distance]) rotate([90,0,0]) cylinder($fn= 20, h = width+4*Wall_Thickness, r = 1.25*Ring_Screw_Diameter,center=true);
                translate([height/2,width/2,-0.5]) rotate([90,0,0]) cube([2.5*Ring_Screw_Diameter,1,width+4*Wall_Thickness],center=true);
                }
            }
        }
        union(){
            translate([-Gap/2-Wall_Thickness/2,-Gap/2-Wall_Thickness/2,-2]) cube([height+Gap+Wall_Thickness, width+Gap+Wall_Thickness, Lock_Length+3]); // Inner Hole
            translate([-Gap/2-Wall_Thickness,-Gap/2-Wall_Thickness,0]) cube([height+Gap+2*Wall_Thickness, width+Gap+2*Wall_Thickness, Lock_Length+2]); // Outer Hole
            if (Ring_Screw_Holes == 1) {
                 translate([height/2,width/2,Border_Distance]) rotate([90,0,0]) cylinder($fn= 20, h = width+6*Wall_Thickness, r = Ring_Screw_Diameter/2, center=true);
            }
        }
    }
    
}

module edge(length, Wall_Thickness){
    length = Lock_Length+Wall_Thickness;
    Wall_Thickness=Wall_Thickness+(Gap/2);
    translate([-Wall_Thickness,-Wall_Thickness,0])
    rotate([90,-90,90])
    difference(){
        union(){
          translate([0,-1.5*Wall_Thickness,-Wall_Thickness])    
          cube([length, Wall_Thickness*4, 2*Wall_Thickness]);    
      
          rotate([-90,0,180])
          translate([-length,-1.5*Wall_Thickness,-Wall_Thickness])    
          cube([length, Wall_Thickness*4, 2*Wall_Thickness]);  
     }
     rotate([45,0,0])
     translate([-1, -sqrt(2)*Wall_Thickness,sqrt(2)*Wall_Thickness])
     cube([length+2, Wall_Thickness*3, Wall_Thickness]);
  }
}


module face(height, width){
   tmprows = height % Anchor_Interval;
   rows=(height - tmprows) / Anchor_Interval;
   sizerows = height / (rows+1.5);
   tmpcols = width % Anchor_Interval;
   cols=(width - tmpcols) / Anchor_Interval;
   sizecols = width / (cols+1.5);
   color("white")
   union() {
     translate([Gap/2,Gap/2,0]) cube([height-Gap, width-Gap, Wall_Thickness]);
   
     translate([Gap/2,width-(Wall_Thickness/2)-Gap/2,0]) cube([height-Gap, Wall_Thickness/2,Wall_Thickness*1.5]);
     translate([Gap/2,Gap/2,0]) cube([height-Gap, Wall_Thickness/2,Wall_Thickness*1.5]);
     translate([Gap/2,Gap/2,0]) cube([Wall_Thickness/2, width-Gap,Wall_Thickness*1.5]);
     translate([height-(Wall_Thickness/2)-Gap/2,Gap/2,0]) cube([Wall_Thickness/2, width-Gap,Wall_Thickness*1.5]);
       
     for (a =[0:sizerows:height-sizerows]) {
         translate([a+sizerows/2,-Wall_Thickness,0])
            cube([sizerows/2,width+(Wall_Thickness*2),Wall_Thickness]);
      }
     for (a =[0:sizecols:width-sizecols]) {
         translate([-Wall_Thickness,a+sizecols/2,0])
            cube([height+(Wall_Thickness*2),sizecols/2,Wall_Thickness]);
      }
   }
}


module view(){
    if (part == "top"){
      // Top
        color ("gray")
        if (Lock_Type==2){
             rotate([180,0,0]) translate([0,-width,-Wall_Thickness]) top(depth,width);
        }
        else top(depth,width);
            
    }
    else if (part == "bottom"){
      // Bottom
        color ("gray")
        if (Lock_Type==2){
             rotate([180,0,0]) translate([0,-width,-Wall_Thickness]) bottom(depth,width);
        }
        else bottom(depth,width);
            
    }
    else if (part == "side"){
       // Sides
       color("silver") 
         if (Lock_Type==2){
             rotate([180,0,0]) translate([0,-height,-Wall_Thickness]) side(depth,height);
         }
         else side(depth,height);
    }
    else if (part == "lock"){
         if (Lock_Type == 1){
             // Corners
             corner (Wall_Thickness);
         } else{
             // Ring
             ring(height, width);
         }
    }
    
    else if (part == "face"){
       // Faces
       face(height, width);
    }
    else if (part == "all"){
      // Top
      color ("gray")
      translate([0,0,height+2*Wall_Thickness]) top(depth,width);
      // Bottom
      color ("gray")
      rotate([180,0,0]) translate([0,-width,-2*Wall_Thickness]) bottom(depth,width);
      // Left
      color ("silver")
       rotate([90,0,0]) translate([0,2*Wall_Thickness,0]) side(depth,height);
      // Right
        color ("silver")
       rotate([270,0,0]) translate([0,-2*Wall_Thickness-height,width]) side(depth,height);
       // Back Face
       rotate([0,270,0]) translate([2*Wall_Thickness,0,-2*Wall_Thickness]) face(height,width); 
       // Front Face
       rotate([0,270,180]) translate([2*Wall_Thickness,-width,depth+Wall_Thickness]) face(height,width);
       
       if (Lock_Type == 1){
           // Corners
           rotate([0,90,0]) translate([-2*Wall_Thickness,width,-1]) corner(Wall_Thickness);
           rotate([0,90,0]) translate([-2*Wall_Thickness,width,0]) rotate([0,0,90]) translate([0,height,-1]) corner(Wall_Thickness); 
           rotate([0,90,0]) translate([-2*Wall_Thickness,width,0]) rotate([0,0,-90]) translate([width,0,-1]) corner(Wall_Thickness); 
           rotate([0,90,0]) translate([-2*Wall_Thickness,width,0]) rotate([0,0,180]) translate([height,width,-1]) corner(Wall_Thickness);
            rotate([0,90,180]) translate([-2*Wall_Thickness,0,-depth-1-3*Wall_Thickness]) corner(Wall_Thickness);
           
           rotate([0,90,180]) translate([-2*Wall_Thickness,0,-depth-3*Wall_Thickness]) rotate([0,0,90]) translate([0,height,-1]) corner(Wall_Thickness);
           rotate([0,90,180]) translate([-2*Wall_Thickness,0,-depth-3*Wall_Thickness]) rotate([0,0,-90]) translate([width,0,-1]) corner(Wall_Thickness);
           rotate([0,90,180]) translate([-2*Wall_Thickness,0,-depth-3*Wall_Thickness]) rotate([0,0,180]) translate([height,width,-1]) corner(Wall_Thickness);
       }
       else{
           // Rings
           rotate([0,270,0]) translate([2*Wall_Thickness,0,-depth-3*Wall_Thickness]) ring(height, width);
           rotate([0,270,180]) translate([2*Wall_Thickness,-width,0]) ring(height, width);
       }
    }
    else{
      // Exploded Distance
      distance = 4*Wall_Thickness;
      // Top
      color ("gray")
      translate([0,distance,height+2*Wall_Thickness+2*distance]) top(depth,width);
      // Bottom
      color ("gray")
      rotate([180,0,0]) translate([0,-width-distance,-2*Wall_Thickness]) bottom(depth,width);
      // Left
      color ("silver")
       rotate([90,0,0]) translate([0,2*Wall_Thickness+distance,0]) side(depth,height);
      // Right
        color ("silver")
       rotate([270,0,0]) translate([0,-2*Wall_Thickness-height-distance,width+2*distance]) side(depth,height);
       // Back Face
       rotate([0,270,0]) translate([2*Wall_Thickness+distance,distance,-2*Wall_Thickness+distance]) face(height,width); 
       // Front Face
       rotate([0,270,180]) translate([2*Wall_Thickness+distance,-width-distance,depth-2*Wall_Thickness+distance+3*Wall_Thickness]) face(height,width);
       
       if (Lock_Type == 1){
           // Corners
           rotate([0,90,0]) translate([-2*Wall_Thickness,width+2*distance,-1-distance-Lock_Length-Wall_Thickness]) corner(Wall_Thickness);
           rotate([0,90,0]) translate([-2*Wall_Thickness-2*distance,width,0]) rotate([0,0,90]) translate([2*distance,height,-1-distance-Lock_Length-Wall_Thickness]) corner(Wall_Thickness); 
           rotate([0,90,0]) translate([-2*Wall_Thickness,width,0]) rotate([0,0,-90]) translate([width,0,-1-distance-Lock_Length-Wall_Thickness]) corner(Wall_Thickness); 
           rotate([0,90,0]) translate([-2*Wall_Thickness-2*distance,width,0]) rotate([0,0,180]) translate([height,width,-1-distance-Lock_Length-Wall_Thickness]) corner(Wall_Thickness);
           
           
            rotate([0,90,180]) translate([-2*Wall_Thickness,0,-depth-1-distance-Lock_Length-Wall_Thickness]) corner(Wall_Thickness);
           rotate([0,90,180]) translate([-2*Wall_Thickness,0,-depth]) rotate([0,0,90]) translate([0,height+2*distance,-1-distance-Lock_Length-Wall_Thickness]) corner(Wall_Thickness);
           rotate([0,90,180]) translate([-2*Wall_Thickness,0,-depth]) rotate([0,0,-90]) translate([width+2*distance,0,-1-distance-Lock_Length-Wall_Thickness]) corner(Wall_Thickness);
           rotate([0,90,180]) translate([-2*Wall_Thickness,0,-depth]) rotate([0,0,180]) translate([height+2*distance,width+2*distance,-1-distance-Lock_Length-Wall_Thickness]) corner(Wall_Thickness);
       }
       else{
           // Rings
           rotate([0,270,0]) translate([2*Wall_Thickness+distance,distance,-depth-distance-Lock_Length-Wall_Thickness-3*Wall_Thickness]) ring(height, width);
           rotate([0,270,180]) translate([2*Wall_Thickness+distance,-width-distance,-distance-Lock_Length-Wall_Thickness]) ring(height, width);
       }
    } 
}

view();
