
/*//////////////////////////////////////////////////////////////////
              -    FB Aka Heartman/Hearty 2016     -                   
              -   http://heartygfx.blogspot.com    -                  
              -       OpenScad Parametric Box      -                     
              -         CC BY-NC 3.0 License       -                      
////////////////////////////////////////////////////////////////////                                                                                                             
12/02/2016 - Fixed minor bug 
28/02/2016 - Added holes ventilation option                    
09/03/2016 - Added PCB feet support, fixed the shell artefact on export mode. 
////////////////////////////////////////////////////////////////////                                                                                                             
25/01/2017 - Mod 1: ventilation on top, cut/add shapes/text on both panels, PCB adapter
26/01/2017 - Mod 2: honeycombed grid support
28/01/2017 - Mod 3: honeycombed grid for PCB adapter, simplified adapter placement
29/01/2017 - Mod 4: boolean PCBLock; larger holes in some parts; new CylinderWithHole
02/02/2017 - Mod 5: PCBFeetXY variable was converted into special one ($PCBFeetXY)
04/02/2017 - Mod 6: increased gaps for adapter-related parts; optional gasket for PCB lock
05/02/2017 - Mod 7: changed PCB adapter dimensions to take feet bottoms into account;
                    fixed handling of $PCBFeetXY

*/////////////////////////// - Info - //////////////////////////////

use <honeycomb_mesh.scad>; // https://github.com/valba/Cool_PCB_Enclosure

// All coordinates are starting as integrated circuit pins.
// From the top view :

//
//   CoordD           <---        CoordC
//      +========================+   ^
//      |                        |   ^
//      +---+                    |   ^
//      |USB|      ARDUINO       |   ^
//      +---+                    |   |
//      |         (example)      |  +Y
//      +--+                     |   |
//      |9V|                     |   ^
//      +--+                     |   ^
//      |                        |   ^
//      +========================+   ^
//   CoordA     --- +X --->     CoordB
//
//
//


////////////////////////////////////////////////////////////////////


////////// - Paramètres de la boite - Box parameters - /////////////

/* [Box dimensions] */
// - Longueur - Length (along X-axis)
  Length        = 160;       
// - Largeur - Width (along Y-axis)
  Width         = 170;                     
// - Hauteur - Height (along Z-axis)
  Height        = 100;  
// - Epaisseur - Wall thickness  
  Thick         = 2;//[2:5]  
  
/* [Box options] */
// - Diamètre Coin arrondi - Filet diameter  
  Filet         = 2;//[0.1:12] 
// - lissage de l'arrondi - Filet smoothness  
  Resolution    = 50;//[1:100] 
// - Tolérance - Tolerance (Panel/rails gap)
  m             = 0.9;
// - Diameter for holes to put shells together (in mm)
  SideHole      = 2;
// - Generates honeycombed holes (grid) in bottom and top shells
  HexGrid       = 0; // [0:No, 1:Yes]
// - Specifies how large each honeycomb will be
  HexDia        = 10;
// - Specifies how thick the honeycombed grid will be
  HexThick      = 2;
// - Decorations to ventilation holes
  Vent          = 1;// [0:No, 1:Yes]
// - Enable extra ventilation holes on the top shell
  Vent_extra    = 0;// [0:No, 1:Yes]
// - Decoration-Holes width (in mm)
  Vent_width    = 1.5;   


  
/* [PCB_Feet] */
//All dimensions are from/to the center foot axis

