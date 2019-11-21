//Top Diameter
d1=55;
//Bottom Diameter
d2=40;
//Height
h=65;
//Thickness
t=3;

becher(d1=d1,d2=d2,h=h,t=t);

module becher(d1=55,d2=40,h=65,t=3) 
{
  p1=[d2/2,0]; 
  p2=[(d2/2)+t,0]; 
  p3=[(d1/2)+t,h];
  p4=[d1/2,h]; 

  pa=[[0,0],p2,p3,[0,h]];
  pi=[[0,t],[d2/2,t],[d1/2,h+0.2],[0,h+0.2]];

  difference() {
    rotate_extrude($fn=180) polygon(points=pa);
    rotate_extrude($fn=180) polygon(points=pi);
  }
}

// -- This script was derived from becher
// -- (c) 2013 Abdreas Urben (urbenan) 
// -- GPL license

