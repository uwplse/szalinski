/******************************************************************************/
/**********                     INFO                                 **********/
/******************************************************************************/
/*
Tripod Antenna Mount Spacer 1.0 May 2016
by David Buhler
Used to mount amatuer radio antennas with a post mount u-bracket to a tripod. 
I used an old camera tripod that works perfectly for this.

Attribution-NonCommercial 3.0 (CC BY-NC 3.0)
http://creativecommons.org/licenses/by-nc/3.0/
*/
/******************************************************************************/
/**********                     Settings                             **********/
/******************************************************************************/
//adjust the follow to meet your needs,  all measurements in mm.

/* [Spacer Sizing] */
//Top Tripod Ring Diameter
outer_ring=49;//[5:100] 
//Tripod Post Diameter
tripod_post=21.9;//[5:100]
//Height of the Spacer
mount_height=58;//[5:100]
//Screw Thread Diameter
screw_diameter=3;//[1:7]
//Screw Head Diameter
screw_head_dia=6;//[2:15]

/******************************************************************************/
/**********                   Variable Calcs                         **********/
/****                     no need to adjust these                      ********/
/******************************************************************************/
/* [HIDDEN] */

/******************************************************************************/
/**********                  Make It Happen Stuff                    **********/
/******************************************************************************/
$fn=50;
difference (){
cylinder(d=outer_ring,h=mount_height);
cylinder(d=tripod_post,h=mount_height);//post hole
translate ([-0.5,-outer_ring/2-0.01,-.01]) 
   cube([1,outer_ring+2,mount_height+2]);
translate ([-outer_ring/2,-outer_ring/3,mount_height/2])rotate([90,0,90]) 
   screw_hole();
translate ([-outer_ring/2+screw_head_dia-3,-outer_ring/3,mount_height/2])rotate([90,0,90]) 
   screw_head();
translate ([-outer_ring/2,outer_ring/3,mount_height/2])rotate([90,0,90]) 
   screw_hole();
translate ([-outer_ring/2+screw_head_dia-3,outer_ring/3,mount_height/2])rotate([90,0,90]) 
   screw_head();
}
/******************************************************************************/
/**********                         Modules                          **********/
/******************************************************************************/
module screw_hole(){
     cylinder(d=screw_diameter,h=outer_ring); 
}
module screw_head(){
    cylinder(d=screw_head_dia,h=outer_ring/3); 
}