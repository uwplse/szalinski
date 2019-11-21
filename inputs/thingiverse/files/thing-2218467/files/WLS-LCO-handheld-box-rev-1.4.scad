/******************************************************************************/
/**********                     INFO                                        **********/
/******************************************************************************/

/*
Wireless Launch System LCO controller case 1.2 March 2017
David Buhler (Crayok)

Custom box design for PIC microcontroller & Board, keypad,
4x20 display, li-ion charge circuit, 4 18650 li-ion battery pack  
and a 900Mhz modem.

Project Pics here:
https://www.flickr.com/photos/crayok/albums/72157604233331535

There are only three items printed, Base box that will hold the 
controller, modem and batteries with the top lid lower section 
housing the keypad that mounts from the bottom side (keypad 
flange inside box) There are two hole in this lid that are used 
to link the lid to the LCD display and angle section.  The angle 
section is variable in angle and length to accommodate the
required display and function stuff.

Adding the extra detail for the inside components gives and idea
how the things will fit and any potential interference.  This allows
for adjustment of the components and the resulting cut-outs to be 
accurate.

*
*********************************************************************************
r 1.2Added slop adjustment to top box for better fit
r 1.3 Cleaned up offset code for cutouts
r 1.4 auto adjust print layout corrected,  added extrude for text but also 
removed text creation for print part render (save compute power)
adjusted top auto placement as slope changes

Attribution-NonCommercial 3.0 (CC BY-NC 3.0)
http://creativecommons.org/licenses/by-nc/3.0/

Some code inspired by FB Aka Heartman/Hearty 2016 
http://heartygfx.blogspot.com 
http://heartygfx.blogspot.ca/2016/01/the-ultimate-box-maker.html
http://www.thingiverse.com/thing:1264391

Compiled on OpenSCAD version 2015.03-2
*/

/******************************************************************************/
/**********                           Settings                             **********/
/******************************************************************************/
//adjust the follow to meet your needs,  all measurements in mm.
// preview[view:south west, tilt:top diagonal]
/* [Display Parts] */
//Print Parts
print_part="None";//[None:None,All:All, Bottom:Bottom Only, Top:Top Only, Angle:Angle Top Only]
//Bottom
bottom_shell=1;//[0:No, 1:Yes]
//Top
top_shell=1;//[0:No, 1:Yes]
//Angle
angle_shell=1;//[0:No, 1:Yes]
//Keypad
keypad=1;//[0:No, 1:Yes]
//LCD
LCD=1;//[0:No, 1:Yes]
//Charger
charger=1;//[0:No, 1:Yes]
//Power Switch
power=1;//[0:No, 1:Yes]
//Battery
battery=1;//[0:No, 1:Yes]

/* [Base Dimensions]   */
//dimensions are almost... all inside dimensions the shell_thickness is added to these

//Overall length of the box
base_length=190;//[20:220]
//Width of the box
base_width=105;//[20:220]
//How high should the base be?
base_height=018;//[5:50]
//Length of Angled Top in flat config (lower top piece is Base Length - Angled Top) 
angletop_length=90;//[30:100]
//How high should the top be?
top_height=20;//[5:50]
//Slope on the Angle portion of the box
angle_top_slope=18;//[0:45]
//Set the shape of the corners 3,4,5 for angles, 40+ for rounded
cir_res=60;//[4:2:150] 
//Diameter of the corners 
box_corner=4;//[1:8]
//How thick of an outside shell
shell_thickness=3; //[1:5]
//Lip height between the bottom and top pieces
base_lip=3;//[1:5]
//Interface slop for cutouts and box fit
slop=0.4;//[0:0.1:0.5]

//Inside Locking Tab Thickness
tab_thickness=2.5;//[2:0.5:10]
//Tab Diameter
tab_dia=16;//[7:20]
//Diameter of the Bulge 
latch_dia=1.6;//[2:5]

