/*******************************************************
 Solar Charge Box ver 2.0 Customizer Version.         
 by Chris Payne cpayne3d revised Jan 1, 2017         
                                                     
 License                                             
 Creative commons share alike license Non-Commercial 
                                                     
 All parts of this project are not to be resold and  
 has been created for the benefit of all Humanity.                                                        
 This project is a low power storage box to be       
 combined with a low power solar panel (eg: 25-80W)
 and will charge USB devices and 12V devices         
 and also run a 12V DC-AC inverter.                  
 This project can store enough power to cause        
 harm, so please follow the wiring diagram and      
 practice caution, and install all rocker switches   
 as suggested in the instructions.                   
*******************************************************/

/* 
 Update: Jan 3, 2017
 
 Cleaned up the top face section borders.
 Cleaned up positioning for pre-built switches.
 Cleaned up positioning of USB and DC port parts.
 Cleaned up positioning of circuit breakers.
 Added customizable round switch option.
 Added slider for vertical positioning of USB and DC accessory parts.
 Improved range of positioning for user customized switches.
 Set all customized switches to ORANGE colour for ease of identification.
 Fixed customized switch centering so that they rotate correctly.


 Update: Jan 1, 2017

 This is a new Customizer version of my Solar Charge Box design.
 Note the following changes:

 - User now selects from several pre-built switches. Commonly found on Amazon.com and Amazon.ca and Walmart auto departents, & common PC power supply swiches.
 
 - Also included is a *NEW* Customizable switch. Each switch location in the model can contain a Customized switch. Simply use the slider bars. Customized Switch can also be rotated 90,180,210,360 degrees. After changing Rotation, the switch will require repositioning using the Position slider bars.
 
 - User can select from 2 different output parts (Marine USB, Marine DC plug), commonly found on Amazon.com and Amazon.ca. The size is common to parts found online.
 
 - circuit breakers are found in old APC UPS battery backup devices, or online.
 
 - User can select between VIEW modes: 
    - Design PREVIEW Mode: See the solar charge box with renderred switch parts
    - DESIGN VIEW Mode: See the solar charge box in BLIND parts mode.(faster)
    - PRINT READY Mode: See the correctly inverted solar charge box ready to SAVE or EXPORT for printing.
    ** Be sure to change to PRINT READY Mode prior to saving your project!
 
Important:
 Review the PDF files included with this project to locate parts, and wiring info.
 The MAIN battery switch ONLY disconnects power from all output devices.
 The MAIN battery switch should be in the OFF position when power is not required.
 The PV (panel) switch disconnects the panel and charge controller from the battery.
 The PV (Panel) switch should be in the OFF position when not charging the battery.
 The PV panel will charge the battery when the PV switch is in the ON position. 
 The MAIN battery switch WILL NOT prevent PV panel from charging the battery. These are
 two separate curcuits.
 The MAIN battery and PV switches should be in the OFF position when battery is not in use.
 PV switch MUST be in the OFF position before disconnecting or connecting a PV panel.
 The maximum draw from the battery is limited to 10A in the original wiring diagram.
*/

//use <write.scad>
use <write/Write.scad>
case_wid = 127+0; 
case_len = 127+0; 

// preview[view:south, tilt:top]

// Toggle Model View. Choose Print-Ready before saving. 
OUTPUT = 5; //[5:Case & parts view, 0:Case - Design view, 1:Case - Print Ready, 2:Pre-built Switches]

/* [Master Battery Switch] */
// Select the battery switch type
battery_switch = 3; //[2: +Customizable Rectangle Sw, 6: +Customizable Round Sw, 1:Big Switch (29.25 x 26.5), 3:Round Switch (20.7mm), 4:Power Supply Switch (19.75 x 13.5), 5:Automotive Rocker (29 x 13.5)] 

// Customized Round switch Diameter
Custom_Batt_Round_Switch = 20; //[6:32]  

