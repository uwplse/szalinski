/*[Function]*/
//Begin of function
start=0;
//End of function
end=6.283218265359; 


/*[Variables/Modificators]*/
//Use these to form the vase to your wishes: sin(x*k)*l+m
k=60;
l=10;
m=20;
n=10;

/*[Object-Stuff]*/
//Wall-Thickness
r=1; 
//Top closed? (0=No, 1=Yes)
top=0; 
//Bottom closed? (0=No, 1=Yes)
bottom=1; 

/*[Resolution]*/
//Steps of the function
step=0.05;
//Faces of the vase
res=100;

function f(x,k,l,m)=sin(x*k)*l+m;

translate([0,0,r-start*n])
rotate_extrude($fn=res)
for(i=[start:step:end])
{
 hull()
 {
  assign(j=i+step)
  {
   translate([f(i,k,l,m),i*n,0])
   circle(r=r);
   translate([f(j,k,l,m),j*n,0])
   circle(r=r);
  }
 }
}

if(top==1)
{
translate([0,0,(end-start)*n+2*step])
cylinder(r=f(end,k,l,m), h=2*r, $fn=res);
}

if(bottom==1)
{
cylinder(r=f(start,k,l,m), h=2*r, $fn=res);
}