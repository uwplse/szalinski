// Cell Diameter
cell = 18.5;
// Number of Rows
rows = 3; // [0:10]
// Number of Columns
cols = 2; // [0:10]
// Holder Height
height = 8;
// Space betwen Cells
space = 2;

cubeSize = cell+space;

// number of faces in circle
$fn = 48; 
difference()
{
    translate([(rows+1)*cubeSize/2, (cols+1)*cubeSize/2, 0])
    cube(size = [cubeSize*rows+space, cubeSize*cols+space, height], center = true);
    
    for ( i = [1 : cols] )
    {
        translate([0,i*cubeSize,0])
        for ( ii = [1 : rows] )
        {
            translate([ii*cubeSize,0,0])
            
            union()
            {
                translate([0,0,height/2]) cube(size = [cell/2,cubeSize+3,4], center = true);
                translate([0,0,height/2]) cube(size = [cubeSize+3,cell/2,4], center = true); 
                translate([0,0,-height/2-1.9]) cylinder(h = height, r=cell/2);
            }
            
        }
    }
}

/*for ( i = [1 : numerical_slider2] )
{
    translate([0,i*(21),0])
    for ( i = [1 : numerical_slider] )
    {
        translate([i*(21),0,0])
        difference()
        {
            cube(size = [21,21,8], center = true);
            union()
            {
                translate([0,0,4]) cube(size = [10,23,4], center = true);
                translate([0,0,4]) cube(size = [23,10,4], center = true); 
            }
            translate([0,0,-5.99]) cylinder(h = 8, r=9.1);
        }
    }
}*/
