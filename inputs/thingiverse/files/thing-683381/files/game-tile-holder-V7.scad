//---> Important: Change this variable to 0 when using OpenSCAD, then you can use all your Windows fonts. Just enter their name in the "fontname" variable!
Thingiverse_Customizer=1*1;

//Select the STL part to generate.
part = "both_for_print"; // [right,left,both_for_print,both_for_display]

//Piece width in mm
piece_w=33;

//Piece height in mm. For square tiles, e.g. for micropul, set it to the same as the piece width
piece_h=33;

//Piece thicknes in mm
piece_th=3.5;

//Pieces per side. This is optimized for 3 pieces per side
tileNumber=3;

//Text to put on the holder (optional)
text="micropul";

//Font name
fontfilename="write/Orbitron.dxf"; //[write/orbitron.dxf:Orbitron,write/Letters.dxf:Basic,write/knewave.dxf:Knewave,write/BlackRose.dxf:BlackRose,write/braille.dxf:Braille]

/* [Hidden] */
//-------------------------------------------------------------------------------

//Font name, e.g. "Libration Sans", "Aldo", depends on what is available on the platform.
//Will take effect only if Thingiverse_Customizer=0
fontname="Aldo"; 

use <write/Write.scad>  


// micropul game tile holder
//
//  Copyright 2011 John Cooper
//  Modified 2015 to fit micropul tiles by MC Geisler (mcgenki at gmail dot com)
//  Version 7
//
//  Have fun!
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//   (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.



//
/* [Hidden] */
//-------------------------------------------------------------------------------

// Make the curves more curvey
$fs=0.2;

//cube([piece_h,piece_w,piece_w]);

thick=3;

tileHeight=piece_h*.75;
tileWidth=piece_w;
tileDepth=piece_th*2;

standWidth= tileWidth * ( tileNumber + 0.1 );

module writetext(textstr, sizeit) 
{
    smallersize=sizeit*.85;
    
   if(Thingiverse_Customizer==1)
    {
        translate([-smallersize*.15,-smallersize*.35,-1.5])
            write(textstr,t=3,h=smallersize,font=fontfilename,space=1,center=false);
    }
    else
    {
        linear_extrude(height = 3, center = true, convexity = 10, twist = 0)
            text(textstr,size=sizeit,font="Aldo",valign="center");
     }
}

module holder (side) {
    piece_shift = ( side == "right" ) ? 3 : -1;
    text_shift = ( side == "right" ) ? piece_w*.5 : piece_w*.4;
    difference () {
        union () {
            // Stand
            rotate ([55,0,0]) 
            {
              difference () 
              {
                  minkowski() 
                  {
                    cube ([standWidth, tileHeight, thick]);
                    cylinder(r=3, h=1);
                  }
                  
                  // for right x = 3 and 17 for these two translates

                 translate ([text_shift,piece_w*.37,4]) 
                    writetext(text, piece_w/2);
              }
                *for (i = [0 : 2])
                {
                    translate([piece_shift+i*piece_w*1.02,0,4+piece_th])
                        rotate([0,90,0])
                            cube([piece_th,piece_h,piece_w]);
                }
            }
            // bottom
            translate([0, 1, 0]) {
                minkowski() {
                  cube ([standWidth, tileHeight * 0.8, 2]);
                  cylinder(r=3, h=1);
                }
            }
            // lip
            rotate ([145,0,0]) {
              difference () {
                  minkowski() {
                    cube ([standWidth, tileDepth * 0.8, 3]);
                    cylinder(r=3, h=1);
                  }
                  translate ([-4,13,12]) {
                      rotate ([0,90,0]) {
                        cylinder (h=standWidth * 1.2, r=10.5);
                      }
                  }
              }
            }
        }
        translate ([-4,-10,-10]) {
            cube ([standWidth + 8, tileHeight * 1.5, 10]);
        }
        // Stand arch
        difference () {
          translate ([standWidth * 0.5, standWidth * 0.42, -0.1]) {
            cylinder (r=standWidth * 0.5, h=3.15);
          }
          translate ([0, -13, -0.1]) {
            cube ([standWidth,15,5]);
          }
        }
    }
}

module rightHolder () {
    difference () {
        holder (side="right");
        // hole for clip
        translate ([2.4,10,0]) {
          cylinder ( r=4, h=4);
        }
        translate ([5,-20,0]) {
          rotate ([0,0,100]) {
            cube ([tileHeight * 2, 7, tileHeight * 1.1]);
          }
        }
    }

}
module leftHolder () {
    union () {
        difference () {
            holder (side="left");
            translate ([standWidth +2,-20,0]) {
              rotate ([0,0,80]) {
                cube ([tileHeight * 2, 7, tileHeight * 1.1]);
              }
            }
        }
        // peg for clip
        translate ([standWidth + 5.5 - 2.4,9,0]) {
           cylinder ( r=3.6, h=4);
        }
    }

}

module bothTogether () {
    // Show them both connected together
    translate ([standWidth-2.7,0.5,0]) {
      rotate ([0,0,-20]) {
        rightHolder ();
      }
    }
    leftHolder ();
}

module bothForPrint () {
    // Show them both next to each other for printing
    translate([0, tileHeight * 2, 0]) {
      rightHolder ();
    }
    leftHolder ();
}

if(part == "right")
{
    rightHolder ();
}
else
{
    if(part == "left")
    {
        leftHolder ();
    }
    else
    {
        if(part == "both_for_print")
        {
            bothForPrint ();
        }
        else
        {
            if(part == "both_for_display")
            {
                bothTogether ();
            }
            else
            {
                //
            }    
        }       
    }    
}

