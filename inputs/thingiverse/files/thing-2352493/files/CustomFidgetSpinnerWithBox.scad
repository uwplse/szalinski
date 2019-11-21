// ***************************************************************************
// Custom fidget spinner with box by Eirik Solheim
// Twitter, youtube, instagram etc: @eirikso
// http://eirikso.com
//
// Yes, this code can be used as an outstanding example of how NOT to code!
// ....but it works.
//
// Box based on the much better code from 
// Faber Unserzeit's "Customizable round box with threaded lid"
// ***************************************************************************

use <write/Write.scad>

// Which one would you like to see?
part = "first"; // [first:Spinner,second:Center,third:Box,fourth:Lid]

// Diameter of the center bearing
main_bearing_diameter = 22; // [1:0.1:30]

// Diameter of the center hole of the center bearing
main_bearing_center   = 8; // [1:0.1:20]

// The thickness of the center bearing
main_bearing_depth    = 7; // [1:0.1:30]

// Do you want the weights to be round or hex?
w_form = 1; // [1:Round,0:Hex]

// Diameter of the weight if round
w_diameter = 22; // [1:0.1:30]

// Size of the weight if hexnut. See description for how to measure
w_size = 8; // [1:0.1:30]

// Thickness of the weight
w_depth  = 7; // [1:0.1:30]

// Text on spinner (set to blank for none)
Label = "SPINNER" ;

// Text on box (set to blank for none)
BoxText = "SPINNER BOX";

// Thickness of the body around the center bearing
body = 5; // [2:1:20]

// Thickness of the body around the weight
w_body = 5; // [2:1:20]

// How many weights?
amount = 3; // [2:1:20]

// How rounded edges?
chamfer = 2; // [1:1:10]

// Extra room for the bearings (0.17 gives a tight fit on my LulzBot)
slack = 0.17; // [0:0.01:1]

// Extra thickness of the center pin to make the center pads fit tighter
ct = 0.05; // [0:0.01:1]

/* [Hidden] */
detail = 60;  // Variable for detail of cylinder and square. High number = high detail
w_distance = main_bearing_diameter/2+w_diameter/2+body+w_body-2-chamfer;
w_hexdistance = main_bearing_diameter/2+(w_size/sin(60))/2+body+w_body-2-chamfer;
// w_shape = 6;

print_part();

module print_part() {
	if (part == "first") {
		spinner();
	} else if (part == "second") {
		center();
	} else if (part == "third") {
		Dose();
    }  else if (part == "fourth") {
        Deckel();
    }  else {
        spinner();
	}
}

