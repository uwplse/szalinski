/* [General] */

// Part to print
part="knight2"; // [pawn2:Pawn,rook2:Rook,knight2:Knight,bishop2:Bishop,queen2:Queen,king2:King,team2:Whole Team,all:Whole Shabang]
// Pillar Type
pillar_type="twisty"; // [twisty:Twisty,teepee:Tee-pee Style]
// Square Size in Inches
square_size=2; // [1.5:1-1/2",1.75:1-3/4",2:2" (No. 4),2.25:2-1/4" (No. 5),2.5:2-1/2" (No. 6)]
// Base Height (needs to be higher than magnet height)
base_height=10;
// Base Fragment resolution
bfn=30; // [5:1:80]

/* [Magnet] */
// Add hole for magnet
domag=1; // [1:Yes,0:No]
// Magnet Hole Size (remember to oversize by 0.2 or so for clearance)
magw=18.2; // [0:0.2:30]
// Magnet Height
magh=6; // [0:.2:20]

/* [Hidden] */

mag=(domag*magw);
square=square_size*25.4;
white=[0.9,0.9,0.9];
black=[0.3,0.3,0.3];

*rook2();
*translate([square,0]) knight2();
*translate([square*2,0]) bishop2();

if(part=="pillars") pillars();
else if(part=="pawn2") pawn2();
else if(part=="rook2") rook2();
else if(part=="knight2") knight2();
else if(part=="bishop2") bishop2();
else if(part=="queen2") queen2();
else if(part=="king2") king2();
else if(part=="board") board();
else if(part=="team2") {
  translate([square*3,0]) rook2();
  translate([square*2,0]) knight2();
  translate([square*1,0]) bishop2();
  translate([square*0,0]) queen2();
  translate([square*-1,0]) king2();
  translate([square*4,0]) pawn2();
}
else if(part=="all") {
  board();
  for(y=[0,square*7]) {
    color(y==0?white:black) team(y);
  }
}

