
// Written by Remi Vansnickt <>
// licensed under the Creative Commons - Attribution - Non-Commercial license. 
// Modified by H.Sablotny makerheb@thingiverse hsy05112018
/* [Main] */

//( mm ) Width of the Nozzle
PrinterNozzleWidth=0.8; //[0.1:0.05:1]

//( mm ) Spool inner Width    [250gr~90 750gr~100 2.3kg~300]
//SpoolInnerWidth=90;    //[50:1:400]  //kaisertechStd
SpoolInnerWidth=80;    //[50:1:400] //anycubic

//( mm ) Spool outer Width    [250gr~140 750gr~200 2.3kg~380]
SpoolOuterWidth=198;    //[100:1:500]  //kaisertech Std, anycubic
//SpoolOuterWidth=150;    //[100:1:500]

//( mm ) Part Height           [250gr~37 750gr~45 2.3kg~90]
//PartHeight=55; //[2:0.1:150]  //kaisertechStd
PartHeight=48;                //anycubic

//( degree ) Part Radius Cover ( will be reduice by PartClearance )
PartRadiusCover=120;  //[1:1:360]

/* [Customize] */

//Number section
PartSection=3;  //[1:1:10]

//hsy05112018
//midSection-Position, divides PartSection horizontal
MidSection=1.18;   //[0:noMidSection, 1:2 ] position of Midsection

//(reason) Part asymetric recommand values 0 symetric other asymetric 1/PartSection is a good value
PartAsymetric=0; //[-0.1:0.1:1]

//handle type 
HandleType = 1; // [0:nothing, 1:handle, 2:hole]

//Add a label on Part 
PrintedLabel = 2; // [0:nothing! please, 1:label Positif, 2:label Negatif]

//text to display
PrintedLabelText = "Gewindemuttern"; 

//label-holder 
LabelHolder = 0; // [0:nothing, 1:yes! please]

//( mm ) Hole screw diameter
HoleScrew=4.05;  //[2:0.05:6]

/* [Advanced] */

//( mm ) Part's Outer space clearance (this parameter will rediuce Part Radius Cover)
PartClearance=1.5; //[0:0.1:4]

//Wall's number global determine Thickness PrinterNozzleWidth*WallLayerCount 0.4*3=1.2mm
WallLayerCount=3;  //[1:1:10]

//Wall's number section 0.4*3=1.2mm
SectionLayerCount=1.2;  //[1:1:5]

//(mm) BottomThickness 2mm
BottomThickness=0.8;  //[0.3:0.1:3]

//Wall's number Hole determine Thickness 0.4*3=1.2mm
HoleLayerCount=2;  //[1:1:5]

//Handle size
HandleSize = 1; // [2:0.5:5]

//( mm ) height of char ( this parameter is limited by PartHeight, you might increase the WallLayerCount if the char is very big )
PrintedLabelSize = 13; // [0:1:100] 

//( % ) Height label %of part height
LabelHolderHeight=50*1; ////[20:0.1:100]

//( % ) Height label %of part width
LabelHolderWidth=60*1; ////[20:0.1:80]

//( mm ) label-Holder's Clearance from part
LabelHolderClearance=0.8*1; ////[0.1:0.05:1.5]

//Wall's number label 0.4*2=0.8mm
LabelLayerCount=2*1;  //[1:1:5]

//( mm ) label-holder size
LabelHolderSize=3*1; ////[1:0.5:5]

//QualityMesh
QualityMesh=100;    //[50:1:200]


//begin

function asymetric(n) = n == 0 ? -90 : ((1+(n-1)*PartAsymetric))*PartRadius/(PartSection*((1+(PartSection-1)*PartAsymetric)+1)/2)+asymetric(n-1);

PartRadius=PartRadiusCover-asin((PartClearance)/(SpoolOuterWidth/2));

LabelRadius=LabelHolderWidth*PartRadius/100;
LabelStartRadius=((LabelHolderWidth-100)/2)*PartRadius/100;

wt=WallLayerCount*PrinterNozzleWidth+0.01;
st=SectionLayerCount*PrinterNozzleWidth+0.01;
gt=(HandleSize)*PrinterNozzleWidth+0.01;
ht=(HoleLayerCount)*PrinterNozzleWidth+0.01;
lt=(LabelLayerCount)*PrinterNozzleWidth+0.01;

module LetterBlock(chars, size=10) {
    wantedWidth=(PrintedLabelSize/2)/tan(acos(((PrintedLabelSize/2))/(SpoolOuterWidth/2)));
    
