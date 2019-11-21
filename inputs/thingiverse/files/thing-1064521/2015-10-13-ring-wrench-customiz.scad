//*** Ring wrench tool / Ringschlüssel *****
//*        Henning Stöcklein 11.2.2015          *
// - 10.10.2015: 2 ring parametric version    *
// - 12.10.2015  Version for Customizer        *
// - 13.10.2015  Param readability optimized *
//*********************************

use <write/Write.scad>

//*********************************
//        User definable parameters               *
//*********************************

/* [Handle] */

// Write key size text to handle
Write_text = 1 ; // [0:No, 1:Yes]

// Text Size
Text_Size = 5.0 ;  // [4.5:Small, 5.0: Medium, 5.8: Big, 6.5: Huge] 

// Edge chamfering
Chamfer = 0.7 ; // [0.0:None, 0.4:Small, 0.7:Medium, 1.0:Big, 1.8:Huge]

// Width of wrench handle
Handle_Width = 9; // [7:10]

// Height of wrench handle
Handle_Height = 5; // [3:8]

// Length of wrench handle
Handle_Length = 60;   // [40:100]

// Weight reduced handle
long_hole = 1; // [-1:Open, 1:Deep, 3:Medium, 4:Small, 10:None]

/* [Key 1] */

// Height 
Key_1_Height = 5; // [3:12]
// hnabe1 = max (hnabe1, Handle_Height) ;

// Hex hole diameter 
Key_1_Diameter = 7 ; // [4:20]
lweite1 = Key_1_Diameter * 0.58 ;
text1  = str (Key_1_Diameter) ;

/* [Key 2] */

// Height 
Key_2_Height  = 8; // [3:12]
// hnabe2 = max (hnabe2, Handle_Height) ;

// Hex hole diameter
Key_2_Diameter = 12 ; // [4:20]
lweite2 = Key_2_Diameter * 0.58 ;
text2  = str (Key_2_Diameter) ;

//**********************************
//    Main objects and subroutines following    *
//  Change only when you know what to do... *
//**********************************
rotate ([0,0,180]) translate ([0,-Handle_Length,0])
   ring (lweite1, Key_1_Height, Handle_Height, Handle_Width, Handle_Length, text1) ;
ring (lweite2, Key_2_Height, Handle_Height, Handle_Width, Handle_Length, text2) ;


module ring (lweite, hnabe, hgriff, wgriff, lgriff, tsize)
{
  difference() {
   minkowski() {
    union() {
      translate ([0,0,hnabe/2]) rotate ([0,0,30])
        cylinder (r=lweite*1.6-Chamfer, h=hnabe-2*Chamfer, $fn=6, center=true);

        hull() {                                            // Wrench handle
          translate ([-(wgriff-2*Chamfer)/2,0,Chamfer]) cube ([wgriff-2*Chamfer, 1, hgriff-2*Chamfer]) ;
          translate ([-(wgriff-2*Chamfer)/2,lgriff/1.5,Chamfer]) cube ([wgriff-2*Chamfer, 1, hgriff-2*Chamfer]) ;
        } // hull 
      } // union
      sphere (r=Chamfer, $fn=7) ;
    } // minkowski

    // Hexagon whole
    rotate ([0,0,30])
       cylinder (r=lweite, h=hnabe+10, $fn=6, center=true);

    // Long whole in wrench handle
    hull() {
         translate ([0,lweite*2+8,long_hole]) cylinder (r=wgriff/3.2, h=3*hgriff, $fn=20) ;
         translate ([0,lgriff,long_hole]) cylinder (r=wgriff/3.2, h=3*hgriff, $fn=20) ;
      }
  }

  // Size text on the wrench holder
  if (Write_text == 1) {
     translate ([0,lweite*2.2,hgriff-0.6]) rotate ([0,0,-90]) 
  	   write (tsize, t=2.1, h=Text_Size, center=true) ;
  }
}
