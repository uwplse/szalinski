/* [Parameters] */
// .     All Dimensions are in MM 
Belt_Slot_Width = 2.1   ;
//.  
Belt_Slot_Depth = 1.1 ;
// .
Number_Of_Belts = 1 ;
// .     Pulley Diameter (at inside of belt)
Pulley_Diameter = 20.1;
// .     (Thickness of Pulley)
Pulley_Height = 12.1;
// .   
Axel_Diameter=3.1;
//.     Use Hub Height = 0 for no hub.
Hub_Height=12.1;
// .
Hub_Diameter=15.1;

// . 
Number_of_Attachment_Screws = "One";  // [None, One, Two, Three, Four]
// .    Size of Attachment Screw Hole(s)
Screw_Hole_Diameter=3.1;
// .    Do you want a nut trap?
Nut_Shape = "Hex"; //[No nut trap, Square, Hex]
// .     Width of nut (across the flats -- wrench size)
Nut_Width =5.5;
// .     
Nut_Thickness=2.25;
// .     Distance from outside of axel hole to inside face of nut
Nut_Spacing=2.1;


/* [Hidden] */
$fn=100;
Pulley_Radius = Pulley_Diameter/2;
 Spacing = Pulley_Height/(Number_Of_Belts + 1);
       echo ("Spacing -- ", Spacing);

/*  Pulley Construction Modules */

    function Pulley_Outside_Diameter() =
        Pulley_Diameter + (2 * Belt_Slot_Depth);

    module  PulleyCreator() {
            cylinder(d=Pulley_Outside_Diameter(), h=Pulley_Height,  center=false);
        }
        
    module EachBeltGroove() 
        {   
        translate([(
            (Pulley_Diameter/2)), 0, 0])
        color("blue")
polygon(points=[[0,Belt_Slot_Width/2], [Belt_Slot_Depth +0.1, Belt_Slot_Width/2], [Belt_Slot_Depth +0.1, -Belt_Slot_Width/2], [0, -Belt_Slot_Width/2], [0,Belt_Slot_Width/2]]);
 /*           polygon(points=[[0,-Belt_Slot_Width/2], [2*Belt_Slot_Width,-2*Belt_Slot_Width], [2*Belt_Slot_Width,2*Belt_Slot_Width], [0,Belt_Slot_Width/2]]);
            */
       }
       
  module BeltGroovesKnockout()  
        {
            for (Count=[1:1:Number_Of_Belts])
                translate ([0,Count * Spacing,0])  
                    EachBeltGroove();
        }
                    
 module BeltGrooves()
        {
           color("lightgreen")
            rotate_extrude(convexity = 10, $fn = 100)
            BeltGroovesKnockout();
        }

// Hub Creation Module 
    module HubCreator()
    {
    translate([0, 0, Pulley_Height- 0.01]) cylinder(r = Hub_Diameter/2, h = Hub_Height, center = false);
    }

// Axel Hole Creation Module
    module AxelHole()
    translate ([0,0, -0.1 * (Pulley_Height + Hub_Height)])
    cylinder(r=Axel_Diameter/2,h = 1.2 * (Pulley_Height + Hub_Height))
    ;

// Nut Trap Creation Modules
    
     module NutTrapBody()
       translate([0, -Nut_Width/2,0])
       color("Green") {
        cube([Pulley_Diameter, Nut_Width, Nut_Thickness]);
       }

    module NutTrapTip()
        
      if (Nut_Shape == "Square")
        {
            {
            translate([-Nut_Width/2, -Nut_Width/2,0])
            cube([Nut_Width/2,Nut_Width,Nut_Thickness]);}
            }
       else
          {
              cylinder(d=(2*Nut_Width/sqrt(3)), h=1.1*Nut_Thickness, center=false, $fn=6);
              }
           
    module NutTrapSlug()
       if (Nut_Shape != "No nut trap")
         {  
         rotate([0,270 ,180])
             translate([ScrewHoleElevation(), 0, (Axel_Diameter/2) +Nut_Spacing])
          union()
            { 
             NutTrapBody(Pulley_Diameter, Nut_Width, Nut_Thickness,Nut_Shape); 
             NutTrapTip(Nut_Shape, Nut_Width, Nut_Thickness);
            }
        }
 // Screw Hole Creation Module     
    module ScrewHole()
        rotate([0,90,0])
        translate ([-ScrewHoleElevation(), 0, 0])
        cylinder( d=Screw_Hole_Diameter, 
            h = 1.1* (Pulley_Diameter + Hub_Diameter)/2);
        
    function ScrewHoleElevation()=
        (
        Hub_Height > 0 ?
        Pulley_Height + Hub_Height/2
       :    
        Pulley_Height/2
        );


// Position the designated number of Screw Holes and Nut Traps
    
        module ScrewAndNutTrapKnockout()
        {if (Number_of_Attachment_Screws == "One")
            {NutTrapSlug();
            ScrewHole();}
        if (Number_of_Attachment_Screws == "Two")
            {NutTrapSlug();
            ScrewHole();
              rotate([0,0,90])
                {NutTrapSlug();
                ScrewHole();
                } 
            }
            if (Number_of_Attachment_Screws == "Three")
            {NutTrapSlug();
            ScrewHole();
              rotate([0,0,120])
                {NutTrapSlug();
                ScrewHole();
                } 
                rotate([0,0,240])
                {NutTrapSlug();
                ScrewHole();
                } 
            }
            if (Number_of_Attachment_Screws == "Four")
                {NutTrapSlug();
                ScrewHole();
                  rotate([0,0,90])
                    {NutTrapSlug();
                    ScrewHole();}
                    rotate([0,0,180])
                    {NutTrapSlug();
                    ScrewHole();}
                   rotate([0,0,270])
                    {NutTrapSlug();
                    ScrewHole(); } 
            } 
            else
            ;
        }
   
// Assemble the components

difference()
   {
       union()
     {PulleyCreator();
            HubCreator();}
        
        BeltGrooves();
        ScrewAndNutTrapKnockout();       
        AxelHole();
         
    }
    
 
   
   







