////////////////////////////////////////////////////
/*

OpenSCAD Random Rock Generator by skitcher
https://www.thingiverse.com/skitcher/about

*/
////////////////////////////////////////////////////

$fn=10; // Resolution

/* [Size parameters] */
// Number of points
count=20; 
//seed=314; // Seed

// Minimum distance from center
mn=10; 

// Maximum distance from center
mx=25; 

// Sphere point radius
r=1.5; 

// % size in X direction
x=1; 

// % size in Y direction
y=1; 

// % size in Z direction
z=1; 



/* [Angle randomizers] */

// min
a1=0;   
//max
a2=360;
// min   
b1=0;   
//max
b2=360; 
// min
c1=0;   
//max
c2=360; 


/* [Hidden] */

lol=Hello_World;

///////////////////////////////////////////////////

//////////

    // Random variables
    rand=rands(mn,mx,count);
    echo(rand);
    
    rand2=rands(a1,a2,count);
    echo(rand2);
    
    rand3=rands(b1,b2,count);
    echo(rand3);
    
    rand4=rands(c1,c2,count);
    echo(rand4);

//////////

///////////////////////////////////////////////////

    // Rock
scale([x,y,z]){
    hull(){
        for(a =[1:1:count]){
            rotate([rand2[a],rand3[a],rand4[a]]) translate([rand[a],0,0]) sphere(r);
            echo(a);
        }
    }   
}   
    
    
///////////////////////////////////////////////////