//Parts used to create the cutouts in the final piece
/* [KEYPAD]   */
//Length Protrusion through top
keypad_length=69;//[20:100]
//Width Protrusion through top
keypad_width=76.7;//[20:100]
//Enough height to protrude through shell, if not actual height
keypad_height=9.22;//[2:15]
//Number Keys in Rows 
keyrows=4;//[1:5]
//Number of Keys in Columns
keycolumns=5;//[1:5]

/* [LCD] */
//LCD display only Length
LCD_length=26;//[10:50]
//LCD display only Width
LCD_width=77;//[10:120]
//LCD display height that is enough to protrude through shell for cutout
LCD_height=7;//[10:50]
//Overall LCD Length
LCD_olength=61;//[10:50]
//Overall LCD Width
LCD_owidth=99;//[10:120]
//LCD Height Circuit height not including the cutout height
LCD_oheight=20;//[10:50]
//Screw diameter plus a mm or so
LCD_screw=4;//[2:7]

/* [CHARGER]   */
//Charger Board Display Length
charger_dlength=11.5;//[5:50]
//Charger Board Display Width
charger_dwidth=26.5;//[5:50]
//Charger Board Display Height that is enough to protrude through shell for cutout
charger_dheight=7;//[5:30]
//Overvall Charger Board Length
charger_olength=30;//[5:50]
//Overall Charger Board Width
charger_owidth=66;//[5:50]
//Charger Board height not including display
charger_oheight=3;//[5:30]

/* [POWER SWITCH]   */
//Overvall Power  Board Length
power_length=20.5;//[5:30]
//Overvall Power Board Width
power_width=13.1;//[5:30]
//Overvall Power  Board height that is enough to protrude through shell for cutout
power_height=19;//[5:30]

/* [BATTERY]   */
//Overvall Battery Pack Length
battery_plength=82;//[30:100]
//Overvall Battery Pack Width
battery_pwidth=84;//[30:100]
//Overvall Battery Pack Height
battery_pheight=12;//[5:30]
//Battery Diameter
battery_diameter=18.2;//[5:30]
//Battery Length
battery_length=65;//[50:80]

/* [OUTSIDE GRIPS]   */
//Grip Serrations on Outside of Box
numofgrips=10;//[0;12]
//Right Side inset (visual alignmet for the moment)
insetr=1.4;
//Left Side inset (visual alignmet for the moment)
insetl=0.6;

//the keytext line below is modified as Thingiverse customizer does not parse test arrays
/* [TEXT]   */
keytext=" SMGA-9630852+741ADOF";//[" ","SAFE","MENU","GO","ARM","-","9","6","3","0","8","5","2","+","7","4","1","AUX" ,"DUMP","O2","FILL"]; //" SMGA-9630852+741ADOF";
LCDline1txt="Angle Top";
LCDline2txt="Box System rev 1.3";
LCDline3txt="By Crayok";
LCDline4txt="Buhler's World";



/******************************************************************************/
/*******                      Variable Calcs                             **********/
/****                       no need to adjust these                    ********/
/******************************************************************************/
/* [HIDDEN] */
angletop_width = base_width;
tbase_width=(shell_thickness *2) +base_width; //add shell thichness
tbase_length=(shell_thickness *2) +base_length; //add shell thichness
tbase_height=(shell_thickness *2) +base_height; //add shell thichness
ttop_height=(shell_thickness *2) +top_height; //add shell thichness
tangletop_width=(shell_thickness *2) +angletop_width; //add shell thichness
//Length from Base offset for cutout
keypad_loffset=base_length-angletop_length-keypad_length-10;
//Length from Base offset for cutout
lcd_loffset=base_length-angletop_length+sin(angle_top_slope)*(LCD_oheight+7)+5;//112
//Height offset for cutout
lcd_hoffset=base_height+top_height-LCD_oheight-shell_thickness+(sin(angle_top_slope)*13);
//Length from Base offset for cutout
power_loffset=base_length+shell_thickness-cos(angle_top_slope)*power_length-2;//169 
//Length from Base offset for cutout
charger_loffset=base_length+shell_thickness-cos(angle_top_slope)*charger_olength-.25;//164.5
//Height offset for cutout
charger_hoffset= (angletop_length-cos(angle_top_slope)*charger_olength-.25)*tan(angle_top_slope)+base_height+charger_oheight+13;//54.7
//Height offset for cutout
power_hoffset=(angletop_length-cos(angle_top_slope)*power_length-2)*tan(angle_top_slope)+base_height+5;//45
//Little bulge piece that interfaces with top sections to lock
latch_length=tab_dia/4;

