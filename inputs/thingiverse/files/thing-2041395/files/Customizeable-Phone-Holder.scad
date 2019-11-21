echo(version=version());
/* 
Customizable Phone Holder
Created by: Zeakfury
Created date: 01/16/2017
*/

// Include Boxes library to get easy rounded boxes
include <MCAD/boxes.scad>  

//Viewer
rotate([0,0,180])
render()
Item_Holder();

//Setup Variables

/* [Item Dimensions] */
//- Item's Width (X-Axis)
pWidth = 83.5;

//- Item's Thickness (Y-Axis)
pThick = 11;

//- Mount/Holder Height (Z-Axis)
HHolder = 40;

//- Thickness of the walls for the Mount
WallThick = 3;// 

/* [Supports] */
//- Height of Horizontal Front Lip
HLip = 10;// 

//- Width of Vertical Front Lip
WLip = 20;// 

//- Front Hole on Lip (0=No 1=Yes)
FHole = 1;// [1:Yes,0:No]

//- Front Hole Lip Length
FWidth = 5;// 

/* [Bottom Hole] */
//- Bottom Hole for charger/speakers (0=No 1=Yes)
BHole = 1;// [1:Yes,0:No]

//- Width for Rim of Hole to Hold Item
BWidth = 2;

//- Thick for Rim of Hole to Hold Item
BThick = 2;




//Create Body
module Item_Holder() {
    //rotate([pTilt*-1,0,0]){
        difference(){
            //Main Shape
            union(){
                roundedBox([pWidth+WallThick*2,pThick+WallThick*2,HHolder+WallThick], 2, true, $fn=40);
                
            }
            //Remove Parts
            union(){
                //Phone Hole
                translate([0,0,WallThick]) 
                    color("green")
                cube([pWidth,pThick,HHolder+WallThick], true);
                //Lip Height
                translate([-(pWidth-WLip)/2,pThick/2,WallThick/2-(HHolder/2-HLip)]) 
                    color("blue")
                cube([pWidth-WLip,WallThick,HHolder-HLip], false);
                //Lip Hole
                if (FHole == 1 && BHole == 1 && BThick <= pThick){
                    translate([-(pWidth-FWidth*2-WLip)/2,(pThick/2-BThick),-(HHolder+WallThick)/2]) 
                        color("pink")
                    cube([pWidth-(FWidth*2)-WLip,WallThick+(BThick),HLip+WallThick],false);
                    }else if (FHole == 1 && (BHole == 0 || BThick > pThick)){
                    translate([-(pWidth-FWidth*2-WLip)/2,(pThick/2),-(HHolder+WallThick)/2]) 
                        color("pink")
                    cube([pWidth-(FWidth*2)-WLip,WallThick,HLip+WallThick],false);}                    
                //Bottom Hole
                if (BHole == 1 && BWidth < pWidth && BThick < pThick) {
                    translate([-(pWidth-(BWidth*2))/2,-(pThick-(BThick*2))/2,-(HHolder+WallThick)/2]) 
                        color("red")
                    cube([pWidth-(BWidth*2),pThick-(BThick*2),WallThick],false);}

            }  
         }
             
        //}
}
