Taille=100;
RC=Taille*75/100;
PC=Taille/2;
Vue="Roi";//[Roi,Reine,Fou,Cavalier,Tour,Pion,Tout]
if(Vue=="Tout")
{
translate([-Taille*4,0,0])
roi();
translate([-Taille*3,0,0])
reine();
translate([-Taille*2,0,0])
fou();
translate([-Taille*1,0,0])
cavalier();
tour();
translate([Taille*1,0,0])
pion();}

if(Vue=="Roi"){roi();}
if(Vue=="Reine"){reine();}
if(Vue=="Fou"){fou();}
if(Vue=="Cavalier"){cavalier();}
if(Vue=="Tour"){tour();}
if(Vue=="Pion"){pion();}


module roi()
{
  union()
  {
  hull()
  {
    cube([RC,RC,0.00001],center=true);
    translate([0,0,Taille*2.5])
    cube([RC,RC/4,0.00001],center=true)  ;
  }
  hull()
  {
    cube([RC,RC,0.00001],center=true);
    translate([0,0,Taille*2.5])
    cube([RC/4,RC,0.00001],center=true)  ;
  }
}
}
module reine()
{
  union()
  {
    {
      for(i=[1:8])
      {
        hull()
        {
        cube([RC,RC,0.00001],center=true);
        translate([sin(360/8*i)*(RC/2-11),cos(360/8*i)*(RC/2-11),Taille*2.5-RC/2])
        {
          sphere(d=22,$fn=50);
        }
        }
      }
    }
  }  
}

module fou()
{
  union()
  {
  difference()
  {
    hull()
    {
      cube([RC,RC,0.00001],center=true);
      translate([0,0,Taille*2-RC/2])
      {
        sphere(r = RC/4,$fn=50);
        translate([0, 0, RC/4 * sin(RC/3)])
        cylinder(h = RC/3, r1 =  RC/4 * cos(RC/3), r2 = 0,$fn=50);
      }
    }
    translate([0,0,Taille*2-RC/2])
    difference()
    {
      cylinder(d=RC/3,h=Taille*2);
      cylinder(d=RC/4,h=Taille*3);
    }
  }
}
}
module cavalier()
{
  union()
  {
  hull()
  {
  cube([RC,RC,0.00001],center=true);
  translate([0,RC/4,Taille*2-RC/2])
  rotate([90,0,90])
  scale([0.5,1,1])
  cylinder(d=RC,h=RC/16,$fn=50,center=true);
  }
  hull()
  {
  translate([0,RC/4,Taille*2-RC/2])
  rotate([90,0,90])
  scale([0.5,1,1])
  cylinder(d=RC/4*3,h=RC/4,$fn=50,center=true);

  translate([0,-RC/4,Taille*2-RC])
  rotate([90,0,90])
  scale([0.5,0.5,1])
  cylinder(d=RC/4*3,h=RC/8,$fn=50,center=true);
  }
}

}

module tour()
{
  union()
  {
  hull()
  {
    cube([RC,RC,0.00001],center=true);
    translate([RC/3,RC/3,Taille*2.25])  
    cube([RC/3,RC/3,0.00001],center=true);
  }

  hull()
  {
    cube([RC,RC,0.00001],center=true);
    translate([RC/3,-RC/3,Taille*2.25])  
    cube([RC/3,RC/3,0.00001],center=true);
  }
  hull()
  {
    cube([RC,RC,0.00001],center=true);
    translate([-RC/3,RC/3,Taille*2.25])  
    cube([RC/3,RC/3,0.00001],center=true);
  }

  hull()
  {
    cube([RC,RC,0.00001],center=true);
    translate([-RC/3,-RC/3,Taille*2.25])  
    cube([RC/3,RC/3,0.00001],center=true);
  }
}
  
}

module pion()
{
  hull()
  {
    cube([PC,PC,0.00001],center=true);
    translate([0,0,Taille*1.25-PC/2])
    sphere(d=PC,$fn=50);
  }
}