module spinner() {
difference() {

  // ******
  // Solids
  // ******  
  union(){
    
  if (main_bearing_depth >= w_depth) {
    translate([0,0,0]) { // Move the next solids to this coordinates. x,y,z   
      rcylinder(main_bearing_diameter/2+body,main_bearing_diameter/2+body,main_bearing_depth,chamfer,true,$fn=detail);
    } // End translate
    
    if (w_form == 1) {
    for (space =[0:360/amount:360]) { // For loop from 10 with intervals of 20 all the way up ro 60
      rotate([0,0,space]) {
        translate([w_distance,0,0]) {
          rcylinder(w_diameter/2+w_body,w_diameter/2+w_body,main_bearing_depth,chamfer,true,$fn=detail);
            
        } // End translate
      } // End rotate       
    } // End for space
    } // End if w_form
    
      if (w_form == 0) {
          w_diameter = (w_size/sin(60));
    for (space =[0:360/amount:360]) { // For loop from 10 with intervals of 20 all the way up ro 60
      rotate([0,0,space]) {
        translate([w_hexdistance,0,0]) {
          rcylinder(w_diameter/2+w_body,w_diameter/2+w_body,main_bearing_depth,chamfer,true,$fn=detail);
            
        } // End translate
      } // End rotate       
    } // End for space
    } // End if w_form
    
   } // End if main > w
   
   if (w_depth > main_bearing_depth) {
    translate([0,0,0]) { // Move the next solids to this coordinates. x,y,z   
      rcylinder(main_bearing_diameter/2+body,main_bearing_diameter/2+body,w_depth,chamfer,true,$fn=detail);
    } // End translate
    
    if (w_form == 1) {
    for (space =[0:360/amount:360]) { // For loop from 10 with intervals of 20 all the way up ro 60
      rotate([0,0,space]) {
        translate([w_distance,0,0]) {
          rcylinder(w_diameter/2+w_body,w_diameter/2+w_body,w_depth,chamfer,true,$fn=detail);
        } // End translate
      } // End translate       
    } // End for space
    }
    
     if (w_form == 0) {
        w_diameter = (w_size/sin(60));
    for (space =[0:360/amount:360]) { // For loop from 10 with intervals of 20 all the way up ro 60
      rotate([0,0,space]) {
        translate([w_hexdistance,0,0]) {
          rcylinder(w_diameter/2+w_body,w_diameter/2+w_body,w_depth,chamfer,true,$fn=detail);
        } // End translate
      } // End translate       
    } // End for space
    }
    
   } // End if main > w
    
  } // End union Solids


  // *********
  // Subtracts
  // *********  
  union(){
    
    if (main_bearing_depth >= w_depth) {
      translate([0,0,(-main_bearing_depth/2)-1]) {
        cylinder(d1=main_bearing_diameter+slack,d2=main_bearing_diameter+slack,h=main_bearing_depth+20,$fn=detail); 
        // d1 = bottom diameter, d2 = top diameter
      }
  
    if (w_form == 1) { 
      for (space =[0:360/amount:360]) { // For loop from 10 with intervals of 20 all the way up ro 60
      rotate([0,0,space]) {
        translate([w_distance,0,(main_bearing_depth/2)-w_depth-slack]) {
          cylinder(d1=w_diameter+slack,d2=w_diameter+slack,h=w_depth+20,$fn=60);
            } // End translate
          translate([w_distance,0,0]) {
          rotate([0,0,90]) {
            writecylinder(Label,[0,0.5,0],w_diameter/2+w_body,t=1,h=main_bearing_depth*0.8-chamfer*0.7);
          }
          }
    }
    }
    }
    
    if (w_form == 0) { 
         w_diameter = (w_size/sin(60));
      for (space =[0:360/amount:360]) { // For loop from 10 with intervals of 20 all the way up ro 60
      rotate([0,0,space]) {
        translate([w_hexdistance,0,(main_bearing_depth/2)-w_depth-slack]) {
          cylinder(d1=w_diameter+slack,d2=w_diameter+slack,h=w_depth+20,$fn=6);
           } // End translate 
            
             translate([w_hexdistance,0,0]) {
          rotate([0,0,90]) {
          writecylinder(Label,[0,0.5,0],w_diameter/2+w_body,t=1,h=main_bearing_depth*0.8-chamfer*0.7);
     
        
    }
    }
    }
    }
    }
    
    } // End if m > W
    
    if (w_depth > main_bearing_depth) {
      translate([0,0,(w_depth/2)-main_bearing_depth-slack]) {
        cylinder(d1=main_bearing_diameter+slack,d2=main_bearing_diameter+slack,h=main_bearing_depth+10,$fn=detail); 
        // d1 = bottom diameter, d2 = top diameter
      }
  
      
      if (w_form == 1) { 
      
      for (space =[0:360/amount:360]) { // For loop from 10 with intervals of 20 all the way up ro 60
      rotate([0,0,space]) {
        translate([w_distance,0,(-w_depth/2)]) {
          cylinder(d1=w_diameter+slack,d2=w_diameter+slack,h=w_depth+1,$fn=60); 
        } // End translate
        
         translate([w_distance,0,0]) {
          rotate([0,0,90]) {
          writecylinder(Label,[0,0.5,0],w_diameter/2+w_body,t=1,h=w_depth*0.8-chamfer*0.7);
          }
          }
        
      } // End translate       
    } // End for space
    }
    
       if (w_form == 0) { 
      w_diameter = (w_size/sin(60));
      for (space =[0:360/amount:360]) { // For loop from 10 with intervals of 20 all the way up ro 60
      rotate([0,0,space]) {
        translate([w_hexdistance,0,(-w_depth/2)]) {
          cylinder(d1=w_diameter+slack,d2=w_diameter+slack,h=w_depth+1,$fn=6); 
        } // End translate
        
         translate([w_hexdistance,0,0]) {
          rotate([0,0,90]) {
          writecylinder(Label,[0,0.5,0],w_diameter/2+w_body,t=1,h=w_depth*0.8-chamfer*0.7);
          }
          }
        
      } // End translate       
    } // End for space
    }
   
    } // End if m > W
   
   translate([0,0,-30]) {
     cylinder(d1=main_bearing_diameter-2,d2=main_bearing_diameter-2,h=60,$fn=detail); 
   }
   
     if (w_form == 1) { 
       for (space =[0:360/amount:360]) { 
      rotate([0,0,space]) {
        translate([w_distance,0,-30]) {
          cylinder(d1=w_diameter-3,d2=w_diameter-3,h=60,$fn=detail); 
        } // End translate
      } // End translate       
    } // End for space
    }
    
       if (w_form == 0) { 
           w_diameter = (w_size/sin(60));
       for (space =[0:360/amount:360]) { 
      rotate([0,0,space]) {
        translate([w_hexdistance,0,-30]) {
          cylinder(d1=w_diameter-3,d2=w_diameter-3,h=60,$fn=detail); 
        } // End translate
      } // End translate       
    } // End for space
    }
  
  } // End union subtracts

} // End difference

} // End Moduel Spinner



