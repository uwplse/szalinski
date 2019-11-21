use <write/Write.scad>;

/* [Array] */
SOCKET01 = 20; // [0:"None", 1:"4mm", 2:"4.5mm", 3:"5mm", 4:"5.5mm", 5:"6mm", 7:"7mm", 8:"8mm", 9:"9mm",10:"10mm",11:"11mm",12:"12mm",13:"13mm", 20:"5/32", 21:"3/16", 22:"7/32", 23:"1/4", 24:"9/32", 25:"5/16", 26:"11/32", 27:"3/8", 28:"13/32", 29:"7/16", 30:"15/32", 31:"1/2"  ] 
SOCKET02 = 21; // [0:"None", 1:"4mm", 2:"4.5mm", 3:"5mm", 4:"5.5mm", 5:"6mm", 7:"7mm", 8:"8mm", 9:"9mm",10:"10mm",11:"11mm",12:"12mm",13:"13mm", 20:"5/32", 21:"3/16", 22:"7/32", 23:"1/4", 24:"9/32", 25:"5/16", 26:"11/32", 27:"3/8", 28:"13/32", 29:"7/16", 30:"15/32", 31:"1/2"  ] 
SOCKET03 = 22; // [0:"None", 1:"4mm", 2:"4.5mm", 3:"5mm", 4:"5.5mm", 5:"6mm", 7:"7mm", 8:"8mm", 9:"9mm",10:"10mm",11:"11mm",12:"12mm",13:"13mm", 20:"5/32", 21:"3/16", 22:"7/32", 23:"1/4", 24:"9/32", 25:"5/16", 26:"11/32", 27:"3/8", 28:"13/32", 29:"7/16", 30:"15/32", 31:"1/2"  ] 
SOCKET04 = 23; // [0:"None", 1:"4mm", 2:"4.5mm", 3:"5mm", 4:"5.5mm", 5:"6mm", 7:"7mm", 8:"8mm", 9:"9mm",10:"10mm",11:"11mm",12:"12mm",13:"13mm", 20:"5/32", 21:"3/16", 22:"7/32", 23:"1/4", 24:"9/32", 25:"5/16", 26:"11/32", 27:"3/8", 28:"13/32", 29:"7/16", 30:"15/32", 31:"1/2"  ] 
SOCKET05 = 24; // [0:"None", 1:"4mm", 2:"4.5mm", 3:"5mm", 4:"5.5mm", 5:"6mm", 7:"7mm", 8:"8mm", 9:"9mm",10:"10mm",11:"11mm",12:"12mm",13:"13mm", 20:"5/32", 21:"3/16", 22:"7/32", 23:"1/4", 24:"9/32", 25:"5/16", 26:"11/32", 27:"3/8", 28:"13/32", 29:"7/16", 30:"15/32", 31:"1/2"  ] 
SOCKET06 = 25; // [0:"None", 1:"4mm", 2:"4.5mm", 3:"5mm", 4:"5.5mm", 5:"6mm", 7:"7mm", 8:"8mm", 9:"9mm",10:"10mm",11:"11mm",12:"12mm",13:"13mm", 20:"5/32", 21:"3/16", 22:"7/32", 23:"1/4", 24:"9/32", 25:"5/16", 26:"11/32", 27:"3/8", 28:"13/32", 29:"7/16", 30:"15/32", 31:"1/2"  ]  
SOCKET07 = 26; // [0:"None", 1:"4mm", 2:"4.5mm", 3:"5mm", 4:"5.5mm", 5:"6mm", 7:"7mm", 8:"8mm", 9:"9mm",10:"10mm",11:"11mm",12:"12mm",13:"13mm", 20:"5/32", 21:"3/16", 22:"7/32", 23:"1/4", 24:"9/32", 25:"5/16", 26:"11/32", 27:"3/8", 28:"13/32", 29:"7/16", 30:"15/32", 31:"1/2"  ] 
SOCKET08 = 27; // [0:"None", 1:"4mm", 2:"4.5mm", 3:"5mm", 4:"5.5mm", 5:"6mm", 7:"7mm", 8:"8mm", 9:"9mm",10:"10mm",11:"11mm",12:"12mm",13:"13mm", 20:"5/32", 21:"3/16", 22:"7/32", 23:"1/4", 24:"9/32", 25:"5/16", 26:"11/32", 27:"3/8", 28:"13/32", 29:"7/16", 30:"15/32", 31:"1/2"  ] 

/* [Hidden] */
THICKNESS = 10;
BASE = 21;

XX = 0;  //No Print

M40 = 1;
M45 = 2;
M50 = 3;
M55 = 4;
M60 = 5;
M65 = 6;
M70 = 7;
M80 = 8;
M90 = 9;
M10 = 10;
M11 = 11;
M12 = 12;
M13 = 13;
//M14 = 14;
//M15 = 15;

U05 = 20;
U06 = 21;
U07 = 22;
U08 = 23;
U09 = 24;
U10 = 25;
U11 = 26;
U12 = 27;
U13 = 28;
U14 = 29;
U15 = 30;
U16 = 31;
//U17 = 32;
//U18 = 33;


/* Metric Diameters */

// exact inch measurements from calipers

