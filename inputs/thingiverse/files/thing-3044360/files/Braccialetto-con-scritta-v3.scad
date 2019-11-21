/*[General settings]*/
$fn=36; //([36:36:36*5])
Bracelet_length=160;
Bracelet_width=14;      
Bracelet_thickness=3;  
Text_thickness=16;
//Scale text height
Scale_text_height=0.4;//[0.05:0.05:3]
//Scale text length
Scale_text_width=0.4;//[0.05:0.05:3]
//Move text along bracelet length
Text_x_offset=0;//[0:0.25:15]
//Move text across
Text_y_offset=0;//[0:0.25:15]
//Add flaring to the text, positive values makes text bigger at top side
Flare_text=1; //[1:0.05:3]
Text="What goes around comes around";
Font="Pacifico";
Font_size=Bracelet_width;
//Radius of the holes for inner wire
Wire_hole_radius=0.65;//[0:0.1:3]

difference()
   {
union()
{
   
      cube([Bracelet_length,Bracelet_thickness,Bracelet_width],center=true);
      translate([Bracelet_length/2,0,0])
      rotate([90,0,0])
      cylinder(r=Bracelet_width/2,h=Bracelet_thickness,center=true);
      translate([-Bracelet_length/2,0,0])
      rotate([90,0,0])
      cylinder(r=Bracelet_width/2,h=Bracelet_thickness,center=true);


   
    scale([Scale_text_width,Scale_text_height,1])    
    translate([Text_x_offset,Text_y_offset,-Bracelet_width/2])
     linear_extrude(height=Text_thickness,scale=Flare_text)
       text(Text,font=Font,valign="center",halign="center",size=Font_size);

      

   }

translate([0,0,Bracelet_width/3])
rotate([0,90,0])
cylinder(r=Wire_hole_radius,h=Bracelet_length*2,center=true);
translate([0,0,0])
rotate([0,90,0])
cylinder(r=Wire_hole_radius,h=Bracelet_length*2,center=true);
translate([0,0,-Bracelet_width/3])
rotate([0,90,0])
cylinder(r=Wire_hole_radius,h=Bracelet_length*2,center=true);
}