// Customized switch LENGTH
Custom_Batt_Switch_Length = 29.5; //[10:40]  
battgenswllen = Custom_Batt_Switch_Length;

// Customized switch WIDTH
Custom_Batt_Switch_Width = 22;    //[5:40]   
battgenswwid = Custom_Batt_Switch_Width;

// Customized switch ROTATION.
Custom_Batt_Rotation = 0; //[0:90:360]

// Customized  switch Horizontal Position
Custom_Batt_Horiz_Pos = 98; //[40:120]

// Customized switch Vertical Position
Custom_Batt_Vert_Pos = 104; //[40:140]

/* [PV Solar Switch] */
// Select the Solar input switch type
pv_array_switch = 3; //[2: +Customizable Rectangle Sw, 6: +Customizable Round Sw, 1:Big Switch (29.25 x 26.5), 3:Round Switch (20.7mm), 4:Power Supply Switch (19.75 x 13.5), 5:Automotive Rocker (29 x 13.5)]

/*//[1:Big Switch, 2:Customizable Rectangle Sw, 6:Customizable Round Sw, 3:Round Switch, 4:Power Supply Switch, 5:Automotive Rocker]  */

// Customized switch LENGTH
Custom_PV_Switch_Length = 24; //[10:40]  
pvgenswllen = Custom_PV_Switch_Length;

// Customized Round switch Diameter
Custom_PV_Round_Switch = 20; //[6:32] 

// Customized switch WIDTH
Custom_PV_Switch_Width = 22;    //[5:40]   
pvgenswwid = Custom_PV_Switch_Width;

// Customized switch ROTATION.
Custom_PV_Rotation = 0; //[0:90:360]

// Customized switch Horizontal Position
Custom_PV_Horiz_Pos = 24; //[2:80]

// Customized switch Vertical Position
Custom_PV_Vert_Pos = 104; //[40:120]

/* [Part 1 Switch] */
// Select Part1 device type
part1 = 6; //[6:USB ports, 7:DC port or Round Volt meter]

// Adjust Vertical Alignment of Part1
Part1_Vert_Position = 28; //[20:2:60]

// Select the Part1 switch type
part1_switch = 3; //[2: +Customizable Rectangle Sw, 6: +Customizable Round Sw, 1:Big Switch (29.25 x 26.5), 3:Round Switch (20.7mm), 4:Power Supply Switch (19.75 x 13.5), 5:Automotive Rocker (29 x 13.5)]

// Customized Round switch Diameter
Custom_Pt1_Round_Switch = 20; //[6:32] 

// Customized switch LENGTH
Custom_Pt1_Switch_Length = 29.5; //[10:40]  
pt1genswllen = Custom_Pt1_Switch_Length;

// Customized switch WIDTH
Custom_Pt1_Switch_Width = 22;    //[5:40]   
pt1genswwid = Custom_Pt1_Switch_Width;

// Customized switch ROTATION.
Custom_Pt1_Rotation = 90; //[0:90:360]

// Customized switch Horizontal Position
Custom_Pt1_Horiz_Pos = 92; //[40:100]

// Customized switch Vertical Position
Custom_Pt1_Vert_Pos = 64; //[20:140]


/* [Part2 Switch] */
// Select Part2 device type
part2 = 7; //[6:USB ports, 7:DC port Or Volt meter]

// Adjust Vertical Alignment of Part2
Part2_Vert_Position = 28; //[20:2:60]

// Select the Part2 switch type
part2_switch = 4; //[2: +Customizable Rectangle Sw, 6: +Customizable Round Sw, 1:Big Switch (29.25 x 26.5), 3:Round Switch (20.7mm), 4:Power Supply Switch (19.75 x 13.5), 5:Automotive Rocker (29 x 13.5)]

// Customized Round switch Diameter
Custom_Pt2_Round_Switch = 20; //[6:32] 

// Customized switch LENGTH
Custom_Pt2_Switch_Length = 29.5; //[10:40]  
pt2genswllen = Custom_Pt2_Switch_Length;

