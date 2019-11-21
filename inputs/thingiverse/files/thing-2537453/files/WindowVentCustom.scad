//**************************************//
// Window Vent
// Created By Erik McClain - 09/10/2017
//**************************************//

//**************************************//
// Variables
//**************************************//b

//**************************************//
//--Work Piece Options--//      //1 = Yes, 0 = No

//Is this a vent
IsVent = "yes"; // [yes,no]

//Is there attchment pegs
IsPeg = "yes"; // [yes,no]

//Is there attchment holes
IsHole = "yes"; // [yes,no]                     

//Is there a seal ridge
IsSealR = "yes"; // [yes,no]                  

//Is there a seal slot
IsSealS = "yes"; // [yes,no]

//Is the a clamp Bottom Offset 1 yes, 0 no
IsClampBO = 1; // [1,0]                  

//**************************************//
//Work Piece Vars
WorkH = 200;                    //Hight Of Work Piece
WorkW = 185;                    //Width Of Work Piece
WindowW = 39;                   //Window Width

  
//**************************************//
//Clamp Vars
ClampT = 6;                     //Thickness Of Wall
ClampCWO = 0;                   //Cavity Width Offset
ClampSL = 25 ;                  //Clamp Side Length
ClampBO = 5 ;                   //Clamp Bottom Offset


//**************************************//
//Wall Vars
WallT = 10;                     //Thickness Of Wall

  
//**************************************//
//End Vars
EndT = 6;                       //Thickness Of end
EndCWO = -0.5;                     //Cavity Width Offset
  
  
//**************************************//
//Vent Vars
VentT = 5;                      //Thickness Of end
VentOD = 97;                    //Vent Outer Diameter
VentL = 120;                    //Vent Length
VentXO = 15;                    //Vent X (Length) Offset
VentYO = 60;                    //Vent Y Offset
VentZO = 50;                    //Vent Z Offset
  
 
//**************************************// 
//Peg
PegLR = 5.85;                   //Peg Latch Radius
PegSR = 5;                      //Peg Stem Radius
PegL = 12;                      //Peg Length
PegSW = 3.5;                    //Peg Slot Width
PegSD = 1;                      //Peg Slot Depth
PegNC = 0.1;                    //Peg Neck Clearance   
PegBC = 0.2;                    //Peg Ball Clearnace
PegSC = 0.5;                    //Peg Shaft Clearnace


//**************************************// 
//Seal
SealW = 2;                      //Seal Width
SealH = 4;                      //Seal Height
SealHG = .15;                   //Gap Space Around Seal 

      
//**************************************//
// Calculations
//**************************************//
  
  //Clamp Section
  ClampH = WorkH;               //Heigh of Work Pice
  ClampWI = WindowW +ClampCWO;  //Cavity Inner Width
  ClampWO = ClampWI+(2*ClampT); //Cavity Outer Width

  //Wall Section
  WallHO = (ClampWO - WallT)/2;    //Wall Horzontal Offset
  WallW = (WorkW - EndT - ClampT + (ClampT*IsClampBO)); //Wall Width

  
  //End Section
  EndW = WindowW + EndCWO;     //Cavity Inner Width
  
  
  
  
  
//**************************************//   
//Window Block
//**************************************//
union() {   
  //**************************************//
  //Clamp 
  difference() {
    translate([0, WorkW - ClampT, 0])
      cube([ClampWI + (2*ClampT), ClampSL, ClampH]);
    translate([ClampT, WorkW + ClampT - ClampT, -1])
      cube([ClampWI, ClampSL, ClampH+2]);
    
    //Is there a Clamp Bottom Offset?
    if ( IsClampBO == 1 )
    {
      translate([-1, WorkW - ClampT-1, -1])
        cube([ClampWI + (2*ClampT)+2, ClampSL+2, ClampBO+1]);
    }
    
    //Is There a Seal Slot?
    if ( IsSealS == "yes" )
    {
      //Clamp
      CClampS(ClampT/2 - SealW/2, WorkW - ClampT + (ClampT - SealW)/2, -.2);
      
      //Wall Seal
      color( "blue", 1.0 ) {
        translate([WallHO + WallT/2 - SealW/2 - SealHG, -.2, -.2])
          cube([SealW +  SealHG*2, (WorkW - EndT - ClampT + EndT + ClampT/2), SealH  +  SealHG + .2]);    
      }    
      
    }         
  } 


