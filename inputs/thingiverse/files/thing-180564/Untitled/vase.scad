//Length
L=150;
//Depth
D=40;
//Height
H=70;
//Thickness
t=3;

vase(L=L,D=D,H=H,t=t);

module langloch(L=150,D=40,H=70)
{
  translate(v=[0,0,H/2]) {
    cube(size=[L-D,D,H],center=true);
  }
  translate(v=[-L/2+D/2,0,0]) {
    cylinder(h=H,r=D/2,$fn=100);
  }
  translate(v=[L/2-D/2,0,0]) {
    cylinder(h=H,r=D/2,$fn=100);
  }
}

module vase(L=150,D=40,H=70,t=3)
{
  difference() {
    langloch(L=L,D=D,H=H);
    translate(v=[0,0,t]) {
      langloch(L=L-t-t,D=D-t-t,H=H);
    }
  }
}

// -- (c) 2013 Abdreas Urben (urbenan) 
// -- GPL license