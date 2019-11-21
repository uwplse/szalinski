$fn=36;
Bracelet_circumference=80;
Bracelet_radius=3;        
Text_radius=6;
Scale_text_height=0.6;
Scale_text_width=0.2;
Text_x_offset=0;
Text_y_offset=0;
Text_z_offset=-2;
Text_height=Text_radius*4;
Flare_text=1;
Text="What goes around comes around";
Font="Dancing Script";
Font_size=Text_radius*2;
Wire_hole_radius=0.5;

difference()
   {
union()
{
   
      hull()
            {
                translate([Bracelet_circumference/2,0,0])
                 rotate([0,0,0])
                  sphere(r=Bracelet_radius,center=true);

               translate([-Bracelet_circumference/2,0,0])
                 rotate([0,0,0])
                  sphere(r=Bracelet_radius,center=true);

                }    

intersection()
{
      translate([0,0,Text_z_offset])
      hull()
            {
                translate([Bracelet_circumference/2,0,0])
                 rotate([0,0,0])
                  sphere(r=Text_radius,center=true);

               translate([-Bracelet_circumference/2,0,0])
                 rotate([0,0,0])
                  sphere(r=Text_radius,center=true);
                }    
   
    scale([Scale_text_width,Scale_text_height,1])    
    translate([Text_x_offset,Text_y_offset,-Text_height/2+Text_z_offset])
     linear_extrude(height=Text_height,scale=Flare_text)
       text(Text,font=Font,valign="center",halign="center",size=Font_size);

      }

   }
translate([0,0,-Bracelet_radius*5])
   cube([Bracelet_circumference*2,Text_radius*4,Bracelet_radius*10],center=true);

translate([0,Bracelet_radius/2,Bracelet_radius/2])
rotate([0,90,0])
cylinder(r=Wire_hole_radius,h=Bracelet_circumference*2,center=true);
translate([0,-Bracelet_radius/2,Bracelet_radius/2])
rotate([0,90,0])
cylinder(r=Wire_hole_radius,h=Bracelet_circumference*2,center=true);
}