// - Place (a kind of cubic hole) for the adapter in the bottom shell.
PCBAdapter      = 0;// [0:No, 1:Yes]
// - Stand (a kind of cube) to place lock for the adapter.
PCBLock         = 0;// [0:No, 1:Yes]
// - Coin bas gauche - Low left corner X position
PCBPosX         = 7;
// - Coin bas gauche - Low left corner Y position
PCBPosY         = 6;
// - Longueur PCB - PCB Length
PCBLength       = 70;
// - Largeur PCB - PCB Width
PCBWidth        = 50;
// - Heuteur pied - Feet height (relative to horizontal plane at Z = -0.5?)
FootHeight      = 10;
// - Diamètre pied - Foot diameter
FootDia         = 8;
// - Diamètre trou - Hole diameter
FootHole        = 3;  
// - PCB feet coordinates are relative to [PCBPosX, PCBPosY]
// NOTE: use $PCBFeetXY to override these coordinates from an outer module
PCBFeetXY =
[
  [ 0,         0 ]
, [ PCBLength, 0 ]
, [ PCBLength, PCBWidth ]
, [ 0,         PCBWidth ]
];

/* [STL element to export] */
// Small lock for the PCB adapter
Lock            = 0;// [0:No, 1:Yes]
// Specifies whether to render PCB (it is not exported in any case)
PCB             = 0;// [0:No, 1:Yes]
// Pieds PCB - PCB feet (according to PCBFeetXY) on bottom shell or adapter
PCBFeet         = 0;// [0:No, 1:Yes]
//Coque haut - Top shell
TShell          = 0;// [0:No, 1:Yes]
//Coque bas- Bottom shell
BShell          = 0;// [0:No, 1:Yes]
//Panneau avant - Front panel
FPanL           = 0;// [0:No, 1:Yes]
//Panneau arrière - Back panel  
BPanL           = 0;// [0:No, 1:Yes]

  
/* [Hidden] */
// - Couleur coque - Shell color  
Couleur1        = "Orange";       
// - Couleur panneaux - Panels color    
Couleur2        = "OrangeRed";    
// Thick X 2 - making decorations thicker if it is a vent to make sure they go through shell
Dec_Thick       = Vent ? Thick*2 : Thick; 
// - Depth decoration
Dec_size        = Vent ? Thick*2 : 0.8;





/// - Boitier générique bord arrondis - Generic rounded box - ///

module RoundBox($a=Length, $b=Width, $c=Height){// Cube bords arrondis
  $fn=Resolution;            
  translate([0,Filet,Filet]){  
    minkowski (){                                              
      cube ([$a-(Length/2),$b-(2*Filet),$c-(2*Filet)], center = false);
      rotate([0,90,0]){    
        cylinder(r=Filet,h=Length/2, center = false);
      } 
    }
  }
}// End of RoundBox Module


/////////////// - Simple PCB Adapter - ///////////////

module Adapter(mounts = false, is_hole = false)
{
  gap = 0.3; // we need some space between adapter and its place to put it smoothly there
  // Same calculations in Feet()
  off_X = FootDia / 2 + Filet;
  off_Y = FootDia / 2 + Filet;
  len_X = PCBLength + 2 * off_X;
  len_Y = PCBWidth + 2 * off_Y;
  color(mounts ? Couleur1 : Couleur2)
  translate([3*Thick+7-off_X-(is_hole?gap:0)
            ,Thick+10-off_Y-(is_hole?gap:0)
            ,-(is_hole?0.1:0)]) {
    if (mounts) {
      translate([-Thick, 3*Thick, 0])
        rotate([0, 0, -90])
          corner();
      translate([len_X-3*Thick, -Thick, 0])
        rotate([0, 0, 0])
          corner();
/*
      translate([3*Thick, pos_Y+len_Y+Thick, 0])
        rotate([0, 0, 180])
          corner();
*/
      if (PCBLock) { // Stand for the lock
        difference() {
          translate([PCBLength/2-FootDia/2, len_Y+gap, 0]) {
            cube([FootDia, FootDia, 2*Thick]);
            if (HexGrid) { // we'll need a longer/wider base for the stand not to miss a honeycomb
              translate([-FootDia/2, 0, 0])
                cube([FootDia*2, FootDia*2, Thick]);
            }
          }
          translate([PCBLength/2, len_Y+FootDia/2+gap, Thick/2])
            cylinder(d=FootHole, h=3*Thick/2+0.1, $fn=60); // high enough to cut hole in the stand
        }
      } // if
    }
    else
    {
      // TODO use intersection() instead of multiple differences
      difference() {
        cube([len_X+(is_hole?2*gap:0)
             ,len_Y+(is_hole?2*gap:0)
             ,Thick/2+(is_hole?0.2:0)]);
        if (!is_hole && HexGrid) { // let's make honeycombed holes in the adapter
          translate([off_X, off_Y, -0.1])
            difference() {
              cube([len_X-2*off_X, len_Y-2*off_Y, Thick/2+0.2]);
              translate([(len_X-2*off_X)/2, (len_Y-2*off_Y)/2, Thick/2-0.2]) // hexagonal_grid returns centered grid
                hexagonal_grid([len_X-2*off_X, len_Y-2*off_Y, Thick/2+0.4], HexDia, HexThick);
            }
        } // if
      }
    }
  }
}

