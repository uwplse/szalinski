// Stepper Motor Heatsink by Gregory L Holloway.
// @greg_the_maker
// 2019 - CC-BY-SA | https://creativecommons.org/licenses/by-sa/4.0/
// All measurements are in mm.
// https://www.thingiverse.com/thing:3663009

/* [Global] */

// mm
Motor_Body_Width = 42;

// mm
Motor_Body_Length = 38;

// mm
Housing_Thickness = 3;

Fins_On_Side_1 = 1; // [1:Yes,0:No]

Fins_On_Side_2 = 1; // [1:Yes,0:No]

Fins_On_Side_3 = 1; // [1:Yes,0:No]

Fins_On_Side_4 = 1; // [1:Yes,0:No]

Number_Of_Fins_Per_Side = 6;

// mm
Fin_Thickness = 3;

// mm
Fin_Length = 10;

// Cut-Out the Motor Cable Socket or cables.
Cable_Gap = 1; // [1:Yes,0:No]

// mm
Cable_Width = 18;

// mm
Cable_Height = 12;

// mm
Body_Undersize = 0.125;

/* [Hidden] */

heatsink (Motor_Body_Width,Motor_Body_Length,Fins_On_Side_1,Fins_On_Side_2,Fins_On_Side_3,Fins_On_Side_4,Cable_Gap,Number_Of_Fins_Per_Side,Housing_Thickness,Fin_Thickness,Fin_Length,Cable_Width,Cable_Height,Body_Undersize);

module heatsink (Fin_Spacing)
{
    // resolution
    $fn = 100; // Does not effect the STL
    
    // Calculations
    Fin_Spacing = (Motor_Body_Width/(Number_Of_Fins_Per_Side-1))-(Fin_Thickness/(Number_Of_Fins_Per_Side-1));

    // start objects
    
    // housing
    difference(){
              
        union(){
            minkowski(){
            translate([0,0,Motor_Body_Length/2])
            cube([Motor_Body_Width,Motor_Body_Width,Motor_Body_Length],true);
            cylinder(r=Housing_Thickness,h=Motor_Body_Length);
            }
        //fins side 1
        if (Fins_On_Side_1==1){
        for(Fins = [0:Number_Of_Fins_Per_Side-1]){     
            translate ([(Fin_Spacing*Fins)-(Motor_Body_Width/2),Motor_Body_Width/2+Housing_Thickness,0])
            cube([Fin_Thickness,Fin_Length,Motor_Body_Length], false);    
            }
        }

        //fins side 2
        if (Fins_On_Side_2==1){
        for(Fins = [0:Number_Of_Fins_Per_Side-1]){     
            translate ([Motor_Body_Width/2+Housing_Thickness,(Fin_Spacing*Fins)-(Motor_Body_Width/2),0])
            cube([Fin_Length,Fin_Thickness,Motor_Body_Length], false);    
            }
        }

        //fins side 3
        if (Fins_On_Side_3==1){
        for(Fins = [0:Number_Of_Fins_Per_Side-1]){
            translate ([(Fin_Spacing*Fins)-(Motor_Body_Width/2),-Motor_Body_Width/2-Housing_Thickness-Fin_Length,0])
            cube([Fin_Thickness,Fin_Length,Motor_Body_Length], false);    
            }   
        }
    
        //fins side 4
        if (Fins_On_Side_4==1){
        for(Fins = [0:Number_Of_Fins_Per_Side-1]){     
            translate ([-Motor_Body_Width/2-Housing_Thickness-Fin_Length,(Fin_Spacing*Fins)-(Motor_Body_Width/2),0])
            cube([Fin_Length,Fin_Thickness,Motor_Body_Length], false);    
            }   
        }
    }
    
    translate([0,0,Motor_Body_Length/2])
    cube([Motor_Body_Width-(Body_Undersize*2),Motor_Body_Width-(Body_Undersize*2),Motor_Body_Length+4],true);
    
    // Cable Cutout
    if (Cable_Gap==1){
        translate([0,Motor_Body_Width/2+Housing_Thickness/2,Motor_Body_Length-Cable_Height/2])
        cube([Cable_Width,Cable_Height*4,Cable_Height+0.5], true);
    }
    
    //dirty hax.
    translate([0,0,(Motor_Body_Length*1.5+2.5)])
    cube([Motor_Body_Width+15,Motor_Body_Width+15,Motor_Body_Length+5],true);
    }
}