    minimalWidth= (wantedWidth<=(2*PrinterNozzleWidth)) ? 2*PrinterNozzleWidth : wantedWidth;
    LetterWidth= (wantedWidth>=(2*wt)) ? 2*wt-2*PrinterNozzleWidth : minimalWidth;
    
    wantedHeight= (size<=PartHeight) ? size : PartHeight;
   
    lettersIndex=len(chars)-1;
    step_angle=asin((wantedHeight)/(SpoolOuterWidth/2));
    
    
    
    if (lettersIndex>=0)
    for(i = [0 : lettersIndex]) {
        
    rotate([0,0,90+PartRadius/2+(i-lettersIndex/2) * step_angle])    
            translate([0,-(SpoolOuterWidth/2-LetterWidth/2),PartHeight/2])
                rotate([90,0,0])
                    linear_extrude(height=LetterWidth, convexity=5)
                text(chars[i], 
                     size=wantedHeight,
                     font="Bitstream Vera Sans",
                     halign="center",
                     valign="center");
    } 
}


module tiroir(){
    
color("blue")
    rotate_extrude (angle=PartRadius,convexity=10,$fn=10*QualityMesh)
        translate([SpoolOuterWidth/2-wt, 0])
            square([wt,PartHeight]);
color("blue")
    rotate_extrude(angle=+PartRadius,convexity=10,$fn=5*QualityMesh)
        translate([SpoolInnerWidth/2, 0])
            square([wt,PartHeight]);
    
//hsy05112018
    if (MidSection>0) {
        color("blue")
            rotate_extrude(angle=+PartRadius,convexity=10,$fn=5*            QualityMesh)
            translate([(SpoolOuterWidth-SpoolInnerWidth)/2*MidSection,            0])
            square([wt,PartHeight]);    
    }
            
color("green")
    rotate_extrude(angle=PartRadius,convexity=10,$fn=5*QualityMesh)
        translate([SpoolInnerWidth/2, 0])
            square([SpoolOuterWidth/2-SpoolInnerWidth/2,BottomThickness]);

}

module handleG (){
color("yellow") 
    rotate([0,0,PartRadius-90])
        translate([0, SpoolOuterWidth/2-wt])
            union(){
                cube([4*gt,8*gt,PartHeight]);
                translate([2*gt, 8*gt]) cylinder (h = PartHeight, r=2*gt,  $fn=QualityMesh);
            }
    }
module handleH (){
teta=PartRadius-90-asin((gt*15+2*wt)/(SpoolOuterWidth/2));

color("yellow") 
     rotate([0,0,teta])
        translate([0, SpoolOuterWidth/2+2*wt,PartHeight])
            rotate([-270,0,0])
                cylinder (h = +10*wt, r=gt*10,  $fn=QualityMesh);
    }

module sections (){
color("black")
    translate([SpoolInnerWidth/2, 0])
        cube([SpoolOuterWidth/2-SpoolInnerWidth/2,wt,PartHeight]);
color("black")
    rotate([0,0,PartRadius-90])
        translate([0, SpoolInnerWidth/2])
            cube([wt,SpoolOuterWidth/2-SpoolInnerWidth/2,PartHeight]); 

color("black")
    for (i = [ 1 : 1 : PartSection-1 ])
        rotate([0,0,asymetric(i)+asin((st/2)/(SpoolOuterWidth/2))])
            translate([0, SpoolInnerWidth/2])
                cube([st,SpoolOuterWidth/2-SpoolInnerWidth/2,PartHeight]);
    }
    
module percageNegatif (){
    rHole=HoleScrew/2+ht;
    teta=90-acos((rHole+wt)/(SpoolOuterWidth/2));
    distancex=SpoolOuterWidth/2-(rHole+wt);
    
    color("purple")
        rotate([0,0,teta])
            translate([ distancex,0,-1]) 
                    cylinder (h = PartHeight+2, r=HoleScrew/2,  $fn=QualityMesh);
    }
    
module percagePositif (){
    rHole=HoleScrew/2+ht;
    teta=90-acos((rHole+wt)/(SpoolOuterWidth/2));
    distancex=SpoolOuterWidth/2-(rHole+wt);
    
    color("red")
        rotate([0,0,teta])
            translate([ distancex,0]) 
                union(){
                    cylinder (h = PartHeight, r=rHole,  $fn=QualityMesh/2);
                    translate([0,-rHole,0]) cube ([rHole,rHole,PartHeight]);
                }
    }
    
