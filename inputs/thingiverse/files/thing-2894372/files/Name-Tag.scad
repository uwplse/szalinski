// Name Tag.scad - two sided name tag with hole
// name for front - embossed
nfront="front";
// name for back - recessed
nback="back";
// tag width in mm
size=20;
// unused
nlen=1;

// Module instantiation
LetterTag();

// Module definition.

module LetterTag() {

  difference(){
      
    union() {
 
    nlen = len(nfront);
         if(len(nback)>len(nfront)){nlen=len(nback);}
  
        translate([0,0,size/4]) cube([(size*0.6*nlen)+size/3,size,size/6
       ], center=true);
    {
   
        translate([0,0,size/4]) {
            // convexity is needed for correct preview
            // since characters can be highly concave
            linear_extrude(height=size/6, convexity=4)            
                text(nfront, 
                     size=size*22/30,
                     font="Bitstream Vera Sans",
                     halign="center",
                     valign="center");
        }
        }
        translate([((size*0.3*nlen)+size/6),0,size/6]){
            linear_extrude(height=size/6)
            circle(d=size);
    } // translate
    difference(){
            translate([-((size*0.3*nlen)+size/6),0,size/6]){
              linear_extrude(height=size/6)
              circle(d=size);} // end semicircle
            translate([-((size*0.3*nlen)+size/6),0,size/6]){
              linear_extrude(height=size/6)
              circle(d=size/2); 
          }// translate hole    
      } 
  
     } //union
       mirror(0,1,0) { translate([0,0,0]) {
          
            linear_extrude(height=size/4, convexity=4)            
                text(nback, 
                     size=size*22/30,
                     font="Bitstream Vera Sans",
                     halign="center",
                     valign="center");
                                          }
        }//mirror

               
} // outer difference
}  // lettertag

echo(version=version());
// Written by Marius Kintel <marius@kintel.net>
// adapted by Hamish Low May 2018 to make name tags
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
