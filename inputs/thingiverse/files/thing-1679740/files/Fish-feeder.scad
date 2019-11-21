/* [Feeder] */

// Fish feeder diameter (recomended increment 10)
Diameter = 75; // 10

// Fish feeder height (recomended increment 1)
Height = 15; //1

// Fish feeder wall thickness (recomended increment 0.1)
WallThickness = 1; // 0.1

/* [Sifter] */

// Fish feeder sifter height (recomended increment 0.1)
SifterHeight = 0.25; // 0.1

// Fish feeder sifter hole diameter (recomended increment 1)
HoleDiameter = 4; // 1

// Fish feeder sifter hole space (recomended increment 0.1)
HoleSpace = 0.5; // 0.1


/* [Hidden] */

FN = 40;

//difference(convexity = 1, $fn=FN){
    union(convexity = 1, $fn=FN){    
        body(); 
        difference(convexity = 1,$fn=FN){
            sifter();    
            hole();
        }
    }
//    body(WallThickness);    
//}

// MODUE

module hole(){
    for (b =[HoleDiameter+HoleSpace:HoleDiameter+HoleSpace:Diameter]){
        for (a =[HoleDiameter+HoleSpace:HoleDiameter+HoleSpace:Diameter]){
            isSecond = b % ((HoleDiameter+HoleSpace)*2) == 0;
            
            if(isSecond){
               translate([-Diameter/2+b,-Diameter/2+a,(-Height/2)-SifterHeight])
                cylinder(Height,d=HoleDiameter,d=HoleDiameter,$fn=FN);
            }else{
                translate([-Diameter/2+b,-Diameter/2+a-HoleDiameter/2,(-Height/2)-SifterHeight])
                cylinder(Height,d=HoleDiameter,d=HoleDiameter,$fn=FN);
            }
        }
      
    }
}
   
 module body(){
  rotate_extrude(convexity = 1,$fn=FN)
    translate([Diameter/2, 0, 0])
    hull(convexity = 1,$fn=FN){
        square((Height/2) ,$fn=FN);
        translate([0, (Height), 0])
        circle(d = 1,$fn=FN);
    }
}  

module sifter(){
    cylinder(SifterHeight,d=Diameter,$fn=FN); 
}