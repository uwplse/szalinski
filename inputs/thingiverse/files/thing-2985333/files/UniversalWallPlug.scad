$fn=100;	

//Size
Diameter = 6.1;
Length = 40;
HoleDiameter = 3.5;

//Tip
TipDiameter = 4;
TipHeight = 6;

//Colar
CollarDiameter = 9;
CollarHeight = 0.7;

//Ribs
RibNr = 4;
RibDiameter = 8;
RibHeight = 10;

//Sleeves
SleeveStart = Length / 4;
SleeveLength = Length / 2;
SleeveWidth = 1;

//Folding/Weakening Hole
FoldingHoleDiameter = 3.5;


difference(){

  union(){
    cylinder(d=Diameter,h=Length - TipHeight);
    
    //tip
    translate([0,0,Length - TipHeight]){
      cylinder(r1=Diameter/2,r2=TipDiameter/2,h=TipHeight);
    }
    
    //colar
    cylinder(d=CollarDiameter,h=CollarHeight);
    
    //ribs
    cylinder(r1=RibDiameter/2,r2=Diameter/2,h=RibHeight,$fn=RibNr);
   
  }

  translate([0,0,-1]){
    cylinder(d=HoleDiameter,h=Length);
  }
  
  translate([0,0,Length-2]){
   cylinder(d=HoleDiameter-((HoleDiameter/100) * 30),h=3);
  }
  
  //Sleeves
  translate([0-SleeveWidth/2,-Diameter,SleeveStart]){
    cube([SleeveWidth,Diameter*2,SleeveLength]);
  }
  
  //FoldingHole
   translate([0/2,Diameter,Length/2]){
      rotate([90,0,0]){
        cylinder(d=FoldingHoleDiameter,h=Diameter*2);
      }
   }
 
}