// Customized switch WIDTH
Custom_Pt2_Switch_Width = 22;    //[5:40]   
pt2genswwid = Custom_Pt2_Switch_Width;

// Customized switch ROTATION.
Custom_Pt2_Rotation = 90; //[0:90:360]

// Customized switch Horizontal Position
Custom_Pt2_Horiz_Pos = 32; //[5:100]

// Customized switch Vertical Position
Custom_Pt2_Vert_Pos = 64; //[5:100]


if (OUTPUT == 5) {
translate([case_len, 0, 0]) rotate([0, 0, 90]) 
union() {   
  translate([0, 0, 0]) rotate([0, 0, 0]) partlayout();       // design view unrotated
    translate([130, 122, 90]) rotate([0, 0, -90]) write("Design Preview Mode",t=4,h=7);
    }
} // end if 5

if (OUTPUT == 0) {
translate([case_len, 0, 0]) rotate([0, 0, 90]) union() { 
  translate([0, 0, 0]) rotate([0, 0, 0]) partlayout();       // design view unrotated
   translate([130, 122, 90]) rotate([0, 0, -90]) write("Design View Mode",t=4,h=7);
  }
}


if (OUTPUT == 1) {
translate([case_len, 0, 0]) union() { 
  translate([0, 0, 88]) rotate([0, 180, 0]) partlayout();       // print ready assembled object
  }
}

if (OUTPUT == 2) {
    /* Text output */
    translate([6, 135, 40]) write("Parts View Mode",t=4,h=15);

    /* parts */
   translate([10, 10, 0]) bigswitch(1);       // big RED battery switch
   translate([20, 60, 0]) rswitch(1);         // round switch - round rocker switch - Amazon.ca
   translate([10, 85, 0]) ps_switch(1);     // small black PC power supply switch
   translate([10, 115, 0]) auto_rect_rocker(1); // rectangular auto rocker
 
   translate([155, 120, 0]) fuse(1);            // 10A-15A UPS circuit breaker
   translate([155, 70, 0]) marine_dcplug(1);    // marine DC plug
   translate([155, 20, 0]) marine_usb(1);         // marine in dash dual usb port - amazon.ca
 }  /* end if 2 */



/* assembled finished part - main module  */
module partlayout() {
      
difference() {
// primary body
union() {
  translate([0, 0, 90-4]) case_top(2.5, 1);  // draw the box top plate
   translate([0, 0, 0]) case_top(90-4, 0);  // add the case walls
       
   if (OUTPUT == 5) 
    {
     add_the_parts();
    } // end if
    
} // end union    
 
    
// diff section
union() {
  if ( (OUTPUT == 0) || ( OUTPUT == 1) || ( OUTPUT == 2) ){  
    add_the_parts();
  } // end if

  translate([109, -1, 4])  cube([12, 136, 6]);  // cut out wire holes for solar charger & battery wires
 
 // battery border
   translate([(case_len +40) /2, (case_wid -6) /2, 87.5]) lborder(40, case_wid /2, 2);   // battery section border 
  //  translate([84, 58, 87.5]) lborder(40, 65, 2);   // battery section border 
 
 // PV border
   translate([(case_len +40) /2, 1, 87.5]) lborder(40, case_wid /2 -2, 2);   // solar section border 
//   //   translate([84, 3, 87.5]) lborder(40, 53, 2);   // solar section border 

 // Part1 border
 translate([2, (case_wid -6) /2 , 87.5]) lborder(80, case_wid /2 , 2);   // Part1 section border 
  // translate([6, 61, 87.5]) lborder(77, 54, 2);    // Part1 section border
  
 // Part2 border
 translate([2, 2, 87.5]) lborder(80, case_wid /2 -3, 2);   // Part2  // translate([6, 6, 87.5]) lborder(77, 50, 2);     // Part2 section border 
 
  }  // end diff union
 } // end diff
} // end module - parts layout
  
  
  
