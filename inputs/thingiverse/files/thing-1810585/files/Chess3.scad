/*[Hidden]*/
style= rands(0.01,0.99,100);
$fn=45;
color("Gray"){translate([-25,-25,0])king();
translate([-25,0,0])queen();
translate([0,-25,0])knight();
translate([25,-25,0])rook();
translate([50,-25,0])bishop();
translate([0,0,0])knight();
translate([25,0,0])rook();
translate([50,0,0])bishop();}
color("Gray"){
translate([-25,25,0])pawn();
translate([0,25,0])pawn();
translate([25,25,0])pawn();
translate([50,25,0])pawn();
translate([-25,50,0])pawn();
translate([0,50,0])pawn();
translate([25,50,0])pawn();
translate([50,50,0])pawn();}
module king(){
difference(){
rotate_extrude(){intersection(){
square([13,10+10+40+20]);
offset(r=1)offset(r=-1.5)offset(r=0.5)  {union() {
base(10,12);
translate([0,12])stem(40,10);
translate([0,12+35])shoulder(6.18,6.18);
translate([0,12+35+6.18]){
scale(1.6)intersection(){
translate([-10,0,0])square(20);
offset(r=0.5)offset(r=-1)offset(r=0.5)
union(){
translate([0,11,0])scale([1,0.4])circle(2.8);

difference(){
circle(10);
translate([33.5,-4,0])circle(30,$fn=120);
;}}}
}

basecore(12+40+10,50);
}}}}translate([0,0,12+35+6.18+15]){
cube([20,2,2],center=true);
cube([2,20,2],center=true);
}}}
module queen(){
difference(){


rotate_extrude(){intersection(){
square([13,10+10+30+20+10]);
offset(r=1)offset(r=-1.5)offset(r=0.5)  {union() {


base(10,12);
translate([0,12])stem(35,10);
translate([0,12+30])shoulder(6.18,6.18);
translate([0,12+30+6.18,6.18]){
scale([1.6,1.4,1])intersection(){
translate([-10,0,0])square(25);
offset(r=0.5)offset(r=-1)offset(r=0.5)
union(){
translate([0,9.7,0])circle(2.2);
difference(){
circle(10);
translate([0,15,0])circle(8);
translate([33.5,-4,0])circle(30,$fn=120);
;}}}}
basecore(12+30,50);

}}}}
translate([0,0,12+30+6.18]){
for (a=[0:45:330]){
rotate([0,0,a ]){
rotate([0,0,22.5])translate([8.3,0,12])rotate([0,90+35,0])scale([1,1,1.2])sphere(1.8);}}}}
}

module rook(){
difference(){

rotate_extrude(){intersection(){
square([13,10+10+20+10]);union() {offset(r=1)offset(r=-2)offset(r=1)union() {
base(10,12);
translate([0,10])stem(20,10);
translate([0,10+20])shoulder(6.18,6.18*1.2);
translate([0,10+20+8])square([6.18*2.5,6.18*1.5],center=true);

}offset(r=0.4)offset(r=-0.6)offset(r=0.2)difference(){
translate([0,10+20+10])square([6.18*2.7,6.18*1.5],center=true);
translate([0,10+20+10+7.5])square([6.18*1.6,6.18*1.5],center=true);
}}}}
translate([0,0,10+20+14.5]){
for (a=[0:90:330]){
rotate([0,0,a ]){
 translate([5,0,0]) scale([1,1,1.2])cube([11,2,2],center=true);}}}}}

module knight(){
    rotate_extrude(){ square(1);}
  scale(0.95)rotate([0, 0, 45])Knightshead();
rotate_extrude(){intersection(){
square([13,10+10+20+10]);union() {offset(r=1)offset(r=-2)offset(r=1)union() {
base(10,12);}}}}}

