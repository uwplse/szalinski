/*
TerrainTile.scad
Public Domain Code
Based on Metaballs By: William A Adams 	4 June 2011

This code is a simplified implementation of "Marching Cubes" over Noise + a Z gradient. A isosurface which is the interaction of the Noise field in tree octaves: half, one and four. All Cubes are tested and a joint hull is generated of each corner that lies inside the threshold  of the metaball 

*/

randseed=3798753;
Resolution =1; 
tileX=0;
tileY=0;
MinSubdivisions=3;//[0:1:5] 
Threshold = 0.40;// [0:0.01:1]
// Allways clamped to powers of two of resolution 
tilesize=16;//[1:1:64] 
// Small Medium Large
octavebalance=[40,150,280];
Zcutoff=5;
Zfalloff=0.1909;// [0:0.001:1]
Zoffset=3;
Diagnostic=false; 
colorseed=rands(0, 49709639, 1)[0]; 
DrawMetaballs( Threshold,tileX*f2(tilesize),tileY*f2(tilesize),-1,tilesize); 

/// end


module DrawMetaballs( Threshold,sx,sy,sz,sSize){
// clamp everyting to multiples and powers of resolution
x=f(sx);
y=f(sy);
    z=f(sz);
    Size=f2(sSize);
   // echo ( Threshold,x,y,z,Size);
DrawSubMetaballs( Threshold,x,y,z,Size); 
}
module DrawSubMetaballs( Threshold,x,y,z,Size,i=0) {    



suma = Octavenoice (x, y, z);
sumb = Octavenoice (x + Size, y, z );
sumc = Octavenoice (x, y + Size, z);
sumd = Octavenoice (x + Size, y + Size, z);
sume = Octavenoice (x, y, z + Size);
sumf = Octavenoice (x + Size, y, z + Size);
sumg = Octavenoice (x, y + Size, z + Size);
sumh = Octavenoice (x + Size, y + Size, z + Size);
sumcolor =[0.1,1,0]*0.3+0.7*[1-abs(Sweetnoise (x/5, y/5, z/5,colorseed+27)),1-abs(Sweetnoise (x/5, y/5, z/5,colorseed+13)),1-abs(Sweetnoise (x/5, y/5, z/5,colorseed))];




// test for empty and full Cubes
 if (i<=MinSubdivisions&&z<Zcutoff) { 
    h=Size*0.5  ;
    DrawSubMetaballs( Threshold,x,y,z,h,i+1);
    DrawSubMetaballs( Threshold,x+h,y,z,h,i+1);
    DrawSubMetaballs( Threshold,x,y+h,z,h,i+1);
    DrawSubMetaballs( Threshold,x+h,y+h,z,h,i+1);
    
    DrawSubMetaballs( Threshold,x,y,z+h,h,i+1);
    DrawSubMetaballs( Threshold,x+h,y,z+h,h,i+1);
    DrawSubMetaballs( Threshold,x,y+h,z+h,h,i+1);
    DrawSubMetaballs( Threshold,x+h,y+h,z+h,h,i+1);
    
    }else {
    
if (  suma >=  Threshold && sumb >=  Threshold && sumc >=  Threshold && sumd >=  Threshold && sume >=  Threshold && sumf >=  Threshold && sumg >=  Threshold && sumh >=  Threshold) {if (Diagnostic){translate([x, y, z]) %cube(Size);}} 
else if ( suma < Threshold && sumb < Threshold && sumc < Threshold && sumd < Threshold && sume < Threshold && sumf < Threshold && sumg < Threshold && sumh < Threshold) {
translate([x, y, z])  color(sumcolor) cube(Size);} 


else if(Size>Resolution){ 
    h=Size*0.5  ;
    DrawSubMetaballs( Threshold,x,y,z,h,i+1);
    DrawSubMetaballs( Threshold,x+h,y,z,h,i+1);
    DrawSubMetaballs( Threshold,x,y+h,z,h,i+1);
    DrawSubMetaballs( Threshold,x+h,y+h,z,h,i+1);
    
    DrawSubMetaballs( Threshold,x,y,z+h,h,i+1);
    DrawSubMetaballs( Threshold,x+h,y,z+h,h,i+1);
    DrawSubMetaballs( Threshold,x,y+h,z+h,h,i+1);
    DrawSubMetaballs( Threshold,x+h,y+h,z+h,h,i+1);}
else { 

    // For every corner inside treshold make and mirror a corner piece, hull the lot.
   //echo(sumcolor);
    color(sumcolor)hull(){
        
        sab=inter(suma,sumb,Threshold)*Size;
sac=inter(suma,sumc,Threshold)*Size;
sae=inter(suma,sume,Threshold)*Size;
sba=inter(sumb,suma,Threshold)*Size;
sbd=inter(sumb,sumd,Threshold)*Size;
sbf=inter(sumb,sumf,Threshold)*Size;
sca=inter(sumc,suma,Threshold)*Size;
scd=inter(sumc,sumd,Threshold)*Size;
scg=inter(sumc,sumg,Threshold)*Size;
sdb=inter(sumd,sumb,Threshold)*Size;
sdc=inter(sumd,sumc,Threshold)*Size;
sdh=inter(sumd,sumh,Threshold)*Size;
sea=inter(sume,suma,Threshold)*Size;
seg=inter(sume,sumg,Threshold)*Size;
sef=inter(sume,sumf,Threshold)*Size;
sfh=inter(sumf,sumh,Threshold)*Size;
sfe=inter(sumf,sume,Threshold)*Size;
sfb=inter(sumf,sumb,Threshold)*Size;
sge=inter(sumg,sume,Threshold)*Size;
sgh=inter(sumg,sumh,Threshold)*Size;
sgc=inter(sumg,sumc,Threshold)*Size;
shg=inter(sumh,sumg,Threshold)*Size;
shf=inter(sumh,sumf,Threshold)*Size;
shd=inter(sumh,sumd,Threshold)*Size;
if (suma < Threshold){    translate([x, y, z])  Corner(sab,sac,sae);}
if (sumb < Threshold){    translate([x + Size, y, z])  Corner(-sba,sbd,sbf);}
if (sumc < Threshold){  translate([x, y + Size, z])  Corner(scd,-sca,scg);}
if (sumd < Threshold){    translate([x + Size, y + Size, z]) Corner(-sdc,-sdb,sdh);}
    
if (sume < Threshold){   translate([x, y, z + Size])  Corner(sef,seg,-sea);}
if (sumf < Threshold){   translate([x + Size, y, z + Size])  Corner(-sfe,sfh,-sfb);}
if (sumg < Threshold){    translate([x, y + Size, z + Size])  Corner(sgh,-sge,-sgc);}
if (sumh < Threshold){    translate([x + Size, y + Size, z + Size]) Corner(-shg,-shf,-shd);}
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

function Lotto(i) = [rands(i*30,i*30+ 30, 1)[0],rands(0, 65, 1)[0],rands(0, 75, 1)[0],rands(21, 24, 1)[0]];

//Field function
     function ColorField3D(x, y, z, BallSack,Colorsack, i) = (i == 0) ? Powercolor(x, y, z, BallSack[0])*Colorsack[0]: Powercolor(x, y, z, BallSack[i])*Colorsack[i] + ColorField3D(x, y, z, BallSack,Colorsack, i - 1);

function Powercolor(x, y, z, Ball) = (Ball[3] / sqrt((x - Ball[0]) * (x - Ball[0]) + (y - Ball[1]) * (y - Ball[1]) + (z - Ball[2]) * (z - Ball[2]))); 
     
//function Powerball(x, y, z, Ball) = (Ball[3] / sqrt((x - Ball[0]) * (x - Ball[0]) + (y - Ball[1]) * (y - Ball[1]) + (z - Ball[2]) * (z - Ball[2])));
 function Powerball(x, y, z, Ball)   = Coldnoise (x,y,z);
// Recursive Field Evaluation
function BallField3D(x, y, z, BallSack, i) = (i == 0) ? Powerball(x, y, z, BallSack[0]): Powerball(x, y, z, BallSack[i]) + BallField3D(x, y, z, BallSack, i - 1);
function rndc() = [round(rands(0, 2, 1)[0])/2, round(rands(0, 2, 1)[0])/2, round(rands(0, 2, 1)[0])/2];
     //interpolate
function inter(t,r,Threshold)=(t==r)?1:(t>Threshold)?(r<Threshold)? abs(Threshold-t)/abs(t-r) :0 :(r>Threshold)? abs(Threshold-t)/abs(t-r) :1 ;
// Recursive find min/max extremes
function findMax(v, select, i = 0) = ((i + 1) < len(v)) ? max(v[i][select] + abs(v[i][3]) + Resolution, findMax(v, select, i + 1)): v[i][select] + abs(v[i][3]) + Resolution;
function findMin(v, select, i = 0) = ((i + 1) < len(v)) ? min(v[i][select] - abs(v[i][3]) - Resolution, findMin(v, select, i + 1)): v[i][select] - abs(v[i][3]) - Resolution;
function Coldnoise (x,y,z,seed=69940 )= 
((3754853343/((abs((floor(x+40)) ))+1))%1
+(3628273133/((abs((floor(y+44) ) ))+1) )%1
+(3500450271/((abs((floor(z+46 )) ))+1) )%1
+(3367900313/(abs(seed)+1) )/1)%1 ;

function Sweetnoise (x,y,z,seed=69840)=(z-Zoffset)*Zfalloff+tril( SC3(x-floor(x)), (SC3(y-floor(y))), (SC3(z-floor(z))),
    Coldnoise ((x ) ,(y ) ,(z ) ,seed),
    Coldnoise ((x+1  ),(y ) ,(z ) ,seed),
    Coldnoise ((x ) ,(y+1 ) ,(z ) ,seed),
    Coldnoise ((x ) ,(y ) ,(z+1) ,seed),
    Coldnoise ((x  +1),(y ) ,(z+1 ) ,seed),
    Coldnoise ((x ) ,(y+1 ) ,(z+1 ) ,seed),
    Coldnoise ((x+1 ),(y+1) ,(z ) ,seed),
    Coldnoise ((x +1) ,(y+1),(z+1 ) ,seed));
    
   function SC3 (a)= (a * a * (3 - 2 * a))
   ;
function tril(x,y,z,V000,V100,V010,V001,V101,V011,V110,V111) =	
/*V111* (1 - x)* (1 - y)* (1 - z) +
V011* x *(1 - y) *(1 - z) + 
V101* (1 - x) *y *(1 - z) + 
V110* (1 - x) *(1 - y)* z +
V010* x *(1 - y)* z + 
V100* (1 - x)* y *z + 
V001* x *y* (1 - z) + 
V000* x *y *z
*/
V000*  (1 - x)* (1 - y)* (1 - z) +
V100*  x *(1 - y) *(1 - z) + 
V010*  (1 - x) *y *(1 - z) + 
V001*  (1 - x) *(1 - y)* z +
V101*  x *(1 - y)* z + 
V011*  (1 - x)* y *z + 
V110*  x *y* (1 - z) + 
V111*  x *y *z

;
function Octavenoice(x, y, z,seed=randseed) =let(SML=lim31(1,octavebalance))(Sweetnoise (x*1, y*1, z*1,seed)*SML[0]+Sweetnoise (x/2, y/2, z/2,seed)*SML[1]+  Sweetnoise (x/4, y/4, z/4,seed)*SML[2]);
function f(a)= floor(a/Resolution)*Resolution;
function f2(a)= pow(2, round(log(a/(Resolution))/log(2)))*Resolution;

