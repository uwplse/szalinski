Bracelet_circumference=180;
Bracelet_width=20;
Bracelet_thickness=3;
Bracelet_side_rounding=2;

Text="MY BRACELET";
Font="Handlee";
Text_height=4;
Text_x_offset=0;
Text_y_offset=-0.25;
Text_z_offset=-1.5;
Font_size=14;
Flare_text=1.05;
Scale_text_width=1;

//Text hanging between borders
Only_border=1;
Border_size=4;

//Type of closure: 0=original    1=for end-clasps
Ends_style=1; //([0:1])
Ends_width=8;
Ends_length=5;
Ends_thickness=3.5;
        
$fn=72;

step=Bracelet_circumference/len(Text);


difference()
    {
    translate([0,0,0])
        hull()
            {
                translate([(Bracelet_circumference/2-Bracelet_side_rounding),(Bracelet_width/2-Bracelet_side_rounding),0])
                 rotate([0,0,0])
                  sphere(r=Bracelet_side_rounding,center=true);
                    translate([(Bracelet_circumference/2-Bracelet_side_rounding),-(Bracelet_width/2-Bracelet_side_rounding),0])
                 rotate([0,0,0])
                  sphere(r=Bracelet_side_rounding,center=true);
                    translate([-(Bracelet_circumference/2-Bracelet_side_rounding),(Bracelet_width/2-Bracelet_side_rounding),0])
                 rotate([0,0,0])
                  sphere(r=Bracelet_side_rounding,center=true);
                    translate([-(Bracelet_circumference/2-Bracelet_side_rounding),-(Bracelet_width/2-Bracelet_side_rounding),0])
                 rotate([0,0,0])
                  sphere(r=Bracelet_side_rounding,center=true);
                }    
if(Only_border==0)    {    
    scale([Scale_text_width,1,1])    
    translate([Text_x_offset,Text_y_offset,Text_z_offset])
     linear_extrude(height=Text_height,scale=Flare_text)
       text(Text,font=Font,valign="center",halign="center",size=Font_size);
    }
    
    if(Only_border==1)
    {
      cube([Bracelet_circumference-Border_size*2-20,Bracelet_width-Border_size*2,Bracelet_thickness*2],center=true);
    }

//Zona agganci
if(Ends_style==0)
   {
    translate([Bracelet_circumference/2-4,4,0])
            cube([10,4,Bracelet_thickness*2],center=true);
    translate([Bracelet_circumference/2-4,-4,0])
            cube([10,4,Bracelet_thickness*2],center=true);
        
    translate([-Bracelet_circumference/2+4,5,0])
            cube([10,4,Bracelet_thickness*2],center=true);
    translate([-Bracelet_circumference/2+4,14,0])
            cube([10,4,Bracelet_thickness*2],center=true);
    translate([-Bracelet_circumference/2+4,-4,0])
            cube([10,4,Bracelet_thickness*2],center=true);
   }  
if(Ends_style==1)
   {
    translate([Bracelet_circumference/2,0,0])
            cube([Ends_length*2,Bracelet_width,Bracelet_thickness*2],center=true);
    translate([-Bracelet_circumference/2,0,0])
            cube([Ends_length*2,Bracelet_width,Bracelet_thickness*2],center=true);
   }  
//
        translate([0,0,5+Bracelet_thickness/2])
            cube([Bracelet_circumference*2,Bracelet_width*2,10],center=true);
                translate([0,0,-5-Bracelet_thickness/2])
            cube([Bracelet_circumference*2,Bracelet_width*2,10],center=true);
            
        translate([Bracelet_circumference/2+Bracelet_thickness,0,0])
            cube([Bracelet_thickness*2,Bracelet_width*2,10],center=true);
        translate([-Bracelet_circumference/2-Bracelet_thickness,0,0])
            cube([Bracelet_thickness*2,Bracelet_width*2,10],center=true);

//Fori fissaggio
if(Ends_style==0)
   {
    translate([-Bracelet_circumference/2+6,0,0])
      rotate([90,0,0])
         cylinder(r=0.75,h=Bracelet_width*2,center=true);
    translate([Bracelet_circumference/2-6,0,0])
      rotate([90,0,0])
         cylinder(r=0.75,h=Bracelet_width*2,center=true);
    translate([-Bracelet_circumference/2+2,0,0])
      rotate([90,0,0])
         cylinder(r=0.75,h=Bracelet_width*2,center=true);
    translate([Bracelet_circumference/2-2,0,0])
      rotate([90,0,0])
         cylinder(r=0.75,h=Bracelet_width*2,center=true);
      }
    }
    
    if(Only_border==1)
    {    
    scale([Scale_text_width,1,1])    
    translate([Text_x_offset,Text_y_offset,Text_z_offset])
     linear_extrude(height=Text_height,scale=Flare_text)
       text(Text,font=Font,valign="center",halign="center",size=Font_size);
    }

if(Ends_style==1)
   {
    translate([Bracelet_circumference/2-Ends_length/2,0,(Ends_thickness-Bracelet_thickness)/2])
            cube([Ends_length,Ends_width,Ends_thickness],center=true);
    translate([-Bracelet_circumference/2+Ends_length/2,0,(Ends_thickness-Bracelet_thickness)/2])
            cube([Ends_length,Ends_width,Ends_thickness],center=true);
   } 