module bishop(){
difference(){
rotate_extrude(){intersection(){
square([13,10+10+20+10+10]);offset(r=1)offset(r=-2)offset(r=1)union() {
base(10,12);
translate([0,10])stem(20,10);
translate([0,10+20])shoulder(6.18,6.18*1.2);
translate([-6,10+20+10+2])circle(6.18*2.1);
translate([0,10+20+10+2+6.18*2])circle(1.8);

}}} translate([0,-2,43])rotate([20,0,0])translate([0,0,10])cube([30,1,20],center=true);}}
module pawn(){
 
rotate_extrude(){intersection(){
square([13,10+10+10+10]);offset(r=1)offset(r=-2)offset(r=1)union() {
base(10,12);
translate([0,10])stem(10,10);
translate([0,10+10])shoulder(6.18,6.18);
translate([0,10+10+10])circle(6.18*1.2);
}}}}
module base(h=1,w=1)
{

r1=w*0.1;
r2=w*0.25*style[4];
r3=w*0.2*style[5];
r4=w*1*lerp(0.3,1,style[6]);
difference(){
union(){

basecore(h+r3,w);

hull(){
translate([w-r1,r1])circle(r=r1);
basecore(h/2,w);}
hull(){
translate([lerp(w-r2, w/2+r2,style[0]),lerp(h-r2,r2,style[1])])circle(r=r2);
basecore(h,w);}
hull(){
translate([w*0.618-r3,h ])circle(r=r3);
translate([0,r3])basecore(h+r3,w);}


}
translate([lerp(w*0.65+r4,w*0.45+r4,style[7]),lerp(h,r4+r1*0.5,style[8])])circle(r=r4);

}

}
module basecore(h,w){
square([w*0.1,h]);
}
module stem(h=1,w=1)
{

r1=w*0.1*style[5];
r2=w*0.35*style[10];
r3=w*0.2*style[11];
r4=w*2*style[15];

 difference(){
union()
{
stemcore(h,w);
hull(){
translate([w*0.618-r1,0])circle(r=r1);
translate([0,r1])stemcore(h/2,w);}
hull(){
translate([lerp( w*0.2,w-r2,style[12]),lerp(h-r2,r2,style[13])])circle(r=r2);
stemcore(h,w);}
hull(){
translate([w/2-r3,h-r3])circle(r=r3);
translate([0,h/2])stemcore(h/2,w);}
}
translate([lerp(w*0.75+r4,w*0.3+r4,style[16]),lerp(h-r4,r4,style[17])])circle(r=r4);
}

}


module stemcore(h,w){
square([w*0.3,h]);
}
module shoulder(h=1,w=1)
{

r1=w*0.5*style[20];
r2=w*0.5*style[21];
r3=w*0.5*style[22];
r4=w*0.75*style[25];
 union(){stemcore(h,w);
{

stemcore(h,w);

difference(){union(){hull(){
translate([w-r1,0])circle(r=r1);
stemcore(h,w);}
hull(){
translate([lerp( r2,w-r2,style[23]),lerp(h-r2,r2,style[24])])circle(r=r2);
stemcore(h,w);}

hull(){
translate([w-r3,h-r3])circle(r=r3);
stemcore(h,w);}}
translate([lerp(w+r4,w*0.5+r4,style[26]),lerp(h-r4,r4,style[27])])circle(r=r4);
}

};}

}

module kingshead (){$fn=60;

scale(2)rotate_extrude(){
intersection(){
square(10);
offset(r=0.5)offset(r=-1)offset(r=0.5)
union(){difference(){
circle(10);
translate([33.5,-4,0])circle(30,$fn=120);
;
}
}
}
}
rotate([0,0,0])w();
rotate([0,0,90])w();
rotate([0,0,180])w();
rotate([0,0,270])w();
translate([0,0,26])sphere(3);
module w(){

v=[[10,0,0,1],[10,0,5,1],[20,0,10,1],[10,0,20,1],[0,0,5,1],[0,0,10,0]];
detail = 1/20;
fn=10;
translate([0,0,15])for(i = [detail: detail: 1]) {

  hull() {
        translate([bez2(i, v)[0], bez2(i, v)[1], bez2(i, v)[2]]) rotate(bez2euler(i, v)) rotate([0, 90, 0]) {
        translate([0,-1,0])  sphere(d = bez2(i, v)[3], $fn = fn);
        translate([0,1,0])  sphere(d = bez2(i, v)[3], $fn = fn);
        };
        translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v)) rotate([0, 90, 0]){ 
translate([0,-1,0])sphere(d = bez2(i - detail, v)[3], $fn = fn);
translate([0,1,0])sphere(d = bez2(i - detail, v)[3], $fn = fn);}
sphere();      }

}}}

