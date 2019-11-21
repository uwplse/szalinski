// Display rows
rows = 2; // [1:100]
// Display columns
cols = 2; // [1:100]
// Plate height [mm]
plate_height = 10;
// Plate width [mm]
plate_width = 10;
// Display thickness [mm] (must be lower or equal to plate_width)
thickness = 3.2;
/* [Advanced] */
// Separation between rows [mm]
row_space = 2.2;
// Separation between columns [mm]
col_space = 2.2;
// Hole vs bridge gap [mm]
hole_gap=0.4;
// Plate hole size [mm]
hole_size=1.2;
// Gap between frame and plates [mm] (must be lower than row_space/2 and col_space/2)
horizontal_gap=0.6;
// Plates type
plates_type="rounded"; // [rounded:rounded corners,cube:simple cube]
// Adds plate holders to keep them in position
plate_holders="two"; // [none:none,one:one,two:two,twod:two diagonaly,four:four]
// Plate holders hole size [mm]
plate_holders_size=1;
// Plate holders pin size [multiplier]
plate_holders_pin_size=0.8;

$fs = hole_gap;

print_part();

module print_part() {
    for(column = [0 : 1 : cols-1])
    {
        for(row = [0 : 1 : rows-1])
        {
            translate([(row)*(plate_height+row_space),column*(plate_width+col_space),0])holy_roundedcube(plate_height,plate_width,thickness,hole_size);
            if(plate_holders!="none")
            {
                color("white")translate([(row)*(plate_height+row_space)-1.3*(horizontal_gap),column*(plate_width+col_space)+plate_width/5,thickness/2])sphere(plate_holders_pin_size*plate_holders_size);
                if(plate_holders=="two" || plate_holders=="four")
                {
                    color("white")translate([(row)*(plate_height+row_space)-1.3*(horizontal_gap),column*(plate_width+col_space)+4*plate_width/5,thickness/2])sphere(plate_holders_pin_size*plate_holders_size);
                }
                if(plate_holders=="twod" || plate_holders=="four")
                {                
                    color("white")translate([(row)*(plate_height+row_space)+plate_height+1.3*(horizontal_gap),column*(plate_width+col_space)+4*plate_width/5,thickness/2])sphere(plate_holders_pin_size*plate_holders_size);
                }
                if(plate_holders=="four")
                {
                    color("white")translate([(row)*(plate_height+row_space)+plate_height+1.3*(horizontal_gap),column*(plate_width+col_space)+plate_width/5,thickness/2])sphere(plate_holders_pin_size*plate_holders_size);
                }
            }        
        }
        color("white") translate([-row_space+horizontal_gap,(plate_width+col_space)*(column)-col_space+horizontal_gap,0])cube([(plate_height+row_space)*(rows),col_space-2*horizontal_gap,thickness ]);

        color("red") translate([-(horizontal_gap),(column+1)*(plate_width/2)+column*(plate_width/2+col_space),thickness/2])rotate([0,90,0])cylinder(h=(plate_height+row_space)*(rows),r=hole_size-hole_gap);
        
        
    }
    color("white") translate([-row_space+horizontal_gap,(plate_width+col_space)*(cols)-col_space+horizontal_gap,0])cube([(plate_height+row_space)*(rows),col_space-2*horizontal_gap,thickness ]);
    


    for(row = [0 : 1 : rows])
    {
        color("white") translate([row*(plate_height+row_space)-row_space+horizontal_gap,-col_space+horizontal_gap,0])cube([row_space-2*horizontal_gap,(plate_width+col_space)*(cols)+col_space-2*horizontal_gap,thickness ]);       
    }
}

module holy_roundedcube(xdim ,ydim ,zdim, hole_diameter){
difference()
{
    roundedcube(xdim,ydim,zdim);
    translate([0-1,ydim/2,zdim/2])rotate([0,90,0])cylinder(h=xdim+2,r=hole_diameter);
    if(plate_holders!="none")
    {
        translate([0-0.4*(horizontal_gap),ydim/5,zdim/2])sphere(plate_holders_size);
        translate([0-0.4*(horizontal_gap),4*ydim/5,zdim/2])sphere(plate_holders_size);
        if(plate_holders=="twod" || plate_holders=="four")
        {                
            translate([xdim+0.4*(horizontal_gap),ydim/5,zdim/2])sphere(plate_holders_size);
            translate([xdim+0.4*(horizontal_gap),4*ydim/5,zdim/2])sphere(plate_holders_size);
        }
    }
}

}


module roundedcube(xdim ,ydim ,zdim){
union()
{
    diameter=zdim;
    radius=diameter/2;
    if(plates_type=="rounded")
    {
        translate([xdim,ydim-radius,radius])resize([0,0,zdim])rotate([0,-90,0])cylinder(h=xdim,r=radius);
        translate([0,radius,radius])resize([0,0,zdim])rotate([0,90,0])cylinder(h=xdim,r=radius);
        translate([0,radius,0])cube([xdim,ydim-diameter,zdim]);
    }
    else if(plates_type=="cube")
    {
        translate([0,0,0])cube([xdim,ydim,zdim]);
    }
    else if(plates_type=="triangle")
    {
        translate([xdim,ydim/2,radius])rotate([0,-90,0])cylinder(r=radius,h=ydim,$fn=3);
    }
}

}