module add_the_parts() {  

union() {
/////// MAIN Battery switch  &  Battery breaker fuse   
if (battery_switch == 1)
  {
   translate([89, 89, 73]) bigswitch();
  }
else 
if (battery_switch == 2)
  {
  translate([Custom_Batt_Vert_Pos, Custom_Batt_Horiz_Pos, 63]) rotate([0, 0, Custom_Batt_Rotation]) generic_rocker(0, battgenswllen, battgenswwid ); 
  }
  else
if (battery_switch == 3)
  {  
  translate([104, 100, 72]) rswitch();    
  }
  else
if (battery_switch == 4)
  {
  translate([96, 95, 79]) ps_switch();
  }
  else
if (battery_switch == 5)
  {
  translate([90, 94, 69]) auto_rect_rocker();
  }
  else
 if(battery_switch == 6)
 {
 translate([Custom_Batt_Vert_Pos, Custom_Batt_Horiz_Pos, 72]) generic_round(Custom_Batt_Round_Switch /2);
 }     
 
 // battery circuit breaker 
   translate([105, 74, 60]) fuse();      // batt main fuse
    
// Solar PV switch  & Solar PV breaker fuse    
  if (pv_array_switch == 1)
  {
   translate([90, 6, 73]) bigswitch();
  }
else 
if (pv_array_switch == 2)
  {
  translate([Custom_PV_Vert_Pos, Custom_PV_Horiz_Pos, 63]) rotate([0, 0, Custom_PV_Rotation]) generic_rocker(0, pvgenswllen ,pvgenswwid); 
  }
  else
if (pv_array_switch == 3)
  {  
  translate([104, 20, 72]) rswitch();    
  }
  else
if (pv_array_switch == 4)
  {
  translate([96, 15, 79]) ps_switch();
  }
  else
if (pv_array_switch == 5)
  {
  translate([90, 15, 69]) auto_rect_rocker();
  }
 else
 if(pv_array_switch == 6)
 {
 translate([Custom_PV_Vert_Pos, Custom_PV_Horiz_Pos, 72]) generic_round(Custom_PV_Round_Switch /2);
 }  
 
  // pv circuit breaker 
   translate([105, 49, 60]) fuse();      // PV fuse
      
/////// Part2 - 12V dc port  &  12V dc switch    
 if (part2_switch == 1)
  {
   translate([50, 20, 73]) bigswitch();
  }
else 
if (part2_switch == 2)
  {
  translate([Custom_Pt2_Vert_Pos, Custom_Pt2_Horiz_Pos, 63]) rotate([0, 0, Custom_Pt2_Rotation]) generic_rocker(0, pt2genswllen ,pt2genswwid); 
  }
  else
if (part2_switch == 3)
  {  
  translate([65, 32, 72]) rswitch();    
  }
  else
if (part2_switch == 4)
  {
  translate([54, 25, 79]) ps_switch();
  }
  else
if (part2_switch == 5)
  {
  translate([65, 32, 69]) auto_rect_rocker();
  }
else
 if(part2_switch == 6)
 {
 translate([Custom_Pt2_Vert_Pos, Custom_Pt2_Horiz_Pos, 72]) generic_round(Custom_Pt2_Round_Switch /2);
 }  
 

