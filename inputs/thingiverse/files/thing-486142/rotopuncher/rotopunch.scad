$fs=0.3;
$fa=5;

dpivot=2;

oeil_ep=1;
camewidth=2;
epcame=1;
hpivot=epcame*4;
epcase=1.2;

a=$t*360;	//angle moteur
Ax=0;
Ay=40;	//pivot haut sur l'axe de translation (A)
Bx=20;
By=40;	//axe moteur (B)
r1=10;	//came moteur [BC]
r2=10*(sqrt(8)-1);	//bras de liaison moteur-coude [CE]
ra1=20;	//coude actionneur came haute [AE]
ra2=20;	//coude actionneur came basse [EG]

marge=r1;
Mx=max(Ax,Bx);
My=max(Ay,By);	
Nx=min(Ax,Bx);
Ny=min(Ay,By);	


Cx=Bx+r1*cos(a);Cy=By+r1*sin(a); //extremite came moteur (C)

dac=sqrt(pow(Ax-Cx,2)+pow(Ay-Cy,2)); //distance [AC]
dab=sqrt(pow(Ax-Bx,2)+pow(Ay-By,2)); //distance [AB]

//--- determiner point E (coude de l'actionneur) ----
//formule de Heron => aire de ACE
s=(ra1+r2+dac)/2; //demi somme des cotes
aire=sqrt(s*(s-ra1)*(s-r2)*(s-dac));
//hauteur de ACE base = AC
h=2*aire/dac; //mesure de la hauteur.
//soit F le pieds de la hauteur
dfc=sqrt(r2*r2-h*h); //distance entre C et pieds de la hauteur (pythagore)
fprop=dfc/dac;
Fx=Cx+(Ax-Cx)*fprop;Fy=Cy+(Ay-Cy)*fprop;
//soit W un vecteur orthogonal a AC
Wx=Cy-Ay;Wy=Ax-Cx;
Wl=sqrt(Wx*Wx+Wy*Wy);//Wl = norme de W
//point E : image de F par W renormé ( /Wl*h )
Ex=Fx+Wx/Wl*h;Ey=Fy+Wy/Wl*h;

//angle CE vs Horiz
HCE=180+atan2(Ey-Cy,Ex-Cx);
//angle AE vs Horiz
HAE=180+atan2(Ey-Ay,Ex-Ax);



//--- detrminer point G (extremité coté 'pointe' )
//on uilise le triangle rectangle d'hypotenuse EG
wy=sqrt(ra2*ra2-Ex*Ex);
Gx=0;Gy=Ey-wy;
//angle GE vs Horiz
HGE=atan2(Ey-Gy,Ex-Gx);

//---------------------------------------------------------------------------
module rondelle(ep=epcame) {
   difference(){
		cylinder(d=dpivot+oeil_ep*2,h=ep);
		translate([0,0,-ep]) cylinder(d=dpivot*1.05,h=ep*3);
	}	
}


//---------------------------------------------------------------------------
module came(l=10,ep=epcame) {
  difference(){
	union() {
		translate([0,-camewidth/2,0]) cube([l,camewidth,ep]);
		cylinder(d=dpivot+oeil_ep*2,h=ep);
		translate([l,0,0]) cylinder(d=dpivot+oeil_ep*2,h=ep);
		}
	translate([0,0,-ep*2]) cylinder(d=dpivot*1.05,h=ep*4);
	translate([l,0,-ep*2]) cylinder(d=dpivot*1.05,h=ep*4);
	}
  }  
  
//---------------------------------------------------------------------------
// -- pivots --

translate([Cx,Cy,0])	cylinder(d=dpivot,h=hpivot);	//pivot C
translate([Ex,Ey,0])	cylinder(d=dpivot,h=hpivot);	//pivot E
translate([Gx,Gy,-0.8])	cylinder(d=dpivot,h=hpivot);	//pivot G

translate([Cx,Cy,epcame]) rondelle(); 
translate([Ax,Ay,0]) rondelle();   
  
translate([Bx,By,0])		rotate([0,0,a])		came(l=r1,ltop=2);
translate([Ex,Ey,2*epcame])	rotate([0,0,HCE])	came(l=r2);
translate([Ex,Ey,epcame])	rotate([0,0,HAE])	came(l=ra1,ltop=2,lcame=1);
translate([Gx,Gy,0])		rotate([0,0,HGE])	came(l=ra2);

//base plate. will need tailoring depending on axes and radii configuration
color([0.5,0.5,0.5])  
{  
translate([Ax,Ay,-0.5])	cylinder(d=dpivot,h=hpivot+0.5);	//pivot A
translate([Bx,By,-0.5])	cylinder(d=dpivot,h=hpivot/3+0.5);	//pivot B

	
difference()
{	hull() {
	translate([Mx,My,-epcase])cylinder(r=dpivot+marge,h=epcase);
	translate([Nx,Ny,-epcase])cylinder(r=dpivot+marge,h=epcase);
	translate([0,0,-epcase])cylinder(r=dpivot+marge,h=epcase);
	}
	translate([0.5*dpivot, -dpivot,-1])rotate([0,0,90])cube([ra1+ra2,dpivot,5]);
}
} 