/////////////// - Corner element for PCB Adapter - ///////////////

module corner() {
  difference() {
    linear_extrude(height = 2 * Thick) // deep enough to reach bottom plane and hit a honeycomb edge
      polygon([[0, 0], [Thick * 4, 0], [Thick * 4, Thick * 4]]);
    translate([-0.1, 0.1, Thick/2-0.1])
      linear_extrude(height = Thick/2+0.3) // cut hole in the middle to insert adapter's plate
        polygon([[Thick-0.4, Thick-0.4], [Thick*3+0.4, Thick-0.4], [Thick*3+0.4, Thick*3+0.4]]);
  }
}

///////// - Module Coque/Shell - /////////

module Coque(is_top){//Coque - Shell  
  Thick = Thick*2;  
  difference(){    
    difference(){//sides decoration
      union(){
        //intersection() {
        difference() {//soustraction de la forme centrale - Substraction Fileted box
                      
          difference(){//soustraction cube median - Median cube slicer
            union() {//union               
              difference(){//Coque    
                RoundBox();
                translate([Thick/2,Thick/2,Thick/2]){
                  RoundBox($a=Length-Thick, $b=Width-Thick, $c=Height-Thick);
                }
              }//Fin diff Coque
              difference(){//largeur Rails        
                translate([Thick+m,Thick/2,Thick/2]){// Rails
                  RoundBox($a=Length-((2*Thick)+(2*m)), $b=Width-Thick, $c=Height-(Thick*2));
                }//fin Rails
                translate([((Thick+m/2)*1.55),Thick/2,Thick/2+0.1]){ // +0.1 added to avoid the artefact
                  RoundBox($a=Length-((Thick*3)+2*m), $b=Width-Thick, $c=Height-Thick);
                }           
              }//Fin largeur Rails

            }//Fin union
            
            translate([-Thick,-Thick,Height/2]){// Cube à soustraire
              cube ([Length+100, Width+100, Height], center=false);
            }                                            

            if (HexGrid && (!Vent_extra || !is_top)) { // Extra_vent overrides HexGrid for the top shell
              HexOffX = 2 * Thick;
              HexOffY = 2 * Thick;
              HexLength = Length - 2 * HexOffX;
              HexWidth = Width - 2 * HexOffY;
              translate([HexOffX, HexOffY, -0.1])
              difference() {
                cube([HexLength, HexWidth, Thick+0.3]);
                translate([HexLength/2, HexWidth/2, 0])
                  hexagonal_grid([HexLength, HexWidth, Thick+0.2], HexDia, HexThick);
              }
            } // End of HexGrid

          }//fin soustraction cube median - End Median cube slicer
          translate([-Thick/2,Thick,Thick]){// Forme de soustraction centrale 
            RoundBox($a=Length+Thick, $b=Width-Thick*2, $c=Height-Thick);       
          }                          
          if (!is_top && PCBAdapter) { // Cut hole for the adapter
            translate([PCBPosX,PCBPosY,Thick/4+0.1])
            Adapter(is_hole=true);
          }

        }
        //} // intersection

        if (!is_top && PCBAdapter) { // mounting for the adapter
          translate([PCBPosX,PCBPosY,0])
          Adapter(mounts=true);
        }

        difference(){// wall fixation box legs
          union(){
            translate([3*Thick +5,Thick,Height/2]){
              rotate([90,0,0]){
                $fn=6;
                cylinder(d=16,Thick/2);
              }   
            }
                            
            translate([Length-((3*Thick)+5),Thick,Height/2]){
              rotate([90,0,0]){
                $fn=6;
                cylinder(d=16,Thick/2);
              }   
            }

          }
          translate([4,Thick+Filet,Height/2-57]){   
            rotate([45,0,0]){
              cube([Length,40,40]);    
            }
          }
          translate([0,-(Thick*1.46),Height/2]){
            cube([Length,Thick*2,10]);
          }
        } //Fin fixation box legs
      }

      union(){// outbox sides decorations
            
        for(i=[0:Thick:Length/4]){

          // Ventilation holes part code submitted by Ettie - Thanks ;) 
          translate([10+i,-Dec_Thick+Dec_size,1]){
            cube([Vent_width,Dec_Thick,Height/4]);
          }
          translate([(Length-10) - i,-Dec_Thick+Dec_size,1]){
            cube([Vent_width,Dec_Thick,Height/4]);
          }
          translate([(Length-10) - i,Width-Dec_size,1]){
            cube([Vent_width,Dec_Thick,Height/4]);
          }
          translate([10+i,Width-Dec_size,1]){
            cube([Vent_width,Dec_Thick,Height/4]);
          }
  
          if (is_top && Vent_extra) // Extra ventilation holes
          {
            translate([10+i,Dec_size,Dec_Thick-0.1]){
              rotate([-90, 0, 0])
              cube([Vent_width,Dec_Thick,Width/3]);
            }
            translate([(Length-10) - i,Dec_size,Dec_Thick-0.1]){
              rotate([-90, 0, 0])
              cube([Vent_width,Dec_Thick,Width/3]);
            }
            translate([(Length-10) - i,Width-Dec_size,-0.1]){
              rotate([90, 0, 0])
              cube([Vent_width,Dec_Thick,Width/3]);
            }
            translate([10+i,Width-Dec_size,-0.1]){
              rotate([90, 0, 0])
              cube([Vent_width,Dec_Thick,Width/3]);
            }
          }
                
        }// fin de for
        // }
      }//fin union decoration
    }//fin difference decoration


    union(){ //sides holes
      $fn=50;
      translate([3*Thick+5,20,Height/2+4]){
        rotate([90,0,0]){
          cylinder(d=SideHole,20);
        }
      }
      translate([Length-((3*Thick)+5),20,Height/2+4]){
        rotate([90,0,0]){
          cylinder(d=SideHole,20);
        }
      }
      translate([3*Thick+5,Width+5,Height/2-4]){
        rotate([90,0,0]){
          cylinder(d=SideHole*1.1,20); // make hole larger to let screw pass freely
        }
      }
      translate([Length-((3*Thick)+5),Width+5,Height/2-4]){
        rotate([90,0,0]){
          cylinder(d=SideHole*1.1,20);
        }
      }
    }//fin de sides holes

  }//fin de difference holes
}// fin coque 

