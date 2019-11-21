/**

  Lighter hull for LUX(tm)
  
**/  

//Font to use
use <write/Write.scad>  //Change to directory where write.scad resides;


/* [General] */

// wall thickness
thick = 1.5;


// Raised text1?
raise1 = "no"; // [no:No, yes:Yes]
text1 = "Feuerzeug" ;

// Raised text2?
raise2 = "yes"; // [no:No, yes:Yes]
text2 = "Ullrich's" ;


////font = "Broadway";


// choose font
///select_font="Broadway" ;
select_font="Limelight" ;//[Limelight,Alfa Slab One,Indie flower,Lobster,Oxygen,Kaushan Script,Bangers,write/braille.dxf:Braille]
// or type in a Google font name (see https://www.google.com/fonts)
font_name="";

///font="orbitron.dxf"; //[write/orbitron.dxf:Futuristic,write/Letters.dxf:Basic,write/knewave.dxf:Round,write/BlackRose.dxf:Classic,write/braille.dxf:Braille]

use_fontname=(font_name!="");

font=use_fontname?font_name:select_font;

//Height of characters [mm]
fontsize=8;  //[5:20]						  

// Should the hull have small holes on the side?
holes = "yes"; // [no:No, yes:Yes]


/* [Dimension adjust] */


// Use these parameters if needed for a tighter or looser fit [mm]
bottom_depth = 11.5 ;
bottom_width = 23.5;

top_depth = 13 ;
top_width = 24.5;

height = 67;

do_smallholes=(holes=="yes");
dont_raise1=(raise1=="no");
dont_raise2=(raise2=="no");


feuerzeughuelle();
//textdeco();

module plate(depth,width,t=1)
{
  r= depth/2;
  hull(){
    dist= width-depth;
    translate([-dist/2,0,0])
    {
        cylinder(t , r=r) ;
        translate([dist, 0, 0]) cylinder(t,r=r) ;
    }
  }
}

module cutout()
{
    hull(){
        plate(bottom_depth, bottom_width);
        translate([0,0,height])
            plate(top_depth, top_width,t=2);
    }
}

module huelle(depth,width)
{
    translate([0,0,-thick])
    hull(){
        plate(depth+2*thick, width+2*thick);
        translate([0,0,height+thick])
            plate(depth+2*thick, width+2*thick);
    }
}


module textdeco(h=4,text="Feuerzeug")
{
 
    translate([
       0, 
       (top_depth)/2,
       height/2]) rotate([-90,-90,0])
    linear_extrude(height = h) 
    text(text,font=font,size=fontsize,halign="center",valign="center");
}

module smallholes()
{
    for (i=[10,20,30,40,50,60])
    {
        translate([-25,0,i-3]) rotate([90,0,90]) 
          cylinder(50,r=4);
    }
}

module feuerzeughuelle(t1=text1,t2=text2)
{
    difference()
    {
    
        huelle(top_depth,top_width);
        
        // platz fuers fuerzeug
        cutout(); 
        
        //bodenloch
        translate([0,0,-thick*2]) cylinder(thick*3,r=4);
        
       // cutout text 
       if(dont_raise2)
            translate([0 ,-thick,0]) textdeco(text=text2);
       if(dont_raise1)
            rotate([0,0,180]) translate([0 ,-thick,0]) textdeco(text=text1);
        
       if(do_smallholes) 
       // side holes 
        smallholes();
    }
    // applied text
    if(!dont_raise2)  textdeco(thick+thick,text=text2)  ;  
    if(!dont_raise1) rotate([0,0,180]) textdeco(thick+thick,text=text1)  ;  
}


