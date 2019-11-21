/* [Global] */

//example would you like?  If you choose "arbitrary isogonal" then also selct the "Isogonal" tab, above, to change the spherical coordinates of the starting vertex.
which = 0;//[0:arbitrary isogonal, 1:cube, 2:octahedron, 3:truncated cube, 4:truncated octahderon, 5:cubeoctahedron, 6:rhombicubeoctahedron, 7:rhombitruncatedcubeoctahedron, 8:Great Truncated Cuboctahedron,9:Great Cubicuboctahedron]

//of circumsphere
radius = 20;//[10:200]

//number of sides in the cross section of each edge
n = 20;//[3:40]

//of each edge
thickness=1;//[1:0.1:10]

/* [Uniform] */

//coordinates of the starting vertex for the uniform examples is predetermined.
The = 0;//[0,0]

/* [Isogonal] */

//is the longitude of the starting vertex.
a1 = 30;//[0:0.1:360]

//is the lattitude of the starting vertex.
a2 = 70;//[-90:0.1:90]

/* [Hidden] */
module bone2(rad1,rad2,height,fn){
hull(){
translate([0,0,height])
       sphere(r=rad2,center=true,$fn=fn);
sphere(r=rad1,center=true,$fn=fn);
  }  }     
 
module base(p1,num,r,fn)
  {union()
      {edge2(p1,
             [[1,0,0],
              [0,-1,0],
              [0,0,1]]*p1,
              r,r,fn);
       edge2(p1,
             [[cos(360/num),sin(360/num),0],
              [sin(360/num),-cos(360/num),0],
              [0,0,1]]*p1,
                  r,r,fn); 
       edge2(p1,
             [[0,0,1],
              [0,1,0],
              [1,0,0]]*p1,
                  r,r,fn); 
   }  } 


 // The edge module defines a bone from point p1 to point p2
 module edge2(p1,p2,rad1,rad2,fn){
     translate(p1)
     rotate(acos(([0,0,1]*(p2-p1))/norm(p2-p1)),
         (pow((p2-p1)[0],2)+pow((p2-p1)[1],2)==0 &&(p2-p1)[2]<0)?
            [1,0,0]: cross([0,0,1],p2-p1))
     bone2(rad1,rad2,norm(p2-p1),fn);
 }

module isocube(rad,ang1,ang2,th,fn){
for(k=[0:1])
{rotate([k*90,0,0])
{for(j=[0:3])
{rotate([0,j*90,0])
    {for(i=[0:3])
{
    rotate([0,0,i*90]){
    union(){
    base([rad*cos(ang1)*cos(ang2),rad*sin(ang1)*cos(ang2),rad*sin(ang2)],
        4,th,fn);
    mirror([0,1,0]){
base([rad*cos(ang1)*cos(ang2),rad*sin(ang1)*cos(ang2),rad*sin(ang2)],
        4,th,fn);}}}}}}}
}
}

if (which == 1) 
    {isocube(radius,45,atan(1/sqrt(2)),thickness,n);} //Cube
else if (which == 2) 
    {isocube(radius,0,90,thickness,n);}  //OCtahedron
else if (which == 3) 
    {isocube(radius,22.5,atan((1+sqrt(2))/sqrt(4+2*sqrt(2))),thickness,n);}
                                       //  truncated cube
else if (which == 4) 
    {isocube(radius,0,atan(2),thickness,n);}  //  Truncated Octahedron
else if (which == 5) 
    {isocube(radius,0,45,thickness,n);}  //  CubeOctahedron
else if (which == 6) 
    {isocube(radius,45,atan((1+sqrt(2))/sqrt(2)),thickness,n);} 
                                 //  RhombiCubeOctahedron
else if (which == 7) 
    {isocube(radius,22.5,atan((1+2*sqrt(2))/sqrt(4+2*sqrt(2))),thickness,n);}  
                                 //  RhombiTruncatedCubeOctahedron
else if (which == 8) 
    {isocube(radius,-67.5,atan((3+sqrt(2))/sqrt(4+2*sqrt(2))),thickness,n);}
                                       //  Great Truncated Cuboctahedron
else if (which == 9) 
    {isocube(radius,45,-atan(1/(2+sqrt(2))),thickness,n);}
                                       //  Great Cubicuboctahedron
else 
    {isocube(radius,a1,a2,thickness,n);}  //  Arbitrary Isogonal truncation.