////////////////////////////// - Experiment - ///////////////////////////////////////////





///////////////// - Foot with base filet - /////////////////
module foot(FootDia,FootHole,FootHeight){
  //DEBUG??? Filet=2;
  color(Couleur1)
  translate([0,0,Filet-1.5])
    difference(){
      difference(){
        //translate ([0,0,-Thick]){
          cylinder(d=FootDia+Filet,FootHeight-Thick, $fn=100);
        //}
        rotate_extrude($fn=100){
          translate([(FootDia+Filet*2)/2,Filet,0]){
            minkowski(){
              square(10);
              circle(Filet, $fn=100);
            }
          }
        }
      }
      cylinder(d=FootHole,FootHeight+1, $fn=100);
    }          
}// Fin module foot
  
module Feet(){
//////////////////// - PCB only visible in the preview mode - /////////////////////    
  if (PCB)
  { 
    translate([3*Thick+2,Thick+5,FootHeight+(Thick/2)-0.5]){
    
      %square ([PCBLength+10,PCBWidth+10]);
      translate([PCBLength/2,PCBWidth/2,0.5]){ 
        color("Olive")
        %text("PCB", halign="center", valign="center", font="Arial black");
      }
    } // Fin PCB 
  }
  
    
///////////////////// - 4 Feet - /////////////////////
/*    
    translate([3*Thick+7,Thick+10,Thick/2]){
        foot(FootDia,FootHole,FootHeight);
    }
    translate([(3*Thick)+PCBLength+7,Thick+10,Thick/2]){
        foot(FootDia,FootHole,FootHeight);
        }
    translate([(3*Thick)+PCBLength+7,(Thick)+PCBWidth+10,Thick/2]){
        foot(FootDia,FootHole,FootHeight);
        }        
    translate([3*Thick+7,(Thick)+PCBWidth+10,Thick/2]){
        foot(FootDia,FootHole,FootHeight);
    }   
*/
  translate([(3*Thick)+7, Thick+10, 0])
  intersection() {
    // You can assign your coordinates to $PCBFeetXY in an outer module
    PCBFeetXY = ($PCBFeetXY == undef) ? PCBFeetXY : $PCBFeetXY;
    echo(str("len(PCBFeetXY)=", len(PCBFeetXY)));
    for (i = [0:len(PCBFeetXY)-1]){
      x = PCBFeetXY[i][0];
      y = PCBFeetXY[i][1];
      if (x != undef && y != undef) {
        translate([x, y, Thick/2]){
          foot(FootDia, FootHole, FootHeight);
          if (HexGrid) {
            cylinder(d=2*FootDia, h=Thick/2);
          }
        }
      }
    } // for
    if (HexGrid && PCBAdapter) { // feet bases shouldn't go out of adapter boundaries
      // Same calculations in Adapter()
      off_X = FootDia / 2 + Filet;
      off_Y = FootDia / 2 + Filet;
      len_X = PCBLength + 2 * off_X;
      len_Y = PCBWidth + 2 * off_Y;
      translate([-off_X, -off_Y, 0])
        cube([len_X, len_Y, FootHeight]);
    }
  } // intersection
  