/******************************************************************************/
/**********                  Make It Happen Stuff                   **********/
/******************************************************************************/
echo (Project_Size_Width=tbase_width);
echo (Project_Size_Length=tbase_length);
echo( Project_Size_Height=tbase_height+top_height+tan(angle_top_slope)*angletop_length);

//laysout all three parts on platform,  use slicer to seperate parts and print one or two of three    
 if (print_part=="All")
    {
    print_base();
    print_top();
    print_angle();  
    }
else if (print_part=="Bottom")
  {
   print_base();
  }
else if (print_part=="Top")
  {
   print_top();
  }
else if (print_part=="Angle")
  {
   print_angle();    
  }
  else
  {
    //Display the Base Section
if(bottom_shell==1)
    {
    color("lightblue")   
    translate([0,0,0])
    difference()
        {
        base_build();
        handgrip();
        }
    }
//Display the Top Section
if(top_shell==1)
    {
    color("lightblue")      
    //translate([0,0,10])
    difference()
        {
        top_build();
        translate([0,0,0])    
        base_build(); //removes the latch bumps to allow for positive retension   
        translate([keypad_loffset,(base_width-keypad_width)/2,base_height+top_height-2])     
            keypad();
        handgrip();
        // lcd cutout only used if screw holes protrude to top shell
        translate([lcd_loffset,(tbase_width-LCD_owidth)/2,lcd_hoffset])
            rotate([0,-angle_top_slope,0])
                LCD();         
        }
     }
//Display the Angle Top Section
if(angle_shell==1)
    {
    color("lightblue")   
    difference()
        {
        angle_build();
        base_build();
        handgrip();  
        translate([lcd_loffset,(tbase_width-LCD_owidth)/2,lcd_hoffset])
            rotate([0,-angle_top_slope,0])
                LCD();     
        translate([charger_loffset,tbase_width-charger_owidth-15,charger_hoffset])
            rotate([0,-angle_top_slope,0])
                charger();
        translate([power_loffset,10,power_hoffset])
            rotate([0,-angle_top_slope,0])
                power();
        }    
    }

//Display the Keypad
if (keypad==1)
    {
    translate([keypad_loffset,(base_width-keypad_width)/2,base_height+top_height-2])     
    keypad();
    }

//Display the LCD    
if (LCD==1)
    {
    translate([lcd_loffset,(tbase_width-LCD_owidth)/2,lcd_hoffset])
            rotate([0,-angle_top_slope,0])
    LCD();
    }

//Display the Charger    
if (charger==1)
    {
     translate([charger_loffset,tbase_width-charger_owidth-15,charger_hoffset])
            rotate([0,-angle_top_slope,0])
    charger();
    } 

 //Display the Power Switch       
 if (power==1)
    {
    translate([power_loffset,10,power_hoffset])
            rotate([0,-angle_top_slope,0])
    power();
    }

//Display the Battery Pack    
 if (battery==1)
    {
    translate([shell_thickness,(tbase_width-battery_pwidth)/2,shell_thickness])
        battery();
    }
  }
  
/******************************************************************************/
/**********                   Module Section                           **********/
/****                                                                             ********/
/******************************************************************************/
module print_base()
   {
     //base    
    translate([-base_length/2,-base_width-shell_thickness*2,0])
    difference()
        {
        base_build();
        handgrip();
        }    
   }
