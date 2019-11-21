// Configureable Miniature Hex Base
//  For Wasabi Minature Wargame
//  Created by Mark Tabije
//  Designed by Brian Coley, Mike Warner, and Mark Tabije
//  See Thingiverse.com for lisencing information.

//Defaults based on Knight Model at x1.5

//***** Variables *****

/* [Basic] */

//Parts to create (valid entries: "base_and_clip" , "base_only" , "clip_only" )
partSelection = 1; //[1: Base Plus Clip(s), 2: Base Only, 3: Clip(s) Only, 4: Example Model Base]

// Width of the Model Base in mm (Width of the model base flat side to flat side).
modelBaseSize = 30.25;

// Thickness of the Model Base in mm.
modelBaseThickness = 6;

// Size of the Base in mm (Width of the base flat side to flat side; typically 8mm larger than modelBaseThickness).
baseSize = 38;

// Thickness of the Base in mm.  (Typically modelBaseSize + Clip Band Thickness + 3mm)  
baseThickness = 10;

// Ability for the Clip ("All" creates all 3 clips)
baseClipAbility = "All";  //[Range, Direct, Sneak, All]

// Level for the base (Tipically 0 is Hero)
baseLevel = 5; //[0:5]  


/* [Advanced] */

abilityClipWidth = 10;
abilityClipBandThickness = 1.5;
lipOverhang = 0.5;
lipOverhangThickness = .7;
lipOverhangTolerance = 0.5;
clipTolerance = 0.25;
symbolThickness = 1.5;  
levelNotchWidth = 3;
levelNotchDepth = 3;
generateSupport = false; //currently not implemented
supportContactWidth = 0.2; //currently not implemented

/* [Testing] */

notchToTable = true; //[true,false]  //currently not implemented
abilityOnSide = true; //[true,false]  //currently not implemented
clipSidePrint = true; //[true,false]  //currently not implemented




//****** Main ********

if(partSelection == 1)
{
    //Base and Clip
    difference()
    {
        makeBase();
        buenasNotches(levelNotchWidth, levelNotchDepth, baseLevel);
    }
    makeClips(baseClipAbility);    
} 
else if(partSelection == 2)
{
    //Base Only
    difference()
    {
        makeBase();
        buenasNotches(levelNotchWidth, levelNotchDepth, baseLevel);
    }
}
else if(partSelection == 3)
{   
    //Clip Only
    makeClips(baseClipAbility);
}
else if(partSelection == 4)
{   
    //Example Model Base
    makeHex(modelBaseSize, modelBaseThickness);
}

else
{
    echo("Yo Dawg:  Why was there no selection?");
}


//******* Main Modules *********
//*******   Warning: These modules are dependant on variables in parent code   *********

module makeBase()
{
    difference()
    {
        //Base Shell
        makeHex(baseSize, baseThickness);
        
        //Model Base (removed from Base Shell)   
        translate([0,0,(baseThickness-modelBaseThickness)])makeHex(modelBaseSize, modelBaseThickness);
        
        //Removing material for Ability clip
        rotate([0,0,-30])
            sideAbilityClip(baseSize, abilityClipWidth+clipTolerance*2, baseThickness, abilityClipBandThickness+clipTolerance, ((baseSize-modelBaseSize)+lipOverhang+clipTolerance)/2, lipOverhang, lipOverhangThickness, lipOverhangTolerance, baseClipAbility, false);
        
        
    }
    
    echo("Base Plate Min Size = ", baseThickness-modelBaseThickness-clipTolerance-abilityClipBandThickness);
}


  

module makeClips(clipType)
{
    //Note:  This module uses variables defined in the parent module (i.e. *** Main  ***)
    
    if(clipType == "All")
    {
        translate([baseSize/2+15,0,0])
            rotate([0,0,90])
                sideAbilityClip(baseSize, abilityClipWidth, baseThickness, abilityClipBandThickness, (baseSize-modelBaseSize)/2, lipOverhang, lipOverhangThickness, lipOverhangTolerance, "Range", abilityOnSide);

        translate([baseSize/2+20+abilityClipWidth,0,0])
            rotate([0,0,90])
                sideAbilityClip(baseSize, abilityClipWidth, baseThickness, abilityClipBandThickness, (baseSize-modelBaseSize)/2, lipOverhang, lipOverhangThickness, lipOverhangTolerance, "Direct", abilityOnSide);
        
        translate([baseSize/2+25+abilityClipWidth*2,0,0])
            rotate([0,0,90])
                sideAbilityClip(baseSize, abilityClipWidth, baseThickness, abilityClipBandThickness, (baseSize-modelBaseSize)/2, lipOverhang, lipOverhangThickness, lipOverhangTolerance, "Sneak", abilityOnSide);
        
    }
    else
    {
        //Default creation of 1 clip.
        
        translate([baseSize/2+15,0,0])
            rotate([0,0,90])
                sideAbilityClip(baseSize, abilityClipWidth, baseThickness, abilityClipBandThickness, (baseSize-modelBaseSize)/2, lipOverhang, lipOverhangThickness, lipOverhangTolerance, baseClipAbility, abilityOnSide);

    }
   