  //**************************************//
  //End
  difference(){
    translate([ClampT - EndCWO/2, 0, 0])
      cube([EndW, EndT, WorkH]);
  
    //Is There a Seal Slot?
    if ( IsSealS == "yes" )
    { 
      //Wall Seal
      color( "blue", 1.0 ) {
        translate([WallHO + WallT/2 - SealW/2 - SealHG, -.2, -.2])
          cube([SealW +  SealHG*2, (WorkW - EndT - ClampT + EndT + ClampT/2), SealH  +  SealHG + .2]);    
      }      
    }
  }

  //**************************************//
  //Wall
  //**************************************//
  //Create Wall
  CWall(0, 0, 0); 

  //Are there Pegs?
  if ( IsPeg == "yes" )
  {
    //Peg
    CPeg((ClampWI + (2*ClampT))/2, (WorkW - ClampT - PegLR), WorkH);
    CPeg((ClampWI + (2*ClampT))/2, (EndT + PegLR), WorkH);
  } 

  //Is there a Seal Ridge?
  if ( IsSealR == "yes" )
  {  
    //Create Clamp Seal
    CClampR(ClampT/2 - SealW/2, WorkW - ClampT + (ClampT - SealW)/2, WorkH);  

    //Wall Seal
    color( "red", 1.0 ) {
      translate([WallHO + WallT/2 - SealW/2, 0, WorkH])
        cube([SealW, (WorkW - EndT - ClampT + EndT + ClampT/2), SealH]);    
    }
  }
  
} //End Union


 
  




//**************************************//
//Modules
//**************************************//

//**************************************//
//Create Wall
module CWall(XOff, YOff, ZOff){  
  if ( IsVent == "no" )
  {
    difference() {
        //Wall No Vent
    translate([WallHO, EndT, 0])
      cube([WallT, WallW, WorkH]);
      
      //Are there Attachment Holes?
      if ( IsHole == "yes" )
      {
        //Bottom Peg Holes
        HPeg((ClampWI + (2*ClampT))/2, (WorkW - ClampT - PegLR), -.2);
        HPeg((ClampWI + (2*ClampT))/2, (EndT + PegLR), -.2);
      } 
 
      //Is There a Seal Slot?
      if ( IsSealS == "yes" )
      { 
        //Wall Seal
        color( "blue", 1.0 ) {
          translate([WallHO + WallT/2 - SealW/2 - SealHG, -.2, -.2])
            cube([SealW +  SealHG*2, (WallW + EndT + ClampT/2), SealH  +  SealHG + .2]);    
        }      
      }  
    }  
  }  
  else
  {
    
    //**************************************//
    //Wall With Vent
    difference() {
      union(){         
        translate([WallHO, EndT, 0])
          cube([WallT, WallW, WorkH]);        
        
        //translate([(ClampWI + (2*ClampT))/2 + VentXO,((WorkW - EndT - ClampT)/2) + EndT, WorkH/2])
        translate([(ClampWI + (2*ClampT))/2 + VentXO,VentYO + VentOD/2, VentZO + VentOD/2])
          rotate([0, 90, 0])
            cylinder(VentL, d = VentOD, center=true, $fn=100) ; 
      } 
      //translate([(ClampWI + (2*ClampT))/2 + VentXO,((WorkW - EndT - ClampT)/2) + EndT, WorkH/2])
      translate([(ClampWI + (2*ClampT))/2 + VentXO,VentYO + VentOD/2, VentZO + VentOD/2])
        rotate([0, 90, 0])
          cylinder(VentL+ 2, d = (VentOD - VentT*2), center=true, $fn=100) ; 

      //Are there Attachment Holes?
      if ( IsHole == "yes" )
      {
        //Bottom Peg Holes
        HPeg((ClampWI + (2*ClampT))/2, (WorkW - ClampT - PegLR), -.2);
        HPeg((ClampWI + (2*ClampT))/2, (EndT + PegLR), -.2);
      } 
 
      //Is There a Seal Slot?
      if ( IsSealS == "yes" )
      { 
        //Wall Seal
        color( "blue", 1.0 ) {
          translate([WallHO + WallT/2 - SealW/2 - SealHG, -.2, -.2])
            cube([SealW +  SealHG*2, (WallW + EndT + ClampT/2), SealH  +  SealHG + .2]);    
        }  
      }
      
      
    }
  }
}