module print_top()
  {
   //top   
   translate([0,shell_thickness,base_height+top_height+shell_thickness]) 
        rotate([0,180,0]) 
           difference()
              {
              top_build();
              base_build(); //removes the latch bumps to allow for positive retension   
              translate([keypad_loffset,(base_width-keypad_width)/2,base_height+top_height-2])     
                  keypad();//keypad cutout
              handgrip();//make serrations
              translate([lcd_loffset,(tbase_width-LCD_owidth)/2,lcd_hoffset])
                   rotate([0,-angle_top_slope,0])
                      LCD(); //lcd cutout   
              }   
  }
module print_angle()
    {
   //angle
    translate([base_length+(shell_thickness*2)+15,shell_thickness,top_height-base_height+shell_thickness*2])
        rotate([0,180+angle_top_slope,0])
         difference()
            {
            angle_build();
            base_build();//removes the latch bumps to allow for positive retension   
            translate([lcd_loffset,(tbase_width-LCD_owidth)/2,lcd_hoffset])
                rotate([0,-angle_top_slope,0])
                    LCD();//lcd cutout
            translate([charger_loffset,tbase_width-charger_owidth-15,charger_hoffset])
                rotate([0,-angle_top_slope,0])
                    charger();//charger cutout
            translate([power_loffset,10,power_hoffset])
                rotate([0,-angle_top_slope,0])
                    power();//power switch cutout   
            }       
    }
//makes side serrations for better handholding
module handgrip()
    {
    for(i=[30:10:(numofgrips*10)+20])
        {
        translate([i,-insetr,0])
            cube([2,2,base_height*2+top_height*2]);     
        translate([i,tbase_width-insetl,0])
            cube([2,2,base_height*2+top_height*2]); 
        }
    }
    
// Make box with round corners
module RoundBox(length,width,height)
    {
    $fn=cir_res;            
    translate([0,box_corner/2,box_corner/2])
        {  
        minkowski ()
            {                                              
            cube ([length-(length/2),width-box_corner,height-box_corner]);
            rotate([0,90,0])    
                cylinder(d=box_corner,h=length/2);
            }
        }
    }

// builds the base of the box, added a rim relief for better fitting and tabs for locking box to top section
module base_build()
    {
    union()
        {
         difference()
            {
            RoundBox(tbase_length,tbase_width,tbase_height*1.2);//tbase_width,tbase_length,tbase_height
            translate([shell_thickness+slop/2,shell_thickness+slop/2,shell_thickness])
                RoundBox(base_length-slop,base_width-slop,base_height+10);//removes inside
            translate([-shell_thickness,-shell_thickness,base_height+shell_thickness])
                cube([base_length*2,base_width*2,base_height+10]);  //removes top (creates flat top)  
            translate([(shell_thickness/2),(shell_thickness/2),base_height+shell_thickness-base_lip])
                cube([base_length+shell_thickness,base_width+shell_thickness,base_height+10]);  //removes inset
            }   
        make_tabs();
        //make battery compartment divider    
        translate([shell_thickness+battery_plength+2,shell_thickness,shell_thickness])
            cube([1.6,base_width+2,battery_pheight/2]);
        }
     }

