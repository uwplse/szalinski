// Created by Andrew Moore 2016
//  http://www.thingiverse.com/tacpar  
//  
//  
//=============================

//=============================
//Global Constants: 
//  Don't change these. It will break the code.
//=============================
inch = 25.4;


//=============================
//Compiler Options: 
//These will change your viewing options in OpenSCAD
//=============================
          

//=============================
//Global Print Variables:
//  These will adjust how the part is printed but not affect the overall part shape
//=============================
$fn = 20;

//=============================
//Global Mechanical Variables: 
//  Change these to adjust physical properties of the part
//=============================
card_len = 85;
card_width = 54;
card_thickness = 1.5;
form_thickness = 10;
margin = 0.25*inch;
card_text = "TacPar";
card_font_size = 14;
text_depth = 1.5;
mink_edge_size = 1.75;

//mirror_image inverts the text so the molded part comes out correct
mirror_image = true;



//==============================
//Calculated Variables: k
//Do not Change these directly
//==============================
//clearance fit for 1/4-20" bolt
//through_hole_dia = inch*17/64;
through_hole_dia = inch*0;

module main()
{
    //add global logic and call part modules here
    difference()
    {
        translate([0,0,form_thickness]) Mold_Base();
        translate([0,0,form_thickness-card_thickness-text_depth]) text_inlay(card_text, card_font_size,"Arial"); 
    }  
}

module Mold_Base()
{
   difference()
   {
		positives();
		negatives();
    }    
   module positives()
   {
      translate([0,0,-form_thickness/2]) cube([card_len+2*margin, card_width+2*margin, form_thickness],center=true);       
   }
    module negatives()
   {
       
       minkowski() 
      {
         translate([0,0,0.0]) cube([card_len-mink_edge_size, card_width-mink_edge_size, 2*card_thickness-mink_edge_size],center=true);
         sphere(r=mink_edge_size);
         //rotate([45,45,45]) cube([mink_edge_size,mink_edge_size,mink_edge_size]);
      } 
      
      translate([(card_len-0.5)/2, -(card_width+margin)/2,0])outlet();
      translate([-(card_len-0.5)/2, (card_width+margin)/2,0]) rotate([0,0,180])outlet();
      translate([-(card_len+margin)/2,-(card_width-0.5)/2,0])rotate([0,0,-90])outlet();
      translate([(card_len+margin)/2,(card_width-0.5)/2,0]) rotate([0,0,90])outlet();
   }
   
    module outlet()
	{
		difference()
		{
			positives();
			negatives();
		}
		module positives()
		{
			rotate([90,0,0])cylinder(r1=1, r2=2, h=2*margin, center=true);
		}
		module negatives()
		{
                
		}
	}
   
}



module text_inlay(card_text="card text goes here", card_txt_size=9,label_font = "Arial")
{
	difference()
	{
		linear_extrude(height=text_depth){
            positives();
        }
		negatives();
	}
	module positives()
	{  
        if (mirror_image)
        {
            mirror()
            {
                text(card_text, size=card_txt_size,font=label_font, valign="center", halign="center");
            }
        }
        else
        {
                text(card_text, size=card_txt_size,font=label_font, valign="center", halign="center");
        }
	}
	module negatives()
	{
			
	}
    
}

//execute program and draw the part(s)
main();