    // *** The following is for SCAD test use only.  The following code should be commented out.
        /*
        
        translate([0,0,0])
                rotate([0,0,-30])
                    sideAbilityClip(baseSize, abilityClipWidth, baseThickness, abilityClipBandThickness, (baseSize-modelBaseSize)/2, lipOverhang, lipOverhangThickness, lipOverhangTolerance, baseClipAbility, abilityOnSide);
        
        */
    // ***End of test code
        
}

module buenasNotches(notchWidth, notchDepth, notchNumber)
{
    //DEV/DEBUG - This is a very rudimentary version of this code.  This needs to be expanded to be more
    //                 parametrically flexible. Resizing may not work properly.  Notches are square for now.
    
    if(notchNumber >= 1)
    { 
        rotate([0,0,30])
            translate([0,3,0])  //Make this Parametric
                buenasNotchesPieces(baseSize, notchDepth, notchWidth, baseThickness);
       
        rotate([0,0,210])
           translate([0,3,0])  //Make this Parametric
                buenasNotchesPieces(baseSize, notchDepth, notchWidth, baseThickness);       
    }
    
    if(notchNumber >= 2)
    {
       rotate([0,0,30])
            translate([0,-3,0])  //Make this Parametric
                buenasNotchesPieces(baseSize, notchDepth, notchWidth, baseThickness);
       
        rotate([0,0,210])
           translate([0,-3,0])  //Make this Parametric
                buenasNotchesPieces(baseSize, notchDepth, notchWidth, baseThickness);        
    }
   
    if(notchNumber >= 3)
    {
        rotate([0,0,60])
            translate([-notchDepth,0,0])  //Make this Parametric  --  Work on this algorythm the most
                buenasNotchesPieces(baseSize, notchDepth+.75, notchWidth, baseThickness);
       
        rotate([0,0,240])
           translate([-notchDepth,0,0])  //Make this Parametric  --  Work on this algorythm the most
                buenasNotchesPieces(baseSize, notchDepth+.75, notchWidth, baseThickness);  
        
    }
     
   
    if(notchNumber >= 4)
    { 
        rotate([0,0,90])
            translate([0,3,0])  //Make this Parametric
                buenasNotchesPieces(baseSize, notchDepth, notchWidth, baseThickness);
       
       rotate([0,0,270])
           translate([0,3,0])  //Make this Parametric
                buenasNotchesPieces(baseSize, notchDepth, notchWidth, baseThickness);       
    }
    
    if(notchNumber >= 5)
    {
       rotate([0,0,90])
            translate([0,-3,0])  //Make this Parametric
                buenasNotchesPieces(baseSize, notchDepth, notchWidth, baseThickness);
       
        rotate([0,0,270])
           translate([0,-3,0])  //Make this Parametric
                buenasNotchesPieces(baseSize, notchDepth, notchWidth, baseThickness);        
    }
    
}

module makeSupport(contactSize)
{
    //Not Yet Implemented
    
}


//******* Aux Modules  (not dependant on external variables i.e. stand-alone)  *********

module makeHex(shapeWidth, thickness)
{
    hexAngles = [ for (i = [0 : 60 : 300]) i ];
    
        linear_extrude(height = thickness)
        {
            hull()
            {
                for(i = hexAngles)
                {    
                    rotate([0,0,i])
                        polygon([[-(shapeWidth/sqrt(3))/2,-shapeWidth/2],[0,0],[(shapeWidth/sqrt(3))/2,-shapeWidth/2]]);
                }
            }
        }
}


module sideAbilityClip(clipLength, clipWidth, clipSideThickness, clipBottomBandThickness, clipSideWidth, clipLipWidth, clipLipThickness, clipLipTolerance, clipShape, shapeOnSide)
{
    
    //DEV/DEBUG - Need to simplify this Module, consider making more submodules
    
    /*Explain each variable here
      Note: The naming convention changes depending on the Full Clip or the Side part of the Clip.
      e.g.  When viewing the clips in the preivew:  Width of the clip (clipWidth) is along 
            the X axis. However, width of the side of the clip (clipSideWidth) is along the 
             Y axis. */
    
    union()
    {
       
       //*Bottom Band
       translate([-clipLength/2,-clipWidth/2,0])
            cube([clipLength, clipWidth, clipBottomBandThickness]);
                      