 if (part2 == 6)
 {
  translate([Part2_Vert_Position, 32, 53])  marine_usb(0);
 //ranslate([28, 32, 53])  marine_usb(0);
  }
 else
 if (part2 == 7)
 {
     translate([Part2_Vert_Position, 32, 55]) marine_dcplug(0); 
 }
 else
   translate([Part2_Vert_Position, 32, 55]) marine_dcplug(0);        // 12v marine port


// PART1 - USB port  &  USB switch
if (part1_switch == 1)
  {
   translate([48, 78, 73]) bigswitch();
  }
else 
if (part1_switch == 2)
  {
  translate([Custom_Pt1_Vert_Pos, Custom_Pt1_Horiz_Pos, 63]) rotate([0, 0, Custom_Pt1_Rotation]) generic_rocker(0, pt1genswllen ,pt1genswwid); 

  }
  else
if (part1_switch == 3)
  {  
  translate([65, 92, 72]) rswitch();    
  }
  else
if (part1_switch == 4)
  {
  translate([54, 85, 79]) ps_switch();
  }
  else
if (part1_switch == 5)
  {
  translate([48, 84, 70]) auto_rect_rocker();
  } 
else
 if(part1_switch == 6)
 {
 translate([Custom_Pt1_Vert_Pos, Custom_Pt1_Horiz_Pos, 72]) generic_round(Custom_Pt1_Round_Switch /2);
 }  


  
if (part1 == 6)
 {
  translate([Part1_Vert_Position, 91, 55])  marine_usb(0);
 }
 else
 if (part1 == 7)
 {
     translate([Part1_Vert_Position, 91, 53]) marine_dcplug(0); 
 }
 else
  translate([Part1_Vert_Position, 91, 55]) marine_usb(0);    // marine usb port  
} // end union   
    
} // end module


////////////////////////////////
// big red switch - square battery switch
module bigswitch(includetext) {
  swllen = 29.25;
  swwid = 26.5;
  sw_z =  18.5;
  swtoplen = 31.5;
  swtopwid = 29.4 ;
  union() { 
   color("BLUE") cube([swllen, swwid, sw_z]) ;  // sw cube
    
   translate([-(swtoplen - swllen) /2, -(swtopwid - swwid) /2, sw_z -2]) color("BLUE") cube([swtoplen, swtopwid, 2]) ;  // sw top lip
    
   translate([2, 2, sw_z]) rotate([0, 8, 0]) color("RED") cube([swllen - 4, swwid -4, 4]) ;  // sw red switch
    
  if (includetext == 1) {
    
 /* add text to the cover plate. Nice to have things labeled. */
 translate([swllen +8, 3, 0]) write("Bigswitch",t=4,h=8);
 translate([swllen +8, 15, 0]) write("29mm x 26.5mm",t=4,h=6);

 } // end if        
} // end union  
} // end module


////////////////////////
// switch - round - Amazon.ca round rocker with LED
module rswitch(includetext) {
cyl_dia = 20.7 / 2;
cyl_h = 17.25; 
    
union() {    
 color("BLUE") cylinder(h=cyl_h, r=cyl_dia, $fn=30); // switch body

 translate([0, 0, 17]) color("BLUE") cylinder(h=2, r1=cyl_dia,r1=22.85 /2, $fn=30); // switch body shoulder

 translate([0, 0, 17.7]) rotate([0, 8, 0]) color("RED") cylinder(h=1.5, r=cyl_dia - 2, $fn=30); // switch button
 
  translate([-1, -(23 / 2 ) , 5]) color("LIGHTBLUE") cube([2.5, 23, 12]); // key way
   
 if (includetext == 1) {
    
 /* add text to the cover plate. Nice to have things labeled. */
 translate([cyl_dia + 8, -5, 0]) write("Round Switch",t=4,h=8);
 translate([cyl_dia + 8, 5, 0]) write("20.5mm",t=4,h=6);
 } // end if      
  } // end union

}  // end module



/////////////////////
// fuse breaker - 10 / 12 amp  - from APC UPS
module fuse(includetext) {
 fuse_d = 10.85 /2;
 fuselen = 14;
 fusewid = 29.5;
 fusez = 23;
  
 union() {   
 translate([0, 0, fusez]) color("RED") cylinder(h=9.81, r= fuse_d); // reset threads

 translate([0, 0, fusez]) color("BLACK") cylinder(h=10.5, r= fuse_d-0.5); // reset button
 
    translate([0, 0, fusez]) color("ORANGE") cylinder(h=2.4, r=13 /2); // reset shoulder
    
 translate([-fusewid / 2, -fuselen /2, 0]) color("BLUE") cube([fusewid, fuselen, fusez ]);   
     
