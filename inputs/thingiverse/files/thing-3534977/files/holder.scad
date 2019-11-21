/*
Glue some foam to one or both ends to hold the batteries
*/

include <shape_trapezium.scad>;

base_height = 3;
batt_len    = 72;
batt_start  = -85;  //my COG is here
                    //you may have to add some base if yours is further forward
batt_pad_W  = 14;
batt_pad_H  = 14;
batt_pad_D  = 4;

guide_start = -82;
guide_gap   = 41;
guide_dist  = 42;

steady_start = -58;
steady_gap   = 44;
steady_dist  = 9;

module front ()
{
difference()
    {
    polygon(
    shape_trapezium([36, 17], 
    h = 21,
    corner_r = 2)
    );
    polygon(
    shape_trapezium([28, 9], 
    h = 13,
    corner_r = 2)
    );
   }
}
module  mid ()
{
//translate([0,-36,0]) //show not fitted
translate([0,-32,0])
difference()
    {
    polygon(
    shape_trapezium([50, 36], 
    h = 45,
    corner_r = 2));
    polygon(
    shape_trapezium([42, 28], 
    h = 37,
    corner_r = 2));
    }
}

module  back ()
{
    translate([0,-71,0])
    difference()
    {
        polygon(
        shape_trapezium([49, 50], 
        h = 35,
        corner_r = 2));
        polygon(
        shape_trapezium([41, 42], 
        h = 27,
        corner_r = 2));
    }
}

//steady_start = -58;
//steady_dist  = 9;
module  steady()
{
    translate([(steady_gap/2)-(batt_pad_D/2),steady_start,0])
        cube([batt_pad_D,batt_pad_D,batt_pad_H]);
    translate([-(steady_gap/2)-(batt_pad_D/2),steady_start,0])
        cube([batt_pad_D,batt_pad_D,batt_pad_H]);
    translate([-24,steady_start,0])
        #cube([batt_pad_D,batt_pad_D,batt_pad_H]);
    translate([20,steady_start,10])
        cube([batt_pad_H,batt_pad_D,batt_pad_D]);
    translate([-34,steady_start,10])
        cube([batt_pad_H,batt_pad_D,batt_pad_D]);
    
    translate([20,-49,0])cube([8,13,base_height]);
    translate([-28,-49,0])cube([8,13,base_height]);
}

module batt()
{
    translate([-(batt_pad_W/2),batt_start,0])
        cube([batt_pad_W,batt_pad_D,batt_pad_H]);
    translate([-(batt_pad_W/2),batt_start+batt_len,0])
        cube([batt_pad_W,batt_pad_D,batt_pad_H]);
}
//
module guides()
{
    translate([-(guide_gap/2)-(batt_pad_D/2),guide_start,0])
        cube([batt_pad_D,batt_pad_D,batt_pad_H]);
    translate([(guide_gap/2)-(batt_pad_D/2),guide_start,0])
        cube([batt_pad_D,batt_pad_D,batt_pad_H]);

    translate([-(guide_gap/2)-(batt_pad_D/2),
    guide_start+guide_dist,0])
        cube([batt_pad_D,batt_pad_D,batt_pad_H]);
    translate([(guide_gap/2)-(batt_pad_D/2),
    guide_start+guide_dist,0])
        cube([batt_pad_D,batt_pad_D,batt_pad_H]);
}

module holder()
{
    linear_extrude(base_height) front();
    linear_extrude(base_height) mid();
    linear_extrude(base_height) back();
    steady();
    batt();
    guides();
}

module holder1()
{
    linear_extrude(base_height) front();
    linear_extrude(base_height) mid();
    linear_extrude(base_height) back();
    steady();
    batt();
    guides();
}

holder();
translate([70,0,0])holder1();