module center() {


// Center #1

// **********
// Center
// **********

difference() {
// Center Solids
union(){
    
    translate([0,0,0]) {
          rcylinder((main_bearing_diameter/2)+3,(main_bearing_diameter/2)+3,2,1,true,$fn=detail);
        } // End translate
    translate([0,0,2.5]) {
          rcylinder((main_bearing_center/2)+ct,(main_bearing_center/2)+ct,(main_bearing_depth/2)+1,1,true,$fn=detail);
        } // End translate
    
    translate([0,0,1]) {
          cylinder(d1=main_bearing_center+2,d2=main_bearing_center+2,h=1,$fn=detail);
        }
    }
    
// Center Subtracts
union(){
    
    
      translate([0,0,1]) {
          cylinder(d1=main_bearing_center-4.5,d2=main_bearing_center-4.5,h=main_bearing_depth,$fn=detail);
        }
        
        translate([-5,-0.25,1]) {
        cube([10,0.5,10],false);
            }
            
         translate([-0.25,-5,1]) {
        cube([0.5,10,10],false);
            }
    }
    } // End difference
    
   
   
    // Center #2

// **********
// Center
// **********

difference() {
// Center Solids
union(){
    
    translate([40,0,0]) {
          rcylinder((main_bearing_diameter/2)+3,(main_bearing_diameter/2)+3,2,1,true,$fn=detail);
        } // End translate
    translate([40,0,2.5]) {
          rcylinder((main_bearing_center/2)+ct,(main_bearing_center/2)+ct,(main_bearing_depth/2)+1,1,true,$fn=detail);
        } // End translate
    
    translate([40,0,1]) {
          cylinder(d1=main_bearing_center+2,d2=main_bearing_center+2,h=1,$fn=detail);
        }
        
    if (w_depth > main_bearing_depth) {
    
    translate([40,0,0]) {
          rcylinder((main_bearing_diameter/2)+3,(main_bearing_diameter/2)+3,2,1,true,$fn=detail);
        } // End translate
    translate([40,0,3+(w_depth-main_bearing_depth)]) {
          rcylinder((main_bearing_center/2)+ct,(main_bearing_center/2)+ct,(main_bearing_depth/2)+0.5+(w_depth-main_bearing_depth),1,true,$fn=detail);
        } // End translate
    
    translate([40,0,1]) {
          cylinder(d1=main_bearing_center+2,d2=main_bearing_center+2,h=1+(w_depth-main_bearing_depth),$fn=detail);
        }  
    
    }
        
    }
    
// Center Subtracts
union(){
    
    
      translate([40,0,1]) {
          cylinder(d1=main_bearing_center-4.5,d2=main_bearing_center-4.5,h=main_bearing_depth+10,$fn=detail);
        }
        
        translate([35,-0.25,1]) {
        cube([10,0.5,10],false);
            }
            
         translate([39.75,-5,1]) {
        cube([0.5,10,10],false);
            }
    
            }
            
    } // End difference
    
    
    
    } // End Module Center
    

