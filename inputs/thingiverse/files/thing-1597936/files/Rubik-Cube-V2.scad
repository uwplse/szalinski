/*---------------------------------------------------------\
|     From: Ekobots Innovation Ltda - www.ekobots.com.br   |
|       by: Juan Sirgado y Antico - www.jsya.com.br        |
|----------------------------------------------------------|
|            Program Rubik Cube - 2016/05/29               |
|               All rights reserved 2016                   |
|---------------------------------------------------------*/
/* [ Global ] */

/* [ Rubik´s Cube ] */

// Object faces (resolution of curves).
number_faces = 30;
// Block pieces distance.
block_distance = 0.25;
// Core pieces distance.
core_distance = 0.50;
// Create support bars (0=No, 1=Yes).
support_bars = 1; // [0,1]
// Dice notation (0=No, 1=Yes).
dice_notation = 1; // [0,1]

/* [ Hidden ] */

f = number_faces;    // number of faces for objects;
d = 20;              // distance of the pieces;
c = block_distance;  // cut adjust for the blocks;
g = core_distance;   // cut adjust for the core;
s = 20-c;            // block size;
b = 2-(c/2);         // border size;
//---------------------------------------------------------|
// Animate --> fps: 30 Steps: 600
// color([0.8,0.8,0.1],1) rubikCubeHalf(); // Half Cube;
//---------------------------------------------------------|
color([0.8,0.8,0.1],1) rubikCubeFull(); // Full Cube;
//---------------------------------------------------------|
module rubikCubeFull()
{
   difference()
   {
      union()
      {
         translate([0,0,0])  
            rubikCube(d);
         if(support_bars)
         {
            translate([0,0,0])    
                support_23();
         }
      }
      if(dice_notation)
      {
         for(n = [0,5])
            rotate([0,0,90]) 
               translate([0,0,n>2?d+10:-d-10]) 
                  diceFace(n,d);
         for(n = [1,4])
            rotate([0,90,0]) 
               translate([0,0,n>2?d+10:-d-10]) 
                  diceFace(n,d);
         for(n = [2,3])
            rotate([90,0,0]) 
               translate([0,0,n>2?d+10:-d-10]) 
                  diceFace(n,d);
      }
   }
}
//---------------------------------------------------------|
module rubikCube()
{
     // Core of cube
     translate([0,0,0])  
        piece_0(); // Core of cube
     // Centers of faces 6 pieces
     for(r = [[0,0,0],[0,0,90],[0,90,0],[0,0,180],[0,0,-90],[0,-90,0]])
        rotate(r) 
           translate([d,0,0])  
              rotate([0,-90,0]) 
                 piece_1(); // Center of cube
     // Cardinais of faces 12 pieces
     for(r = [[0,0,0],[0,0,90],[0,90,0],[90,0,90]])
        rotate(r) 
           translate([d,d,0])  
              rotate([90,0,-90]) 
                 piece_2(); // Cardinal of Cube
     for(r = [[0,0,0],[0,0,90],[0,90,0],[90,0,90]])
        rotate(r) 
           translate([-d,-d,0])  
              rotate([90,0,90]) 
                 piece_2(); // Cardinal of Cube
     for(r = [[0,0,90],[0,180,90],[0,0,-90],[0,180,-90]])
        rotate(r+[0,0,0]) 
           translate([0,d,d])  
              rotate([0,90,-90]) 
                 piece_2(); // Cardinal of Cube
     // Corners of cube 8 pieces
     for(r = [[0,0,0],[0,0,90],[0,90,0],[0,90,90]])
        rotate(r) 
           translate([-d,-d,-d])  
              piece_3(); // Corner of Cube
     for(r = [[0,0,0],[0,0,90],[0,90,0],[0,90,90]])
        rotate(r) 
           translate([d,d,d])  
              rotate([0,180,90]) 
                 piece_3(); // Corner of Cube
}
//---------------------------------------------------------|
module rubikCubeHalf()
{
   difference()
   {
      rotate([0,0,360*$t])
         translate([0,0,0])  
            rubikCube(d);
      translate([0,50,0])
         cube([100,100,100],center=true); 
   }
}
//---------------------------------------------------------|
module piece_0() // Core of cube
{
   difference()
   {
      translate([0,0,0])    
         sphere(d=35-g,center=true,$fn=f);
      translate([0,0,0])    
         sphere(d=20,center=true,$fn=f);
      for(i=[[0,0,0],[0,90,0],[90,0,0],
             [0,180,0],[0,-90,0],[-90,0,0]])
         rotate([i[0],i[1],i[2]])
            translate([0,0,10])    
               sphere(d=14+g,center=true,$fn=f);
      for(i=[[0,0,0],[0,90,0],[90,0,0],
             [0,180,0],[0,-90,0],[-90,0,0]])
         rotate([i[0],i[1],i[2]])
            translate([0,0,15])    
               cylinder(h=5,d=10+g,center=true,$fn=f);
   }
}
//---------------------------------------------------------|
module piece_1() // Center of cube
{
   union()
   {
      difference()
      {
         translate([0,0,0])  
             block(s,b); 
         translate([0,0,20]) 
            sphere(d=48+c,center=true,$fn=f);
      }
      translate([0,0,0]) 
         cylinder(h=18,d=10-c,center=true,$fn=f);
      difference()
      {
         translate([0,0,10])    
            sphere(d=14-c,center=true,$fn=f);
//         translate([0,0,20]) 
//            sphere(d=20+c,center=true,$fn=f);
      }
      translate([0,0,10])    
         support_1();
   }
}
//---------------------------------------------------------|
module piece_2() // Border of Cube
{
   difference()
   {
      union()
      {
         difference()
         {
            translate([0,0,0])  
               block(s,b); 
            translate([20,0,20]) 
               sphere(d=48+c,center=true,$fn=f);
         }
         intersection()
         {
            translate([20,0,20]) 
               sphere(d=48-c,center=true,$fn=f);
            translate([5,0,5]) 
               cube([20-c,10-c,20-c],center=true); 
         }
         translate([2.5,0,2.5]) 
            cube([15-c,10-c,15-c],center=true); 
      }
      translate([20,0,20]) 
         rotate([0,45,0]) 
            sphere(d=35+c,center=true,$fn=f);
   }    
}
//---------------------------------------------------------|
module piece_3() // Corner of Cube
{
   difference()
   {
      union()
      {
         translate([0,0,0])  
            block(s,b); 
         intersection()
         {
            translate([20,20,20]) 
               sphere(d=48-c,center=true,$fn=f);
            translate([5,5,5]) 
               cube([20-c,20-c,20-c],center=true);
         }
      }
      translate([20,20,20]) 
        sphere(d=35+c,center=true,$fn=f);
   }    
}
//---------------------------------------------------------|
module support_1() // piece 1 support
{
   union()
   {
      translate([0,0,0]) 
         cylinder(h=20,d=1,center=true,$fn=f);
      translate([0,0,0]) 
         rotate([0,90,0]) 
            cylinder(h=20,d=1,center=true,$fn=f);
      translate([0,0,0]) 
         rotate([90,0,0]) 
            cylinder(h=20,d=1,center=true,$fn=f);
   }
}
//---------------------------------------------------------|
module support_23() // piece 2 and 3 support
{
   for(x=[28,20,12,8,0,-8,-12,-20,-28])
      for(y=[28,-28])
         translate([x,y,0]) 
              cylinder(h=30,d=1,center=true,$fn=f);
   for(x=[28,-28])
      for(y=[20,12,8,0,-8,-12,-20])
         translate([x,y,0]) 
            cylinder(h=30,d=1,center=true,$fn=f);
   for(x=[20,12,8,-8,-12,-20,])
      for(y=[24,-24])
         translate([x,y,0]) 
              cylinder(h=30,d=1,center=true,$fn=f);
   for(x=[24,-24])
      for(y=[20,12,8,-8,-12,-20])
         translate([x,y,0])
            cylinder(h=30,d=1,center=true,$fn=f);
   for(x=[25,-25])
      translate([x,0,0])
         cylinder(h=30,d=1,center=true,$fn=f);
   for(y=[25,-25])
      translate([0,y,0])
         cylinder(h=30,d=1,center=true,$fn=f);
}
//---------------------------------------------------------|
module block( // Block of cube
// my minkowski (not bad, more fast and good $fn)
// - - - - - - - - - - - - - - - - - - - - - - - - - - -
   // User configurable variables
   s = 20,   // External size of cube
   b = 2)    // Border diameter for cube
