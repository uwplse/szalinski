//By Coat, 18-march-2019
//Licensed under the Creative Commons - Attribution license.
//Cable-label in Braille

//Braille-measurements used here are based on https://www.pharmabraille.com/pharmaceutical-braille/marburg-medium-font-standard/

//Parameters

/* [Text and cable] */
//Text on label (use spaces for aligning)
labeltext = "fridge";  
//Diameter of cable (mm)
cablediam = 8;

/* [Advanced Label] */
//Minimum Length label (part right of the cable without edge, mm) 
lablength = 25;
//Width label (without edge, mm)
labwidth = 10;  
//Overall thicknes of the part (mm)
thickness = 1.5;  

//Makes it stiffer for lablengths over 25 mm(0 = no, 1 = yes)
  stifferspring = 1;

/* [Advanced Braille] */
//Horizontal Distance between Braille-cells/corresponding dots (6, 7 or 8 according to different standards)
cellroomx = 7.0;  
//height of the dots (0.2-0.8 is according to different standards)
dotheight = 0.8;

//-----------------
//----Modules Label
//-----------------

module rim()  //outer rim
{
  difference()
  {
    cube([lo,wo,th]);
    translate([wr,wr,-0.5*th])
      cube([li+sp,wi+sp*2, th*2]);
  }
}

module labelplate()  //inner plate
{
  translate([wr+sp+cd+th, wr+sp,0])
    cube([li-cd-th,wi,th]);  
}  

module cablehull()   //cableholder
{
  translate([wr+sp,wr+sp,0])
    difference()
    {
      chull(cd+th*2, wi,0);
      translate([th,-wi/2,th])
        chull(cd,wi*2, th*2);
    }  
}  

module chull(cdh,wih,tcb)  //cableholder part
{
  hull()  
  {
    translate([0,0,-tcb])
      cube([cdh, wih,cdh/2]);   
    translate([cdh/2,wih/2,cdh/2])
      rotate([90,0,0])  
        cylinder(d=cdh, wih, center=true); 
  }
}  


module stiffspring()  //extra cube at 25 mm of cableholder
{
  if (stifferspring >0 &&lo > 25+cd+th*2+sp) 
  {
    translate([25+cd+th*2+sp,0,0])
    cube([wr,wo,th]);
  }  
}  

//---------------------------
//----Modules/functions Braille
//---------------------------

function funcup2(c) = (ord(c)>96)&&(ord(c)<123) ? chr(ord(c)-32):c;  //uppercase

function funcdy(p,n1,n2,v)= p==n1||p==n2?v:-1;  //wich row is the dot

module textinbraille()     //compose braille from text                   
{
  echo(labeltext);
  for(i=[0:len(labeltext)-1])
  {
    ichar = funcup2(labeltext[i]);
    for (b=blist)
    { 
      if (ichar == b[0])
      {
        translate([i*cellroomx,dotdisty,0])
          placepoints2(b);
      }  
    }
  }
}

module placepoints2(pl)  //character to braillecell  
{
  union()
  for (p=[ 1 : len(pl) - 1 ])
  {  
    dx =  pl[p]<4 ? 0 : 1;
    dy = max(funcdy(pl[p],1,4,0),
             funcdy(pl[p],2,5,1),
             funcdy(pl[p],3,6,2));
    
    if (dy < 0)
      echo("check your places for: ",pl[0]);
 
    translate([dx*dotdistx,-dy*dotdisty,0])
      hull() //*
      {
        translate([0,0,th])
          scale([1,1,dotheight/(dotdiam/2)])
            sphere(d = dotdiam);
        cylinder(d=dotdiam,th/4); //*, th/4 for a smoother transition
      }
  }  
//*hull and cylinder not neccesary, but handy if you want to raise the dots a little more from the plate      
}

//------------------------------
//----character translation list
//------------------------------
blist =
//character, positions of points
//1 4
//2 5
//3 6
[
["A",1],
["B",1,2],
["C",1,4],
["D",1,4,5],
["E",1,5],
["F",1,4,2],
["G",1,4,2,5],
["H",1,2,5],
["I",4,2],
["J",4,2,5],
["K",1,3],
["L",1,2,3],
["M",1,4,3],
["N",1,4,5,3],
["O",1,5,3],
["P",1,4,2,3],
["Q",1,4,2,5,3],
["R",1,2,5,3],
["S",4,2,3],
["T",4,2,5,3],
["U",1,3,6],
["V",1,2,3,6],
["W",4,2,5,6],
["X",1,4,3,6],
["Y",1,4,5,3,6],
["Z",1,5,3,6],
//numbers
["#",3,4,5,6],   //# as numberindicator
["1",1],
["2",1,2],
["3",1,4],
["4",1,4,5],
["5",1,5],
["6",1,4,2],
["7",1,4,2,5],
["8",1,2,5],
["9",4,2],
["0",4,2,5],
//punctuation
[".",2,5,6],
[",",2],
["!",2,3,5],
["?",2,3,6],
[":",2,5],
[";",2,3],
["-",3,6],         //minus char
["≥",3,5,6],       //>> (alt 242)
["≤",2,3,6],       //<< (alt 243)
["(",2,3,5,6],
[")",2,3,5,6],
["<",1,2,6],
[">",3,4,5],
["/",3,4],
["'",3],
["*",3,5],
["@",3,4,5],
//other
["+",2,5,3],
["=",2,3,5,6]
//[" "]space is every not mentioned character including the space
];


//------------------------------
//----main----------------------
//------------------------------
//secondary parameters
$fn=12;

dotdiam = 1.5;   //dot base diameter (min=1.3 - max=1.6)
dotdistx = 2.5;  // Hor distance between dots same cell
dotdisty = 2.5;  // Vert Distance between dots same cell

//cellroomy = 10; //Vert Distance between cells/corresponding dots (10.0-10.2)
labroomx = cellroomx;    //space at start

sp = 0.5;          //space between label and outerrim
wi = max(dotdisty*4, labwidth);    //inner width
cd = cablediam;    //cable diameter
th = thickness;    //thickness plate
wr = wi/4;         //width outer rim
wo = wi + sp*2 + wr*2; //total width 
li = max(lablength,(len(labeltext)*cellroomx)+labroomx/2)+cd+th*2;  //inner length
lo = li + sp + wr*2;   //total length  
sf = 0.6;              //factor of wi for textsize

//the thing
rim();
labelplate();
translate([wr+sp+cd+th*2+labroomx, wr+sp+wi/2,0])
  textinbraille();
cablehull();
stiffspring();