// This next part of the code is an edited version of Faber Unserzeit's "Customizable round box with threaded lid"  https://www.thingiverse.com/thing:1648580
// Thanks to Faber Unserzeit for making this model and sharing it with a Creative Commons - Attribution license.

/* [Hidden] */

/* Geometry */
// The inner height in mm
Inner_Height = main_bearing_depth+8;
// The thickness
Thickness = 2;
// The inner width in mm

// the height of the thread
Thread_Height = 7;
// Turns of thread
thread_turns = 3;
// Cut away a bit of the thread to make it blunt and easier going. How much (in percent) shall be cut away?
cut_thread_percent = 10;
// true makes the base for the thread of the can wider to fit the lid
smooth_sides = 1; // [0:no, 1:yes]

/* [Printing] */
// Only set this to no if you want to see both parts together
layout_to_print = 1; // [0:no, 1:yes]
// Only set this to true if you want to have a sectioned view
view_sectioned = 0; // [0:no, 1:yes]
// It is recommended to print the parts seperately. Which part do you want to print
part_to_print = 0; // [0:all, 1:can, 2:cap]

/* Resolution and Tolerance */
// resolution of roundings in steps/360°
fn = 128; // [8,16,32,64,128,256]
// space between moving Parts, printer dependent
wackel = 0.5;

/* [Hidden] */
Hoehe_Rand = 0;
Durchmesser_Rand = 30;

tol = 0.05;
thread_thicknes = ((Thread_Height/thread_turns)/2); // *(100-cut_tread_percent)/100;
Windungshoehe = Thread_Height / thread_turns;

cut_mittelhoehe = thread_thicknes*cut_thread_percent/100;
cut_breite = thread_thicknes*(100-cut_thread_percent)/100;

