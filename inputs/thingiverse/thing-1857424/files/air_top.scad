//
// Air Top
//

//Number of Blades
N_Blades = 3;         // default "3"
//Wing Span
Span   = 40 ;         //default "40"
//Angle of Attack
Alpha  = 20;          // default "20"
//Blade Cord (Width)
Cord   = 9.5;         // default "9.5"

//Handle Length
L_Handle   = 13;      // default "13"
//Handle Diameter
D_handle   = 2.6;     // default "2.6"



/* [Hidden] */
/////////////////////////////////
$fn=50;
//Thickness of Blades
t_blade = 0.6;         // default "0.6"
//Handle Thickness
t_handle   = 0.45;     // default ".45"
//Radius of Thick part of blade
Rthick = 8.3;          // default "8.3"
//Radius of Blade Corners
r_tip  = 1.5;          // default "1.5"
nblades = max(2,floor(N_Blades));
//Cord and blade tip
eCord = Cord;          // default "same as Cord"
//Add A Hoop
AddHoop=false;         // ["Yes":true,"No":false]
t_hoop = 0.8;
h_hoop = 1.3;

dp=(D_handle-t_blade*sin(Alpha));

/////////////////////////////////
/// Start Creating the Model  ///
/////////////////////////////////
difference()
{
    union()
    {
        difference()
        {
            union()
            {
                blades();
                cylinder (d=D_handle,h=L_Handle);
            }
            cylinder (d=D_handle-t_handle*2,h=3*L_Handle,center=true);
        }
        translate([0,0,L_Handle]) sphere (d=D_handle);
        
        if (AddHoop) //Add hoop around blades
        {
            difference()
            {
                cylinder (d=Span+t_hoop,h=h_hoop);
                cylinder (d=Span-t_hoop,h=L_Handle*2,center=true);
            }
        }
    }
    cylinder(d=2*Span,h=.25);
}

//////////////////////////////////////////////
// Module to create a full set of blades   ///
// using the single blade module           ///
//////////////////////////////////////////////
module blades()
{
    single_blade();
    for (n=[1:nblades])
    {
        echo(n);
        rotate ([0,0,360/nblades*n]) single_blade();
    }
}

/////////////////////////////////////
// Module to create a single blade //
/////////////////////////////////////
module single_blade()
{
  translate([0,0,D_handle/2*sin(Alpha)+ t_blade/2*cos(Alpha) ])
  {
    rotate([Alpha,0,0])
    {
      hull()
      {
        translate([0,0,0]) 
            cylinder(d=dp,h=t_blade,center=true);
        translate([ Span/2/2 ,Cord/2-D_handle/2,0]) 
            cylinder(d=Cord,h=t_blade ,center=true );
        translate([ Rthick ,Cord/2-D_handle/2+(eCord/2-r_tip),0]) 
            cylinder(r=r_tip,h=t_blade ,center=true );
          
        translate([Span/2-r_tip, eCord/2-D_handle/2+(eCord/2-r_tip) ,0])
            cylinder(r=r_tip,h=t_blade ,center=true );
        translate([Span/2-r_tip, eCord/2-D_handle/2-(eCord/2-r_tip) ,0])
            cylinder(r=r_tip,h=t_blade ,center=true );
      }
    }
  }   
}