//makes tabs in botton box for alignment and affixing to the upper portions
// added as a module to allow latch subtraction in upper box for positive latching     
module make_tabs()
   {
    difference()//adds tabs to box
    {
    union()//creates the 6 tabs and places them
       {
       $fn=6; //set shape of tab
       translate([base_length/5,shell_thickness+tab_thickness+slop/2 ,base_height])
          rotate([90,0,0])
              cylinder(d=tab_dia,tab_thickness);
       translate([base_length-base_length/5,shell_thickness+tab_thickness+slop/2,base_height])
          rotate([90,0,0])
              cylinder(d=tab_dia,tab_thickness);
       translate([base_length/1.9,shell_thickness+tab_thickness+slop/2,base_height])
          rotate([90,0,0])
              cylinder(d=tab_dia,tab_thickness);
       translate([base_length/5,base_width+shell_thickness-slop/2,base_height])
          rotate([90,0,0])
              cylinder(d=tab_dia,tab_thickness);
       translate([base_length-base_length/5,base_width+shell_thickness-slop/2,base_height])
          rotate([90,0,0])
              cylinder(d=tab_dia,tab_thickness);          
       translate([base_length/1.9,base_width+shell_thickness-slop/2,base_height])
          rotate([90,0,0])
              cylinder(d=tab_dia,tab_thickness);
       translate([base_length-tab_thickness+shell_thickness-slop/2,(base_width+shell_thickness*2)/2,base_height])//end tab
          rotate([90,0,90])
              cylinder(d=tab_dia,tab_thickness);
       }
//bevels the bottom of the tab for better look and better printing
      translate([0,shell_thickness+box_corner,-base_height/2])                  
        rotate([45,0,0])
           cube([base_length,base_height,base_height]);                            
      translate([shell_thickness,base_width-shell_thickness/2,-base_height/2])   
        rotate([45,0,0])
           cube([base_length,base_height,base_height]);  
      translate([base_length-shell_thickness/2,0,-base_height/2])   
        rotate([45,0,90])
           cube([base_length,base_height,base_height]);    

//bevels the top of the tab for better locking interface
      translate([0,shell_thickness,base_height])                  
        rotate([85,0,0])
           cube([base_length,base_height,base_height]);

      translate([0,base_height/2+base_width-shell_thickness*2,base_height])                  
        rotate([5,0,0])
           cube([base_length,base_height,base_height]);    
    }    
//adds the latch bump on the tab to interface with the top section for locking
      translate([base_length/5-latch_length/2,shell_thickness+slop/2 ,base_height+tab_dia/2-latch_dia-.5])
        rotate([0,90,0])
          {
          $fn=cir_res;    
          cylinder(d=latch_dia,latch_length); 
          }
      translate([base_length-base_length/5-latch_length/2,shell_thickness+slop/2 ,base_height+tab_dia/2-latch_dia-.5])
        rotate([0,90,0])
            {
            $fn=cir_res;    
            cylinder(d=latch_dia,latch_length); 
            }
       translate([base_length/1.9-latch_length/2,shell_thickness+slop/2 ,base_height+tab_dia/2-latch_dia-.5])
        rotate([0,90,0])
            {
            $fn=cir_res;    
            cylinder(d=latch_dia,latch_length); 
            }                      
                
       translate([base_length/5-latch_length/2,base_width+shell_thickness -slop/2,base_height+tab_dia/2-latch_dia-.5])
          rotate([0,90,0])
              {
              $fn=cir_res;    
              cylinder(d=latch_dia,latch_length); 
              }
      translate([base_length-base_length/5-latch_length/2,base_width+shell_thickness -slop/2,base_height+tab_dia/2-latch_dia-.5])
          rotate([0,90,0])
              {
              $fn=cir_res;    
              cylinder(d=latch_dia,latch_length); 
              }
       translate([base_length/1.9-latch_length/2,base_width+shell_thickness-slop/2 ,base_height+tab_dia/2-latch_dia-.5])
          rotate([0,90,0])
              {
              $fn=cir_res;    
              cylinder(d=latch_dia,latch_length); 
              }                       
                
        translate([base_length+shell_thickness,(base_width+shell_thickness*2)/2+latch_length/2-slop/2 ,base_height+tab_dia/2-latch_dia-.5])
          rotate([90,0,0])
              {
              $fn=cir_res;    
              cylinder(d=latch_dia,latch_length); 
              }
     }

module top_build()
  {
   difference()
      {
      translate([0,0,base_height-shell_thickness])
          RoundBox(tbase_length,tbase_width,ttop_height);//tbase_width,tbase_length,tbase_height
      translate([shell_thickness-slop/2,shell_thickness-slop/2,shell_thickness])
          RoundBox(base_length+slop,base_width+slop,top_height+base_height-shell_thickness);//removes inside
      translate([base_length+shell_thickness-angletop_length,-10,0])
           cube([base_length,base_width*2,(base_height+top_height)*2]);       
       }     
   }