//**************************************//
//Create Peg
module CPeg(XOff, YOff, ZOff){ 
  translate([XOff, YOff, ZOff])
    difference(){ 
      union() { 
        difference() {
          translate([0, 0, PegL])
            sphere(PegLR, $fa=5, $fs=0.1);
          translate([ -PegLR - 1, -PegLR - 1, 0])
           cube([PegLR*2 + 2, PegLR*2 + 2, PegLR*2]);           
        }    
        
        //Make Printable
        translate([0, 0, PegLR*2 -(PegLR-PegSR)])
          cylinder(PegLR-PegSR, r1=PegSR, r2=PegLR, center=false, $fn=100);  
        
        cylinder(PegL, d = PegSR*2, center=false, $fn=100) ;  
      }
      
      //Right Side
      translate([2.5, -PegLR - 1, -1])
       cube([PegL+PegLR, PegLR*2 + 2, PegL+PegLR+2]);
     
      //Left Side
      translate([-2.5 - PegLR*2, -PegLR - 1, -1])
       cube([PegLR*2, PegLR*2 + 2, PegL+PegLR+2]); 
     
      //Slot
      translate([-PegLR, -PegSW/2, PegL/2-PegSD])
       cube([PegLR*3, PegSW , PegL*2]);  
      
      //Slot Bottom
      translate([0, 0, PegL/2-PegSD])
        rotate([0, 90, 0])
          cylinder(PegLR, d = PegSW, center=true, $fn=100);  
   }
} 


//**************************************//
//Create Peg Hole
module HPeg(XOff, YOff, ZOff){ 
  translate([XOff, YOff, ZOff])

    difference(){ 
      union() { 
        difference() {
          translate([0, 0, PegL + PegBC/2])
            sphere(PegLR+PegBC, $fa=5, $fs=0.1);
          translate([ -PegLR - 1, -PegLR - 1, 0])
           cube([PegLR*2 + 2, PegLR*2 + 2, PegLR*2 - PegNC]);           
        }        
        //Make Printable
        translate([0, 0, PegLR*2 -(PegLR-PegSR) - PegBC/2])
          cylinder(PegLR-PegSR, r1=PegSR+PegSC/2, r2=PegLR+PegBC, center=false, $fn=100);  

        cylinder(PegL, d = (PegSR*2 + PegSC), center=false, $fn=100) ;
        
        //Create Lead In
        cylinder(PegL, r1=PegSR+1.5, r2=0, center=false, $fn=100);  
       
        //Create Bottom Cut Away
        translate([0, 0, -.2])
          cylinder(.2, r1=PegSR+1.5, r2=PegSR+1.5, center=false, $fn=100);  
      }
      
      //Right Side
      translate([2.5 + PegSC/2, -PegLR - 1, -1])
       cube([PegL+PegLR, PegLR*2 + 2, PegL+PegLR+2]);
     
      //Left Side
      translate([-2.5 - PegLR*2 - PegSC/2, -PegLR - 1, -1])
       cube([PegLR*2, PegLR*2 + 2, PegL+PegLR+2]);   
    }
  
} 


//**************************************//
//Create Seal Ridge on Clamp
module CClampR(XOff, YOff, ZOff){ 
  ClampX = ClampWI + ClampT + SealW ;
  ClampY = ClampSL - (ClampT - SealW)/2;
  ClampZ = SealH;
color( "red", 1.0 ) {
  translate([XOff, YOff, ZOff])  
    difference() {
        cube([ClampX, ClampY, ClampZ]);
      
        translate([SealW, SealW, -1])
          cube([ClampX - SealW*2, ClampY, ClampZ + 2]);      
    } 
}  
}
//**************************************//
//Create Slot on Clamp
module CClampS(XOff, YOff, ZOff){ 
  ClampX = ClampWI + ClampT + SealW;
  ClampY = ClampSL - (ClampT - SealW)/2;
  ClampZ = SealH;

color( "blue", 1.0 ) { 
  translate([XOff - SealHG, YOff - SealHG, ZOff])  
    difference() {
        cube([ClampX + SealHG*2, ClampY + SealHG*2, ClampZ + SealHG + .2]);
      
        translate([SealW + SealHG*2, SealW + SealHG*2, -1])
          cube([ClampX - SealW*2 - SealHG*2, ClampY, ClampZ + SealHG + 2 + .2]);      
    } 
}  
}

