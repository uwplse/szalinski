// All measures in mm.
// Number of Rows
rows = 5; // [0:10]

// Cell Diameter
cell = 18.8;
// Holder Height
height = 12;
// Space betwen Cells
space = 3;
// Bus Width
bus_w = 7;
// Bus Height
bus_h = 3.5;

////////////////////////////////////////////////////////////////
cubeSize = cell+space;
cols = 2+0;
$fn = 48+0; // number of faces in circle

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
                translate([0,0,height/2]) cube(size = [cell/2, cubeSize+0.1, bus_h+0.3], center = true);
                translate([0,0,height/2]) cube(size = [cubeSize-space/2, cell/2, bus_h+2.5], center = true); 
                translate([0,0,-height/2-bus_h/2-1.2]) cylinder(h = height, r=cell/2);
                if(( i==1 )&&(ii<rows))
                    translate([cell/2+space/2,cell/2+space/2,-height/2-1]) cylinder(h = height*2, r=1.7);
            }
        }
    }
    // Bus Bar
    translate([(rows+1)*(cubeSize+space)/2, (cols+1)*cubeSize/2, height/2])
    cube(size = [(cubeSize+space)*rows, bus_w+0.2, bus_h+0.3], center = true);
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
