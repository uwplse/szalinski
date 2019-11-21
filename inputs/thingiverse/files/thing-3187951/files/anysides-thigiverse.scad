// number of sides
PieceSides = 5;

// side lenght
PieceSideSize = 20; 

// heigth
PieceHeight=3;

// keep room for WS2812 LED with board
LEDPlaceHolder=true;

//Level of details for cylinders 
cylinderDetail=90; 


// Connection tube: internal radius
tubeIn=1;  

// Connection tube: external radius
tubeOut=3;  




extMargin=0.1;
intMargin=0;

tubeLen=PieceSideSize/2-extMargin-intMargin;

ratio=1.02;

echo("Generating a LED holder", PieceSides, PieceSideSize,PieceHeight);

baseAngle=360/PieceSides;
surroundingCircleRayon= sqrt(pow((PieceSideSize/2),2)/(1-pow(cos(baseAngle/2),2)));

echo("Base angle: ", baseAngle);
echo("Circle: ", surroundingCircleRayon);


module BasePolyhedron() {
    cylinder(h=PieceHeight, d1=surroundingCircleRayon*2, d2=surroundingCircleRayon*2, center=false,$fn=PieceSides);
          
}

// volume to substract to BasePolyhedron for LED 
module LEDPlaceHolder() {
  ledsq=5;
  boardR=5;
  union () {
      
        linear_extrude(height= PieceHeight)
            square([ledsq, ledsq], center = true);
    //cylinder(h=PieceHeight, r=ledsq,center=false,$fn=4); 
    translate([0,0,1])  
    cylinder(h=PieceHeight, r=boardR,center=false,$fn=cylinderDetail); 
  }  
}



module Tube() { translate([0,0,extMargin]) cylinder(h=tubeLen, r=tubeOut,center=false,$fn=cylinderDetail);}
module TubeHole() {translate([0,0,extMargin]) cylinder(h=tubeLen, r=tubeIn,center=false,$fn=cylinderDetail); }


// ConnectionTubes to add to BasePolyhedron sides for assembly 
// placed on first half of side 
module ConnectionTube() { difference() { Tube(); TubeHole(); } }

// ConnectionTubesPlaceHolder to remove from BasePolyhedron sides to let room for ConnectionTube of other piece.
// placed on second half of side
module ConnectionTubePlaceHolder() { 
extTubeOutLen=PieceSideSize;  
extTubeOutR=tubeOut*ratio;  
extShift=PieceSideSize/2;
    union() {
        difference (){ 
            translate([0,0,extTubeOutLen/2])
        cylinder(h=extTubeOutLen/2, r=extTubeOutR,center=false,$fn=cylinderDetail);
        Tube();
    }
    TubeHole();}
}




//Place each ConnectionTube around BasePolyhedron
module AllConnectionTubes() {
  for (i = [0:PieceSides]) {
    translate([surroundingCircleRayon*cos(i*baseAngle), surroundingCircleRayon*sin(i*baseAngle),   PieceHeight]) rotate([90,   0,   (-0.5+i)*baseAngle])   
      ConnectionTube ();
  }  
}

//Place each ConnectionTubePlaceHolder around BasePolyhedron
module AllConnectionTubePlaceHolders(){
  for (i = [0:PieceSides]) {
    translate([surroundingCircleRayon*cos(i*baseAngle),   surroundingCircleRayon*sin(i*baseAngle),
   PieceHeight]) rotate([90,   0,   (-0.5+i)*baseAngle]) ConnectionTubePlaceHolder();
   }
}


//Place each edge spher holder around BasePolyhedron
module AllEdgesPlaceHolders() {
 union () {
    for (i = [0:PieceSides]) {      
      /*
        *///union() {
     // translate([(surroundingCircleRayon)*cos(i*baseAngle), (surroundingCircleRayon)*sin(i*baseAngle),   PieceHeight])          sphere (r=PieceHeight, $fn=cylinderDetail);
      translate([(surroundingCircleRayon)*cos(i*baseAngle), (surroundingCircleRayon)*sin(i*baseAngle),   PieceHeight])          sphere (r=PieceHeight, $fn=cylinderDetail);
    
            
            translate([(surroundingCircleRayon)*cos(i*baseAngle), (surroundingCircleRayon)*sin(i*baseAngle),   PieceHeight])          cylinder(h=PieceHeight, r=PieceHeight, center=false, $fn=cylinderDetail);
    }
  }
   
}

module Piece() {
    difference () { 
      union() {    
        difference(){ 
          BasePolyhedron();
          AllConnectionTubePlaceHolders(); 
if (LEDPlaceHolder)          LEDPlaceHolder();
        }
        AllConnectionTubes();  
      } 
      AllEdgesPlaceHolders(); 
     AllConnectionTubePlaceHolders(); 
      }
}
Piece();
