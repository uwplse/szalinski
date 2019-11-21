// diameter (mm) of holes or sides of square.  Increase this to include printer error
_diam = 8.2;             
// depth of holes (mm)
_depth = 12;                
// num of columns of holes
_cols = 4;                  
// num of rows of holes
_rows = 3;                  

// hole shape
_strShape = "circle";   //[circle,square,hex]  
// radius of rounded edges on tray.  If hole shape is squares, use 0 or small number.
_rad_rounded_edge = 3;      
// should small holes be placed to save on print material?
_add_intersect_holes = 1; // [1:yes,0:no]

function int_to_bool(n) = n == 1 ? true : false; 

module hole(diam, depth, strShape)
{
    if(strShape == "circle")
    {
        cylinder(depth,d=diam, $fn=diam*4);
    }
    else if (strShape == "square")
    {
        translate([-diam/2,-diam/2,0]) cube([diam, diam, depth]);
    }
    else if (strShape == "hex")
    {
        rotate([0,0,15]) cylinder(depth,d=diam, $fn=6);
    }
    
}
module hole_array(diam, depth, cols, rows, strShape)
{
    for(r=[0: rows - 1])
    {
        translate([0, r * (diam + 1.2),0])
        for(c=[0: cols - 1])
        {
            translate([c * (diam + 1.2) ,0,1.2]) hole(diam, depth + .1, strShape);
        }
    }
}
module intersect_hole(diam, depth)
{
    rotate([0,0,360/16]) cylinder(depth, d=diam/3, $fn=8);
    //diam, depth, cols, rows
}
module intersect_hole_array(diam, depth, cols, rows)
{
    for(r=[0: rows - 2])
    {
        translate([0, r * (diam + 1.2),0])
        for(c=[0: cols - 2])
        {
            translate([c * (diam + 1.2) ,0,1.2]) intersect_hole(diam, depth + .1);
        }
    }
}
module tray(diam=10, depth=10, cols=2, rows =2, strShape = "square", rad_rounded_edge = 0, add_intersect_holes = false)
{
    
    difference()
    {   
        minkowski()
        {
            translate([rad_rounded_edge,rad_rounded_edge,0])
            cube([  ( (diam * cols) + (cols * 1.2) + (1 * 1.2) - (2*rad_rounded_edge))  , 
                      ( (diam * rows) + (rows * 1.2) + (1 * 1.2) - (2*rad_rounded_edge)) , 
                        depth + 1.2]);
            cylinder(.01,r=rad_rounded_edge, $fn=20);
        }
        translate([(diam/2) + 1.2, (diam/2) + 1.2, 0]) 
            hole_array(diam, depth, cols, rows, strShape);
        
        if(add_intersect_holes == true)
        {
            translate([diam + ( 1.2 + (1.2/2)) , diam + ( 1.2 + (1.2/2)) ,0])
            intersect_hole_array(_diam, _depth,_cols,_rows);
        }
    }
}

// output the tray
tray(_diam, _depth, _cols, _rows, _strShape, _rad_rounded_edge, int_to_bool(_add_intersect_holes));

