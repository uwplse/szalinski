$fn=60;

use <involute_gears.scad>;

support=false;
cp=3.5;
os_d=5;

module mygear( gear_thickness, rim_thickness, number_of_teeth, twist, hole=false )
{
  intersection()
  {
    gear(
      circular_pitch = cp,
      gear_thickness = gear_thickness,
      rim_thickness = rim_thickness,
      hub_thickness = 0,
      hub_diameter = 0,
      rim_width = 0,
      number_of_teeth = number_of_teeth,
      bore_diameter = 0,
      clearance = 0.6,//0.5,
      backlash = 0.52,//0.45//0.35,
      involute_facets = 15,
      twist = twist,
      pressure_angle=28
      );
    r=pitch_radius(cp,number_of_teeth);
    a=gear_addendum(cp,number_of_teeth);
    cylinder(d1=2*r+4*a,d2=2*r+a,h=gear_thickness);
  }
}

module dgear( nt, thick, hole=false )
{
  for(i=[0,1])
  mirror([0,0,i])
  mygear(
    gear_thickness = thick/2,
    rim_thickness = thick/2,
    number_of_teeth = nt,
    twist=0,//5*thick/pitch_radius(cp,nt),
    hole = hole
    );
}


nt0=10; // axis of motor
nt1=40;
nt2=44;
nt3=44;
nt4=17; // axes of wheels
r0=pitch_radius(cp,nt0);
r1=pitch_radius(cp,nt1);
r2=pitch_radius(cp,nt2);
r3=pitch_radius(cp,nt3);
r4=pitch_radius(cp,nt4);


choose=0;

all=(choose==0);
body=(choose==1)||all;
axes=(choose==2)||(choose==4)||all;
wheels=(choose==3)||(choose==4)||all;

axis0=(choose==10)||axes;
axis1=(choose==11)||axes;
axis2=(choose==12)||axes;
axis3=(choose==13)||axes;
wheel0=(choose==20)||wheels;
wheel1=(choose==21)||wheels;

wheel_lock=(choose==31);

gr_1=8; // thickness of small gears
gr_2=4; // thickness of large gears
gr_sep=2.5; // gear separation, kolko do scianki, dy, dx

zplane_1=1.5+gr_1/2;
zplane_2=zplane_1+gr_1/2+gr_2/2;
zplane_3=zplane_2+gr_1/2+gr_2/2;

batteryholder_H=14;
batteryholder_H2 = batteryholder_H+10;
gr_wewn=zplane_1+gr_1/2+1.5;
l_wewn=r0+2*r1+2*r0+2*r3+r4+batteryholder_H2;
l_obud_wewn=gr_wewn+18+1;


module rotateAroundAxle( x, y, degree )
{
  translate([x,y,0])
    rotate([0,0,degree])
      translate([-x,-y,0])
        children();
}

module dziura(ile_grubsza=0)
{  
  translate([0,0,-2.1])
    cylinder(d=os_d+0.55+ile_grubsza,h=2.1+l_obud_wewn+2.1,center=false);
}


rozstaw=36;
dkolo=36; // duze kola loko
grkolo=3.5; // wieksze kółko
grkolo2=3; // mniejsze kółko

down = rozstaw/2 - l_obud_wewn/2; // ile ponizej plaszczyzny XY dla osi z kolami
down2 = 1.6; // dla osi bez kol


// axis of gears inside body
module os(ile_grubsza=1)
{
  translate([0,0,0.4])
    cylinder(d=os_d+ile_grubsza/*2*/,h=l_obud_wewn-0.8);
}

// axis of gears
module osm()
{
  os();
  translate([0,0,-down2])
    cylinder(d=os_d,h=l_obud_wewn+2*down2);
}

// axis of wheels
module osw()
{
  union()
  {
    os(3);
    // uwaga - eksperyment, pogrubiamy otwory na os na 6mm
    //translate([0,0,l_obud_wewn/2])
    //  cylinder(d=os_d,h=rozstaw+2*grkolo+2*grkolo2,center=true);
    translate([0,0,l_obud_wewn/2])
      cylinder(d=os_d+2,h=rozstaw+0.02,center=true);
  }
}


