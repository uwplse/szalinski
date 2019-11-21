/*

Syringe

Carles Oriol

28/03/2015

*/

// Resolution
$fn=128;


/* [Global] */

// Presentation 0 = Splited, 1 = On floor, 2=Presentation, 3= full plunger
mode = 0; 

// Diameter
diameter = 1.59; 

// Height
height = 8.5;

// Wall size
wall = .08;

// nozzle holediameter
boca = .24;

// nozzle offset from center
nozzleoffset = .2;

// handle size
nansa = .24;

 syringe( diameter, height, wall, boca, nansa, nozzleoffset, mode);



//syringe(1.59, 8.5, .08, .24 , .6, .20, 3); 
//syringe(1, 8.5, .08, .24 , .6, 0);

module syringe( diameter, height, wall, boca, nansa, nozzleoffset, mode)
{
    if( mode == 0)
    {
   color([.7,.7,.7,.5])   translate([0,0,11.5]) syringe_body( diameter, height, wall, boca, nansa, nozzleoffset);
     color([.7,.7,.7,.5])  syringe_plunger( diameter, height, wall, boca, nansa, nozzleoffset);
     color([.2,.2,.2]) translate([0,0,10]) syringe_piston( diameter, height, wall, boca, nansa, nozzleoffset);
    }
    if( mode == 1)
    {
   color([.7,.7,.7,.5])   translate([0,0,0]) syringe_body( diameter, height, wall, boca, nansa, nozzleoffset);
     color([.7,.7,.7,.5]) translate([diameter+nansa*2,0,0])  syringe_plunger( diameter, height, wall, boca, nansa, nozzleoffset);
     color([.2,.2,.2])  translate([-(diameter+nansa*2),0,0]) syringe_piston( diameter, height, wall, boca, nansa, nozzleoffset);
    }
    
        if( mode == 2)
    {
       color([.7,.7,.7,.2])  translate([0,0,height/3]) syringe_body( diameter, height, wall, boca, nansa, nozzleoffset);
        color([.7,.7,.7,.5])  syringe_plunger( diameter, height, wall, boca, nansa, nozzleoffset);
        color([.2,.2,.2]) translate([0,0,height+wall*3]) syringe_piston( diameter, height, wall, boca, nansa, nozzleoffset);
    }
    
       if( mode == 3)
    {
        color([.7,.7,.7,.5]) syringe_plunger( diameter, height, wall, boca, nansa, nozzleoffset);
        color([.2,.2,.2]) translate([0,0,height+wall*3]) syringe_piston( diameter, height, wall, boca, nansa, nozzleoffset);
    }
}

module piston( r1, r2, h1, h2)
{
    
    union()
    {
     cylinder( r=r1, h= h1);
     translate([0,0,h1]) cylinder( r1=r1, r2=r2, h= h2);
    }
}

module syringe_piston( diameter, height, wall, boca, nansa, nozzleoffset)
{
     radi=diameter/2-wall;
    union()
    {
    difference()
    {
        union()
        {
        piston( radi, 0, wall,  height/17);
        translate([0,0,wall*2]) piston( radi, 0, wall,  height/17-wall);            
            
        }
        
        cylinder( r1=radi-wall, r2=0,  height/17-wall);
        translate([0,0,wall]) cylinder( r1=radi-wall*2, r2=0,  height/17-wall);
        
    }
    
    translate([0,0,wall*4]) cylinder( r1=radi-wall*4, r2=0,  wall*3);
}

}

module syringe_plunger( diameter, height, wall, boca, nansa, nozzleoffset)
{
    radi=diameter/2;
    dcanula=wall*2+boca;
    altcanula=height/5.3;
    
    
    // base
    difference()
    {
      cylinder( r=radi+wall*2, h= wall*2);
        
    baseseg=12;
        for (i=[0:baseseg+1])
        {
            translate([0,i*(diameter/baseseg)-((diameter+wall*2)/2),0]) cube([diameter+wall*4, diameter/(baseseg*2),wall], center=true);
        }
    }
    
    // inner
    d2=diameter-wall*4;

    for ( sides=[0:90:90] )
    rotate([0,0,sides])
    difference()
    {
    translate([0,0,height/2+wall*2]) cube([d2,wall,height], center=true);
        
        hull()
        {
        translate([d2/2+(d2/7),-wall/2,wall*4+height*0.10]) rotate([0,90,90]) cylinder(r=d2/7, h=wall);    
        translate([d2/2,-wall/2,wall*4]) rotate([0,90,90]) cylinder(r=d2/7, h=wall);
        }
        
                hull()
        {
        translate([-(d2/2+(d2/7)),-wall/2,wall*4+height*0.10]) rotate([0,90,90]) cylinder(r=d2/7, h=wall);    
        translate([-(d2/2),-wall/2,wall*4]) rotate([0,90,90]) cylinder(r=d2/7, h=wall);
        }
    }
   

    
    // top
    
    translate([0,0,height*.95+wall*2]) cylinder(r=radi-wall*2,h=wall);
    translate([0,0,height+wall*2]) cylinder(r=radi-wall*2,h=wall);
    translate([0,0,height+wall*3]) cylinder(r1=radi-wall*2, r2=0, h=wall);
    
    translate([0,0,height+wall*4])
    {
          for ( sides=[0:90:90] ) rotate([0,0,sides])  cube([diameter-wall*10,wall, wall*4], center=true) ;
    }   
    
    translate([0,0,height+wall*6]) cylinder(r=radi-wall*3,h=wall);
}

module syringe_body( diameter, height, wall, boca, nansa, nozzleoffset)
{
    radi=diameter/2;
    dcanula=wall*2+boca;
    altcanula=height/5.3;
    
   difference()
    {
    union()
    {
    // tub
    cylinder(r=radi, h=height);
    cylinder(r=radi*1.02, h=height/9); // sortint de la part baixa

    // part superior
        
    difference()
    {
        union()
        {
            translate([0,0,height]) cylinder(r1=radi, r2=0, h=height/17);
            translate([0,nozzleoffset,height]) cylinder(r1=(dcanula*1.3)/2, r2=dcanula/2, h=altcanula);           
        }    
    
        translate([0,0,height]) cylinder(r1=radi-wall*2, r2=0, h=height/17-wall);
        translate([0,nozzleoffset,height])  cylinder(r1=(boca*1.3)/2, r2=boca/2, h=altcanula); 
    }

    // base
    //resize([diameter+nansa*2, diameter+wall*4, wall*2]) rotate([0,0,90]) cylinder(r=1, h=wall*2, $fn=6);
    hull()
    {
        cylinder( r=radi+wall*2, h= wall);
        
        translate([nansa+radi, radi/2,0]) cylinder( r=wall*2, h= wall);
        translate([-(nansa+radi), radi/2,0]) cylinder( r=wall*2, h= wall);    
        translate([-(nansa+radi), -(radi/2),0]) cylinder( r=wall*2, h= wall);
        translate([nansa+radi, -(radi/2),0]) cylinder( r=wall*2, h= wall);
    }
    }
    
    cylinder(r=(radi-wall), h=height);
    }
}