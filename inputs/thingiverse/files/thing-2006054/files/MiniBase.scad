// Title: Mini Base
// Author: http://www.thingiverse.com/Jinja
// Date: 29/12/2016

/////////// START OF PARAMETERS /////////////////


base_diam = 20; // [10:Tiny, 20:Medium, 40:Large, 60:Huge: 80:Gargantuan]
slot_width = 2;
//base_diam = 20;
//base_diam = 10;
multi_slots = 0; // [1:MultiSlots, 0:SingleSlot]

base_or_mini = 0; // [0:Base, 1:Mini]

//silhouette_filename = "minibase40_bear.dat"; // [image_surface:100x100]
//silhouette_filename = "minibase40_spider.dat"; // [image_surface:100x100]
//silhouette_filename = "minibase40_wolf.dat"; // [image_surface:100x100]
//silhouette_filename = "minibase40_warhorse.dat"; // [image_surface:100x100]
//silhouette_filename = "minibase40_tiger.dat"; // [image_surface:100x100]
silhouette_filename = "minibase40_halfling.dat"; // [image_surface:100x100]

silhouette_scale = 1.0; // warhorse 40
//silhouette_scale = 0.7; // bear 20
//silhouette_scale = 1.2; // bear 40
//silhouette_scale = 1.0; // spider 40
//silhouette_scale = 0.5; // spider 20
//silhouette_scale = 0.3; // spider 10
//silhouette_scale = 1.4; // wolf 40
//silhouette_scale = 0.7; // wolf 20
//silhouette_scale = 1.2; // tiger 40
//silhouette_scale = 0.65; // tiger 20
//silhouette_scale = 0.6; // halfling 20


/////////// END OF PARAMETERS /////////////////
rounded = 1*1;    // the mm width of the bevelled edge

$fs=0.3*1;
$fa=6*1; //smooth
//$fa=20; //rough
pi = 3.1415927 * 1.0;

silhouette_width = 0.3*6.0; // 

if(base_or_mini==0)
{
    Base(base_diam);
}
else
{
    //translate([-1,0,3])
    //rotate([90,0,90])
    Silhouette(silhouette_width);
}

module Silhouette(width)
{
    scale([silhouette_scale,silhouette_scale,width/2.0])
    
    intersection()
    {
        translate([0,0,-15])
        scale([0.5,0.5,30])
        surface(file=silhouette_filename);
        
        cube([150,150,2.0]);
    }
    
    //translate([0,0,1.03])
    //union()
    //{
    //    Image();
    //    scale([1,1,-1])    
    //    Image();
    //}
}

module Image()
{
    difference()
    {
        translate([0,0,-0.03])
        scale([0.5,0.5,1])
        surface(file=silhouette_filename);
        translate([-2,-2,-2])
        cube([150,150,2]);        
    }
    
}



module Base(base_diam)
{
	card = 0.0;
	rad=base_diam/2.0;
    difference()
    {
        union()
        {
            cylinder( 1.5, rad, rad );
            translate( [0,0,1.5] )
            cylinder( 1.5, rad, rad-1.5 );
        }
        if(multi_slots==0)
        {
            Slit(base_diam);
        }
        else
        {
            count=floor(((base_diam/2)-4) / (2*slot_width));
            for (i = [-count : 1 : count]) 
            {
                x=i*2*slot_width;
                translate([x,0,0])
                Slit(base_diam);
            }
        }
    }
}

module Slit(base_diam)
{
    translate([0,0,2.5])
    cube([slot_width,base_diam,3],true);
}