module wheel()
{
  n = floor(dkolo*PI);
  intersection()
  {
    difference()
    {
      union()
      {        
        // version with row for rubber band
        cylinder(d=dkolo,h=grkolo2-.6,center=false);
        translate([0,0,grkolo2-.6])
          cylinder(d=dkolo-.8,h=1.2,center=false);
        translate([0,0,grkolo2+.6])
          cylinder(d=dkolo,h=grkolo2-.6,center=false);

        // szprychy
        translate([0,0,2*grkolo2])
        {
          cylinder(d=dkolo/4,h=.4,center=false);
          *cylinder(d=dkolo/6,h=.8,center=false);
          intersection()
          {
            translate([0,-5*dkolo/12,0])
              cube([dkolo*2,dkolo/3,10],center=true);
            cylinder(d=dkolo-2,h=.4,center=false);
          }
          for(i=[0:30:360-30])
            rotate([0,0,i])
              intersection()
              {
                cube([dkolo*2,1.5,10],center=true);
                cylinder(d=dkolo-2,h=.4,center=false);
              }
          difference()
          {
            cylinder(d=dkolo,h=.4,center=false);
            cylinder(d=dkolo-6,h=1,center=true);
          }
        }
      }
      for(i=[0:10:350])
        rotate([0,0,i])
          translate([dkolo/2,0,2*grkolo2])
            cube([4,2,3],center=true);
    }
    cylinder(d1=dkolo+(2*grkolo2*2),d2=dkolo-2,h=2*grkolo2+.6);
  }
}

module wheels()
{
  translate([0,0,l_obud_wewn/2 + rozstaw/2])
    wheel();
  translate([0,0,l_obud_wewn/2 - rozstaw/2])
    mirror([0,0,1])
      wheel();
}


module wheel_support(R,H,W=5)
{
  if(support)
  {
    *difference()
    {
      cylinder( r=R,    h=H -.4 );
      cylinder( r=R-.3, h=1000, center=true );
    }
    difference()
    {
      union()
      {
        translate([0,0,.2])
          cylinder( r=R, h=H-.4 );
        translate([0,0,H-W-.2])
          cylinder( r1=R, r2=R+W/2, h=W );
      }
      translate([0,0,H-W-.1])
        cylinder( r1=R-.3, r2=R-W/2, h=W );
      cylinder( r=R-.3, h=H-W-.09 );
    }
  }
}

module wheels_with_gear()
{
  osw();
  translate([0,0,zplane_3])
    dgear(nt4,gr_1-1);
  /**/
  wheels();
  translate([0,0,-down])
  {
    wheel_support( r4-.5, zplane_3-(gr_1-1)/2 + down, 3 );
    wheel_support( dkolo/2-1.5, rozstaw, 3 );
  }
}


module engine()
{
  D=20.4;
  L=27.4;
  H=15.4;
  intersection()
  {
    cylinder(d=D,h=L);
    translate([-D/2+(D-H)/2,-15,-1])
      cube([H,30,29]);
  }
  translate([0,0,-1.1])
    cylinder(d=6.5,h=L+3);
  translate([0,0,-10])
    cylinder(d=2.6,h=L+3);
}

module engine_mount()
{
  difference()
  {
    union()
    {
      translate([0,0,9.5])
        cube([19.20,24,23],center=true);
      // to bedzie do wyciecia
      for(i=[-1,1])
        translate([i*9.1,12,0])
          cube([2,0.8,42],center=true);
    }
    engine();
    translate([0,0,10])
      cube([20.02,16,8],center=true);
  }
}


silnik_stopni=15;

module axes_placement()
{
  rotateAroundAxle( 0, 0, 30 )
  translate([0,-r3-r0,0])
  {
    rotateAroundAxle( 0, 0, -60 )
    translate([0,-r2-r0,0])
    {
      // axis0
      rotateAroundAxle( 0, 0, 90+silnik_stopni )
      translate([0,-r1-r0,0])
        children(0);
      // axis1
      children(1);
    }
    // axis2
    children(2);
  }
  // pierwsza oś jezdna
  rotateAroundAxle( 0, 0, -36 )
  translate([0,-r3-r4,0])
    children(4);
  // koło napędowe
  children(3);
  // druga oś jezdna
  rotateAroundAxle( 0, 0, 36 )
  translate([0,r3+r4,0])
    children(5);
}

