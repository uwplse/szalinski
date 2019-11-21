// band width[mm]
nauhanleveys = 24; // [24:1:39]
// underplate width[mm] 
alalevyn_leveys =26; // [26:1:39]
//underplate legth[mm]
alalevyn_pituus =20; // [18:1:39]

$fn = 30;

CubePoints = [  // viiste
  [  0,  -1,  19 ],  //0
  [ 32,  -1,  -14 ],  //1
  [ 32,  25,  -14 ],  //2
  [  0,  25,  19 ],  //3
  [  0,  -1,  50 ],  //4
  [ 32,  -1,  50 ],  //5
  [ 32,  25,  50 ],  //6
  [  0,  25,  50 ]]; //7
  
CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
 

  difference(){
translate([-2,0,0])
cube([16+nauhanleveys/3-10,21,25],false); //alkupalikka
      
translate([2.5,2,0]) // alinrako
cube([5+nauhanleveys/3-10,2,25],false);      
      
translate([4,16,0]) // ylinrako
cube([6+nauhanleveys/3-10,2,25],false);      
      
translate([5,12,0]) // 2. ylinrako
cube([2.5+nauhanleveys/3-10,2,25],false);

intersection(){
difference(){
translate([6.25+nauhanleveys/3-10,8,7.5])
cylinder(h=25, r=6, center=true);
translate([0,12,0])
cube([3.5,4,20],false);}  
   
translate([5+nauhanleveys/3-10,0,0])
cube([25,25,25],false);    }     
    
intersection(){ 
translate([5,15,7.5])
cylinder(h=25, r=3, center=true); 
cube([5,25,25],false);}  
      
polyhedron( CubePoints, CubeFaces );

suuaukkoreika();
suuaukkoreika1();
suuaukkocube();
ohjainreika();
alaohjainreika();
ura2();

translate([-3,-1,18]) 
cube([14,26,15],false); //reunan tasaus
  }
  

  difference(){
translate([5,15,7.5]) //yläkielekkeen pyöristys
cylinder(h=15, r=1, center=true); 
     polyhedron( CubePoints, CubeFaces );
translate([-1,-1,14]) 
cube([25,25,15],false);
  } 

 difference(){  
translate([5,14,0]) // yläkieleke
cube([3,2,15],false);
     polyhedron( CubePoints, CubeFaces );
  }

  difference(){ 
translate([6.25+nauhanleveys/3-10,8,8])
cylinder(h=16, r=4, center=true);
    polyhedron( CubePoints, CubeFaces );
suuaukkoreika();
suuaukkoreika1();
suuaukkocube();
ohjainreika();
alaohjainreika();
ura2();
  }  
 
  difference(){
translate([2,4,0])  
cube([4.5+nauhanleveys/3-10,8,25],false); //keskipalikka
      polyhedron( CubePoints, CubeFaces );
suuaukkoreika();
suuaukkoreika1();      
suuaukkocube();
ohjainreika();
alaohjainreika();
ura2();
  }
  
  difference(){
lisake();
suuaukkoreika();
suuaukkoreika1();      
suuaukkocube();
ohjainreika();
alaohjainreika();
ura();
  }

module lisake(){
    Pointsit = [
  [  -2,  0,  18 ],  //0
  [ -2,  21,  18 ],  //1
  [ -5,  21,  18 ],  //2
  [  -5,  0,  18 ],  //3
  [ -2,  21,  0 ],  //4
  [ -2,  0,  0 ]];  //5
  
  Naamat = [
  [3,2,1,0],  // bottom
  [1,4,5,0],  // front
  [3,5,4,2],  //back
  [4,1,2], // left
  [0,5,3]]; // right
    
 polyhedron(Pointsit, Naamat );}
 
  
module suuaukkoreika(){
    rotate([90,90,90])
translate([-10+nauhanleveys/3-10,8,-5])
cylinder(h=30, r=3, center=false);}

module suuaukkocube(){
translate([-6,5,8-(nauhanleveys/3-10)]) // suuaukkocube
     rotate([0,-7,0])   
cube([118,6,15],false); }

module ohjainreika(){
    $fn = 6;
       rotate([90,0,0])
translate([0,16.5,-35])
    rotate([0,0,30])
cylinder(h=25, r=0.75, center=false);} 

module alaohjainreika(){
    $fn = 6;
       rotate([90,0,0])
translate([-2,16.5,-10])
    rotate([0,0,30])
cylinder(h=25, r=0.75, center=false);} 



module suuaukkoreika1(){
    rotate([90,90,90])
translate([-8+nauhanleveys/3-10,8,-5])
    rotate([0,-7,0])
cylinder(h=30, r=3, center=false);}

module ura(){
    $fn = 6;
       rotate([90,0,0])
translate([-4.8,16.5,-35])
    rotate([0,0,30])
cylinder(h=25, r=0.75, center=false);} 

module pidike(){
    translate([0,11,16]) 
     rotate([0,0,0])   
cube([3,10,2],false); }

module ura2(){
    $fn = 6;
       rotate([90,0,0])
translate([3,16.5,-35])
    rotate([0,0,30])
cylinder(h=25, r=0.75, center=false);} 

difference(){
pidike();
ohjainreika();
ura2();}

    translate([1,0,0]) 
     rotate([0,0,0])   
cube([alalevyn_pituus,1.5,alalevyn_leveys],false); 

module tarjotin(){
    Pointsit1 = [
  [  11,  1.5,  12 ],  //0
  [ 11,  7.5,  12 ],  //1
  [ 19, 1.5,  12 ],  //2
  [ 19,  1.5,  12 ],  //3
  [ 19,  0,  5 ],  //4
  [ 19,  0,  5 ]];  //5
  
  Naamat1 = [
  [3,2,1,0],  // bottom
  [1,4,5,0],  // front
  [3,5,4,2],  //back
  [4,1,2], // left
  [0,5,3]]; // right
    
 polyhedron(Pointsit1, Naamat1 );}
 
 module tarjotin3(){
    Pointsit2 = [
  [  5,  1.5,  20 ],  //0
  [ 5,  7.5,  20 ],  //1
  [ 11, 1.5,  25 ],  //2
  [ 11,  1.5,  25 ],  //3
  [ 19,  1.5,  20 ],  //4
  [ 19,  1.5,  20 ]];  //5
  
  Naamat2 = [
  [3,2,1,0],  // bottom
  [1,4,5,0],  // front
  [3,5,4,2],  //back
  [4,1,2], // left
  [0,5,3]]; // right
    
 polyhedron(Pointsit2, Naamat2 );}
 
 CubePoints1 = [  // tarjotin2
  [  11,  0,  12 ],  //0
  [ 19,  0,  12 ],  //1
  [ 19,  1.5,  12 ],  //2
  [  11,  7.5,  12 ],  //3
  [  5,  0,  20 ],  //4
  [ 19,  0,  20 ],  //5
  [ 19,  1.5,  20 ],  //6
  [  5,  7.5,  20 ]]; //7
  
CubeFaces1 = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left

rotate([0,0,0]){   
tarjotin();
polyhedron( CubePoints1, CubeFaces1 );
tarjotin3();}


