height = 5;//[1:20]
keyr_size = 20;//[5:75]
keyr_thick = 3;//[1:70]

thick = 5;//[1:20]
length = 40;//[20:100]
holder_size = 30;//[10:100]
hole_opening = 25;//[10:100]



difference()
{
    cylinder(height,d=keyr_size+keyr_thick,d=keyr_size+keyr_thick);
        translate([0,0,-0.5])
        {
            cylinder(height+1,d=keyr_size,d=keyr_size);
        } 
}



translate([-thick/2,keyr_size/2,0])
{
    cube([thick,length,height]);
}


difference()
{
    difference()
    {
        translate([-holder_size/2-thick/2,length+keyr_size/2,0])
            {
                cylinder(height,d=holder_size+thick*2,d=holder_size+thick*2);
            }
        
        translate([-thick/2-hole_opening,keyr_size/2,-0.5])
            {
                cube([hole_opening,length,height+1]);
            }
    }       
        
    translate([-holder_size/2-thick/2,length+keyr_size/2,-0.5])
    {
        cylinder(height+1,d=holder_size,d=holder_size);
    }   
    
}