        //*Left Side of Clip
        translate([-clipLength/2,-clipWidth/2,0])
        {
            if(shapeOnSide == false)
            {
                union()
                {   
                    //Vertical Clip Piece
                    cube([clipSideWidth, clipWidth, clipSideThickness+clipLipTolerance]);
                            
                    //Clip Lip
                    translate([0, 0, clipSideThickness+clipLipTolerance])
                        cube([clipSideWidth+clipLipWidth, clipWidth, clipLipThickness]);
                
                    //Ability Symbol
                    translate([clipSideWidth/2, clipWidth/2, clipSideThickness+clipLipTolerance+clipLipThickness])
                        abilitySymbol(clipSideWidth, symbolThickness, clipShape);  
                }
            } 
            else
            {
                difference()
                {
                    
                    union()
                    {   
                        //Vertical Clip Piece
                        cube([clipSideWidth, clipWidth, clipSideThickness+clipLipTolerance]);
                                
                        //Clip Lip
                        translate([0, 0, clipSideThickness+clipLipTolerance])
                            cube([clipSideWidth+clipLipWidth, clipWidth, clipLipThickness]);
                    
                        //Ability Symbol
                        translate([clipSideWidth/2, clipWidth/2, clipSideThickness+clipLipTolerance+clipLipThickness])
                            abilitySymbol(clipSideWidth, symbolThickness, clipShape);  
                    }
                        //Side Ability Symbol - Removes material
                      
                    translate([symbolThickness/2, clipWidth/2, clipSideThickness/2])
                        rotate([0,-90,0])  
                            abilitySymbol(clipWidth/2, symbolThickness, clipShape);
                }
            }
        }
       
        //*Right Side Clip
        mirror([1,0,0])
        {
            translate([-clipLength/2,-clipWidth/2,0])
            {
                if(shapeOnSide == false)
                {
                       union()
                    {   
                        //Vertical Clip Piece
                        cube([clipSideWidth, clipWidth, clipSideThickness+clipLipTolerance]);
                                
                        //Clip Lip
                        translate([0, 0, clipSideThickness+clipLipTolerance])
                            cube([clipSideWidth+clipLipWidth, clipWidth, clipLipThickness]);
                    
                        //Ability Symbol
                        translate([clipSideWidth/2, clipWidth/2, clipSideThickness+clipLipTolerance+clipLipThickness])
                            abilitySymbol(clipSideWidth, symbolThickness, clipShape);  
                    }
                } 
                else
                {
                    difference()
                    {
                        
                        union()
                        {   
                            //Vertical Clip Piece
                            cube([clipSideWidth, clipWidth, clipSideThickness+clipLipTolerance]);
                                    
                            //Clip Lip
                            translate([0, 0, clipSideThickness+clipLipTolerance])
                                cube([clipSideWidth+clipLipWidth, clipWidth, clipLipThickness]);
                        
                            //Ability Symbol
                            translate([clipSideWidth/2, clipWidth/2, clipSideThickness+clipLipTolerance+clipLipThickness])
                                abilitySymbol(clipSideWidth, symbolThickness, clipShape);  
                        }
                            //Side Ability Symbol - Removes material
                          
                        translate([symbolThickness/2, clipWidth/2, clipSideThickness/2])
                            rotate([0,-90,0])  
                                abilitySymbol(clipWidth/2, symbolThickness, clipShape);
                    }
                }
            }
        }
            
    
        
    }
    
    
}

module abilitySymbol(abilitySize, abilityThickness, ability)
{
    echo("Ability Symbol Size =", abilitySize);
    
    //Range - Triangle
    if(ability == "Range")
        rotate([0,0,-90])
            linear_extrude(height=abilityThickness)
                polygon([[-abilitySize/1.5,-abilitySize/2],[0,abilitySize/2],[abilitySize/1.5,-abilitySize/2]]);

    //Direct - Square
    if(ability == "Direct")
        translate([0, 0, abilityThickness/2])  //setting cube to be center set and start at Z=0
            cube([abilitySize, abilitySize, abilityThickness], center=true);

    //Sneak - Circle
    if(ability == "Sneak")
       cylinder(h=abilityThickness,r=abilitySize/2);
    
  
       
}

module buenasNotchesPieces(baseLength, notchWidth, notchLength, notchThickness)
{
    //Vertical notch Pieces
   
    //Left Notch
    translate([-baseLength/2,-notchLength/2,0])
        cube([notchWidth, notchLength, notchThickness]);
    
    //Right Notch - Not Necessary cannot make notches to cross over center.
    //mirror([1,0,0])
    //    translate([-baseLength/2,-notchLength/2,0])
     //       cube([notchWidth, notchLength, notchThickness]);
}