module Dose()
{
if (w_form == 1) { 
    Inner_Width = 2*(main_bearing_diameter/2+body+w_body+w_diameter+w_body-2-chamfer+Thickness);
	difference()
	{
		union()
		{
			cylinder(r = Inner_Width / 2 + Thickness, h = Inner_Height + Thickness, $fn=fn);
			translate([0,0,Inner_Height + Thickness - Thread_Height - Windungshoehe/2])
				screw_extrude
				(
					P = (cut_thread_percent > 0) 
					?
						[
							[-tol,thread_thicknes-tol],
							[cut_breite,cut_mittelhoehe],
							[cut_breite,-cut_mittelhoehe],
							[-tol,-(thread_thicknes-tol)]	
						]
					:
						[
							[-tol,thread_thicknes-tol],
							[thread_thicknes,0],
							[-tol,-(thread_thicknes-tol)]	
						],
					r = Inner_Width / 2 + Thickness,
					p = Windungshoehe,
					d = 360 * (thread_turns + 0),
					sr = 0,
					er = 45,
					fn = fn
				);

			translate([0,0,Inner_Height/2-Thread_Height/2+Thickness/2])
			{
            difference()
                { 
				cylinder(r=Inner_Width/2+thread_thicknes+Thickness + ((smooth_sides!=0) ? Thickness : 0), h=Inner_Height- Thread_Height+Thickness, center=true, $fn=fn);
    
    rotate([0,0,90])   {             
    translate([0,0,1+Inner_Height/2-Thread_Height/2-((Inner_Height+Thickness-Thread_Height)/3)/2])    
  writecylinder(BoxText,[0,0,-(Inner_Height+Thickness-Thread_Height)/3],Inner_Width/2+thread_thicknes+Thickness + ((smooth_sides!=0) ? Thickness : 0),0,t=2, h=(Inner_Height+Thickness-Thread_Height)/2, center=true, $fn=fn);              
       }         
      }
				
			}
		}
		// Innenraum:
        
        union()
		{
		//translate([0,0,Thickness])
		translate([0,0,(main_bearing_depth*3)/2+Thickness]) { // Move the next solids to this coordinates. x,y,z   
      rcylinder(main_bearing_diameter/2+body+2,main_bearing_diameter/2+body+2,main_bearing_depth*3,chamfer,true,$fn=detail);
    } // End translate       
    
    for (space =[0:360/amount:360]) { // For loop from 10 with intervals of 20 all the way up ro 60
      rotate([0,0,space]) {
        translate([w_distance,0,(main_bearing_depth*3)/2+Thickness+3.5]) {
          rcylinder(w_diameter/2+w_body+0.8,w_diameter/2+w_body+0.8,main_bearing_depth*3,chamfer,true,$fn=detail);
            
        } // End translate
      
    } // End for space	
    } // End translate
      }
      
        //cylinder(r=Inner_Width / 2, h=Inner_Height + tol, $fn=fn);
		// Platz für den Dosenrand:
		translate([0,0,Thickness + Inner_Height - Hoehe_Rand])
			cylinder(r = Durchmesser_Rand/2, h=Hoehe_Rand + tol, $fn=fn);
		// Überstehendes Gewinde abschneiden:
		translate([0,0,Inner_Height+Thickness-tol])
			cylinder(r=Inner_Width+Thickness*2+thread_thicknes*2+tol, h=Windungshoehe*2+tol);
		/*
		*/
	}
} // End if w_form = 1

if (w_form == 0) { 
    w_diameter = (w_size/sin(60));
    Inner_Width =  2*(main_bearing_diameter/2+body+w_body+w_diameter+w_body-2-chamfer+Thickness);
	difference()
	{
		union()
		{
			cylinder(r = Inner_Width / 2 + Thickness, h = Inner_Height + Thickness, $fn=fn);
			translate([0,0,Inner_Height + Thickness - Thread_Height - Windungshoehe/2])
				screw_extrude
				(
					P = (cut_thread_percent > 0) 
					?
						[
							[-tol,thread_thicknes-tol],
							[cut_breite,cut_mittelhoehe],
							[cut_breite,-cut_mittelhoehe],
							[-tol,-(thread_thicknes-tol)]	
						]
					:
						[
							[-tol,thread_thicknes-tol],
							[thread_thicknes,0],
							[-tol,-(thread_thicknes-tol)]	
						],
					r = Inner_Width / 2 + Thickness,
					p = Windungshoehe,
					d = 360 * (thread_turns + 0),
					sr = 0,
					er = 45,
					fn = fn
				);

			translate([0,0,Inner_Height/2-Thread_Height/2+Thickness/2])
			{
            difference()
                { 
				cylinder(r=Inner_Width/2+thread_thicknes+Thickness + ((smooth_sides!=0) ? Thickness : 0), h=Inner_Height- Thread_Height+Thickness, center=true, $fn=fn);
    
    rotate([0,0,90])   {             
    translate([0,0,1+Inner_Height/2-Thread_Height/2-((Inner_Height+Thickness-Thread_Height)/3)/2])    
  writecylinder(BoxText,[0,0,-(Inner_Height+Thickness-Thread_Height)/3],Inner_Width/2+thread_thicknes+Thickness + ((smooth_sides!=0) ? Thickness : 0),0,t=2, h=(Inner_Height+Thickness-Thread_Height)/2, center=true, $fn=fn);              
       }         
      }
				
			}
		}
		// Innenraum:
        
        union()
		{
		//translate([0,0,Thickness])
		translate([0,0,(main_bearing_depth*3)/2+Thickness]) { // Move the next solids to this coordinates. x,y,z   
      rcylinder(main_bearing_diameter/2+body+2,main_bearing_diameter/2+body+2,main_bearing_depth*3,chamfer,true,$fn=detail);
    } // End translate       
    
    for (space =[0:360/amount:360]) { // For loop from 10 with intervals of 20 all the way up ro 60
      rotate([0,0,space]) {
        translate([w_hexdistance,0,(main_bearing_depth*3)/2+Thickness+3.5]) {
          rcylinder(w_diameter/2+w_body+0.8,w_diameter/2+w_body+0.8,main_bearing_depth*3,chamfer,true,$fn=detail);
            
        } // End translate
      
    } // End for space	
    } // End translate
      }
      
        //cylinder(r=Inner_Width / 2, h=Inner_Height + tol, $fn=fn);
		// Platz für den Dosenrand:
		translate([0,0,Thickness + Inner_Height - Hoehe_Rand])
			cylinder(r = Durchmesser_Rand/2, h=Hoehe_Rand + tol, $fn=fn);
		// Überstehendes Gewinde abschneiden:
		translate([0,0,Inner_Height+Thickness-tol])
			cylinder(r=Inner_Width+Thickness*2+thread_thicknes*2+tol, h=Windungshoehe*2+tol);
		/*
		*/
	}
} // End if w_form = 0
}

