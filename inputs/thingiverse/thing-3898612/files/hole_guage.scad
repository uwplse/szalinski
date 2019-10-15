minimum = 1;        // starting guage in mm diameter
maximum = 10;       // stopping guage in mm diameter   
height = 10;        // height of guage

for(i=[minimum:maximum])
{
    // triangular numbers to line everything up next to each other
    translate([i*(i+2)/2,0,0]) cylm(i,i+2,height);
    
}
   
// create cylinder with i and 2 mm wall
module cylm(id, od, len)
{
    difference() 
    {
        cylinder(len,d = od);
        translate([0,0,-1])cylinder(len+2,d=id);
    }
}