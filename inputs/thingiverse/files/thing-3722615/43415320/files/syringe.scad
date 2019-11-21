/*

Syringe

Carles Oriol

28/03/2015

Updates by ALittleSlow 28/06/2019
* better spacing for mode=0 and 1
* fixed display mode rendering issues
* fixed non-manifold surfaces
* made nozzle length customizable
* added piston and body modes
* modified for supportless FDM printing
* changed default scale to mm (was cm)
* added "part" option for automatic Customizer generation

*/

// Resolution
$fn=128;


/* [Global] */
//Parts to display
part = 0; //[0:all, 1:body, 2:plunger, 3:piston]

// Display  mode
mode = 0; //[0:split,1:on floor,2:presentation]

// Diameter 
diameter = 15.9; 

// Height
height = 85.5;

// Wall size
wall = .8;

// Nozzle height
altcanula=16.5;

// Nozzle hole diameter
boca = 2.4;

// Nozzle offset from center
nozzleoffset = 2.5;

// Space between piston and plunger
tolerance = 0.2;

// Handle size
nansa = 2.4;

/* [Hidden] */
epsilon = 0.01;
spacing = 15;
opaque = 1.0;
demitransparent = 0.5;
transparent =0.2;
plungerheight = diameter/2;

 syringe( diameter, height, wall, boca, nansa, nozzleoffset, mode);

//syringe(1.59, 8.5, .08, .24 , .6, .20, 3); 
//syringe(1, 8.5, .08, .24 , .6, 0);

module syringe( diameter, height, wall, boca, nansa, nozzleoffset, mode)
{
    demi = [.6,.6,.8, demitransparent];
    dark = [.2,.6,.2, opaque];
    light = [.2,.2,.2, transparent];
    verydark = [.7,.6,.6,opaque];
    if( mode == 0)
    {
        if (part==0 || part == 1) color(demi)   translate([0,0,height + spacing * 2]) syringe_body( diameter, height, wall, boca, nansa, nozzleoffset);
        if (part==0 || part == 2) color(demi)  syringe_plunger( diameter, height, wall, boca, nansa, nozzleoffset);
        if (part==0 || part == 3) color(dark) translate([0,0,height + spacing]) syringe_piston( diameter, height, wall, boca, nansa, nozzleoffset);
    }
    if( mode == 1) // on floor
    {
        if (part==0 || part == 1) color(demi)   translate([0,0,0]) syringe_body( diameter, height, wall, boca, nansa, nozzleoffset);
         if (part==0 || part == 2) color(dark) translate([diameter+nansa*2 + spacing,0,0])  syringe_plunger( diameter, height, wall, boca, nansa, nozzleoffset);
        if (part==0 || part == 3) color(demi)  translate([-(diameter+nansa*2 + spacing),0,0]) syringe_piston( diameter, height, wall, boca, nansa, nozzleoffset);
    }
    