module percageAngle (){
    rHole=HoleScrew/2+ht;
    teta=90-acos((rHole+wt)/(SpoolOuterWidth/2-(rHole+wt)));
    distancex=SpoolOuterWidth/2-(rHole+wt);
    
    difference(){
        color("brown")
            translate([distancex, -wt,-1])
                cube([rHole+2*wt,rHole+2*wt,PartHeight+2]);
        color("purple")
            rotate([0,0,teta])
                translate([ distancex,0,-2]) 
                        cylinder (h = PartHeight+4, r=rHole+wt,  $fn=QualityMesh);
    }  
}

module labelPlace(){
    tetaS=asin((lt)/((SpoolOuterWidth)/2));
    tetaB=asin((LabelHolderSize+lt)/((SpoolOuterWidth)/2));
    
    color("gray")
        rotate([0,0,-LabelStartRadius])
            rotate_extrude(angle=LabelRadius,convexity=10,$fn=QualityMesh)
                translate([SpoolOuterWidth/2, 0])
                    square([LabelHolderClearance+lt,BottomThickness]);
    color("white")
        rotate([0,0,-LabelStartRadius])
            rotate_extrude(angle=LabelRadius,convexity=10,$fn=QualityMesh*LabelHolderWidth/10)
                translate([SpoolOuterWidth/2+LabelHolderClearance, 0])
                    square([lt,BottomThickness+LabelHolderSize]);
        
    color("black")
        rotate([0,0,-LabelStartRadius])
            rotate_extrude(angle=tetaB,convexity=10,$fn=QualityMesh/2)
                translate([SpoolOuterWidth/2+LabelHolderClearance, 0])
                    square([lt,PartHeight*LabelHolderHeight/100]);
    color("black")
        rotate([0,0,-LabelStartRadius+LabelRadius-asin((LabelHolderSize+lt)/((SpoolOuterWidth+LabelHolderSize+lt)/2))])
            rotate_extrude(angle=tetaB,convexity=10,$fn=QualityMesh/2)
                translate([SpoolOuterWidth/2+LabelHolderClearance, 0])
                    square([lt,PartHeight*LabelHolderHeight/100]);
        
    color("red")
        rotate([0,0,-LabelStartRadius])
            rotate_extrude(angle=tetaS,convexity=10)
                translate([SpoolOuterWidth/2, 0])
                    square([lt+LabelHolderClearance,PartHeight*LabelHolderHeight/100]);
    color("red")
        rotate([0,0,+(LabelRadius)-LabelStartRadius-asin((lt)/(SpoolOuterWidth/2))])
            rotate_extrude(angle=tetaS,convexity=10)
                translate([SpoolOuterWidth/2, 0])
                    square([lt+LabelHolderClearance,PartHeight*LabelHolderHeight/100]);
 }
 

module mask (Start,Part){
if (Part<=180)
    union(){
    color("blue") 
        rotate([0,0,Start+90])   
            translate([-SpoolOuterWidth,-SpoolOuterWidth/2-2,-2])
                cube ([SpoolOuterWidth,2*SpoolOuterWidth,PartHeight+4]);
    color("black") 
        rotate([0,0,Start+90+Part])   
                translate([0,-SpoolOuterWidth/2-2,-2])
                    cube ([SpoolOuterWidth,2*SpoolOuterWidth,PartHeight+4]);
    }
    
 if (Part>180) 
  difference(){
      translate([0,0,-1])   cylinder (h = PartHeight+2, r=SpoolOuterWidth/2+1,$fn=QualityMesh);
      mask(Start+Part,360-Part);
      }   
      
}

//output
module output(){
rotate([0,0,-80])
union(){
    difference(){
        difference(){
                union(){
                    tiroir();
                    sections();
                    percagePositif();
                    if (HandleType==1) handleG();
                    if (PrintedLabel==1) LetterBlock(PrintedLabelText,PrintedLabelSize);
                    if (LabelHolder==1)labelPlace();//no mask for label doesn't work online
                  } 
                union(){
                    if (PartRadius<=180) percageAngle();
                    if (HandleType==2) handleH();
                    if (PrintedLabel==2) LetterBlock(PrintedLabelText,PrintedLabelSize); 
                    }
              }
       union(){
           percageNegatif();
           mask(0,PartRadius);// only for online use can be remove for performance
       }
     }
 }
 }
 output();