// - - - - - - - - - - - - - - - - - - - - - - - - - - -
{
   // Program others variables
   c = s - (b * 2); // Core size of cube
   h = c / 2;       // Core half size of cube
   union()
   {
      // Cube external corners
      for(r = [0:90:270])
         rotate([0,r,0])
            for(y = [h,-h])
               translate([h,y,h])
                  sphere(b,center=true,$fn=30); // Cube corners
      // Cube external borders
      for(r = [0:90:270])
         rotate([0,r,0])
            for(y = [h,-h])
               translate([h,y,0])
                  cylinder(c,b,b,center=true,$fn=30); // Cube borders
      // Cube external borders (axis y)
      for(r = [0:90:270])
         rotate([0,r,0])
            translate([h,0,h]) 
               rotate([90,0,0])
                  cylinder(c,b,b,center=true,$fn=30); // Cube borders
      // Cube external walls
      for(r = [0:90:270])
         rotate([0,r,0])
            translate([b,0,0])
               cube([c,c,c],center=true); // Cube faces
      // Cube external walls  (axis y)
      for(y = [b,-b])
         translate([0,y,0])
            cube([c,c,c],center=true); // Cube faces
   }
}
//---------------------------------------------------------|
module diceFace(n,d) // Number for dice face (dice face number)
{
   for(x=[-1:1:1])
      for(y=[-1:1:1])
         translate([x*d,y*d,0]) 
            diceNumber(n);     
}
//---------------------------------------------------------|
module diceNumber(n) // Number for dice face (dice face number)
{
   p = 5;  // Place for hole 
   h = 2;  // Size for hole
   f = 36; // Faces for hole
   // Position for dots
   xy = [[[0,0]],                                     // Number 1
         [[p,p],[-p,-p]],                             // Number 2
         [[p,p],[0,0],[-p,-p]],                       // Number 3
         [[p,p],[p,-p],[-p,p],[-p,-p]],               // Number 4
         [[p,p],[p,-p],[0,0],[-p,p],[-p,-p]],         // Number 5
         [[p,p],[p,-p],[0,p],[0,-p],[-p,p],[-p,-p]]]; // Number 6

   for(v=xy[n])   
      translate([v[0],v[1],0]) 
         sphere(r=h,center=true,$fn=30);
}//---------------------------------------------------------|