module board() {
  for(x=[0:7]) {
    for(y=[0:7]) {
      translate([(x-4)*square-square/2,y*square-square/2,-10]) color(x%2==y%2?black:white) cube([square,square,10]);
    }
  }
}
module team(y=0) {
  for(p=[-4:3])
      translate([p*square,y==0?square:square*6]) pawn2();
  translate([square*-4,y]) rook2();
  translate([square*-3,y]) rotate([0,0,y==0?90:-90]) knight2();
  translate([square*-2,y]) bishop2();
  translate([square*-1,y]) queen2();
  translate([0,y]) king2();
  translate([square,y]) bishop2();
  translate([square*2,y]) rotate([0,0,y==0?90:-90]) knight2();
  translate([square*3,y]) rook2();
}
module pawn2(bd=square*.56,th=square*.9,mag=mag) {
  base(d=bd,mag=mag);
  translate([0,0,base_height]) pillars(d=bd-2,midh=th-20,t=bd*.2);
  translate([0,0,th-10-(10-base_height)]) {
    neck(d=bd*.8);
    translate([0,0,bd*.35]) sphere(d=bd*.7,$fn=bfn*2);
  }
}
module bishop2(bd=square*.65,th=square*1.25,mag=mag) {
  echo(str("Bishop BD: ",bd," TH: ",th)); // 33.02 63.5
  base(d=bd,mag=mag);
  // sloppy!
  poff=(square_size==2.5?0:
      (square_size==2.25?2.1:
      (square_size==2?4.5:
      (square_size==1.75?6.8:
      (square_size==1.5?9:0)))));
  translate([0,0,base_height]) pillars(d=bd*.88,midh=th*.7-poff,t=bd*.182);
  translate([0,0,th-14-(10-base_height)]) {
    neck(d=bd*(23/33));
    translate([0,0,th*.1574]) scale(bd/33) intersection() {
      translate([0,0,-10]) cylinder(d=30,h=34);
      difference(){
        scale([.8,.8,1.4]) sphere(12,$fn=bfn*1.2);
        translate([2,12,2]) rotate([0,10]) rotate([90,0]) linear_extrude(30) polygon([[0,0],[3,20],[8,20],[2,1]]);
        translate([7,-5,9]) cube(10);
      }
    }
    translate([0,0,bd*(28/33)]) sphere(bd*(4/33),$fn=bfn*.8);
  }
}
module knight2(bd=square*.68,th=square*1.2,mag=mag) {
  base(d=bd,mag=mag);
  echo(str("Knight BD: ",bd," TH: ",th));
  // 34.54 60.96
  translate([0,0,base_height]) //scale([1,0.75,1])
  {
    pillars(d=bd*.94,midh=th*.639,t=bd*.2);
    translate([0,0,th*.672]) {
      translate([0,0,th*-.04]) neck(d=bd*.77);
      translate([0,0,th*-.197]) scale(bd*.0246) intersection() {
        //translate([0,0,10]) cylinder(d=50,h=50,$fn=30);
        translate([-17,7]) rotate([90,0]) linear_extrude(14,convexity=10) horse_profile(0.25);
        translate([0, 0, 14])
        rotate([0, 12, 0])
          translate([0, 0, -9.5])
        rotate([110, 0, 90])
    translate([-8, 0, 0])
      linear_extrude(height = 65, convexity = 20, center = true)
        horse_face(0.20);
      }
      if(version()[0]>=2016)
      {
        translate([bd*-.0434,bd*.0434,th*.1642]) rotate([90,0]) rotate([0,0,70]) scale(bd*.02895) {
          rotate_extrude(angle=180) translate([12,1]) scale([1.2,0.5]) circle(d=5,$fn=bfn/2);
        }
      }
    }
  }
  *knight();
}
module horse_face(scale=0.1) {
  half=[[0,0],[1,28],[2,36],[6,56],[10,70],[18,92],
  [17,93],[15,96],[12,106],[11,112],[11,132],[14,141],[16,145],[20.3,151.8],
  [19.8,156],[20,160],[20.5,163.3],[21.7,164.7],[23.7,164.2],[26,162],[27,160.5],[28.1,159],[31.8,152.55],
  [35.3,152.3],[34.9,155],[34.8,160],[35.2,162],[36,164.2],[37,166.2],[39.4,168.2],[41,169]];
full=concat(half,[for(i=[len(half)-2:-1:0])[82-half[i][0],half[i][1]]]);
  scale(scale)
  polygon(full);
}
module horse_profile(scale=0.1)
{
  scale(scale)
polygon([
 //[15,0],[25,20],[29,36],[20,55],
  [15,40],
  [18,58],
  [1,100],[2,120],[8,135],[20,150],[40,162],
  [66,168],[71,158],[74,155],[80,150],[84,147],[100,127],[110,110],
  [120,102],[118,90],[108,83],//[98,90],
  [100,80],[70,96],[60,93],[73,90],[80,88],
  [102,80],//[108,70],
  [110,60],[120,40],[15,40]
  //[125,0]
  ],[concat([for(i=[0:15])i],[for(i=[22:30])i]),[17,18,19,20]]);
}
module queen2(bd=square*.725,th=square*1.65,mag=mag) {
  points=8;
  pd=360/points;
  base(d=bd,mag=mag);
  hh=bd*.6;
  echo(str("Queen BD: ",bd," TH: ",th));
  translate([0,0,base_height]) pillars(d=bd-2,midh=th-26,t=8);
  translate([0,0,th-16-(10-base_height)]) {
    neck(d=bd*.8);
    difference(){
      cylinder(d1=bd*.43,d2=bd*.73,h=hh,$fn=bfn*1.5);
      translate([0,0,hh-(bd*.2)]) cylinder(d1=10,d2=bd*.62,h=bd*.2+.01,$fn=bfn);
      translate([0,0,hh]) for(r=[0:points-1])
        rotate([0,0,r*pd+pd/2]) translate([bd*.29,0]) sphere(bd*.125,$fn=bfn*.9);
    }
    *translate([0,0,20]) for(r=[0:points-1])
      rotate([0,0,r*pd]) translate([bd/2-7,0]) sphere(2.5,$fn=bfn*.8);
    translate([0,0,hh-6]) cylinder(d1=bd*.457,d2=bd*.05,h=8,$fn=bfn);
    translate([0,0,hh+4]) sphere(bd*.12,$fn=bfn);
  }
}
module king2(bd=square*.76,th=square*1.75,mag=mag) {
  base(d=bd,mag=mag);
  echo(str("King BD: ",bd," TH: ",th));
  translate([0,0,base_height]) pillars(d=bd-2,midh=th-26,t=8);
  translate([0,0,th-16-(10-base_height)]) {
    neck(d=bd-8);
    difference(){
      cylinder(d1=bd-20,d2=bd-10,h=20,$fn=bfn*1.5);
      translate([0,0,16]) cylinder(d1=10,d2=bd-14,h=4.01);
    }
    translate([0,0,16]) cylinder(d1=bd-14,d2=2,h=8);
    translate([bd*-.2,-3,22]) minkowski()
    {
      sphere(1,$fn=bfn/2);
      difference() {
      cube([bd*.42,bd*.155,bd*.42]);
      for(r=[45:90:360])
        translate([bd*.21,bd*.2,bd*.2]) rotate([0,r,0]) translate([bd*-.259,0,0]) rotate([90,0]) {
          if(r<=180)
            cylinder(d=10,h=10,$fn=bfn);
          else
            translate([-1.4,0,5]) cube(10,center=true);
        }
    }
  }
  }
}
module rook2(bd=square*.7,th=square*1.2,mag=mag) {
  bdf=35.6;
  thf=60.96;
  // sloppy!
  poff=(square_size==2.5?-2.2:
      (square_size==2.25?-1.1:
      (square_size==2?0:
      (square_size==1.75?1.1:
      (square_size==1.5?2.2:0)))));
  echo(str("Rook BD: ",bd," TH: ",th)); // 35.56 60.96
  *cylinder(d=bd,h=10,$fn=60);
  base(d=bd,mag=mag);
  translate([0,0,base_height]) pillars(d=bd*.972,midh=th*.71-poff,t=bd*(7/bdf));
  translate([0,0,th*.8686+(base_height-10)]) {
    difference(){
      union(){
        neck(d=bd*.775);
        cylinder(d=bd*.775,h=th/10,$fn=bfn*2);
        left=((bd*.775)/2)-((bd*.5)/2)-1.9;
        // SLOW:
        *rotate_extrude($fn=bfn*2) minkowski() {
          circle(1,$fn=20);
          translate([10,0]) square([((bd-8)/2)-11,6]);
        }
        if(version()[0]>=2016) {
          for(r=[0:60:360]) rotate([0,0,r]) 
            translate([0,0,th/10.2]) {
              rotate_extrude(angle=30,$fn=50) {
                translate([bd*.247,0,0]) minkowski()
                {
                  circle(1,$fn=20);
                  translate([1,0]) square([left,th*(4/thf)]);
                }
              }
            }
         } else {
           difference() {
              translate([0,0,th/10.2]) rotate_extrude($fn=50) {
                translate([((bd-18)/2),0,0]) minkowski() {
                  circle(1,$fn=20);
                  translate([1,0]) square([3,4]);
                }
              }
              translate([0,0,th/10.2]) for(r=[0:60:180-1]) rotate([0,0,r]) translate([bd*-.1,bd*-.8,0]) cube([bd*.2,bd*1.5,th]);
           }
        }
        //rotate_extrude(angle=10) polygon([[0,1],[0,3],[1,4]]]);
      }
      translate([0,0,th*(4/thf)]) cylinder(d=bd*.5,h=th*(4/thf),$fn=bfn);
    }
  }
  *#cylinder(d=35,h=60,$fn=50);
  *#rook(0);
}
module base(d=40,h=base_height,r=2,mag=mag) {
  difference(){
    rotate_extrude($fn=bfn*2.2) union(){
    polygon([[0,h],[d/2-r,h],[d/2,h-r],[d/2,r],[d/2-r,0],[0,0]]);
    translate([d/2-r,h-r]) circle(r=r,$fn=bfn*.7);
    translate([d/2-r,r]) circle(r=r,$fn=bfn*.7);
    };
    if(mag)
      translate([0,0,-0.01]) cylinder(d=mag,h=magh,$fn=bfn);
  }
}
module neck(d=26,h=12,r=2) {
  
rotate_extrude($fn=bfn*1.5)
union(){
  polygon([[0,h/2],[1,h/2-.1],[d/2-r,r+.05],[d/2-.5,0.88],[d/2,0],[d/2-.5,-0.88],[d/2-r,-1*r-.05],[4,h*-.199],[0,h*-.2]]);
  translate([d/2-r,0]) circle(d=r*2,$fn=bfn);
}
}
module pillars(d=38,rods=5,midh=48,t=8)
{
  if(pillar_type=="twisty")
    pillars2(d,rods,midh,t);
  else if(pillar_type=="teepee") {
  od=d*.75;
//  cylinder(d=5,h=midh,$fn=20);
  translate([0,0,(midh-10)]) cylinder(d1=5,d2=od,h=8,$fn=50);
  ry=d/2-4;
  rdeg=atan(ry/midh);
  rz=sqrt(pow(ry,2)+pow(midh,2));
  for(r=[1:rods])
    rotate([0,0,r*(360/rods)])
      translate([0,ry,0]) rotate([rdeg,0]) cylinder(d=5,h=rz,$fn=20);
  }
}
module pillars2(d=38,rods=5,midh=48,t=8)
{
  twist=midh*15;
  echo(str("Building Pillars D:",d," H:",midh," T:",t));
  deg=360/rods;
  intersection(){
    cylinder(d=d,h=midh);
    for(r=[1:rods])
      rotate([0,0,r*deg]) linear_extrude(height = midh*2, twist = twist, $fn=200, scale=0)
         translate([d/2-t, 0, 0])
           rotate(15) circle(d=t,$fn=20);
            //square([t,t]);
  }
  supx=d/4;
  supz=midh-supx-1;
  *for(r=[1:rods])
  { // t = 5, ex = 12
    rotate([0,0,r*deg+25])
    translate([1,0,supz]) rotate([15,0])
      rotate([90,0,0]) linear_extrude(t*.6) polygon([[0,supx],[supx,supx],[supx,0]]);
  }
  difference() {
  translate([0,0,midh-6]) cylinder(d1=10,d2=d*.75,h=4);
  translate([0,0,midh-6.01]) cylinder(d1=14,d2=4,h=3);
  }
}