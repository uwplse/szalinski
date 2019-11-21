
/*[General size]*/
//tower height
height=120; 
//tower diameter
diameter=80; 

/*[Bricks]*/
//number of bricks
nB=24; 
//number of layers
nL=20; 

//twist between the layers
w=7; 

/*[Seam]*/
//gap-depth
r=1; 
//gap-thickness
d=1; 
//gap-thickness between layers
gL=1; 

/*[Resolution]*/
//resolution of the seams
res=300;


z=(height-(nL-1)*gL)/nL;
y=diameter/2;
x=sin(360/nB)*y;

for(k=[0:w/nL:w])
{
 for(j=[0:1:nL-1])
 {
  rotate([0,0,j*w])
  for(i=[0:asin(x/y):360])
  rotate([0,0,i])
  translate([-(x-d)/2,0,j*(z+gL)])
  cube(size=[x-d,y,z]);
 }
} 
cylinder(r=(y-r),h=nL*(z+gL)-gL, $fn=res);