module all_axes()
{
  // axes
  axes_placement()
  {

    if(axis0||body)
    union()
    {
      if(axis0)
      union()
      {
        difference()
        {
          union()
          {
            osm();
            translate([0,0,zplane_1])
              mirror([0,1,0])
                rotate([0,0,14])
                  dgear(nt0,gr_1,hole=true);
            if(support)
            {
              translate([0,0,zplane_1+gr_1/2+.21])
                difference()
                {
                  cylinder(r=r0+1,h=30);
                  cylinder(r=r0-1.5,h=1000,center=true);
                }
            }
          }
          cylinder(d=2.5,h=200,center=true);
          translate([0,0,34])
            cube([20,20,40],center=true);
        }
      }
      if( body )
        translate([0,0,17])
          rotate([0,0,30-silnik_stopni])
            engine_mount();
    }

    if(axis1)
    union()
    {
      osm();
      translate([0,0,zplane_2])
        mirror([0,1,0])
          dgear(nt0,gr_1);
      translate([0,0,zplane_1])
        dgear(nt1,gr_2);
      translate([0,0,-down2-.21])
        wheel_support( r1-1, zplane_1 -gr_2/2 +down2 +.2, 4 );
    }

    if(axis2)
    union()
    {
      osm();
      translate([0,0,zplane_2])
        dgear(nt2,gr_2);      
      translate([0,0,zplane_3])
        dgear(nt0,gr_1);
      translate([0,0,-down2-.21])
        wheel_support( r2-1, zplane_2 -gr_2/2 +down2 +.2, 4 );
    }

    // koło napędowe
    if(axis3)
    union()
    {
      osm();
      translate([0,0,zplane_3])
        mirror([0,1,0])
          dgear(nt3,gr_2);
      translate([0,0,-down2-.21])
        wheel_support( r3-1, zplane_3 -gr_2/2 +down2 +.2, 4 );
    }    

    union()
    {
      if(wheel0)
        wheels_with_gear();
    }

    union()
    {
      if(wheel1)
        wheels_with_gear();
    }
  }  
}

module all_axes_room()
{
  // axes
  axes_placement()
  {
    // axis0
    union()
    {
      dziura();
      translate([0,0,17])
        rotate([0,0,30-silnik_stopni])
          engine();
    }
    // axis1
    dziura();
    // axis2
    dziura();
    // koło napędowe
    dziura();
    // koła
    dziura(2);
    dziura(2);
  }  
}


module hook()
{
  D=6.5;
  minkowski()
  {
    union()
    {
      hull()
      {
        translate([0,16,3])
          cube([14,0.1,6],center=true);
        translate([0,0,3])
          cube([D,0.1,6],center=true);
      }
      translate([0,-0.5,16])
        cylinder(d=D,h=2);
      cylinder(d=D,h=16);
    }
    sphere(d=1);
  }
  translate([0,16.5,14.5])
    cube([30,2,30],center=true);
  translate([-6,15.5,-0.5])
    cylinder(d=4,h=30);
  translate([6,15.5,-0.5])
    cylinder(d=4,h=30);
}


body_h=2*r3+10.8;

module body_wewn()
{
  translate([/*-6*//*-11*/-7,0,0])
    cube([body_h+8+8,l_wewn,l_obud_wewn]);
}

