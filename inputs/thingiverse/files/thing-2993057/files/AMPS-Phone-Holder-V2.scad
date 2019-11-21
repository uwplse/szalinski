echo(version=version());
/* 
Customizable Phone Holder
Created by: Zeakfury
Created date: 01/16/2017

ReMixed by JimDod on 5-July-2018, 19-Oct-2019
Added more rounded edges, AMPS mountung holes, and other holes.
Not perfect but should be easy to do other changes
ReMixed by JimDod again on 19-Oct-2019
added corner rounding where inside roundings (diff'ed fillets) meet.
also screw holes are now sized for M3
*/

// Include Boxes library to get easy rounded boxes
include <MCAD/boxes.scad>


//Viewer
rotate([0,0,180])
render()
Item_Holder();

// test routines
//drill_hole(location=hole_distance_from_bottom, spacing=0, size=ScrewHoleSize);
//translate ([(DeviceWidth/2),DeviceThickness/2,LipHorizWidth]) rotate([0,0,-90])fillet(2,HolderHeight);
//Setup Variables

/* [Item Dimensions] */
//- Item's Width (X-Axis)
DeviceWidth = 78.8;

//- Item's Thickness (Y-Axis)
DeviceThickness = 12.3;

//- Mount/Holder Height (Z-Axis)
HolderHeight = 72;

//- Thickness of the walls for the Mount
WallThick = 3.5;// 
EdgeRadius=2;
/* [Supports] */
//- Height of Horizontal Front Lip
LipHorizWidth = 5; 

//- Width of Vertical Front Lip
LipVertWidth = 10;// 

//- Front Hole on Lip (0=No 1=Yes)
FrontHole = 0;// [1:Yes,0:No]

// add cooling slots 
CoolingSlots = 0;

// mounting holes
ScrewHoleSize = 2.9;  // M3 screws
ScrewHeadSize = 6.2;

// holes for AMPS mount
AMPSHorizontal = 1;  // 4 holes 38mmx30mm pattern
AMPSVertical = 0;  // 4 holes 30mmx38mm pattern
AMPSHeight = 30; // note that these are independetn of horizontal/vertical
AMPSWidth = 38; // note that these are independetn of horizontal/vertical

AMPSHorizontalMountHolesFromBottom = (HolderHeight+WallThick-AMPSHeight)/2; // midway up
AMPSVerticalMountHolesFromBottom = (HolderHeight+WallThick-AMPSWidth)/2; // midway up
AMPSVerticalMountHolesFromLeft = (DeviceWidth/2)-(AMPSHeight/2); // this centers the mount
AMPSHorizontalMountHolesFromLeft = (DeviceWidth/2)-(AMPSWidth/2); //-12; // this centers the mount

CenterHoles = 0; // inline centered two holes 52mm
CenterHoleHeight = 50.8;  // two inches
CenterMountHolesFromBottom = (HolderHeight+WallThick-CenterHoleHeight)/2; // midway up
CenterMountHolesFromLeft = (DeviceWidth/2); // this centers the mount

// customized phone holes (this is for a BLU phone)
SpecialPhoneHoles = 1;
//BottomRoundLocation = (DeviceWidth/2)-(DeviceThickness/2)-11; // left right
BottomRoundLocation = ((DeviceWidth+WallThick)/2)-(30+11);
; // left right
BottomRoundwidth = 18; 
BoxOnBackXLocation = 0; //-(DeviceThickness+WallThick)/2; // left right
BoxOnBackZLocation = -(AMPSHeight/2); // up down

SpecialPhoneHoles2 = 1;
//BottomRoundLocation = (DeviceWidth/2)-(DeviceThickness/2)-11; // left right
BottomRoundLocation2 = ((DeviceWidth+WallThick)/2)-(63);
; // left right
BottomRoundwidth2 = 19; 
BoxOnBackXLocation2 = 0; //-(DeviceThickness+WallThick)/2; // left right
BoxOnBackZLocation2 = -(AMPSHeight/2); // up down

SpecialPhoneHoles3 = 1;
//BottomRoundLocation = (DeviceWidth/2)-(DeviceThickness/2)-11; // left right
BottomRoundLocation3 = ((DeviceWidth+WallThick)/2)-(19);
; // left right
BottomRoundwidth3 = 19; 
BoxOnBackXLocation3 = 0; //-(DeviceThickness+WallThick)/2; // left right
BoxOnBackZLocation3 = -(AMPSHeight/2); // up down

//- Front Hole Lip Length
FWidth = 0;// 

/* [Bottom Hole] */
//- Bottom Hole for charger/speakers (0=No 1=Yes)
BHole = 0;// [1:Yes,0:No]

//- Width for Rim of Hole to Hold Item
BWidth = 6;

//- Thick for Rim of Hole to Hold Item
BThick = 3;


