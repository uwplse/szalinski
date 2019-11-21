//  "Paper" Snowflake Picture Frame Generator
//      This script simulates folding and cutting a paper snowflake
//      Uncomment the "folded_snowflake" line to see how the cuts 
//          look on the "folded" paper
//
//  Created by Andrew Moore 2016
//  http://www.thingiverse.com/tacpar  
//  
//  Licensed under Creative Commons Attribution-ShareAlike 3.0
//  
//=============================

//=============================
//Global Constants: 
//  Don't change these. It will break the code.
//=============================
//don't change this value
inch =25.4;

//=============================
//Compiler Options: 
//These will change your viewing options in OpenSCAD
//=============================
//use a small number to turn circle/oval cuts into polygons instead
$fn=15;          


//=============================
//Global Mechanical Variables: 
//  Change these to adjust physical properties of the part
//=============================
//numfolds should always be 4.  Anything else will break the code until a few things are fixed
numfolds = 4;

//Pick a number 0-4... 4 takes a really long time to render!
fractal_layers = 4;
//size of the square photograph; use "X*inch" to set value in inches (put a number in for X)... this trick won't work in Customizer
picture_size = 75;
//Thickness of the final part
snowflake_thickness = 3; 
//Turns corner cuts on or off
corner_cuts = [true, true, true, true];
//Skews the circular corner cuts for each corner
corner_skew = [0.5,1,1,.5]; 
//Radius of the circular corner cuts (pre-skew)
corner_cut_rad = [7,5,6,8]; 
//Turns the side cuts on or off
side_cuts = [true, true, true, true]; 
//skews the diamond shaped side cuts
side_skew = [1,1.5,1,0.25];
//numbers should stay be between 0.25 and 0.75; use 0.5 for centered cuts
side_offset = [0.25,0.5,0.6,0.3]; 
//size of the side cuts (pre-skew)
side_cut_len = [8,4,6,7];   

//==============================
//Calculated Variables: 
//Do not Change these directly
//==============================
num_layers = pow(2,numfolds);//Do not Change this
paper_size = picture_size;
fold_length = paper_size/pow(2,(floor((numfolds+1)/2)));//Do not Change this
fold_width = paper_size/pow(2,(floor((numfolds)/2)));//Do not Change this



module main()
{
    //add global logic and call part modules here

    //translate([100,0,0]) rotate([0,0,135]) folded_snowflake();//this shows how the cuts are made on the folded paper
    //picture_frame();
    flat_snowflake();
    //Play with these values to set the density of the flake
    //To avoid unconnected "floaters", each subsequent fractal layer should not contain more values that the previous layer for a given instantiation of the snowflake.
    if (fractal_layers >0)frac([0,4,8,12,16,20],15) flat_snowflake();
    if (fractal_layers >1)frac([0,4,8,12,16,20],15) frac([2, 16,21],15) flat_snowflake();
    if (fractal_layers >2)frac([0,4,8,12,16,20],15) frac([21],15) frac([4, 14, 21],15) flat_snowflake();
    if (fractal_layers >3)frac([0,4,8,12,16,20],15) frac([21],15) frac([21],15) frac([3,15, 21],15) flat_snowflake();
    
    module frac(series=[3,15,21], arm_angle = 15)
    {
        for( i=series)
        {
            rotate([0,0,i*arm_angle]) 
                translate([3*paper_size/4, 0,0]) 
                    rotate([0,0,45]) 
                        scale([0.5,0.5,1]) children();
        }
    }   
}

module picture_frame()
{
    difference()
    {
        positives();
        negatives(); 
    }
    module positives()
    {
        cube([paper_size+5,paper_size+5, snowflake_thickness+1], center=true);
    }
    module negatives()
    {
        translate([0,0,snowflake_thickness]) cube([paper_size,paper_size, 2], center=true);
        cube([paper_size-5,paper_size-5, snowflake_thickness+2], center=true);
    }
}
module folded_snowflake()
{
   for(i=[0:num_layers-1])
   {
         difference()
       {
            positives(i);
            negatives(i);
       }  
   }  
   module positives(i=0)
   {
       color([15*i/255, 15*i/255, 15*i/255]) translate([0,0,i]) cube([fold_width, fold_length, snowflake_thickness]);
   }
    module negatives(i=0)
   {  
       if(corner_cuts[0]) scale([corner_skew[0],1,1]) cylinder(r=corner_cut_rad[0], h=100, center=true);
       if(corner_cuts[1]) translate([fold_width, 0,0]) scale([corner_skew[1],1,1])cylinder(r=corner_cut_rad[1], h=100, center=true);
       if(corner_cuts[2]) translate([fold_width, fold_length,0]) scale([corner_skew[2],1,1])cylinder(r=corner_cut_rad[2], h=100, center=true);
       if(corner_cuts[3]) translate([0, fold_length,0]) scale([corner_skew[3],1,1])cylinder(r=corner_cut_rad[3], h=100, center=true);
           
