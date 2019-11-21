//Select an STL part to generate. 
part = "printall"; // [disc,stick,all,printstick,printdisc,printall]

//Should numbers be printed on top to use it like a dice? It works only until 20...
print_numbers=1; //[0,1]

//disc with numbers to replace a dice, set it to maximum 20. If set to e.g. 32, it will be rather round.
numbers=32;

//The space around the middle stick to make it fit snugly into the disc
wiggle=.25;

//Height of the top in mm
totalheight=25;

//width of the top's round mass
disc_diameter=30;

//shrinking percentage for the top's round mass
disc_percent_smaller=0.75;

//stick thickness in mm
stickw=2.6;

//stick stop lock width adder in mm
stick_stop_width=1.5; 

//-------------------

//set corners
$fn=numbers;

/*
Customizable Spinning top with numbers
Version 8, December 2017
Written by MC Geisler (mcgenki at gmail dot com)

License: Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
Under the following terms:
    Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. 
    You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial - You may not use the material for commercial purposes.
    ShareAlike - If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original. 
*/

disc_height=totalheight/4;
pointy_height=totalheight/4;

module stick(adder)
{
    sticklockh=disc_height/2;    
    color("red")
        translate([0,0,-.1])
            rotate([0,0,45])
                {
                    translate([0,0,totalheight/2+wiggle])
                        intersection()
                        {
                            cube([stickw+2*adder,stickw+2*adder,totalheight+wiggle*2],center=true);
                            //pointy end
                            cylinder(r1=0,r2=totalheight,h=totalheight,center=true);
                        }
                    //lock
                    translate([0,0,pointy_height+sticklockh/2+adder/2])
                            cube([stickw+2*adder+2*stick_stop_width,stickw+2*adder,sticklockh+adder],center=true);
                }
}


// .1 .15  /.18 .3
fontfilename="write/Orbitron.dxf"; 

textsizes=  [0, 0, 0, .13, .15, .15, .15, .15, .15, .15, .13, .12, .11, .11, .1, .1, .09, .09, .08, .08, .07];
textsize=disc_diameter*textsizes[numbers]; 

textoffsets=[0, 0, 0, .15, .25, .3,  .3,  .32, .33, .35, .35, .37, .37, .39, .4, .4, .41, .41, .42, .42, .42];
textoffset=disc_diameter*textoffsets[numbers];

use <write/Write.scad>  
number_depth=disc_height/3;

module disc()
{
    difference()
    {
        translate([0,0,pointy_height])
            cylinder(r1=disc_diameter/2*disc_percent_smaller,r2=disc_diameter/2,h=disc_height);
        
        //cutout stick
        stick(wiggle);
        
        if (print_numbers==1)
        {
            //cutout numbers
            for (round = [0:numbers-1])
                rotate([0,0,360/numbers*(round+.5)])
                    translate([textoffset,0,disc_height+pointy_height])
                        rotate([0,0,90])
                            write(str(round+1),t=number_depth,h=textsize,font=fontfilename,space=1,center=true);
        }        
    }  
}

//-------------------------------

if (part=="disc")
    translate([0,0,-pointy_height])
        disc();

if (part=="all")
        disc();

if (part=="stick" || part=="all")
    stick(0);

if (part=="printstick" || part=="printall")
    translate([0,totalheight/2,stickw/2])
        rotate([90,45,0]) 
            stick(0);

if (part=="printdisc" || part=="printall")
    rotate([180,0,0])
        translate([disc_diameter/2+stickw*2,0,-pointy_height-disc_height])
            disc();