module body_zewn()
{
  translate([0,-2,-2])
    cube([body_h,l_wewn+4,l_obud_wewn+4]);
  /**/
  translate([body_h-l_obud_wewn/2+7,2+40,l_obud_wewn/2])
    rotate([-90,0,0])
    {
      cylinder(d=l_obud_wewn*1.6,h=l_wewn-40);
      translate([0,0,l_wewn-40])
        cylinder(d1=l_obud_wewn*1.6,d2=l_obud_wewn,h=5);
      translate([0,0,3*(l_wewn-40)/4])
        rotate([0,90,0])
        {
          difference()
          {
            cylinder(d=20,h=50);
            cylinder(d=16,h=60);
          }
        }
    }
  // kabinka
  G=16;
  translate([body_h/2+8,-8,-G/2])
  {
    difference()
    {
      hull()
      {
        cube([body_h,50,l_obud_wewn+G]);
        translate([-G,G,G/2])
          cube([body_h,50-G,l_obud_wewn]);
      }
      translate([3,3,3])
        cube([body_h,50-6,l_obud_wewn+G-6]);
      //okna boczne
      translate([body_h-20-12,30,-1])
        cube([26,17,100]);
      //okna przod
      translate([body_h-16-8,10,4])
        cube([18,45,14]);
      translate([body_h-16-8,10,l_obud_wewn+G-14-4])
        cube([18,45,14]);
    }
  }
  translate([-body_h/2+30.4,0,l_obud_wewn/2])
  {
    translate([0,l_wewn+batteryholder_H2-6.5,0])
      rotate([180,-90,0])
        hook();
    translate([0,-17.5,0])
      rotate([180,90,180])
        hook();
  }
}

module body()
{
  module wheels_axes_room()
  {
    // axes
    axes_placement()
    {
      union(){}
      union(){}
      union(){}
      union(){}
      // koła
      children(0);
      children(0);
    }  
  }
  
  difference()
  {
    translate([-26,-80,0])    
    difference()
    {
      body_zewn();
      body_wewn();
    }
    all_axes_room();
    translate([-5,0,0])
      wheels_axes_room()
      { 
        cylinder(r=3.8,h=1000,center=true); 
        //cube([8,8,1000],center=true); 
      }
  }
}

all_axes();
//wheel_support(20,40,5);

if(false)
{
  all_axes();
  //all_axes_room();
  if( body )
    body();
}


if( body )
{
  all_axes();
  // batteries
  /*
    batteryholder_H=14; // 2*7.1 ?
    blaszka1=14.3; // szer?
    blaszka2=27.9; // szer?
    batw=28.5; // 2*7.1*2 +.1
    batl=53;   // 51 + 2?
  */
  bH=50.3;
  bR=7.0;
  grbl=1.5;
  spring=2;
  translate([-26,56.6,15.1])
    rotate([0,90,0])
    {
      *for(i=[-bR,bR])
        translate([i,0,2+grbl+spring/2])
          cylinder(r=bR,h=bH);
      *for(i=[1,1+grbl+bH+spring+grbl+2])
        translate([0,0,i])
          cube([28.8,2*bR,2],center=true);
      *for(i=[-2*bR-1,2*bR+1])
        translate([i,0,(2+grbl+bH+spring+grbl+2)/2])
          cube([2,2*bR,2+grbl+bH+spring+grbl+2],center=true);
      
      difference()
      {
        translate([0,0,body_h/2+5])
          cube([l_obud_wewn+.2,2*bR+1,body_h+10],center=true);
        translate([0,0,(2+grbl+bH+spring+grbl+2)/2+2])
          cube([4*bR,2*bR+2,2+grbl+bH+spring+grbl+2],center=true);
      }
    }
  intersection()
  {
    body();
    /**/
    *cube([1000,120,1000],center=true);
  }
}


//hook();

module connector()
{
  for(i=[0:1])
  mirror([0,i,0])
  translate([0,-12,0])
  minkowski()
  {
    difference()
    {
      union()
      {
        cylinder(d=13.9,h=2,center=true,$fn=40);
        translate([0,7.5,0])
          cube([6,15,2],center=true);
      }
      cylinder(d=11,h=2,center=true,$fn=40);
      translate([0,-4,0])
        cube([9.1,8,100],center=true);
    }
    sphere(d=3,$fn=20);
  }
}

//connector();

*translate([0,-12.75,17.5])
{
  translate([0,+50+3.25,0])
    cube(100,center=true);
  cube(6.5,center=true);
}
