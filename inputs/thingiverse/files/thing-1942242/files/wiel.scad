hoogtegrip = 15;
gripoffset = 15.5;

module wiel()
    difference()
    {
        union()
            {
            cylinder(r=26/2,h=30);
            cylinder(r=31/2,h=7);        
            
            cylinder(r=35/2,h=2);    
            
            translate([0,0,3.5])
             cylinder(r=35/2,h=2);        
            
            translate([0,0,30-2])
             cylinder(r=30/2,h=2);    
            
            translate([0,0,30-2-1.5-2])
             cylinder(r=30/2,h=2);      
                
                
            }
        
        union()
            {
            cylinder(r=6/2,h=30);
            cylinder(10,15);   
               
            translate([0,0,30])
            rotate(a=[0,180,0])
            cylinder(10,10);     
            }
        
    }
    
module grip()
    
difference()
{
    union()
    {
    translate([0,0,gripoffset])    
    cube(size=[10,10,hoogtegrip],center=true);
    }    

    union()
    {
    //translate([(10-5.5)/2,10/2-5.5/2/2,0])    
    translate([0,0,gripoffset])
    cube(size=[5.5,5.5/2,hoogtegrip],center=true);
    
    //translate([10/2-5.5/2/2,(10-5.5)/2,0])    
    translate([0,0,gripoffset])
    cube(size=[5.5/2,5.5,hoogtegrip],center=true);    
    }    
}

wiel();
grip();