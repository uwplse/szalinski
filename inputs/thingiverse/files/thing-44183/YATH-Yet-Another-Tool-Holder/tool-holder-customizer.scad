use <utils/build_plate.scad>

//-- Internal length (x-axis)
ilength = 17;

//-- Internal width (y-axis)
iwidth = 3.5;

//-- Height
height = 10;

//-- Thickness
thickness = 3; 

//-- Base thickness (rear)
base_thickness = 7; 

//-- tool holder type
open = "yes";   // [yes,no]
 

translate([0,0,height/2])
tool_holder(ilength, iwidth, height, thickness, base_thickness, open);

//for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 200; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 200; //[100:400]

translate([0,0,-height/2])
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);


//----------------------------------------------------
//-- Tool holder module
//----------------------------------------------------
module tool_holder (ilength, 
                    iwidth, 
                    height,
                    thickness, 
                    base_thickness,
                    open)            //-- Mode. True=Open, False=Close
{
  //-- For easily accesing the vector components
  X = 0;
  Y = 1;
  Z = 2;

  //----- Calculated parameters ----
  //-- Obtained from the user parameters

  //-- Outer-cube
  oc_size = [ilength + 2*thickness, iwidth + 2*thickness, height];

  //-- Inner cube
  ic_size = [ilength, iwidth, height+2];

  //-- Base cube
  b_size = [oc_size[X], base_thickness, height];

  //-- Main holder
  difference() {
  
    //-- Main body
    cube(oc_size, center=true);
    
    //-- Inner room
    cube(ic_size, center=true);
    
    //-- Depending on the mode: open or close the front
    if (open=="yes")
      translate([0, -iwidth/2-thickness/2, 0] )
        cube([ilength - 3*2, iwidth+2, height+2], center=true);
  }

  //-- Add the rear
  //color("green")
  translate([0, b_size[Y]/2 + oc_size[Y]/2, 0])
  cube(b_size, center=true);
}

//----------------------------------------------------------------
//-- Examples
//-- Remove the * on the specific tool holder you want to render
//----------------------------------------------------------------

/*

//-- Wrench 12/13
*tool_holder(ilength = 17, 
            iwidth = 3.5, 
            height = 10,
            thickness = 3, 
            base_thickness = 7,
            open="yes");

//-- rectangular File
*tool_holder(ilength = 17, 
            iwidth = 3.5, 
            height = 10,
            thickness = 3, 
            base_thickness = 15,
            open="yes");

//-- Round file
*tool_holder(ilength = 8, 
            iwidth = 5, 
            height = 10,
            thickness = 3, 
            base_thickness = 15,
            open="no");

//-- Pliers
*tool_holder(ilength = 17, 
            iwidth = 6.5, 
            height = 10,
            thickness = 3, 
            base_thickness = 7,
            open="no");

//-- Caliper
*tool_holder(ilength = 17, 
            iwidth = 6, 
            height = 10,
            thickness = 3, 
            base_thickness = 7,
            open="no");
            
//-- cutter 
*tool_holder(ilength = 32, 
            iwidth = 17, 
            height = 10,
            thickness = 3, 
            base_thickness = 3,
            open="no");
*/
            
//-------------------------------------------------------------------------
//-- YATH:  Yet another Tool Holder,   by  Obijuan
//---------------------------
//-- (c) Juan Gonzalez-Gomez (Obijuan)  Jan-2013
//---------------------------------------------------
//-- GPL license
//-------------------------------------------------------------------------            
            
            