/******************************************************************************/
/**********                     INFO                                 **********/
/******************************************************************************/
/*
         -               By David Buhler                  -
         -      OpenScad Parametric Tool Shelf V1.1         -
         -  Attribution-NonCommercial 3.0 (CC BY-NC 3.0)  -
         - http://creativecommons.org/licenses/by-nc/3.0/ -

Parametric Tool Shelf, you can configure the numbers of holes for screwdrivers,
rods, paint brushes, pin vise, etc
Each shelf, rear mid or front is adjustable on depth
Each shelf can have the hole sizes adjusted, per shelf

*/

/******************************************************************************/
/**********                     Settings                             **********/
/******************************************************************************/
//adjust the follow to meet your needs,  all measurements in mm.


/* [Shelf] */
//number of holes per shelf
number_of_holes=12;//[1:20] 
//spacing per hole
spacing_of_holes=15;//[2:25]
//Hole Diameter Top
rear_hole=9;//[1:15]
//Hole Diameter Top
mid_hole=8;//[1:15]
//Hole Diameter Top
front_hole=8;//[1:15]
//Rear Shelf Height
rear_height=100;//[40:200]
//Mid Shelf Height
mid_height=55;//[40:200]
//Frount Shelf Height
front_height=40;//[40:200]
//Shelf Depth Rear
shelf_depth_rear=18;//[5:30]
//Shelf Depth Middle
shelf_depth_mid=18;//[5:30]
//Shelf Depth Front
shelf_depth_front=25;//[5:30]
//Wall thickness
wall_thickness=3;//[2:7]

/******************************************************************************/
/**********                   Variable Calcs                         **********/
/****                     no need to adjust these                      ********/
/******************************************************************************/
/* [HIDDEN] */
//Carrier Width based on number of holes and spacing between holes define above
carrier_width=(number_of_holes*spacing_of_holes);//determine how wide the unit will be 
//calculate the size of rear slates for even distribution
rear_slate=(rear_height+wall_thickness)/7;
//if unit is longer than 100mm add a middelk support wall
//this calc adjusts for odd number holes so middel supprt wall will be off centre
middle_wall_position=(floor (number_of_holes/2)*spacing_of_holes)+(wall_thickness/2);
total_self_depth=shelf_depth_rear+shelf_depth_mid+shelf_depth_front;


/******************************************************************************/
/**********                  Make Stuff Happen                       **********/
/******************************************************************************/
$fn=50;
translate([-carrier_width/2,-rear_height/2,total_self_depth]) rotate([-90,0,0])
union()
    {
    //rear shelf and related side walls    
    translate ([wall_thickness,shelf_depth_front+shelf_depth_mid,rear_height])
        carrier(rear_hole,shelf_depth_rear);
    translate ([0,shelf_depth_front+shelf_depth_mid,0])
        cube ([wall_thickness, shelf_depth_rear+wall_thickness,rear_height+wall_thickness]);
    translate ([carrier_width+wall_thickness,shelf_depth_front+shelf_depth_mid,0])
        cube ([wall_thickness, shelf_depth_rear+wall_thickness,rear_height+wall_thickness]);    
    
    //mid shelf and related side walls
    translate ([wall_thickness,shelf_depth_front,mid_height])
        carrier(mid_hole,shelf_depth_mid);
    translate ([0,shelf_depth_front,0])
        cube ([wall_thickness, shelf_depth_mid,mid_height+wall_thickness]);
    translate ([carrier_width+wall_thickness,shelf_depth_front,0])
        cube ([wall_thickness, shelf_depth_mid,mid_height+wall_thickness]);    
    
    //front shelf and related side walls
    translate ([wall_thickness,0,front_height])
        carrier(front_hole,shelf_depth_front);
    translate ([0,0,0])
        cube ([wall_thickness, shelf_depth_front,front_height+wall_thickness]);
    translate ([carrier_width+wall_thickness,0,0])
        cube ([wall_thickness, shelf_depth_front,front_height+wall_thickness]);  
    
    //create a middle support wall similar to the side walls
    if (carrier_width>100)
        {
        translate ([middle_wall_position,shelf_depth_mid+shelf_depth_front,0])
            cube ([wall_thickness, shelf_depth_rear+wall_thickness,rear_height+wall_thickness]);
        translate ([middle_wall_position,shelf_depth_front,0])
            cube ([wall_thickness, shelf_depth_mid,mid_height+wall_thickness]); 
        translate ([middle_wall_position,0,0])
            cube ([wall_thickness, shelf_depth_front,front_height+wall_thickness]);
        } 
        
    //back side slates
    for  (i= [ 0:2:6])
        {
        translate ([0,(total_self_depth),i*rear_slate])
            cube ([carrier_width+(wall_thickness),wall_thickness,rear_slate]);  
        }
    }


/******************************************************************************/
/**********                         Modules                          **********/
/******************************************************************************/
module carrier(hole_dia,shelf_depth)
    {
    difference()
        {
        cube ([carrier_width, shelf_depth,wall_thickness]);
        for (i=[spacing_of_holes/2:spacing_of_holes:spacing_of_holes*number_of_holes])
            {
            translate ([i,shelf_depth/2,-1])cylinder(h=wall_thickness*5,d=hole_dia);
            }    
        }    
    }