// build the back top portion than can be angled for better LCD viewing and also to increase available display space
module angle_build()
  {
  difference()
    {
    union()
      {
      difference()//make angle piece
        {
        translate([base_length+shell_thickness-angletop_length,(tbase_width-tangletop_width),base_height+top_height+shell_thickness])
          {
          rotate ([0,-angle_top_slope,0]) 
            {
            translate([0,0,-(top_height+tan(angle_top_slope)*angletop_length)])//translate to adjust the rotation point  to top of piece
              RoundBox(angletop_length*1.5,tangletop_width,top_height+tan(angle_top_slope)*angletop_length) ; 
            }
          }           
    
    difference()//cut off excess so end pice on angle top is left
      {
      translate([base_length-angletop_length+shell_thickness,(tbase_width-tangletop_width)+shell_thickness,base_height+top_height])
        {  
       rotate ([0,-angle_top_slope,0])
          {
          translate([0,0,-(top_height+tan(angle_top_slope)*angletop_length)])//translate to adjust the rotation point to top of piece
            RoundBox(angletop_length*1.5,angletop_width,top_height+tan(angle_top_slope)*angletop_length) ;//+10
            }
          }
        end_snip(); 
        }
      }
                        
      difference()//make top bottom piece
          {           
          translate([base_length-angletop_length+shell_thickness,tbase_width-tangletop_width,base_height-shell_thickness])
            RoundBox(angletop_length*2,tangletop_width,ttop_height ) ;  
          difference()
              {
              translate([base_length-angletop_length+shell_thickness-slop,tbase_width-tangletop_width+shell_thickness,base_height-shell_thickness])
                 RoundBox(angletop_length*2-shell_thickness,angletop_width,ttop_height ) ;            
              end_snip(); 
              }
          
       difference()
            {
            translate([base_length-angletop_length,tbase_width-tangletop_width+shell_thickness,base_height+top_height])
              rotate ([0,-angle_top_slope,0])
                {
                translate([0,0,-(top_height+tan(angle_top_slope)*angletop_length)])
                    RoundBox(angletop_length*2-shell_thickness,angletop_width,top_height+tan(angle_top_slope)*angletop_length) ;                 
                }
             end_snip();
            }
         }
      }
      //remove back excess
      translate([base_length+shell_thickness*2-.01,-10,0])
         cube([base_length,base_width*2,base_height*10]);
      //remove botton excess
      translate([-0,-10,-100])
         cube([base_length*2,base_width*2,base_height+100]);
       }
    }

//Clip angle top end to keep end shell piece
module end_snip()
    {
    translate([base_length+shell_thickness+.1,-base_width/2,base_height-shell_thickness*2])
        cube([base_length,base_width*3,ttop_height+shell_thickness*2+tan(angle_top_slope)*angletop_length]);    
    }

//create a keypad along with button layout 
module keypad()
     {
  
      keyrow_distance=keypad_length/(keyrows);
      keycolumn_distance=keypad_width/(keycolumns);
      keysize= keypad_length/(keyrows+3);  
      color("darkslategray") 
      cube([keypad_length+6,keypad_width+6,1]);
      color("darkslategray")   
      translate([3,3,0])
         cube([keypad_length,keypad_width,keypad_height]);
      translate([(-keyrow_distance/2)-2,(-keycolumn_distance/2)-2,1])
            for (i= [1:keyrows],j= [1:keycolumns])
            {
            color("blue")     
            translate ([keyrow_distance*i,keycolumn_distance*j,0])
                 cube([keysize,keysize,keypad_height]);
           if(print_part=="None")
              {
             if(j==1)
                {
                color("RED") 

                translate ([(keyrow_distance*i)+4,(keycolumn_distance*j)+5,keypad_height-.9])
                  rotate([0,0,270])
                      linear_extrude(1) 
                        text(keytext[i*j], font = "Liberation Sans", size=2,halign="center");   
                }
            else 
                {
                color("yellow") 
  
                translate ([(keyrow_distance*i)+4,(keycolumn_distance*j)+5,keypad_height-.9])
                  rotate([0,0,270])
                      linear_extrude(1)   
                        text(keytext[i+keyrows*(j-1)], font = "Liberation Sans", size=2,halign="center");   
                }
              }
           } 
     }
     
 //create the LCD part    