module Deckel()
{
if (w_form == 1) {
    Inner_Width = 2*(main_bearing_diameter/2+body+w_body+w_diameter+w_body-2-chamfer+Thickness);
	difference()
	{
		cylinder(r = Inner_Width/2 + thread_thicknes + Thickness+Thickness, h = Thread_Height + Thickness, $fn=fn);
		translate([0,0,Thickness])
			cylinder(r=Inner_Width / 2 + Thickness + thread_thicknes + wackel, h= Thread_Height + tol, $fn=fn);
	}
	difference()
	{
		translate([0,0, Thickness - Windungshoehe/2])
		{	
			screw_extrude
			(
				P = (cut_thread_percent > 0) 
				?
					[
						[tol*2,-(thread_thicknes-tol)],
						[-cut_breite,-cut_mittelhoehe],
						[-cut_breite, cut_mittelhoehe],
						[tol*2,thread_thicknes-tol]
					]
				:
					[
						[tol,-(thread_thicknes-tol)],
						[-thread_thicknes,0],
						[tol,thread_thicknes-tol]
					]
				,
				r = Inner_Width / 2 + Thickness + thread_thicknes + wackel,
				p = Windungshoehe,
				d = 360 * (thread_turns + 0),
				sr = 0,
				er = 45,
				fn = fn
			);
		}
		translate([0,0,Thread_Height + Thickness])
			cylinder(r=Inner_Width+Thickness*2+thread_thicknes+tol, h=Windungshoehe+tol);
		rotate([180,0,0])
			translate([0,0,-tol])
			cylinder(r=Inner_Width+Thickness*2+thread_thicknes+tol, h=Windungshoehe+tol);
	}
} // End if w_form == 1

if (w_form == 0) {
    w_diameter = (w_size/sin(60));
    Inner_Width = 2*(main_bearing_diameter/2+body+w_body+w_diameter+w_body-2-chamfer+Thickness);
	difference()
	{
		cylinder(r = Inner_Width/2 + thread_thicknes + Thickness+Thickness, h = Thread_Height + Thickness, $fn=fn);
		translate([0,0,Thickness])
			cylinder(r=Inner_Width / 2 + Thickness + thread_thicknes + wackel, h= Thread_Height + tol, $fn=fn);
	}
	difference()
	{
		translate([0,0, Thickness - Windungshoehe/2])
		{	
			screw_extrude
			(
				P = (cut_thread_percent > 0) 
				?
					[
						[tol*2,-(thread_thicknes-tol)],
						[-cut_breite,-cut_mittelhoehe],
						[-cut_breite, cut_mittelhoehe],
						[tol*2,thread_thicknes-tol]
					]
				:
					[
						[tol,-(thread_thicknes-tol)],
						[-thread_thicknes,0],
						[tol,thread_thicknes-tol]
					]
				,
				r = Inner_Width / 2 + Thickness + thread_thicknes + wackel,
				p = Windungshoehe,
				d = 360 * (thread_turns + 0),
				sr = 0,
				er = 45,
				fn = fn
			);
		}
		translate([0,0,Thread_Height + Thickness])
			cylinder(r=Inner_Width+Thickness*2+thread_thicknes+tol, h=Windungshoehe+tol);
		rotate([180,0,0])
			translate([0,0,-tol])
			cylinder(r=Inner_Width+Thickness*2+thread_thicknes+tol, h=Windungshoehe+tol);
	}
} // End if w_form == 0

} 



