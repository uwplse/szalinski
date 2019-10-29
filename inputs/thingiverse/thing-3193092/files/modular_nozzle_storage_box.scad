// modular nozzle storage box
// version 0.0.1
// by pixelhaufen
// is licensed under CC BY-SA 3.0 -> https://creativecommons.org/licenses/by-sa/3.0/

//------------------------------------------------------------------
// User Inputs

// create a seperate model for nozzle module, heat break module, box, lid
type = "box"; // [nozzle module,heat break module,box,lid]

/* [nozzle module] */
nozzle_diameter = 6; // [2:1:12]
nozzle_total_hight = 13; // [5:1:30]
nozzle_threaded_hight = 8; // [5:1:25]

/* [heat break module] */
heat_break_diameter = 7; // [2:1:12]
heat_break_length = 23; // [10:1:50]

/* [box] */
rows = 6; // [2:1:20]
columns = 6; // [2:1:20]
clearance = 0.2; // [0:0.1:1]

/*[Hidden]*/
$fn=50;

//------------------------------------------------------------------
// Main

if (type=="nozzle module")
{
    nozzle_module(nozzle_total_hight, nozzle_threaded_hight, nozzle_diameter);
}
else if(type=="heat break module")
{
    heat_break_module(heat_break_diameter, heat_break_length, nozzle_diameter);
}
else if(type=="box")
{
    box(rows, columns, clearance, nozzle_total_hight);
}
else if(type=="lid")
{
    lid(rows, columns, clearance);
}

//------------------------------------------------------------------
// Modules

module nozzle_module(nozzle_total_hight, nozzle_threaded_hight, nozzle_diameter)
{
    difference()
    {
        main_box([nozzle_diameter+3,nozzle_diameter+3,nozzle_threaded_hight+1],radius=1);
        translate([nozzle_diameter/2+1.5,nozzle_diameter/2+1.5,0.6])
            cylinder(r1=nozzle_diameter/2+0.5, r2=nozzle_diameter/2+0.5, h=nozzle_threaded_hight+1, center=false);
    }
}

module heat_break_module(heat_break_diameter, heat_break_length, nozzle_diameter)
{
    heat_break_length_multiple = ceil((heat_break_length+3)/(nozzle_diameter+3));
    heat_break_diameter_multiple = ceil((heat_break_diameter+1.8)/(nozzle_diameter+3));
      
    difference()
    {
        main_box([(nozzle_diameter+3)*heat_break_diameter_multiple,(nozzle_diameter+3)*heat_break_length_multiple,nozzle_threaded_hight+1],radius=1);
        
        translate([((nozzle_diameter+3)*heat_break_diameter_multiple -
         (heat_break_diameter+1))/2,((nozzle_diameter+3)*heat_break_length_multiple -
         (heat_break_length+1))/2,0])
            translate([heat_break_diameter/2+0.5 ,heat_break_length/2+0.5 ,nozzle_threaded_hight+1])
                rotate([-90,0,0])
                    cylinder(r1=heat_break_diameter/2+0.5, r2=heat_break_diameter/2+0.5, h=heat_break_length+1, center=true);
    }
}

module box(rows, columns, clearance, nozzle_total_hight)
{
    difference()
    {
        main_box([(nozzle_diameter+3)*rows+clearance+1.6,(nozzle_diameter+3)*columns+clearance+1.6,nozzle_total_hight+2],radius=1.8);
        translate([0.8, 0.8, 0.6])
            main_box([(nozzle_diameter+3)*rows+clearance,(nozzle_diameter+3)*columns+clearance,nozzle_total_hight+2],radius=1);
    }
}

module lid(rows, columns, clearance)
{
    difference()
    {
        main_box([(nozzle_diameter+3)*rows+clearance+3.2,(nozzle_diameter+3)*columns+clearance+3.2,3],radius=2.6);
        translate([0.8, 0.8, 0.6])
            main_box([(nozzle_diameter+3)*rows+clearance+1.6,(nozzle_diameter+3)*columns+clearance+1.6,3],radius=1.8);
    }
}

module main_box(size,radius)
{
    hull()
    {
        translate([radius, radius, 0])
            cylinder(r1=radius, r2=radius, h=size[2], center=false);
        translate([size[0]-radius, radius, 0])
            cylinder(r1=radius, r2=radius, h=size[2], center=false);
        translate([radius, size[1]-radius, 0])
            cylinder(r1=radius, r2=radius, h=size[2], center=false);
        translate([size[0]-radius, size[1]-radius, 0])
            cylinder(r1=radius, r2=radius, h=size[2], center=false);
    }
}
