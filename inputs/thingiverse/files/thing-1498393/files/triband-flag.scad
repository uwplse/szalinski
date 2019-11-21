// 
// Customizable Triband Flag
// version 1.0   4/17/2016
// version 1.1   10/10/2016 
//  used "part" to allow multiple STL outputs 
// (DaoZenCiaoYen @ Thingiverse)
//

// preview[view:south, tilt:top diagonal]

/* [Main] */
// from 0 (min) to 1 (max)
thickness = 0.2 ; // [0:0.1:1]
// the longest side (in mm)
max_size = 75 ; // [20:5:250]
country = 28 ; // [0:Armenia (2x1),1:Austria (3x2),2:Belgium (15x13),3:Bolivia (22x15),4:Bulgaria (5x3),5:Chad (3x2),6:Colombia (3x2),7:Côte d'Ivoire (Ivory Coast) (3x2),8:Estonia (11x7),9:France (3x2),10:Gabon (4x3),11:Germany (5x3),12:Guinea (3x2),13:Hungary (2x1),14:Ireland (2x1),15:Italy (3x2),16:Latvia (2x1),17:Lithuania (5x3),18:Luxembourg (5x3),19:Mali (3x2),20:Netherlands (3x2),21:Nigeria (2x1),22:Peru (3x2),23:Romania (3x2),24:Russia (3x2),25:Sierra Leone (3x2),26:South Ossetia (2x1),27:Yemen (3x2),28:Custom]
// Export each shape separately (Use "All" for display, will export separate models)
part = 0 ; // [0:All,1:Band 1,2:Band 2,3:Band 3]

/* [Country = Custom] */
orientation = 1 ; // [0:Vertical Bands,1:Horizontal Bands]
// width to height
aspect_ratio = 2 ; // [0:3x2,1:4x3,2:5x3,3:2x1,4:22x15,5:15x13,6:11x7]
size1 = 3 ; // [1:3]
size2 = 2 ; // [1:3]
size3 = 3 ; // [1:3]
color1 = 13 ; // [0:Black,1:White,2:Grey,3:Red,4:DarkRed,5:Orange,6:SaddleBrown,7:Goldenrod,8:Gold,9:Yellow,10:GreenYellow,11:Green,12:DarkGreen,13:DodgerBlue,14:Blue,15:MediumBlue,16:DarkBlue,17:Indigo,18:Violet]
color2 = 1 ; // [0:Black,1:White,2:Grey,3:Red,4:DarkRed,5:Orange,6:SaddleBrown,7:Goldenrod,8:Gold,9:Yellow,10:GreenYellow,11:Green,12:DarkGreen,13:DodgerBlue,14:Blue,15:MediumBlue,16:DarkBlue,17:Indigo,18:Violet]
color3 = 16 ; // [0:Black,1:White,2:Grey,3:Red,4:DarkRed,5:Orange,6:SaddleBrown,7:Goldenrod,8:Gold,9:Yellow,10:GreenYellow,11:Green,12:DarkGreen,13:DodgerBlue,14:Blue,15:MediumBlue,16:DarkBlue,17:Indigo,18:Violet]

/* [Build Plate] */
// set to True to see the shape on your build plate
show_build_plate = 0 ; // [0:False,1:True]
// for display only, doesn't contribute to final object
build_plate_selector = 3 ; // [0:Replicator 2,1:Replicator,2:Thingomatic,3:Manual]
// Build plate x dimension for "Manual" (in mm)
build_plate_manual_x = 100 ; // [100:400]
// Build plate y dimension for "Manual" (in mm)
build_plate_manual_y = 100 ; // [100:400]

/* [Hidden] */
ff=0.01 ;
$fn=32;
pc=country;
is=part;
tol=0.13;
ar=[
  3/2, // 0:3x2
  4/3, // 1:4x3
  5/3, // 2:5x3
  2/1, // 3:2x1
  22/15, // 4:22x15
  15/13, // 5:15x13
  11/7 // 6:11x7
  ];
