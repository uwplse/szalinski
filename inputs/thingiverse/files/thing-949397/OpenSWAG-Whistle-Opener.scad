WhistleOpenerText = "SWAG";

OpenSWAGWhistleOpener(WhistleOpenerText);

module OpenSWAGWhistleOpener(WhistleOpenerText)
{
    difference() 
    {
        union()  
        {       
            
            cylinder(20, r=15, $fn = 35); 

            translate([0,9,0]) 
            cube([35,6,20]);  
                
            cube([15,15,20]); 
        
            translate([12,-22,0]) 
            cylinder(20, r=15, $fn = 35); 
            
            rotate([0,0,120]) 
            translate([-31,-20,0]) 
            rotate([0,0,26]) 
            cube([20,15,20]);
            
            rotate([0,0,100]) 
            translate([10,-36,0]) 
            rotate([0,0,43]) 
            cube([20,40,20]);
            

            //Front Face Text
            translate([7,-10,20])
            rotate ([0,0,115]) 
            linear_extrude(height=1, convexity=4)
            text(WhistleOpenerText, 
                 size=11,
                 font="Bitstream Vera Sans:style=Bold",
                 halign="center",
                 valign="center");
            
            
        }
        
        rotate([0,0,110]) 
        translate([-32,-35,-.001]) 
        rotate([0,0,55]) 
        cube([16,18,20.002]);
        
        translate([19,-17,19/2 + .5])
        rotate([0,0,145])
        union(){
            rotate([0,90,0])
            cylinder(h=1.5, d=19, $fn = 35); 

            translate([0,-19/2,-19/2])
            cube ([1.5,19/2,19]);
        }
        
        translate([0,15.001,-.001])
        cube([50,25,20.002]);
        
        translate([0,0,2]) 
        cylinder(16, r=13, $fn = 25); 
        
        translate([0,11,2]) 
        cube([37,2,16]);

        translate([10,15-2/3,2]) 
        rotate([0,0,150])
        cube([10,4,16]); 
        
        translate([4,15-7.5,2]) 
        cube([30/8,10,16]); 
    }

    translate([0,15-7.5,2]) 
    cylinder(1, r=1, $fn = 10);
    
    difference() 
    {
        translate([0,15-7.5,7]) 
        sphere(3+1, $fn=25); 
        translate([0,15-7.5,7]) 
        sphere(3, $fn=25); 
    }
}


