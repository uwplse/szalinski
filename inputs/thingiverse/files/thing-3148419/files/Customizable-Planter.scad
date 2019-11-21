// Custom Planter
// Creator: Levi Oxner
// Created:October 10, 2018


/* [Part] */
Units="mm"; //[mm,inches]

Part="3";//[1:Planter,2:Plate,3:Joined Planter & Plate,4:Spaced Planter & Plate]

/* [Planter] */

//Shape (Only Smooth Circle is visible on the preview, check my uploaded STL files for examples of other shapes)
$fn=100; //[3:Triangle,4:Square,5:Pentagon,6:Hexagon,10:Rough "Circle",100:Smooth Circle]

// Base Diameter
B_Diameter=100; 

// Mouth Diameter
M_Diameter=50; 

// Planter Height
Height=100; 

//Thickness inward from outerdiameter (Keep less than ~1/2 the Diameters)
Thickness=5; 


/* [Drain Hole] */
//Do you want a drain hole?
Drain= "No"; //[Yes,No]

//Drain Hole Diameter
D_Diameter=5; 


/* [Plate] */
//How much larger the plate is from the base diameter (recommend greater than Plate Thickness)
Plate_Diameter_Difference=10;

//Plate Rim Depth
Plate_Depth=10; 

//Plate Thicness inward from outerdiameter
Plate_Thickness=5;

//Spaced Planter & Plate Gape (Mind if you're printing with or without supports)
Gape=2;



if (Part=="4"){
    if (Units=="mm"){
        Custom_Planter();
        translate([0,0,(Plate_Depth+Plate_Thickness)/2-Plate_Thickness-Gape])
            Plate();
    }if(Units=="inches"){
        scale([25.4,25.4,25.4])
            Custom_Planter();
        scale([25.4,25.4,25.4])
        translate([0,0,(Plate_Depth+Plate_Thickness)/2-Plate_Thickness-Gape])
            Plate();
    }
}else if(Part=="3"){
    if (Units=="mm"){
        Custom_Planter();
        translate([0,0,(Plate_Depth+Plate_Thickness)/2-Plate_Thickness])
            Plate();
    }if(Units=="inches"){
        scale([25.4,25.4,25.4])
            Custom_Planter();
        scale([25.4,25.4,25.4])
        translate([0,0,(Plate_Depth+Plate_Thickness)/2-Plate_Thickness])
            Plate();
    }
}else if(Part=="2"){
    if(Units=="mm"){
        Plate();
    }if(Units=="inches"){
        scale([25.4,25.4,25.4])
            Plate();
    }
}else{
    if(Units=="mm"){
        Custom_Planter();
    }if(Units=="inches"){
        scale([25.4,25.4,25.4])
            Custom_Planter();
    }
}


/////////////////////////////////Planter////////////////////////////////////////////

module Custom_Planter(){
    
    difference(){
        translate([0,0,Height/2])
            cylinder(h=Height,d1=B_Diameter,d2=M_Diameter,center=true);
        translate([0,0,Height/2+Thickness])
            cylinder(h=Height,d1=B_Diameter-2*Thickness,d2=M_Diameter-2*Thickness,center=true);
        
        //Drain
        if(Drain=="Yes"){
            translate([0,0,Thickness/2])
                cylinder(h=Thickness,d=D_Diameter,center=true);
        }//if drain
        
    }//difference
}//module planter


///////////////////////////////////Plate////////////////////////////////////////////

module Plate(){
    
    difference(){
            cylinder(h=Plate_Depth+Plate_Thickness,d=Plate_Diameter_Difference+B_Diameter,center=true);
        translate([0,0,Plate_Thickness])
            cylinder(h=Plate_Depth+Plate_Thickness,d=Plate_Diameter_Difference+B_Diameter-2*Plate_Thickness,center=true);
    }//difference
    
}//module plate