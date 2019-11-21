// Weihnachtssterne 2014 - 2018
// (C) Henning und Daniel Stöcklein
// Version 19.12.2018

// Height of star
ht = 1.0 ; // [0.5:0.1:3]

// width of stripes
wd = 2.4 ; // [1:0.2:5]

// Number of stacked sub-stars
stack = 6 ; // [1:7]

// Chamfer height
chamfer = 0.5 ; // [0:0.1:0.7]

// Schweifstern Y/N
sch_flag = 0 ; // [0:kein Schweif, 1:Schweif]

// Width of Bars
wd_schweif = 1.6 ; // [1.4:0.1:2.5]

// Fixing holes Y/N
fix_flag = 0 ; // [0:no holes, 1:holes]

//******************** Objektauswahl ****************************
if (stack == 1) einfachstern();
if (stack == 2) doppelstern() ;
if (stack == 3) dreifachstern() ;
if (stack == 4) vierfachstern() ;
if (stack == 5) fuenffachstern() ;
if (stack == 6) sechsfachstern() ;
if (stack == 7) siebenfachstern() ;

if (sch_flag == 1)
      rotate ([0,0,3]) translate ([21, 2.5, 0]) scale ([0.87,0.82,1]) schweif() ;

//******************************************
// Chamfered Cylinder Submodule (centered)
//******************************************
module cyl_pchamf (rad, ht, pfn, rchamf)
{
    $fn = pfn;
    translate ([0,0,-ht/2+rchamf/2]) cylinder (r2=rad, r1=rad-rchamf, h=rchamf, center=true) ;
    translate ([0,0,0]) cylinder (r=rad, h=ht-2*rchamf+0.01, center=true) ;
    translate ([0,0,ht/2-rchamf/2]) cylinder (r1=rad, r2=rad-rchamf, h=rchamf, center=true) ;
}

module cyl_nchamf (rad, ht, pfn, rchamf)
{
    $fn = pfn;
    translate ([0,0,-ht/2+rchamf/2]) cylinder (r1=rad, r2=rad-rchamf, h=rchamf, center=true) ;
    translate ([0,0,0]) cylinder (r=rad, h=ht-2*rchamf+0.01, center=true) ;
    translate ([0,0,ht/2-rchamf/2]) cylinder (r2=rad, r1=rad-rchamf, h=rchamf, center=true) ;
}

//******************************************
module stern_p (radius)
{
   rotate ([0,0,0]) cyl_pchamf (radius, ht, 3, chamfer);
   rotate ([0,0,60]) cyl_pchamf (radius, ht, 3, chamfer);
}

module stern_n (radius)
{
   rotate ([0,0,0]) cyl_nchamf (radius, ht, 3, chamfer);
   rotate ([0,0,60]) cyl_nchamf (radius, ht, 3, chamfer);
}

module einfachstern()
{
  difference() 
  {
    stern_p (15);
    scale ([1,1,1.01]) stern_n (15-wd);
    if (fix_flag == 1)
      rotate ([0,0,30]) translate ([0,15-2.7,0]) cylinder (r=0.6, h=10, center=true, $fn=20) ;
  }
}

module doppelstern()
{
  difference() 
  {
    stern_p (15);
    scale ([1,1,1.01]) stern_n (15-wd);
    if (fix_flag == 1) rotate ([0,0,30]) translate ([0,15-2.7,0]) cylinder (r=0.6, h=10, center=true, $fn=20) ;
  }
  difference()
  {
    rotate ([0,0,30]) stern_p (8);
    scale ([1,1,1.01]) rotate ([0,0,30]) stern_n (8-wd);
  }
}

module dreifachstern()
{
  difference() 
  {
    stern_p (16);
    scale ([1,1,1.01]) stern_n (16-wd);
    if (fix_flag == 1) rotate ([0,0,30]) translate ([0,16-2.0,0]) cylinder (r=0.5, h=10, center=true, $fn=20) ;
  }
  difference() 
  {
    rotate ([0,0,30]) stern_p (8);
    scale ([1,1,1.01]) rotate ([0,0,30]) stern_n (8-wd);
  }
  difference() 
  {
    stern_p (3.8);
    scale ([1,1,1.01]) stern_n (2.5);
  }
}