METRIC4 = 0.450;
METRIC4_5 = 0.452; 
METRIC5 = 0.455; 
METRIC5_5 = 0.470; 
METRIC6 = 0.475;  
METRIC6_5 = 0.450; // From a different set?
METRIC7 = 0.475;  
METRIC8 = 0.475;  
METRIC9 = 0.505;  
METRIC10 = 0.550;  
METRIC11 = 0.625;  
METRIC12 = 0.650; 
METRIC13 = 0.662;
//METRIC14 = 0.775; // too large for current base
//METRIC15 = 0.863; // too large for current base

/* US Diameters */
// US Variables as x/32
US05 = 0.450;   //  5/32
US06 = 0.454;   //  3/16
US07 = 0.464;   //  7/32
US08 = 0.460;   //   1/4
US09 = 0.470;   //  9/32
US10 = 0.538;   //  5/16
US11 = 0.548;   // 11/32
US12 = 0.538;   //   3/8
US13 = 0.545;   // 13/32
US14 = 0.625;   //  7/16
US15 = 0.620;   // 15/32
US16 = 0.666;   //   1/2
//US17 = 0.700;   // 17/32  // too large for current base
//US18 = 0.775;   //  9/16 // too large for current base




// 4 x 2 array
translate([-3*BASE,-BASE,0])
 customSocket(SOCKET01);
translate([-3*BASE,BASE,0])
 customSocket(SOCKET02);
translate([-BASE,-BASE,0])
 customSocket(SOCKET03);
translate([-BASE,BASE,0])
 customSocket(SOCKET04);
translate([BASE,-BASE,0])
 customSocket(SOCKET05);
translate([BASE,BASE,0])
 customSocket(SOCKET06);
translate([3*BASE,-BASE,0])
 customSocket(SOCKET07);
translate([3*BASE,BASE,0])
 customSocket(SOCKET08);


module customSocket(choice)
{
 if(choice == XX) {}
 else if(choice == M40) {fullSocket(METRIC4, "4mm");}
 else if(choice == M45) {fullSocket(METRIC4_5, "4.5mm");}
 else if(choice == M50) {fullSocket(METRIC5, "5mm");}
 else if(choice == M55) {fullSocket(METRIC4_5, "5.5mm");}
 else if(choice == M60) {fullSocket(METRIC6, "6mm");}
 else if(choice == M65) {fullSocket(METRIC6_5, "6.5mm");}
 else if(choice == M70) {fullSocket(METRIC7, "7mm");}
 else if(choice == M80) {fullSocket(METRIC8, "8mm");}
 else if(choice == M90) {fullSocket(METRIC9, "9mm");}
 else if(choice == M10) {fullSocket(METRIC10, "10mm");}
 else if(choice == M11) {fullSocket(METRIC11, "11mm");}
 else if(choice == M12) {fullSocket(METRIC12, "12mm");}
 else if(choice == M13) {fullSocket(METRIC13, "13mm");}
// else if(choice == M14) {fullSocket(METRIC14, "14mm");}
// else if(choice == M15) {fullSocket(METRIC15, "15mm");}
 else if(choice == U05) {fullSocket(US05, "5/32");}
 else if(choice == U06) {fullSocket(US06, "3/16");}
 else if(choice == U07) {fullSocket(US07, "7/32");}
 else if(choice == U08) {fullSocket(US08, "1/4");}
 else if(choice == U09) {fullSocket(US09, "9/32");}
 else if(choice == U10) {fullSocket(US10, "5/16");}
 else if(choice == U11) {fullSocket(US11, "11/32");}
 else if(choice == U12) {fullSocket(US12, "3/8");}
 else if(choice == U13) {fullSocket(US13, "13/32");}
 else if(choice == U14) {fullSocket(US14, "7/16");}
 else if(choice == U15) {fullSocket(US15, "15/32");}
 else if(choice == U16) {fullSocket(US16, "1/2");}
// else if(choice == U17) {fullSocket(US17, "17/32");}
// else if(choice == U18) {fullSocket(US18, "9/16");}
 else           {}
    
    
    
}



module fullSocket(measurement, nameText)
{
 translate([0,0,THICKNESS/2])   
 difference()
 {
  socket(measurement);
  union()
  {
   name(nameText);
   rotate([0,0,90]) name(nameText);
   rotate([0,0,180]) name(nameText);
   rotate([0,0,-90]) name(nameText);
  }
 }
}
module name(sizeText)
{
  translate([0,-BASE/2,1.5])
   rotate([90,0,0])
    write(
        sizeText, 
        h=5, 
        t=1, 
        font="Letters.dxf",
        center=true);   
}


module socket(diameter)
{
  union()
  {
    difference()
    { 
      base();
      disc(diameter);  
    }    
    post();        
  }   
}

module post()
{
    cylinder(d1=6.8, d2=6.6, h=9.5, $fn=20);    
}

module disc(diameter)
{
    translate([0,0,THICKNESS/4])
     cylinder(d=diameter*25.4+1, h=THICKNESS/2, center=true);    
}

module edge()
{
 translate([BASE/2, -BASE/2, -THICKNESS/2])   
  polyhedron(
   points=[ [0,0,0],[0,0,3],[3,0,0],
            [0,BASE,0],[0,BASE,3],[3,BASE,0]  ], 
   faces=[ [0,1,2],[4,1,0,3],[1,4,5,2],[0,2,5,3],              
           [5,4,3] ]                         
 );   
}

module base()
{
    union()
    {
      cube([BASE, BASE, THICKNESS], center=true);
      edge();     
      mirror([1,0,0]) edge();
    }
}