showCutaway=false;

//[hidden]
small=0.01;

module valve_left()
{
        translate([-1,0,0]) 
        rotate([0,-23,0]) 
        union() {
            cube([5,5,18],center=true); 
            
            translate([0,0,9]) 
            rotate([90,0,0]) 
            translate([0,0,-2.5]) 
            cylinder(5,2.5,2.5); 
        }

}
//!valve_left();

module stem_left()
{
    rotate([0,-23,0])
    translate([-1,0,2.5]) 
    rotate([30,0,0]) 
    cube([1,5,20],center=true);    
}
module valve_right()
{
    rotate([0,0,180])
    valve_left();
}

module stem_right()
{
    rotate([0,0,180])
    stem_left();    
}

module cutout(cnt)
{
    difference()
    {
        union()
        {
            for (i=[0:2:cnt]) 
            {
                translate([0,0,11.5*i])
                valve_left();
                
                translate([0,0,11.5*(i+1)])
                valve_right();
                
            }
        }
        
        union()
        {
            for (i=[0:2:cnt]) 
            {
                translate([0,0,11.5*i])
                stem_left();
                
                translate([0,0,11.5*(i+1)])
                stem_right();
                
            }
        }    
    }
}
//!cutout(2);

module arrow()
{
    linear_extrude(height=1)
    polygon([[0,0],[8,8],[4,8],[4,20],[0,20],[-4,20],[-4,8],[-8,8]]);
}
//!arrow();
module chain()
{
    h=99;
    //scale(1.3)
    translate([0,0,10])
    union()
    {
 
        difference() 
        {
            translate([0,0,h/2]) 
            cube([17,9.5,h],center=true);     
            
            translate([0,0,7])
            cutout(8);
        }
        
        // an arrow to show directionality
        translate([0,-4.25+small,h/2-20/2])
        rotate([90,0,0])
        arrow();
        
        // a nozzle on the top
        translate([-1,0,h-small])
        difference()
        {
            cylinder(d=9.5, h=10);
            translate([0,0,-small])
            cylinder(d=7.5, h=10+2*small);
        }
        
        // straight tube on bottom in a square shape 
        difference()
        {
            translate([0,0,-5+small])
            cube([17,9.5,10],center=true);
            
            translate([2,0,-10-small])
            cylinder(d=7.5, h=10+3*small);
        }
    }

}
if (showCutaway)
{
    difference()
    {
        chain();
        translate([-15,0,-small])cube([30,30,400]);
    }
} else
{
    chain();
}