module vierfachstern()
{
  difference() 
  {
    rotate ([0,0,30]) stern_p (20.5);
    scale ([1,1,1.01]) rotate ([0,0,30]) stern_n (20.5-wd);
    if (fix_flag == 1) rotate ([0,0,00]) translate ([0,20.5-2.0,0]) cylinder (r=0.5, h=10, center=true, $fn=20) ;
  }

  difference() 
  {
    stern_p (16);
    scale ([1,1,1.01]) stern_n (16-wd);
  }
  difference() 
  {
    rotate ([0,0,30]) stern_p (8.2);
    scale ([1,1,1.01]) rotate ([0,0,30]) stern_n (8.2-wd);
  }
  difference() 
  {
    stern_p (3.8);
    scale ([1,1,1.01]) stern_n (2.5);
  }
}

module schweifbogen()
{
  translate ([0,    0,0]) rotate ([0,0,0]) cube ([20, wd_schweif, ht], center=true);
  translate ([19,  -0.8,0]) rotate ([0,0,-5]) cube ([20, wd_schweif, ht], center=true);
  translate ([38.5,-3.4,0]) rotate ([0,0,-10]) cube ([20, wd_schweif, ht], center=true);
  translate ([57,  -7.5,0]) rotate ([0,0,-15]) cube ([20, wd_schweif, ht], center=true);
}

module schweif()
{
  difference() {
    union() {
      // 3 Hauptstrahlen
      translate ([0,0,0]) rotate ([0,0,0]) schweifbogen() ;
      translate ([-1,-4.5,0]) rotate ([0,0,-4.0]) scale ([0.81,1,1]) schweifbogen() ;
      translate ([-2,-9,0]) rotate ([0,0,-14]) schweifbogen() ;

      // Zackenschwanz
      translate ([57,  -9.5,0]) rotate ([0,0,-4.1]) cube ([20, wd_schweif, ht], center=true);
      translate ([55.6,  -13.2,0]) rotate ([0,0,-26.8]) cube ([20, wd_schweif, ht], center=true);
      translate ([55,  -16.7,0]) rotate ([0,0,-6]) cube ([20, wd_schweif, ht], center=true);
      translate ([54,  -19.5,0]) rotate ([0,0,-25]) cube ([20, wd_schweif, ht], center=true);
      translate ([53.5, -22.7,0]) rotate ([0,0,-6.0]) cube ([20, wd_schweif, ht], center=true);
      translate ([52.0,  -28.2,0]) rotate ([0,0,-39.3]) cube ([21, wd_schweif, ht], center=true);

      // Befestigungsloch
      if (fix_flag == 1) translate ([0,0,0]) cylinder (r=1.4, h=ht, $fn=20, center=true) ;
    }
    translate ([0,0,0]) cylinder (r=0.6, h=ht, $fn=20, center=true) ;
  }
}

module fuenffachstern()
{
  difference() 
  {
    stern_p (28);
    scale ([1,1,1.01]) stern_n (28-wd);
    if (fix_flag == 1)
    {
      rotate ([0,0,30]) translate ([0,28-3.0,0])
        cylinder (r=0.5, h=10, center=true, $fn=20) ;
      rotate ([0,0,30]) translate ([0,-28+3.0,0])
        cylinder (r=0.5, h=10, center=true, $fn=20) ;
    }
  }

  difference() 
  {
    rotate ([0,0,30]) stern_p (20.5);
    scale ([1,1,1.01]) rotate ([0,0,30]) stern_n (20.5-wd);
  }

  difference() 
  {
    stern_p (16);
    scale ([1,1,1.01]) stern_n (16-wd);
  }
  difference() 
  {
    rotate ([0,0,30]) stern_p (8.3);
    scale ([1,1,1.01]) rotate ([0,0,30]) stern_n (8.3-wd);
  }
  difference() 
  {
    stern_p (3.9);
    scale ([1,1,1.01]) stern_n (2.6);
  }
}

module sechsfachstern()
{
  fuenffachstern() ;
    
  difference() 
  {
    rotate ([0,0,30]) stern_p (34);
    scale ([1,1,1.01]) rotate ([0,0,30]) stern_n (34-wd);
  }
}

module siebenfachstern()
{
  sechsfachstern() ;
    
  difference() 
  {
    stern_p (42);
    scale ([1,1,1.01]) stern_n (42-wd);
  }
}
