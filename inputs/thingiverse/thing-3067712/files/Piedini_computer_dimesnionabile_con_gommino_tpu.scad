$fn=36;
//Radius and height of the plug that have to fit in the screw hole
radius_top=4;
h_top=7;
//Radius and height of the central body
radius_middle_top=6;
h_middle_top=7;
//Radius of the bottom middle part of the body
radius_middle_bottom=12;
h_middle_bottom=2;
//Radius of the foot
radius_bottom=15;
h_bottom=5;
//Radius hole   0 to disable - This is to fit a TPU insert to extend the foot or to have something softer in contact with the table.
radius_hole=4;
//TPU extension  0 to render foot     1 to render TPU insert
Render_insert=0;
TPU_bottom_radius=radius_bottom;
TPU_bottom_thickness=1;
TPU_insert=radius_hole;

if(Render_insert==0)
difference()
{
   union()
   {
      hull()
      {
      cylinder(r=radius_bottom,h=h_bottom);
      cylinder(r=radius_middle_bottom,h=h_bottom+h_middle_bottom);
      }
      cylinder(r=radius_middle_top,h=h_bottom+h_middle_bottom+h_middle_top);
      cylinder(r=radius_top,h=h_bottom+h_middle_bottom+h_middle_top+h_top);
      cylinder(r=radius_top,h=h_bottom+h_middle_bottom+h_middle_top+h_top);
   }

cylinder(r=radius_hole,h=10);
}

if(Render_insert==1)
{
cylinder(r=TPU_bottom_radius,h=TPU_bottom_thickness);
cylinder(r=radius_hole,h=TPU_bottom_thickness+5);
}