// Simple Towel Hook, customizable width
//
// Thought it would be nice if the hook could made
// as wide as the 2 sided tape used to attach it 
// Default width, 19mm
// 

// Desired width in millimeters
width=19;  // [5:100]

cube ([45, 5 , width]);
translate([50,0,0]) 
{
    translate ([0,5,0])
    {
        rotate([0,0,135])
        {
            cube ([30, 5 , width]);
            translate([30,5 ,0])
            {
                cylinder(h=width,r=5);
            }
        }
        translate([-5,0,0])
        {
            cylinder(h=width,r=5);
            rotate([0,0,163.5])
            {
                difference()
                {
                    translate([2 ,-4,])
                    {
                        cube([3.8,8,width]);
                    };
                    translate([7.5,0,0])
                    {
                        $fn=24;
                        cylinder(h=width,d=5); 
                    }
                
                }
                
            }
            
        }
    }
}