/**
 * screw_extrude(P, r, p, d, sr, er, fn)
	by Philipp Klostermann
	
	screw_rotate rotates polygon P 
	with the radius r 
	with increasing height by p mm per turn 
	with a rotation angle of d degrees
	with a starting-ramp of sr degrees length
	with an ending-ramp of er degrees length
	in fn steps per turn.
	
	the points of P must be defined in clockwise direction looking from the outside.
	r must be bigger than the smallest negative X-coordinate in P.
	sr+er <= d
**/

module screw_extrude(P, r, p, d, sr, er, fn)
{
	anz_pt = len(P);
	steps = round(d * fn / 360);
	mm_per_deg = p / 360;
	points_per_side = len(P);
	echo ("steps: ", steps, " mm_per_deg: ", mm_per_deg);
	
	VL = [ [ r, 0, 0] ];
	PL = [ for (i=[0:1:anz_pt-1]) [ 0, 1+i,1+((i+1)%anz_pt)] ];
	V = [
		for(n=[1:1:steps-1])
			let 
			(
				w1 = n * d / steps,
				h1 = mm_per_deg * w1,
				s1 = sin(w1),
				c1 = cos(w1),
				faktor = (w1 < sr)
				?
					(w1 / sr)
				:
					(
						(w1 > (d - er))
						?
							1 - ((w1-(d-er)) / er)
						:
							1
					)
			)
			for (pt=P)
			[
				r * c1 + pt[0] * c1 * faktor, 
				r * s1 + pt[0] * s1 * faktor, 
				h1 + pt[1] * faktor 
			]
	];
	P1 = [
		for(n=[0:1:steps-3])
			for (i=[0:1:anz_pt-1]) 
			[
				1+(n*anz_pt)+i,
				1+(n*anz_pt)+anz_pt+i,
				1+(n*anz_pt)+anz_pt+(i+1)%anz_pt
			] 
			
		
	];
	P2 = 
	[
		for(n=[0:1:steps-3])
			 for (i=[0:1:anz_pt-1]) 
				[
					1+(n*anz_pt)+i,
					1+(n*anz_pt)+anz_pt+(i+1)%anz_pt,
					1+(n*anz_pt)+(i+1)%anz_pt,
				] 
			
		
	];

	VR = [ [ r * cos(d), r * sin(d), mm_per_deg * d ] ];
	PR = 
	[
		for (i=[0:1:anz_pt-1]) 
		[
			1+(steps-1)*anz_pt,
			1+(steps-2)*anz_pt+((i+1)%anz_pt),
			1+(steps-2)*anz_pt+i
		]
	];
			
	VG=concat(VL,V,VR);
	PG=concat(PL,P1,P2,PR);
	convex = round(d/45)+4;
	echo ("convexity = round(d/180)+4 = ", convex);
	polyhedron(VG,PG,convexity = convex);
}










  module rcylinder(r1=10,r2=10,h=10,b=2)
{translate([0,0,-h/2]) hull(){rotate_extrude() translate([r1-b,b,0]) circle(r = b); rotate_extrude() translate([r2-b, h-b, 0]) circle(r = b);}}