  // All feet are placed on a flat simple base, which can be inserted into bottom shell
  if (PCBAdapter) {
    translate([0,0,Thick/2])
    Adapter();
  }

} // Fin du module Feet




////////////////////////////////////////////////////////////////////////
////////////////////// <- Holes Panel Manager -> ///////////////////////
////////////////////////////////////////////////////////////////////////

//                           <- Panel ->  
module Panel(Length,Width,Thick,Filet){
  scale([0.5,1,1])
    minkowski(){
      cube([Thick,Width-(Thick*2+Filet*2+m),Height-(Thick*2+Filet*2+m)]);
      translate([0,Filet,Filet])
        rotate([0,90,0])
          cylinder(r=Filet,h=Thick, $fn=100);
    }
}



//                          <- Circle hole -> 
// Cx=Cylinder X position | Cy=Cylinder Y position | Cdia= Cylinder dia | Cheight=Cyl height
module CylinderHole(OnOff,Cx,Cy,Cdia){
  if(OnOff==1)
    translate([Cx,Cy,0])
      cylinder(d=Cdia,Thick+0.5,$fn=50);
}

// Cheight=height over panel surface (can be negative - the cylinder will go other side in this case)
module Cylinder(OnOff,Cx,Cy,Cdia,Cheight){
  if (Cheight == undef)
    CylinderHole(OnOff,Cx,Cy,Cdia);
  else
  {
    translate([0, 0, (Cheight < 0) ? Cheight : 0])
      resize([0,0,(Cheight < 0)?abs(Cheight):(Cheight+Thick)])
        CylinderHole(OnOff,Cx,Cy,Cdia);
  }
}
// Hdia=hole diameter
module CylinderWithHole(OnOff,Cx,Cy,Cdia,Cheight,Hdia){
  difference() {
    Cylinder(OnOff,Cx,Cy,Cdia,Cheight);
    translate([0, 0, -0.1])
      Cylinder(OnOff,Cx,Cy,Hdia,(Cheight < 0)?(Cheight-0.2):(Cheight+0.2));
  }
}

