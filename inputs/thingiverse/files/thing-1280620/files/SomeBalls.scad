/*
SomeBalls.scad
Public Domain Code
Based on Metaballs By: William A Adams 	4 June 2011

This code is a simplified implementation of the 'metaball' and uses "Marching Cubes" to register the isosurface which is the interaction of the various balls. All Cubes are tested and a joint hull is generated of each corner that lies inside the threshold  of the metaball 

Future work : 
For obvious reasons linearly interpolated marching cubes. 
A more elegant cube solution than just hulling corners. 
Cube subdivision for speed up.

*/
Resolution = 10;//[5:5:50]
MinSubdivisions=4;//[2:1:10] 
// Smaller number larger blob
Threshold = 1.85;// [1.5:0.01:2.5]
Diagnostic=false;
Oversize=0.6;
// List Format [[x,y,z,r],[x,y,z,r]]
MyBallList=[[50, 50, 50, -11],[25, 5, 5, 35],[95, 5, 75, 45],[-35, 5, 75, 55]];//
//MyBallList=[ for(i=[0:5])Lotto()];
DrawMetaballs(MyBallList);


module DrawMetaballs(BallList) {
 ColorList = [ for(i=[0:len(BallList)])rndc() ];
 
// boundary plus some extra
size=max(findMax(BallList, 0),findMax(BallList, 1),findMax(BallList,2));
DrawSubMetaballs(BallList,ColorList,findMin(BallList, 0)-(size*Oversize),findMin(BallList, 1)-(size*Oversize),findMin(BallList, 2)-(size*Oversize),size*(Oversize*2+1)); 
    


 }
module DrawSubMetaballs(BallList,ColorList,x,y,z,Size,i=0) {    
  //  echo(i,Size);

suma = BallField3D(x, y, z, BallList, len(BallList) - 1);
sumb = BallField3D(x + Size, y, z, BallList, len(BallList) - 1);
sumc = BallField3D(x, y + Size, z, BallList, len(BallList) - 1);
sumd = BallField3D(x + Size, y + Size, z, BallList, len(BallList) - 1);
sume = BallField3D(x, y, z + Size, BallList, len(BallList) - 1);
sumf = BallField3D(x + Size, y, z + Size, BallList, len(BallList) - 1);
sumg = BallField3D(x, y + Size, z + Size, BallList, len(BallList) - 1);
sumh = BallField3D(x + Size, y + Size, z + Size, BallList, len(BallList) - 1);
sumcolor =lim31(1, ColorField3D(x, y, z, BallList,ColorList, len(BallList) - 1));


    
sab=inter(suma,sumb)*Size;
sac=inter(suma,sumc)*Size;
sae=inter(suma,sume)*Size;
sba=inter(sumb,suma)*Size;
sbd=inter(sumb,sumd)*Size;
sbf=inter(sumb,sumf)*Size;
sca=inter(sumc,suma)*Size;
scd=inter(sumc,sumd)*Size;
scg=inter(sumc,sumg)*Size;
sdb=inter(sumd,sumb)*Size;
sdc=inter(sumd,sumc)*Size;
sdh=inter(sumd,sumh)*Size;
sea=inter(sume,suma)*Size;
seg=inter(sume,sumg)*Size;
sef=inter(sume,sumf)*Size;
sfh=inter(sumf,sumh)*Size;
sfe=inter(sumf,sume)*Size;
sfb=inter(sumf,sumb)*Size;
sge=inter(sumg,sume)*Size;
sgh=inter(sumg,sumh)*Size;
sgc=inter(sumg,sumc)*Size;
shg=inter(sumh,sumg)*Size;
shf=inter(sumh,sumf)*Size;
shd=inter(sumh,sumd)*Size;

// test for empty and full Cubes
 if (Size>pow(Resolution, MinSubdivisions)||i<MinSubdivisions) { 
    h=Size*0.5  ;
    DrawSubMetaballs(BallList,ColorList,x,y,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,x+h,y,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,x,y+h,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,x+h,y+h,z,h,i+1);
    
    DrawSubMetaballs(BallList,ColorList,x,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,x+h,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,x,y+h,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,x+h,y+h,z+h,h,i+1);
    
    }else {
    
if (  suma <= Threshold && sumb <= Threshold && sumc <= Threshold && sumd <= Threshold && sume <= Threshold && sumf <= Threshold && sumg <= Threshold && sumh <= Threshold) {if (Diagnostic){translate([x, y, z]) %cube(Size);}} 
else if ( suma > Threshold && sumb > Threshold && sumc > Threshold && sumd > Threshold && sume > Threshold && sumf > Threshold && sumg > Threshold && sumh > Threshold) {
translate([x, y, z]) cube(Size);} 


else if(Size>Resolution){ 
    h=Size*0.5  ;
    DrawSubMetaballs(BallList,ColorList,x,y,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,x+h,y,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,x,y+h,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,x+h,y+h,z,h,i+1);
    
    DrawSubMetaballs(BallList,ColorList,x,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,x+h,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,x,y+h,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,x+h,y+h,z+h,h,i+1);}
else { 

    // For every corner inside treshold make and mirror a corner piece, hull the lot.
   //echo(sumcolor);
    color(sumcolor)hull(){
if (suma > Threshold){    translate([x, y, z])  Corner(sab,sac,sae);}
if (sumb > Threshold){    translate([x + Size, y, z])  Corner(-sba,sbd,sbf);}
if (sumc > Threshold){  translate([x, y + Size, z])  Corner(scd,-sca,scg);}
if (sumd > Threshold){    translate([x + Size, y + Size, z]) Corner(-sdc,-sdb,sdh);}
    
if (sume > Threshold){   translate([x, y, z + Size])  Corner(sef,seg,-sea);}
if (sumf > Threshold){   translate([x + Size, y, z + Size])  Corner(-sfe,sfh,-sfb);}
if (sumg > Threshold){    translate([x, y + Size, z + Size])  Corner(sgh,-sge,-sgc);}
if (sumh > Threshold){    translate([x + Size, y + Size, z + Size]) Corner(-shg,-shf,-shd);}
}
    }
}}