       if(side_cuts[0]) translate([fold_width*side_offset[0],0,0]) scale([side_skew[0],1,1]) rotate([0,0,45]) cube([side_cut_len[0], side_cut_len[0], 100], center=true);
       if(side_cuts[1]) translate([fold_width,fold_length*side_offset[1],0]) scale([side_skew[1],1,1])rotate([0,0,45]) cube([side_cut_len[1], side_cut_len[1], 100], center=true);
       if(side_cuts[2]) translate([fold_width*side_offset[2],fold_length,0]) scale([side_skew[2],1,1])rotate([0,0,45]) cube([side_cut_len[2],side_cut_len[2], 100], center=true);
       if(side_cuts[3]) translate([0,fold_length*side_offset[3],0]) scale([side_skew[3],1,1]) rotate([0,0,45]) cube([side_cut_len[3], side_cut_len[3], 100], center=true);
   }
   
}


module flat_snowflake()
{
   translate([-1.5*fold_length, -1.5*fold_width,0]) for(i=[0:num_layers-1])
   {
       //color([15*i/255, 15*i/255, 15*i/255]) translate([(i%numfolds)*fold_width,floor(i/numfolds)*fold_length,0]) rotate([rx, ry, 0]) translate([-fold_width/2, -fold_length/2,-0.5]) 
       //flip_shift2_3(i) 
       flip_shift4(i)difference()
       {
            positives(i);
            negatives(i);
       }  
   }  
   module positives(i)
   {
       cube([fold_width, fold_length, snowflake_thickness]);
   }
    module negatives(i)
   {
       if(corner_cuts[0]) scale([corner_skew[0],1,1]) cylinder(r=corner_cut_rad[0], h=100, center=true);
       if(corner_cuts[1]) translate([fold_width, 0,0]) scale([corner_skew[1],1,1])cylinder(r=corner_cut_rad[1], h=100, center=true);
       if(corner_cuts[2]) translate([fold_width, fold_length,0]) scale([corner_skew[2],1,1])cylinder(r=corner_cut_rad[2], h=100, center=true);
       if(corner_cuts[3]) translate([0, fold_length,0]) scale([corner_skew[3],1,1])cylinder(r=corner_cut_rad[3], h=100, center=true);
           
       if(side_cuts[0]) translate([fold_width*side_offset[0],0,0]) scale([side_skew[0],1,1]) rotate([0,0,45]) cube([side_cut_len[0], side_cut_len[0], 100], center=true);
       if(side_cuts[1]) translate([fold_width,fold_length*side_offset[1],0]) scale([side_skew[1],1,1])rotate([0,0,45]) cube([side_cut_len[1], side_cut_len[1], 100], center=true);
       if(side_cuts[2]) translate([fold_width*side_offset[2],fold_length,0]) scale([side_skew[2],1,1])rotate([0,0,45]) cube([side_cut_len[2],side_cut_len[2], 100], center=true);
       if(side_cuts[3]) translate([0,fold_length*side_offset[3],0]) scale([side_skew[3],1,1]) rotate([0,0,45]) cube([side_cut_len[3], side_cut_len[3], 100], center=true);
   }
   module flip_shift4(i)
   {
       //I know this code is really ugly.  It took some hacking to get it to work... For some strange reason, it only works if I call children() inside every stinking if()!!! I'd prefer to set a variable for rotation and call children() once.
       //I tried to set the rotation as a variable instead of calling the same transforms 
       //   in every single if statement, but it didnt work, so the code is functional but ugly...
       if (i==0||i==2||i==8||i==10) 
       {
           color([15*i/255,15*i/255, 15*i/255]) 
           translate([(i%numfolds)*fold_width,floor(i/numfolds)*fold_length,0]) rotate([180, 0, 0]) translate([-fold_width/2, -fold_length/2,-snowflake_thickness/2]) children();
       }
       if (i==1||i==3||i==9||i==11) 
       {
           color([15*i/255, 15*i/255, 15*i/255]) 
           translate([(i%numfolds)*fold_width,floor(i/numfolds)*fold_length,0]) rotate([0, 0, 180]) translate([-fold_width/2, -fold_length/2,-snowflake_thickness/2]) children();
       }
       if (i==4||i==6||i==12||i==14) 
       {
           color([15*i/255, 15*i/255, 15*i/255]) 
           translate([(i%numfolds)*fold_width,floor(i/numfolds)*fold_length,0]) rotate([0, 0, 0]) translate([-fold_width/2, -fold_length/2,-snowflake_thickness/2]) children();
       }
       if (i==5||i==7||i==13||i==15){
           color([15*i/255, 15*i/255, 15*i/255]) 
           translate([(i%numfolds)*fold_width,floor(i/numfolds)*fold_length,0]) rotate([0,180, 0]) translate([-fold_width/2, -fold_length/2,-snowflake_thickness/2]) children();
       }  
   }

   
}
//execute program and draw the part(s)
color("silver") rotate([0,0,45]) main();