//                          <- Square hole ->  
// Sx=Square X position | Sy=Square Y position | Sl= Square Length | Sw=Square Width | Filet = Round corner
module SquareHole(OnOff,Sx,Sy,Sl,Sw,Filet){
  if(OnOff==1)
    minkowski(){
      translate([Sx+Filet/2,Sy+Filet/2,0])
        cube([Sl-Filet,Sw-Filet,Thick]);
      cylinder(d=Filet,h=Thick,$fn=100);
    }
}
module SquareZ(OnOff,Sx,Sy,Sl,Sw,Filet,H)
{
  if (H == undef)
    SquareHole(OnOff,Sx,Sy,Sl,Sw,Filet);
  else
  {
    translate([0, 0, (H < 0) ? H : 0])
      resize([0,0,(H < 0)?abs(H):(H+Thick)])
        SquareHole(OnOff,Sx,Sy,Sl,Sw,Filet);
  }
}

 
//                      <- Linear text panel -> 
module LText(OnOff,Tx,Ty,Font,Size,Content){
  if(OnOff==1)
    translate([Tx,Ty,0])
      linear_extrude(height = Thick+0.5){
        text(Content, size=Size, font=Font);
      }
}
//                     <- Circular text panel->  
module CText(OnOff,Tx,Ty,Font,Size,TxtRadius,Angl,Turn,Content){ 
  if(OnOff==1) {
    Angle = -Angl / len(Content);
    translate([Tx,Ty,0.1])
      for (i= [0:len(Content)-1] ){   
        rotate([0,0,i*Angle+90+Turn])
          translate([0,TxtRadius,0]) {
            linear_extrude(height = Thick+0.5){
              text(Content[i], font = Font, size = Size,  valign ="baseline", halign ="center");
            }
          }   
        }
  }
}
////////////////////// <- New module Panel -> //////////////////////
module FPanL(){
    difference(){
        color(Couleur2)
        Panel(Length,Width,Thick,Filet);
    
 
    rotate([90,0,90]){
        color(Couleur2){
//                     <- Cutting shapes from here ->  
        SquareHole  (1,20,20,15,10,1); //(On/Off, Xpos,Ypos,Length,Width,Filet)
        SquareHole  (1,40,20,15,10,1);
        SquareHole  (1,60,20,15,10,1); 
        CylinderHole(1,27,40,8);       //(On/Off, Xpos, Ypos, Diameter)
        CylinderHole(1,47,40,8);
        CylinderHole(1,67,40,8);
        SquareHole  (1,20,50,80,30,3);
        CylinderHole(1,93,30,10);
        SquareHole  (1,120,20,30,60,3);
//                            <- To here -> 
        }
    }
    }

