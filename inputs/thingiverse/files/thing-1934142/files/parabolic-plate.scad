// Created by Andrew Moore 2016
//  For questions, please PM me on Thingiverse
//  www.thingiverse.com/TacPar
//
//  Builds a parabolic plate 
//  according to the formula:
//         y= kx^2
//
//  Where the focal length is 1/(4*k)
//   
//
//  This code is designed for 
//  ease of use, not for computational
//  efficiency. You must be patient 
//  when rendering!
//=============================

//to do: 
//      Add text label for parabola parameters
//      Add base with indicator of focal point

//=============================
//Global Constants: 
//  Don't change these. It will break the code.
//=============================
inch = 25.4;

//=============================
//Compiler Options: 
//These will change your viewing options in OpenSCAD
//=============================
$fn = 30;          

//=============================
//Global Print Variables:
//  These variables will adjust how the part is printed 
//  but not affect the overall part shape
//=============================
numfaces = 50; //this adjusts how smooth the parabolic shape will be

//=============================
//Global Mechanical Variables: 
//  Change these to adjust physical properties of the part
//=============================
Plate_Width = 4*inch;
Plate_Height = 3*inch;
Plate_Thickness = 3/16*inch;
focal_length = 1*inch;


//==============================
//Calculated Variables: 
//Do not Change these directly
//==============================
k=1/(4*focal_length);

module main()
{
    //add global logic and call part modules here
    difference()
    {
        hull()
        {
            parabolic_dish();
        }
        translate([0,Plate_Thickness, -0.01]) scale([1,1,1.1]) hull()
        {
            parabolic_dish();
        }    
    }
        
}

module parabolic_dish()
{
   
   difference()
   {
		positives();
		negatives();
    }    
   module positives()
   {
        for(i=[0:numfaces/2])
        {
            xi = i*Plate_Width/numfaces; 
            yi = k*(xi*xi);
       
            translate([xi,yi,0]) 
                cylinder(r=Plate_Thickness/2, h=Plate_Height);
                
            translate([-xi,yi,0]) 
                cylinder(r=Plate_Thickness/2, h=Plate_Height);
        } 
   }
    module negatives()
   {
       //Use this section to put holes in the part
       //for example: mounting holes, etc.
   }   
}

//execute program and draw the part(s)
main();