//Corner piece
module Corner(u=0.5,v=0.5,w=0.5) {scale([u,v,w])
polyhedron
    (points = [	       [0,0,0],[1,0,0],[0,1,0],[0,0,1],],      faces = [		  [0,0,1],[0,0,2],[0,0,3],[1,2,3]
		  ]
     );}
     
     function lim31(l, v) = v / len3(v) * l;
     function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
// Random color

function Lotto() = [rands(0, 200, 1)[0],rands(0, 100, 1)[0],rands(0, 100, 1)[0],rands(20, 21, 1)[0]];

//Field function
     function ColorField3D(x, y, z, BallSack,Colorsack, i) = (i == 0) ? Powercolor(x, y, z, BallSack[0])*Colorsack[0]: Powercolor(x, y, z, BallSack[i])*Colorsack[i] + ColorField3D(x, y, z, BallSack,Colorsack, i - 1);

function Powercolor(x, y, z, Ball) = (Ball[3] / sqrt((x - Ball[0]) * (x - Ball[0]) + (y - Ball[1]) * (y - Ball[1]) + (z - Ball[2]) * (z - Ball[2])));     
function Powerball(x, y, z, Ball) = (Ball[3] / sqrt((x - Ball[0]) * (x - Ball[0]) + (y - Ball[1]) * (y - Ball[1]) + (z - Ball[2]) * (z - Ball[2])));
// Recursive Field Evaluation
function BallField3D(x, y, z, BallSack, i) = (i == 0) ? Powerball(x, y, z, BallSack[0]): Powerball(x, y, z, BallSack[i]) + BallField3D(x, y, z, BallSack, i - 1);
function rndc() = [round(rands(0, 2, 1)[0])/2, round(rands(0, 2, 1)[0])/2, round(rands(0, 2, 1)[0])/2];
     //interpolate
function inter(t,r)=(t==r)?1:(t>Threshold)?(r<Threshold)? abs(Threshold-t)/abs(t-r) :0 :(r>Threshold)? abs(Threshold-t)/abs(t-r) :1 ;
// Recursive find min/max extremes
function findMax(v, select, i = 0) = ((i + 1) < len(v)) ? max(v[i][select] + v[i][3] + Resolution, findMax(v, select, i + 1)): v[i][select] + v[i][3] + Resolution;
function findMin(v, select, i = 0) = ((i + 1) < len(v)) ? min(v[i][select] - v[i][3] - Resolution, findMin(v, select, i + 1)): v[i][select] - v[i][3] - Resolution;