 if (includetext == 1) {
    
 // add text to the cover plate. Nice to have things labeled.
 translate([fuselen + 8, -5, 0]) write("Breaker",t=4,h=8);
 translate([fuselen + 7, 7, 0]) write("10.8mm diameter",t=4,h=6);
 } // end if      
 } // end union
} // end module


//////////////////////////////
// entire case top plate 
// if solid = 1, then draw a solid plate with parts holes
// if solid = 0, then draw perimeter only
// cyl_h = thickness of top plate
module case_top(cyl_h, solid) {
    diam=5;
    if (solid == 1) {
 union() {       
   hull() {
    translate([diam /2, diam /2, 0]) cylinder(h=cyl_h, r=diam/2, $fn=20);    // 0, 0, 0
    translate([case_len - (diam /2), diam /2, 0]) cylinder(h=cyl_h, r=diam/2, $fn=20);    // +, 0, 0
    translate([case_len - (diam /2), case_wid - (diam /2), 0]) cylinder(h=cyl_h, r=diam/2, $fn=20);    // +, +, 0
    translate([diam /2, case_wid - (diam /2), 0]) cylinder(h=cyl_h, r=diam/2, $fn=20);    // 0, +, 0
    } // end hull    
} // end union
} // end if solid == 1

else
{
 
 union() {
    hull() {
    translate([diam /2, diam /2, 0]) cylinder(h=cyl_h, r=diam/2, $fn=20);    // 0, 0, 0
    translate([case_len - (diam /2), diam /2, 0]) cylinder(h=cyl_h, r=diam/2, $fn=20);    // +, 0, 0
    } // end hull
    
    hull() {
    translate([case_len - (diam /2), diam /2, 0]) cylinder(h=cyl_h, r=diam/2, $fn=20);    // +, 0, 0
 
    translate([case_len - (diam /2), case_wid - (diam /2), 0]) cylinder(h=cyl_h, r=diam/2, $fn=20);    // +, +, 0
} // end hull

hull() {
    translate([case_len - (diam /2), case_wid - (diam /2), 0]) cylinder(h=cyl_h, r=diam/2, $fn=20);    // +, +, 0

    translate([diam /2, case_wid - (diam /2), 0]) cylinder(h=cyl_h, r=diam/2, $fn=20);    // 0, +, 0
} // end hull

hull() {
    translate([diam /2, case_wid - (diam /2), 0]) cylinder(h=cyl_h, r=diam/2, $fn=20);    // 0, +, 0

   translate([diam /2, diam /2, 0]) cylinder(h=cyl_h, r=diam/2, $fn=20);    // 0, 0, 0
  } // end hull
  } // end union
}  // end else
}  // end module


/////////////////////////////////
// create outline around parts
/////////////////////////////////
module lborder(xx, yy, ythick) {

difference() {
 cube([xx, yy, ythick]);
 translate([2, 2, -1]) cube([xx-4, yy-4, ythick+2]); 
 }
   
}// end module



///////////////////////////
// PowerSupply switch - black rectangle switch from PC power supply
module ps_switch(includetext) {
pvswlen = 19.75;
pvswwid = 13.5;    
pvz = 10;    
union() {   
color("BLACK") cube([pvswlen, pvswwid, pvz]);   // switch body
color("BLACK") translate([-0.75, -0.75,pvz]) cube([pvswlen+1.5, pvswwid+1.5, 1]);    // switch top cap
 translate([1.25, 1.25,pvz]) color("GREEN") rotate([0, 4, 0]) cube([pvswlen -3, pvswwid -3, 4]);    // switch top cap


if (includetext == 1) {
    
 // add text to the cover plate. Nice to have things labeled.
 translate([pvswlen + 8, 0, 0]) write("Power Supply Sw",t=4,h=8);
 translate([pvswlen + 8, 12, 0]) write("19.75mm x 13.5mm",t=4,h=8);

 } // end if
} // end union 
} // end module