//Create Body
module Item_Holder() {
    //rotate([pTilt*-1,0,0]){
    difference(){
        difference(){
            //Main Shape
            union(){
                roundedBox([DeviceWidth+WallThick*2,
                DeviceThickness+WallThick*2,
                HolderHeight+WallThick], EdgeRadius, false, $fn=40);               
            }
            //Remove Parts
            union(){
                //Phone Hole
                translate([0,0,WallThick]) 
                    color("green")
                cube([DeviceWidth,DeviceThickness,HolderHeight+WallThick], true);
                //Lip Height
                translate([-(DeviceWidth-LipVertWidth)/2,DeviceThickness/2,
                WallThick/2-(HolderHeight/2-LipHorizWidth)]) 
                    color("blue")
                cube([DeviceWidth-LipVertWidth,WallThick,HolderHeight-LipHorizWidth], false);
                //Lip Hole
                if (FrontHole == 1 && BHole == 1 && BThick <= DeviceThickness){
                    translate([-(DeviceWidth-FWidth*2-LipVertWidth)/2,
                    (DeviceThickness/2-BThick),-(HolderHeight+WallThick)/2]) 
                        color("pink")
                    cube([DeviceWidth-(FWidth*2)-LipVertWidth,WallThick+(BThick),
                    LipHorizWidth+WallThick],false);
                    }else if (FrontHole == 1 && (BHole == 0 || BThick > DeviceThickness)){
                    translate([-(DeviceWidth-FWidth*2-LipVertWidth)/2,
                        (DeviceThickness/2),-(HolderHeight+WallThick)/2]) 
                        color("pink")
                    cube([DeviceWidth-(FWidth*2)-LipVertWidth,WallThick,
                        LipHorizWidth+WallThick],false);}                    
                //Bottom Hole
                if (BHole == 1 && BWidth < DeviceWidth && BThick < DeviceThickness) {
                    translate([-(DeviceWidth-(BWidth*2))/2,-(DeviceThickness-(BThick*2))/2,
                    -(HolderHeight+WallThick)/2]) 
                        color("red")
                    cube([DeviceWidth-(BWidth*2),DeviceThickness-(BThick*2),WallThick],false);}

            }
            if (AMPSHorizontal == 1)
            {
                AMPS_Rec_holes_horizontal(from_bottom=AMPSHorizontalMountHolesFromBottom, 
                   from_left=AMPSHorizontalMountHolesFromLeft);
            }
            if (AMPSVertical == 1)
            {
                AMPS_Rec_holes_vertical(from_bottom=AMPSVerticalMountHolesFromBottom, 
                   from_left=AMPSVerticalMountHolesFromLeft);
            }
            if (CenterHoles == 1)
            {
                AMPS_center_holes(from_bottom=CenterMountHolesFromBottom, 
                   from_left=CenterMountHolesFromLeft);
            }  
                 
            }                      
            translate ([(DeviceWidth/2)-(LipVertWidth/2),
                        (DeviceThickness/2)+WallThick, 
                         LipHorizWidth-0.75]) //LipHorizWidth+WallThick]) 
                rotate([0,0,-90])
                fillet(EdgeRadius, HolderHeight-LipHorizWidth,  $fn=40);
            translate([(DeviceWidth/2)-(LipVertWidth/2),
                (DeviceThickness/2)+WallThick,
                -(HolderHeight/2)+(LipHorizWidth)+2-0.25])
                    fillet_inside_corner(x=90,y=0,z=0);
            translate ([-(DeviceWidth/2)+(LipVertWidth/2),
                        (DeviceThickness/2)+WallThick, 
                         LipHorizWidth-0.75]) //LipHorizWidth+WallThick]) 
                rotate([0,0,180])
                fillet(EdgeRadius, HolderHeight-LipHorizWidth,  $fn=40);
            translate([-(DeviceWidth/2)+(LipVertWidth/2),
                (DeviceThickness/2)+WallThick,
                -(HolderHeight/2)+(LipHorizWidth)+2-0.25])
                    fillet_inside_corner(x=90,y=90,z=0);
            translate ([0,
                        (DeviceThickness/2)+WallThick, 
                         -(HolderHeight/2)+(LipHorizWidth)+1.75]) //LipHorizWidth+WallThick]) 
                rotate([0,90,180])
                fillet(EdgeRadius, DeviceWidth-LipVertWidth,  $fn=40);
            
            if(CoolingSlots == 1) 
            {
                cooling_slots();
            }
            if (SpecialPhoneHoles == 1)
            {
                
                translate ([0,BoxOnBackXLocation, BoxOnBackZLocation])
                    rotate([90,0,0])            
                    roundedBox([AMPSWidth-12, 18, WallThick+5], 7, true, $fn=40);
                translate ([BottomRoundLocation, 0, -(HolderHeight/2)])
                    roundedBox([BottomRoundwidth, DeviceThickness*0.8, WallThick+5],
                    4, true, $fn=40);
                
                //cylinder(h=WallThick,d=DeviceThickness*0.8);
            }
            if (SpecialPhoneHoles2 == 1)
            {
                
                translate ([0,BoxOnBackXLocation2, BoxOnBackZLocation2])
                    rotate([90,0,0])            
                    roundedBox([AMPSWidth-12, 18, WallThick+5], 7, true, $fn=40);
                translate ([BottomRoundLocation2, 0, -(HolderHeight/2)])
                    roundedBox([BottomRoundwidth2, DeviceThickness*0.8, WallThick+5],
                    4, true, $fn=40);
                
                //cylinder(h=WallThick,d=DeviceThickness*0.8);
            }
            if (SpecialPhoneHoles3 == 1)
            {
                
                translate ([0,BoxOnBackXLocation3, BoxOnBackZLocation3])
                    rotate([90,0,0])            
                    roundedBox([AMPSWidth-12, 18, WallThick+5], 7, true, $fn=40);
                translate ([BottomRoundLocation3, 0, -(HolderHeight/2)])
                    roundedBox([BottomRoundwidth3, DeviceThickness*0.8, WallThick+5],
                    4, true, $fn=40);
                
                //cylinder(h=WallThick,d=DeviceThickness*0.8);
            }
            
 }      
        //}
}