    color(Couleur1){
        translate ([-.5,0,0])
        rotate([90,0,90]){
//                      <- Adding text from here ->          
        LText(1,20,83,"Arial Black",4,"Digital Screen");//(On/Off, Xpos, Ypos, "Font", Size, "Text")
        LText(1,120,83,"Arial Black",4,"Level");
        LText(1,20,11,"Arial Black",6,"  1     2      3");
        CText(1,93,29,"Arial Black",4,10,180,0,"1 . 2 . 3 . 4 . 5 . 6");//(On/Off, Xpos, Ypos, "Font", Size, Diameter, Arc(Deg), Starting Angle(Deg),"Text")
//                            <- To here ->
        }
    }
}


/////////////////////////// <- Main part -> /////////////////////////

// Small part to fix PCB adapter in the bottom shell
if (Lock)
  ILock();

if(TShell==1)
// Coque haut - Top Shell
  IShellTop();

if(BShell==1)
// Coque bas - Bottom shell
  IShellBottom();

// Pied support PCB - PCB feet
if (PCBFeet==1)
// Feet
  IFeet();

// Panneau avant - Front panel  <<<<<< Text and holes only on this one.
//rotate([0,-90,-90]) 
if(FPanL==1)
  IPanelFront();

//Panneau arrière - Back panel
if(BPanL==1)
  IPanelBack();

/////////////////////////// <- Interface -> /////////////////////////

module ICut() // may be used for cutting shapes in panels
{
  translate([-.1,0,0])
  rotate([90,0,90]){
    color(Couleur2){
      children();
    }
  }
}

module IAdd() // may be used for adding text on panels
{
  color(Couleur1){
    translate ([0,0,0])
      rotate([90,0,90]){
        children();
      }
  }
}

module IFeet()
{
  translate([PCBPosX,PCBPosY,0]){ 
    Feet();
  }
}

module ILock(gasket=false)
{
  gap = 0.7;

  translate([-FootDia * 4, 0, 0])
  {
    difference()
    {
      cube([3 * FootDia, 2 * FootDia, 3*Thick/2]);
      translate([FootDia/2-gap/2, FootDia/2-gap/2, -0.1])
      {
        translate([0, 0, Thick/2])
          cube([FootDia+gap, FootDia+gap, Thick+0.2]);
        translate([FootDia/2+gap/2, FootDia/2+gap/2, 0])
          cylinder(d=FootHole*1.2, h=2*Thick+0.2, $fn=50);
      }
    }
  
    if (gasket) // extra gasket for short screws
      translate([0, -FootDia, 0])
        difference()
        {
          cylinder(d=FootHole * 2.2, h = Thick, $fn=50);
          translate([0, 0, -0.1])
            cylinder(d=FootHole*1.2, h=Thick+0.2, $fn=50);
        }
  }
}

module IPanelBack()
{
  translate([Thick+m/2,Thick+m/2,Thick+m/2])
  {
    difference(){  
      color(Couleur2)
        Panel(Length,Width,Thick,Filet);
      if ($children >= 1) // cut shapes/text go first
        translate([Thick,Width-(2*Thick+m),0]) // shift for back panel
          rotate([0,0,180]) // mirror for back panel
            children(0);
    }
    if ($children >= 2) // added text/shapes go here
      translate([Thick,Width-(2*Thick+m),0]) // shift for back panel
        rotate([0,0,180]) // mirror for back panel
          children(1);
  }
}

module IPanelFront()
{
  translate([Length-(Thick*2+m/2),Thick+m/2,Thick+m/2])
    if ($children==0)
      FPanL(); // old-style panel
    else
      {
        difference(){
          color(Couleur2)
            Panel(Length,Width,Thick,Filet);
          if ($children >= 1) // cut shapes/text go first
            children(0);
        }
        if ($children >= 2) // added text/shapes go here
          children(1);
      }
}

module IShellBottom()
{
  color(Couleur1){ 
    Coque();
  }
}

module IShellTop()
{
  color(Couleur1,1){
    translate([0,Width,Height+0.2]){
      rotate([0,180,180]){
        Coque(true);
      }
    }
  }
}