    if( mode == 2) // presentation
    {
        if (part==0 || part == 2) color(verydark)  syringe_plunger( diameter, height, wall, boca, nansa, nozzleoffset);
        if (part==0 || part == 3) color(demi) translate([0,0,height+wall*4]) syringe_piston( diameter, height, wall, boca, nansa, nozzleoffset);
        if (part==0 || part == 1) color(demi)  translate([0,0,wall*8]) syringe_body( diameter, height, wall, boca, nansa, nozzleoffset);
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
    difference()
    {
        union()
        {
            translate([0,0,wall*2]) piston( radi, 0, wall,  plungerheight-wall);            
            translate([0,0,wall]) cylinder(r1 = radi-wall*cos(45), r2=radi, h=wall);
            cylinder(r=radi, h=wall);
        }
        // subtract the shape of the holder, and them some more to avoid bridging with flexible filament
        holderradius=radi-wall*2;
        translate([0,0,-epsilon])
            cylinder(r1=holderradius-wall*sin(45), r2=holderradius, h=wall);
        translate([0,0,-epsilon+wall])
            cylinder(r1=holderradius-wall*sin(45), r2=holderradius, h=wall);
        translate([0,0, -epsilon+wall*2])
            cylinder(r1=holderradius, r2=0, h=holderradius);
    }
    
   // #translate([0,0,wall*4]) cylinder( r1=radi-wall*4, r2=0,  wall*3);
   
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
    difference() {
        cylinder( r=radi+wall*2, h= wall);
        translate([0, 0, -epsilon]) cylinder( r=radi+wall, h= wall+epsilon);    
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
            translate([d2/2+(d2/7),-wall/2-epsilon, wall*10]) rotate([0,90,90]) cylinder(r=d2/7, h=wall+2*epsilon);    
            translate([d2/2,-wall/2-epsilon, wall*4]) rotate([0,90,90]) cylinder(r=d2/7, h=wall+2*epsilon);
        }
        
        hull()
        {
            translate([-(d2/2+(d2/7)),-wall/2-epsilon, wall*10]) rotate([0,90,90]) cylinder(r=d2/7, h=wall+2*epsilon);    
            translate([-(d2/2),-wall/2-epsilon, wall*4]) rotate([0,90,90]) cylinder(r=d2/7, h=wall+2*epsilon);
        }
    }
   

    
    // top
    
    //end stop
    translate([0,0,height-wall - diameter/2*cos(45)]) cylinder(r1=0, r2=radi-wall*2, h=diameter/2);
    translate([0,0,height+wall*2]) cylinder(r=radi-wall*2,h=wall);
    translate([0,0,height+wall*3]) cylinder(r1=radi-wall*2, r2=0, h=wall);
    
    //piston holder
    piston_holder(h=height+wall*3, r=radi-wall*3, tolerance=tolerance);
}
    
module piston_holder(h, r, tolerance) {
    d = diameter-wall*10;
    supportheight = wall;
    baseradius = r - tolerance;
    baseclearance = wall; //tolerance;
    
    translate([0,0,h]) {
        // support base
        cylinder(r=baseradius-supportheight*sin(45), h=baseclearance);
        translate([0, 0, baseclearance]) cylinder(r1=baseradius-supportheight*sin(45), r2=baseradius, h=supportheight);
        translate([0, 0, baseclearance+supportheight]) cylinder(r1=baseradius-supportheight*sin(45), r2=baseradius, h=supportheight);
//        translate([0, 0, baseclearance+supportheight*2]) cylinder(r1=baseradius/4-supportheight*sin(45), r2=baseradius/4, h=supportheight);
//        translate([0, 0, baseclearance+supportheight*3]) cylinder(r2=baseradius/4-supportheight*sin(45), r1=baseradius/4, h=supportheight);
    }
}

module syringe_body( diameter, height, wall, boca, nansa, nozzleoffset)
{
    radi=diameter/2;
    dcanula=wall*2+boca;
 
    
    difference()
    {
        union()
        {
            // tub
            cylinder(r=radi, h=height);
            cylinder(r=radi*1.02, h=height/9); // sortint de la part baixa

            // part superior [upper part]
                
            difference()
            {
                union()
                {
                    translate([0,0,height]) cylinder(r1=radi, r2=0, h=plungerheight); // cone
                    translate([0,nozzleoffset,height]) cylinder(d1=dcanula*1.3, d2=dcanula, h=altcanula); // nozzle           
                }    
            
                translate([0,0,height-epsilon]) cylinder(r1=radi-wall*2, r2=0, h=plungerheight-wall+2*epsilon);
                translate([0,nozzleoffset,height-epsilon])  cylinder(d1=boca*1.3, d2=boca, h=altcanula+2*epsilon); // nozzle hole
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
    
        translate([0, 0, -epsilon]) cylinder(r=(radi-wall), h=height+epsilon*2);
    }
}