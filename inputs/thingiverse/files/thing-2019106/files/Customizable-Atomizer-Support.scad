
// Describe the support capacity
 number_of_rows=2; //[ 1, 2, 3, 4, 5, 6 , 7 , 8]
 number_of_holes_per_row=3; //[ 1, 2, 3, 4, 5, 6 , 7 , 8]


// Describe your biggest atomizer :
max_atomizer_diameter=20; //[ 16, 17, 18, 19, 20, 21 , 22 , 23, 24, 25, 26, 27, 28, 29 , 30 , 31, 32]
diameter_of_holes=9;//[ 6, 7, 8, 9, 10, 11 , 12 , 13]
hole_depth = 10; // [6,7,8,9,10,11,12,13,14]


//Additional space between holes    
 additional_space=5;// [6,7,8,9,10,11,12,13,14]


// ignore variable values

//this is a teinturman design.
//you can find the published thing from thingiverse at : 
//http://www.thingiverse.com/thing:2019106



AtomizerStand();


module AtomizerStand()
{
$fn=60;
       
 taillez=hole_depth+2;   
 base_diameter=max_atomizer_diameter+5;
 
    
 taillex=(number_of_holes_per_row-1)*(2*(max_atomizer_diameter/2)+additional_space);
 tailley=(number_of_rows-1)*(2*(max_atomizer_diameter/2)+additional_space);

  difference()
  {  

    hull()
    {
        translate([taillex,0,0])cylinder(r1= base_diameter/2,r2=(max_atomizer_diameter/2),h=taillez);
        translate([taillex,tailley,0])cylinder(r1= base_diameter/2,r2=(max_atomizer_diameter/2),h=taillez);
        translate([0,tailley,0])cylinder(r1= base_diameter/2,r2=(max_atomizer_diameter/2),h=taillez);
        translate([0,0,0])cylinder(r1= base_diameter/2,r2=(max_atomizer_diameter/2),h=taillez);
    }
    
    for (i = [0: 1:number_of_holes_per_row-1]) {
    for (j = [0:1:number_of_rows-1]) {
        translate([i*(2*(max_atomizer_diameter/2)+additional_space) ,j*(2*(max_atomizer_diameter/2)+additional_space),1])cylinder(r=diameter_of_holes/2,h=taillez);
    }
    }
 
} 
}

