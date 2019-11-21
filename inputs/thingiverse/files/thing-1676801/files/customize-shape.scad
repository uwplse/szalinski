CupHeight =100;
TwistDegree=90;
TheSlices=10;
FilletOutside=5;
FilletInside=10;
OutsideSides=4;
InsideSides=10;
OutsideRadius=20;
InsideRadius=5;
ButtomThinkness=0;


module outsideshell(){ 
    linear_extrude(height=CupHeight,twist=TwistDegree,slices=TheSlices){
      offset(r=FilletOutside){
      translate([0,0]) circle(OutsideRadius,$fn=OutsideSides);
      }
   }
   }
       
    module insideshell(){
    linear_extrude(height=CupHeight,twist=TwistDegree,slices=TheSlices){
          offset(r = FilletInside) {
      translate([0,0]) circle(InsideRadius,$fn=InsideSides);
      }
  }
  }
  
  
 difference(){   
     translate([0,0,0]){ outsideshell();}
     translate([0,0,ButtomThinkness]) {insideshell();}
 }
          