//v is  "list of vertices"
 module Knightshead() {
    $fn = 12;    
buck();
mirror([0,1,0])buck();
    v = [
       [0, 0, 16, [11.9, 9.3,8]],
       [0, 0, 20, [10.9, 7.3, 3]],
       [-2, 0, 25, [8.9, 6.3, 3]],
       [-6, 0, 30, [6, 5.5, 3]],
       [-6.5, 0, 35, [6, 6.5, 3]],
       [-7, 0, 40, [5, 5.5, 3]],
       [-5, 0, 45, [5, 5, 2]],
       [0, 0, 44, [4, 6.5, 2]],
       [2, 0, 43, [3.5, 5.5, 1]],
       [5, 0, 40, [2.5, 3, 1]],
       [9, 0, 34, [4.5, 3.5, 2]],
       [9, 0, 32.5, [4, 3.5, 2]],
       [10.5, 0, 30.9, [2, 3.5, 1]],
       [11.3, 0, 30, [1, 2.5, 0.5]]
    ];
    v2 = [
       [-5, 0, 45, [5, 5, 2]],
       [-2, 0, 39, [6, 6.45, 7]],
       [3, 0, 38, [2, 4.5, 7]],
       [5, 0, 36, [2, 4, 7]],
       [9, 0, 32.5, [4, 3.7, 3]],
       [10.5, 0, 30.9, [2, 3.5, 1]]
    ];
    v3 = [
       [-5, 0, 45, [5, 5, 2]],
       [-3, 0, 42, [7, 6.0, 2]],
       [-3, 0, 39, [7, 6.8, 3]],
       [-2.8, 0, 35, [5, 6.5, 3]],
       [-2, 0, 34.9, [5, 5.8, 3]],
       [3, 0, 34, [2, 3.0, 3]],
       [5.9, 0, 31, [2, 3.1, 2]],
       [7.9, 0, 29, [3, 3.4, 1]],
       [9, 0, 28.1, [2, 2, 1]]
    ];
    face = [
       [-8.8, -6, 48.9, [0.7, 0.3, 0.5]],
       [-7.2, -4.9, 47, [1.9, 1.4, 0.5]],
       [-6.6, -4.0, 45.7, [2.4, 1.9, 1.6]],
       [-5.7, -2.8, 44, [3.7, 2.7, 1]],
       [1, -1, 42, [1, 1, 1]],
       [1, -4.7, 42, [1.6, 1, 1.4]],
       [1, -1, 42, [1, 1, 1]],
       [09.2, -1.4, 33.2, [1, 1, 1]],
       [09.2, -2.4, 33.2, [1, 1.5, 1.7]],
       [09, -2.9, 34.3, [1.5, 1.2, 1.7]],
       [10.7, -2.8, 35.1, [1, 1, 0.8]],
       [11, -2.2, 34.5, [1.8, 1, 0.7]],
       [11.23, -1, 33.9, [2, 1, 0.5]]
    ];
neck = [[-10, -0,0,[20,15,15]],[10, -15,0,[1,8,19]],[22, 22,0,[1,1,6]],[40, 8,0,[12,12,1]],[32, 0,0,[8,12,10]],[21, -6,0,[9,-3,1 ]],[21, -13,0,[3,6,6]] ,[19, -13,0,[3,3,5]] ];
cylinder(15,6,6,$fn=40);
difference(){
union(){
    ShowControl2(v);
    ShowControl2(v2);
    ShowControl2(v3);
    ShowControl2(face);
 
  mirror([0, 1, 0]) ShowControl2(face);

    translate([-1, 0, 13]) rotate([0, -90, 90]) {
       extrudeT(neck, 30, 0.15, 0.60, 0, 0.5) { //mane
          scale([1, 1.5, 1]) hull() {
             translate([0, 0.1, 0.1]) rotate([0, 90, 0]) sphere(0.1);
             translate([0, -1, 0.1]) rotate([0, 90, 0]) sphere(0.1);
             translate([0, -1, -0.1]) rotate([0, 90, 0]) sphere(0.1);
             translate([0, 0.1, -0.1]) rotate([0, 90, 0]) sphere(0.1);
          }
       }
       extrudeT(neck, 30, 0.15, 0.60, 0, 1) { //mane
          scale([0.8, 1.4, 0.8]) hull() {
             translate([0, 0.1, 0.1]) rotate([0, 90, 0]) sphere(0.1);
             translate([0, -1, 0.1]) rotate([0, 90, 0]) sphere(0.1);
             translate([0, -1, -0.1]) rotate([0, 90, 0]) sphere(0.1);
             translate([0, 0.1, -0.1]) rotate([0, 90, 0]) sphere(0.1);
          }
       }}
    }
hull(){
translate([8,0,30.7])rotate([90,0,0])cylinder(40,0.5,0.5,center=true);
translate([12,0,29.6])rotate([90,0,0])cylinder(40,0.9,0.9,center=true);
}
}
}
module buck(){ translate([-5,-4.7,38])rotate([0,0,-10])rotate([90,0,0])scale([0.5,0.5,0.45])rotate_extrude($fn=40)
{ 
intersection(){square(10);offset(r=1)offset(r=-2)offset(r=2,$fn=5){
 square([10,5]);
 translate([style[31]*10,5,0])rotate(90*style[28])square([1,1]);
 translate([style[33]*10,5,0])rotate(90*style[29]) square([1,1]);
 translate([style[34]*10,5,0])rotate(90*style[29]) square([2,2]);
}}
}}
module ShowControl2(v) { // translate(t(v[0])) sphere(v[0][3]);
   if (len(v[0][0]) != undef) {
      ShowSplControl(v);
   } else
      for (i = [1: len(v) - 1]) {
         // vg  translate(t(v[i])) sphere(v[i][3]);
         blendline(
            (t(v[i])), (t(v[i - 1])), (v[i][3]), (v[i - 1][3]));
      }
}
 

 
 
 module blendline(v1, v2, s1 = 1, s2 = 1) {
    d = 1 / 1;
    for (i = [0 + d: d: 1]) {
       hull() {
          translate(lerp(v1, v2, i)) scale(lerp(s1, s2, lerp(i, SC3(i), 0.5))) rotate([0, 0, 360 / 24]) ssphere(1);
          translate(lerp(v1, v2, i - d)) scale(lerp(s1, s2, lerp(i - d, SC3(i - d), 0.5))) rotate([0, 0, 360 / 24]) ssphere(1);
       }
    }
 }
 module ssphere() {
    hull() {
  sphere([0.25, 0.25, 1], $fn = 32);
       for (r = [0: 360 / 12: 360]) {
          rotate([0, 0, r]) translate([0.7, 0, 0.15]) sphere(0.4, $fn = 32);
          rotate([0, 0, r]) translate([0.7, 0, -0.15]) sphere(0.4, $fn = 32);
       }
    }
 }