colors=[
  "Black", // 0
  "White", // 1
  "Grey", // 2
  "Red", // 3
  "DarkRed", // 4
  "Orange", // 5
  "SaddleBrown", // 6
  "Goldenrod", // 7
  "Gold", // 8
  "Yellow", // 9
  "GreenYellow", // 10
  "Green", // 11
  "DarkGreen", // 12
  "DodgerBlue", // 13
  "Blue", // 14
  "MediumBlue", // 15
  "DarkBlue", // 16
  "Indigo", // 17
  "Violet" // 18
];
pa=
[ // orientation, aspect, sizes, colors
  [1,3,[1,1,1],[3,14,5]], // 0:Armenia (2x1)
  [1,0,[1,1,1],[3,1,3]], // 1:Austria (3x2)
  [0,5,[1,1,1],[0,9,3]], // 2:Belgium (15x13)
  [1,4,[1,1,1],[3,8,11]], // 3:Bolivia (22x15)
  [1,2,[1,1,1],[1,11,3]], // 4:Bulgaria (5x3)
  [0,0,[1,1,1],[16,8,3]], // 5:Chad (3x2)
  [1,0,[2,1,1],[9,14,3]], // 6:Colombia (3x2)
  [0,0,[1,1,1],[5,1,11]], // 7:Côte d'Ivoire (Ivory Coast) (3x2)
  [1,6,[1,1,1],[13,0,1]], // 8:Estonia (11x7)
  [0,0,[1,1,1],[15,1,3]], // 9:France (3x2)
  [1,1,[1,1,1],[11,8,13]], // 10:Gabon (4x3)
  [1,2,[1,1,1],[0,3,8]], // 11:Germany (5x3)
  [0,0,[1,1,1],[3,8,11]], // 12:Guinea (3x2)
  [1,3,[1,1,1],[3,1,11]], // 13:Hungary (2x1)
  [0,3,[1,1,1],[11,1,5]], // 14:Ireland (2x1)
  [0,0,[1,1,1],[11,1,3]], // 15:Italy (3x2)
  [1,3,[2,1,2],[4,1,4]], // 16:Latvia (2x1)
  [1,2,[1,1,1],[8,11,3]], // 17:Lithuania (5x3)
  [1,2,[1,1,1],[3,1,13]], // 18:Luxembourg (5x3)
  [0,0,[1,1,1],[11,8,3]], // 19:Mali (3x2)
  [1,0,[1,1,1],[3,1,15]], // 20:Netherlands (3x2)
  [0,3,[1,1,1],[11,1,11]], // 21:Nigeria (2x1)
  [0,0,[1,1,1],[3,1,3]], // 22:Peru (3x2)
  [0,0,[1,1,1],[15,8,3]], // 23:Romania (3x2)
  [1,0,[1,1,1],[1,15,3]], // 24:Russia (3x2)
  [1,0,[1,1,1],[11,1,13]], // 25:Sierra Leone (3x2)
  [1,3,[1,1,1],[1,3,9]], // 26:South Ossetia (2x1)
  [1,0,[1,1,1],[3,1,0]], // 27:Yemen (3x2)
  [orientation,aspect_ratio,
    [size1,size2,size3],[color1,color2,color3]], // 28:Custom
] ;
o=pa[pc][0];
a=pa[pc][1];
fw= (o==0) ? max_size : max_size/ar[a] ;
h= (o==0) ? max_size/ar[a] : max_size;
s=pa[pc][2];
wx=s[0]+s[1]+s[2];
wa=[fw*(s[0]/wx),fw*(s[1]/wx),fw*(s[2]/wx)];
minw=min(wa);
maxt=minw*1.5;
mint=min(maxt,5);
t=mint+((maxt-mint)*thickness);
c=[
  colors[pa[pc][3][0]],
  colors[pa[pc][3][1]],
  colors[pa[pc][3][2]]
  ];
//echo(pc=pc,o=o,a=a,s=s,c=c,fw=fw,wa=wa,minw=minw,mint=mint,maxt=maxt,t=t,h=h,wx=wx);

use <utils/build_plate.scad> ;

main();

module main()
{
  part(1)
  {
    color(c[0])
      translate([-fw/2,0,0])
      linear_extrude(height=h)
      panel(0,fw*(s[0]/wx));
  }
  part(2)
  {
    color(c[1])
      translate([(-fw/2)+fw*(s[0]/wx),0,0])
      linear_extrude(height=h)
      panel(1,fw*(s[1]/wx));
  }
  part(3) 
  {
    color(c[2])
      translate([(-fw/2)+fw*(s[0]/wx)+fw*(s[1]/wx),0,0])
      linear_extrude(height=h)
      panel(2,fw*(s[2]/wx));
  }
}

module panel(x,w)
{
  difference()
  {
    union()
    {
      translate([w/2,0,0])
        square([w,t],center=true);
      if (x > 0) lock();
    }
    if (x < 2)
    {
      translate([w,0,0])
      offset(r=tol)
        lock();
    }
  }
}

module lock()
{
  ll=t*0.3; 
  lt=t*0.33;
  translate([0.5,0,0])
    square([1,t],center=true);
  translate([-ll/2+ff,0,0])
  {
    square([ll,lt],center=true);
    translate([-ll/2,0,0])
      circle(d=lt);
  }
  translate([-t*0.275,0,0])
    circle(d=lt*1.4);

}

//
// Utility modules
//
module part(n)
{
  // n = id of part
  if (is == 0 || is == n) {
    children(0);
  }
}

if (show_build_plate==1)
{
  build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
}
