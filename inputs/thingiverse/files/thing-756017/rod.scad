//Script made by NeoTheFox
//GNU GPL v2 Licence

/*  [Global */

//How much sectors (6 is the best for printing)
sectors = 6;
//Rod end diameter 
ed = 4.7752;
//Rod thickness
wd = 1.5;
//Rod length
l = 166;

$fn=sectors;

rotate([90,0,45])
difference()
{
    cylinder(d=ed, h=l, center=true);
    
    cylinder(d=ed-wd, h=l+2, center=true);
}