/////////////////////////////////////
// marine USB - screw-in style. - Amazon.ca
// this is a round marine grade USB device with perimeter threads and a nut
// the device contains 2 usb ports with a rubber snap on cover. @ Amazon.ca
/////////////////////////////////////
module marine_usb(includetext) {
marinediam= 29.5  /2;    // diameter of marin USB device
marine_h = 38;          // height of marine USB device
marine_trim_wid = 26;   // trimmed width of marine USB - flat sides

bigdiam = 36.75  /2;    // top lip diameter
topthick=2.5;           // top lip thickness    
terminal_h = 9.7;       // heigth of terminal connectors
terminal_wid = 6.3;     // width of terminal connectors
  
difference() {    
union() {  
  color("GREY") cylinder(h=marine_h, r=marinediam, $fn=50);  // main body
  translate([marinediam /3, -terminal_wid /2, -terminal_h]) cube([.75, terminal_wid, 9.7]);   //positive lead    

  translate([ -marinediam /3, -terminal_wid /2, -terminal_h]) cube([.75, terminal_wid, 9.7]);   //negative lead    

  translate([0, 0, marine_h]) 
    color("GREY") cylinder(h=topthick, r=bigdiam, $fn=50);  // marineusb shoulder

  translate([-marinediam +4, 0, marine_h + topthick ])  color("LightBlue")
    sphere(2, $fn=50);  // usb led light

if (includetext == 1) {
    
 // add text to the cover plate. Nice to have things labeled.
 translate([marinediam + 8, -5, 0]) write("Dual USB",t=4,h=8);
 translate([marinediam + 8, 7, 0]) write("29mm diameter",t=4,h=8);

 } // end if
} // end union

union() {
  rotate(90) translate([marine_trim_wid /2, -marine_trim_wid /2, -0.25]) cube([10, marinediam *2, marine_h +0.25]); // trim x++ side flat on cylinder 

  rotate(90) translate([-(marine_trim_wid /2 +10), -marine_trim_wid /2, -0.25]) cube([10, marinediam *2, marine_h +0.25]); // trim x-- side flat on cylinder 
 
   // draw USB inner connectors 
 difference() { // local difference
  translate([-((marinediam )  -(12.6/2) -2), 1, marine_h - 9 + topthick])  
    cube([12.6, 5.2, 10.2]); // top usbhole  
  translate([-((marinediam )  -(12.6/2) -2) +1, 1.5, marine_h - 9 + topthick -2])  // usb inner terminal
    cube([12.6 - 2, 5.2 - 3, 10.2]); // top usbhole  
  }
  
 // draw USB inner connectors
difference() { // local difference
  translate([-((marinediam )  -(12.6/2) -2), -7, marine_h - 9 + topthick])  
    cube([12.6, 5.2, 10.2]); // bottom usbhole  
  translate([-((marinediam )  -(12.6/2) -2) +1, -6.5, marine_h - 9 + topthick -2])  // usb inner terminal
    cube([12.6 - 2, 5.2 - 3, 10.2]); // top usbhole  
  }
   
  } // end diff union
 } // end difference
      
} // end module - marine usb


//////////////////////////////
// automotive rectangle rocker switch - walmart rocker
module auto_rect_rocker(includetext) {
baselen = 29;        // length of switch base
basewid = 13.5;      // width of switch base
baseh = 20.83;       // base height 
toplen = 31.5;
topwid = 18.5;
topthick = 1.6;

union() {
 color("BLACK") cube([baselen, basewid, baseh]);    // base of switch
 color("BLACK") translate([-(toplen - baselen) /2,- (topwid - basewid) /2, baseh -1])
  cube([toplen, topwid, topthick]);   // top of switch   

if (includetext == 1) {
    
 // add text to the cover plate. Nice to have things labeled.
 translate([baselen + 8, 0, 0]) write("Auto Rocker",t=4,h=8);
 translate([baselen + 8, 12, 0]) write("29mm x 13.5mm",t=4,h=8);
}


difference() {
 color("RED") translate([14, 1, 20]) rotate([270, 0, 0]) cylinder(h=9.9, r=12.5, $fn=50); // switch rocker    
 color("ORANGE") translate([-2, 0.5, 25]) rotate([0, 5, 0]) 
    cube([29,11, 10]);  // switch top trim 
 } // localdiff
} // end union
} // end module



