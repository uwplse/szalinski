/*
    Parametric pacman
    Carles Oriol .  March 2015 - http://www.thingiverse.com/carlesoriol/about
*/


//use <arc.scad>; // inlined

// Resolution
$fn=128;


/* [Global] */

// Pacman radius
size = 20; // [1:100]

// Mouth open rangle
mouthangle = 45; // [0:180]

// Flat pacman (2D)
flat = 0; // [1, 0]

// Flat base to hold it up
flatbase = 0; // [1, 0]

// Solid eyes
eyes = 0; // [1, 0]

// Holed eyes
holeeyes = 0; // [1, 0]

// Empty pacman ball
holed = 0; // [1, 0]



pacman(size, mouthangle, flat, flatbase, eyes, holeeyes, holed );

//pacman_demo();
//pacman(5, 45, holed=true, flat=true);

module pacman_demo()
{
pacman(5, 45);
translate([15,0,0]) pacman(5, 45, flat=true);
translate([30,0,0]) pacman(5, 45, flatbase=true);
translate([45,0,0]) pacman(5, 45, flatbase=true, flat=true);
translate([60,0,0]) pacman(5, 45, eyes=true);
translate([75,0,0]) pacman(5, 45, holeeyes=true, flat=true);
translate([90,0,0]) pacman(5, 45, holeeyes=true);
translate([105,0,0]) pacman(5, 45, holed=true);
translate([120,0,0]) pacman(5, 45, eyes=true, flat=true);
translate([135,0,0]) pacman(5, 45, holed=true, flat=true);
}


module pacman(size, mouthangle, flat=false, flatbase = false, eyes=false, holeeyes=false, holed=false, pcolor = [1,1,0])
{
    if( flat)
        dopacman_flat(size, mouthangle, flatbase, eyes, holeeyes, holed, pcolor );
    else
        dopacman(size, mouthangle, flatbase, eyes, holeeyes, holed, pcolor );
}

module dopacman(size, mouthangle, flatbase = false, eyes=false, holeeyes=false, holed=false, pcolor = [1,1,0])
{

    color( pcolor )
    {

    difference()
    {
       difference()
        {
            sphere(size);
            if( holed )
            sphere(size*.9);
                
        }
        
         rotate([0,mouthangle/2,0]) 
            translate([0,-size,0]) 
                rotate([0,90,90]) 
                    arc(0, size*1.1, size*2, mouthangle);
        
        if( flatbase) 
         translate([0,0,-size]) cube([size*2, size*2, size/4], center=true);
        
        if( holeeyes)
      color([.2,.2,.2]) 
    {
      translate([size/3,size/2,size/2]) sphere( size/4);
      translate([size/3,-size/2,size/2]) sphere( size/4);
    }
    }
}



if( eyes)
      color([.2,.2,.2]) 
    {
      translate([size/3,size/2,size/2]) sphere( size/4);
      translate([size/3,-size/2,size/2]) sphere( size/4);
    }
}

module dopacman_flat(size, mouthangle, flatbase=false, eyes= false, holeeyes=false,  holed=false, pcolor = [1,1,0])
{
   
    color( pcolor )
 {  
    difference()
    {
            difference()
        {
        translate([0,size/16,0])
        rotate([90,90,0]) 
        rotate([0,0,180-mouthangle/2]) translate([0,0,-size/16]) arc(0, size, size/4, 360-mouthangle);
        
            if( holed )
            {
        translate([0,size/2,0])
        rotate([90,90,0]) 
        rotate([0,0,180-(mouthangle*1.50)/2]) translate([0,0,-(size*.8)/16]) arc(0, (size*.8), size, 360-(mouthangle*1.50));
                }
        }
            if( holeeyes)
            translate([size/8,0,size/2])
                rotate([90,0,0]) cylinder(r=size/8, h=(size/4)*1.1, center=true);
    }
        if( flatbase)
            translate( [0,0,-size] ) cylinder(r=size/2, h=size/8);    
    }
    
    if( eyes)   color([.2,.2,.2]) 
            translate([size/8,0,size/2])
                //rotate([90,0,0]) cylinder(r=size/8, h=(size/4)*1.1, center=true);
                sphere(size/6);
}

/*
Inlined arc module

    http://www.thingiverse.com/thing:735183

    Working for figures over 180º
    modified 1st parameter name to innerradius
    modifier parameters order
    modified parameter name depth -> height
    
     Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
     
     by Carles Oriol  March 2015
*/

/* 
 * Excerpt from... 
 * 
 * Parametric Encoder Wheel 
 *
 * by Alex Franke (codecreations), March 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
*/




module arc( innerradius, radius, height, degrees ) 
{
    $fn=200;
    
    render() 
    {
            if( degrees > 180 )
            {
                difference()
                {
                  difference()
                    {
                        cylinder( r=radius, h=height );
                        cylinder( r=innerradius*1.0001, h=height );
                    }
                    rotate([0,0,-degrees]) arc( innerradius,radius*1.001, height*1.0001,  360-degrees) ;                    
                }
            }
            else
            {        
                difference() 
                {    
                    // Outer ring
                    rotate_extrude()
                        translate([innerradius, 0, 0])
                            square([radius - innerradius,height]);
                
                    // Cut half off
                    translate([0,-(radius+1),-.5]) 
                        cube ([radius+1,(radius+1)*2,height+1]);
           
                    // Cover the other half as necessary
                    rotate([0,0,180-degrees])
                    translate([0,-(radius+1),-.5]) 
                        cube ([radius+1,(radius+1)*2,height+1]);
                }
            }
        
    }
}