module extrudeT(v,d=8,start=0,stop=1,twist=0,gap=1) {
         detail=1/d;

    for(i = [start+detail: detail: stop]) {
if($children>0){
       for (j=[0:$children-1]) 
      hull() {
        translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) rotate([twist*i,0,0]) children(j);
        translate(t(bez2(i - detail*gap, v))) rotate(bez2euler(i - detail*gap, v))scale(bez2(i- detail*gap  , v)[3]) rotate([twist*(i- detail),0,0]) children(j);
      }
    }else{
      hull() {
        translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) rotate([twist*i,0,0])rotate([0,-90,0])sphere(1);
        translate(t(bez2(i - detail*gap, v))) rotate(bez2euler(i - detail*gap, v))scale(bez2(i- detail*gap  , v)[3]) rotate([twist*(i- detail),0,0])rotate([0,-90,0])sphere(1);
      }}
}


  }


function lerp(start, end, bias) = (end * bias + start * (1 - bias));



module ShowControl(v)  
  {  // translate(t(v[0])) sphere(v[0][3]);
      for(i=[1:len(v)-1]){
       // vg  translate(t(v[i])) sphere(v[i][3]);
          hull(){
              translate(t(v[i])) sphere(1);
              translate(t(v[i-1])) sphere(1);
              }          }
      }
  //The recusive
function bez2(t, v) = (len(v) > 2) ? bez2(t, [
for(i = [0: len(v) - 2]) v[i] * (1 - t) + v[i + 1] * ( t)]): v[0] * (1 - t) + v[1] * ( t);

//
function lim31(l, v) = v / len3(v) * l;

function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
// unit normal to euler angles
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];

function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];
function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));
function clamp (a,b=0,c=10)=min(max(a,b),c);
function gauss(i,n=0)=n>0?let(x=gauss(i,n-1))x+(x-SC3(x)):let(x=i)x+(x-SC3(x));