///////////////////////
// Marine DC plug  - Amaon.ca
///////////////////////
module marine_dcplug(includetext) {
diam = 29.5      /2;     // diameter of threaded marine DC plug insert
innerdiam = 20.2 /2;     // inner diameter of jack
height = 41;             // height of dc jack
shortsides = ((diam*2) - 2.75)   /2;   // diameter of short flat edges
terminal_h = 9.7;       // heigth of terminal connectors
terminal_wid = 6.3;     // width of terminal connectors
    
    
difference() {    
color("GREY") union() {
cylinder(h=height, r=diam, $fn=100);  // outer shell
translate([0, 0, height -1]) cylinder(h=1.2, r1=33/2, r2=38/2, $fn=100);  // top ring
 
  translate([diam /3, -terminal_wid /2, -terminal_h]) cube([.75, terminal_wid, 9.7]);   //positive lead    

  translate([ -diam /3, -terminal_wid /2, -terminal_h]) cube([.75, terminal_wid, 9.7]);   //negative lead    
   

  if (includetext == 1) {
 // add text to the cover plate. Nice to have things labeled.
 translate([diam + 10, -5, 0]) write("DC port",t=4,h=8);
 translate([diam + 10, 7, 0]) write("29.5mm diameter",t=4,h=8);
 } // end if   
} // end union


// diff section
union() {
    
translate([0, 0, 35]) cylinder(h=height , r=innerdiam, $fn=100);  // inner cutout
 

translate([shortsides, -diam, -1]) cube([diam *0.25, diam *2, height]); // x++ flat side cut    

translate([(-diam*2) -shortsides, -diam, -1]) cube([diam *2, diam *2, height]); // x-- flat side cut    

 } // end diff union
} // end diff
} // end module 


////////////////////////////////
// Custom generic rocker switch - define your own size!
module generic_rocker(includetext, len, wid) {
  sw_z =  28;        // switch body height
  swtoplen = len +2;   // switch top length
  swtopwid = wid + 2 ;  // switch top width
  
translate([-(len /2), -(wid /2), 0])    
  union() { 
   color("GREY") cube([len, wid, sw_z]) ;  // sw cube
    
   translate([-(swtoplen - len) /2, -(swtopwid - wid) /2, sw_z -2]) color("GREY") cube([swtoplen, swtopwid, 2]) ;  // sw top lip
    
   translate([2, 2, sw_z]) rotate([0, 8, 0]) color("ORANGE") cube([len - 4, wid -4, 4]) ;  // switch
    
  if (includetext == 1) {
    
 // add text to the cover plate. Nice to have things labeled.
 translate([len + 8, 0, 0]) write("Generic Rocker",t=4,h=8);
 translate([len + 8, 12, 0]) write("29.5 x 22mm",t=4,h=8);

  } // end if        
} // end union  
} // end module


////////////////////////////////
// Custom generic round rocker switch - define your own size!
module generic_round(sw_rad) {   
 union() {    
  translate([0, 0, 2]) color("GREY") cylinder(h=15, r=sw_rad, $fn=sw_rad *2); // switch body

 translate([0, 0, 17]) color("GREY") cylinder(h=1.5, r1=sw_rad +1,r2=sw_rad -2, $fn=30, center=true); // switch body shoulder

 translate([0, 0, 18]) rotate([0, 8, 0]) color("ORANGE") cylinder(h=2, r=sw_rad - 2, $fn=30, center=true); // switch button
 
   } // end union
    
} // end module