module cooling_slots()
{
    holesToEdge=(DeviceWidth/2)-(AMPSWidth/2);
    SlotWidth=holesToEdge * 0.5;
    radius = SlotWidth/2;
    SlotHeight=HolderHeight * 0.75;
    SlotOffset=(holesToEdge/2)+(AMPSWidth/2);
    translate ([SlotOffset,-(DeviceThickness+WallThick)/2, 0])
        rotate([90,0,0])
        roundedBox([SlotWidth, SlotHeight, WallThick+5], radius, true, $fn=40);
    translate ([-SlotOffset,-(DeviceThickness+WallThick)/2, 0])
        rotate([90,0,0])
        roundedBox([SlotWidth, SlotHeight, WallThick+5], radius, true, $fn=40);
} 

module AMPS_Rec_holes_horizontal (from_bottom, from_left)
{
    $fn=20;
    drill_hole(xloc=(DeviceWidth/2)-from_left, zlocation=from_bottom, 
        spacing=0, size=ScrewHoleSize, head=ScrewHeadSize);
    drill_hole(xloc=(DeviceWidth/2)-from_left, zlocation=from_bottom, 
        spacing=AMPSHeight, size=ScrewHoleSize, head=ScrewHeadSize);
    drill_hole(xloc=(DeviceWidth/2)-AMPSWidth-from_left, zlocation=from_bottom, 
        spacing=0, size=ScrewHoleSize, head=ScrewHeadSize);
    drill_hole(xloc=(DeviceWidth/2)-AMPSWidth-from_left, zlocation=from_bottom, 
        spacing=AMPSHeight, size=ScrewHoleSize, head=ScrewHeadSize);        
}

module AMPS_Rec_holes_vertical (from_bottom, from_left)
{
    drill_hole(xloc=(DeviceWidth/2)-from_left, zlocation=from_bottom, 
        spacing=0, size=ScrewHoleSize, head=ScrewHeadSize);
    drill_hole(xloc=(DeviceWidth/2)-from_left, zlocation=from_bottom, 
        spacing=AMPSWidth, size=ScrewHoleSize, head=ScrewHeadSize);
    drill_hole(xloc=(DeviceWidth/2)-AMPSHeight-from_left, zlocation=from_bottom, 
        spacing=0, size=ScrewHoleSize, head=ScrewHeadSize);
    drill_hole(xloc=(DeviceWidth/2)-AMPSHeight-from_left, zlocation=from_bottom, 
        spacing=AMPSWidth, size=ScrewHoleSize, head=ScrewHeadSize);        
}

module AMPS_center_holes (from_bottom, from_left)
{
    $fn=40;
    drill_hole(xloc=0, zlocation=from_bottom, 
        spacing=0, size=ScrewHoleSize, head=ScrewHeadSize);
    drill_hole(xloc=0, zlocation=from_bottom, 
        spacing=CenterHoleHeight, size=ScrewHoleSize, head=ScrewHeadSize);
}    

module drill_hole (xloc, zlocation, spacing, size, head)
{
    translate([xloc,-((DeviceThickness/2)+WallThick),(-(HolderHeight/2)+zlocation)+spacing])
    { 
        rotate([0,90,90])
        union()
        { 
            cylinder(h=WallThick,d=size);
            translate([0,0,(WallThick/1.8)])
                cylinder(h=(WallThick/2)+1,d=head);
        } 
    }
}
translate([-30,0,-20])
fillet_inside_corner(x=90,y=0,z=0);
module fillet_inside_corner(x=0,y=180,z=0) {    
        rotate([x,y,z])
        color("olive")
        rotate_extrude(convexity = 10,angle=-90, $fn=40)
            translate([0.01, 0, 0]) 
            color("blue")
            projection() filletv2(0, EdgeRadius, 1, $fn=40);  
}

module filletv2(rot, r, h) {
    translate([r / 2, r / 2, h/2])
    rotate([0,0,rot]) difference() {
        cube([r + 0.01, r + 0.01, h], center = true);
        translate([r/2, r/2, 0])
            cylinder(r = r, h = h + 1, center = true);
    }
}

module fillet(r, h) {
    translate([r / 2, r / 2, 0])
        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);
            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);

        }
}