module LCD()
    {
    color("darkgreen")    
        cube ([LCD_olength,LCD_owidth,LCD_oheight]);
    color("yellowgreen")
        translate([(LCD_olength-LCD_length)/2,(LCD_owidth-LCD_width)/2,LCD_oheight]) 
    cube([LCD_length,LCD_width,LCD_height]);

//add screw mounts to LCD top
    color("silver")
    {
      translate([LCD_screw/2+1,LCD_screw/2+1,LCD_oheight])
          rotate([0,0,90])
             cylinder(h=LCD_height, d=LCD_screw,$fn=50);
      translate([LCD_olength-LCD_screw/2-1,LCD_owidth-LCD_screw/2-1,LCD_oheight])
          rotate([0,0,90])
              cylinder(h=LCD_height, d=LCD_screw,$fn=50);
      translate([LCD_olength-LCD_screw/2-1,LCD_screw/2+1,LCD_oheight])
          rotate([0,0,90])
             cylinder(h=LCD_height, d=LCD_screw,$fn=50);
      translate([LCD_screw/2+1,LCD_owidth-LCD_screw/2-1,LCD_oheight])
          rotate([0,0,90])
              cylinder(h=LCD_height, d=LCD_screw,$fn=50);        
      }

//add text to display
 if(print_part=="None")
    {
     color("darkslategray")
        {
     translate([(LCD_olength-LCD_length)/2+20,LCD_owidth/2,LCD_oheight+LCD_height-.9])
        rotate([0,0,270])
                                linear_extrude(1)   
            text(LCDline1txt,font="Advanced LED Board\\-7:style=Regular",halign="center",size=4);
     translate([(LCD_olength-LCD_length)/2+14,LCD_owidth/2,LCD_oheight+LCD_height-.94])
        rotate([0,0,270])
                                linear_extrude(1)   
            text(LCDline2txt,font="Advanced LED Board\\-7:style=Regular",halign="center",size=4);
     translate([(LCD_olength-LCD_length)/2+8,LCD_owidth/2,LCD_oheight+LCD_height-.9])
        rotate([0,0,270])
                                linear_extrude(1)   
            text(LCDline3txt,font="Advanced LED Board\\-7:style=Regular",halign="center",size=4); 
     translate([(LCD_olength-LCD_length)/2+2,LCD_owidth/2,LCD_oheight+LCD_height-.9])
        rotate([0,0,270])
                                linear_extrude(1)   
            text(LCDline4txt,font="Advanced LED Board\\-7:style=Regular",halign="center",size=4);            
        }
      }
    }

//create the viewhole for the USB 5 volt power supply and battery charger
module charger()
     {
     color("blue")    
     cube([charger_olength,charger_owidth,charger_oheight]);    
     translate([charger_olength-1,charger_owidth/2-5,charger_oheight-9])
        cube([12,10,7]);
     color("lightgray")
     translate([3,21.5,0])    
        cube ([charger_dlength,charger_dwidth,charger_dheight]);
   if(print_part=="None")
    {
       color("black")  
     translate([charger_dlength/2,charger_dwidth/2+21.5,charger_dheight-.8])
         rotate([0,0,270])
           linear_extrude(1)   
            text("89%",font="Digital\\-7:style=Italic",halign="center",size=7);
    }
     }
 //create the power switch
module power()
    {
    color("black")    
    cube ([power_length,power_width,power_height]);
    color("red")
    translate([power_length/2,2,power_height-4])
      rotate([0,-10,0])
        cube([power_length/2,power_width-4,4]);
    }
  
//Create a battery pack    
module battery()
    {
    color("black")    
    cube([battery_plength,battery_pwidth,battery_pheight]);
    color("mediumpurple")
    for (i=[1:4])
        {
         translate([(battery_plength-battery_length)/2,((battery_pwidth-(4*battery_diameter))/5)+(i*(battery_diameter+1.2))-battery_diameter/2,battery_diameter/2])
             rotate ([0,90,0])
                cylinder(d=battery_diameter,h=battery_length);
        }
    }    
    
