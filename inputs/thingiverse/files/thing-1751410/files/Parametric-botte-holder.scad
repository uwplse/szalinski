// Code written by "deckingman" Feb 2016
// Use and enjoy


// User Defined Variables
// Change any of the following to suit

// Bottle hole shape. round/square
Bottle_Shape="round"; // [round, square]

// The number of bottles along the x axis
Number_Of_Bottles_Long=4; 

// The number of bottles along the y axis
Number_Of_Bottles_Wide=6; 

// The inside diameter of the cylinders which hold the bottles.
// Measure your bottle then add a milimeter or 2 for clearance
Inside_Diameter=25.5; 

//Diameter of a push hole at the bottom of each cylinder
Push_Hole_Diameter=0;

// The overall height in mm. Note that the depth of the hole will be this number minus the base thickness 
Overall_Height=22;

// The base thickness in mm. For ease of printing, make this divisible by the layer height of you slicer/printer.
// So for example if the layer height is 0.3 mm use 1.8 or 2.1 but not 2.0.
Base_Thickness=1.8;  

// The wall thickness of the cylinders. Note that the cylinders are joined together by whatever this thickness is
// so DO NOT MAKE THIS ANY LESS THAN 2mm. For ease of printing, make this number divisible by your nozzle diameter.
Wall_Thickness=2.25;  

// Suggested Slicer settings. 3 solid top and bottom layers, 2 or 3 perimiters. 20% infill. 
// Using a 0.5mm nozzle with 0.3mm layer height. 


/* [Hidden] */
// Changing any of the following will likely screw things up !!
First_Bottle_Pos = Bottle_Shape == "square" ? 0 : (Inside_Diameter/2)+Wall_Thickness;
Step = Inside_Diameter+Wall_Thickness;
iMax=First_Bottle_Pos+(Number_Of_Bottles_Long*(Step-1));
jMax=First_Bottle_Pos+(Number_Of_Bottles_Wide*(Step-1)); 

$fn = 150;

for (i = [First_Bottle_Pos:Step:iMax]){
  for (j = [First_Bottle_Pos:Step:jMax]){   
    if(Bottle_Shape == "round"){
      difference(){
        translate ([i,j,0]) cylinder (d=Inside_Diameter+(2*Wall_Thickness),h=Overall_Height);
        translate ([i,j,Base_Thickness]) cylinder (d=Inside_Diameter, h=Overall_Height);
        if(Push_Hole_Diameter > 0)translate ([i,j,-0.1]) cylinder (d=Push_Hole_Diameter, h=Base_Thickness+0.2);
      }
    }
    if(Bottle_Shape == "square"){
      difference(){
        translate ([i,j,0]) cube ([Inside_Diameter+(2*Wall_Thickness),Inside_Diameter+(2*Wall_Thickness),Overall_Height]);
        translate ([i+Wall_Thickness,j+Wall_Thickness,Base_Thickness]) cube ([Inside_Diameter,Inside_Diameter,Overall_Height]);
        if(Push_Hole_Diameter > 0)translate ([i+(Inside_Diameter/2)+Wall_Thickness,j+(Inside_Diameter/2)+Wall_Thickness,-0.1]) cylinder (d=Push_Hole_Diameter, h=Base_Thickness+0.2);
      }
    }
  }
}