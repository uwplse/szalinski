distance_betweek_propellers_axis = 32; 
bumper_inner_radius = 18; 
bumper_width = 1; 
cross_height = 2; 
bumper_height = 3; 

module  props(r1,r2, h) 
{

    translate([r1,r1,0])
    cylinder(h, r2,r2, center=false);

    translate([-r1,r1,0])
    cylinder(h, r2,r2, center=false);

    translate([r1,-r1,0])
    cylinder(h, r2,r2, center=false);

    translate([-r1,-r1,0])
    cylinder(h, r2,r2, center=false);
}

function CircleCircleIntPos(x,r) = (2*x + sqrt(4*x*x-(4*(2*x*x-r*r))))/2;
function CircleCircleIntNeg(x,r) = (2*x - sqrt(4*x*x-(4*(2*x*x-r*r))))/2;

//scale([.1,.1,.1])
module frame(d,r1, r2, h1,h2) 
{
    
    
    dh = d/2;
    union()
    {
        
        difference()
        {
            difference()
            {
                props(dh,r2,h2);
                translate([0,0,-h2*.5])            
                    props(dh,r1,2*h2);
            }
            
            l = 2*CircleCircleIntPos(dh,r1);
            translate([-l/2,-l/2,-h2*.5])
            cube([l,l, 2*h2], center=false);                        
        }
        
        
        l = 2*CircleCircleIntPos(dh,r2);

        translate([0,0,h1/2])
        {
        cube([l,1, h1], center=true);
        cube([1,l, h1], center=true);
        cylinder(h1,l*.06, l*.06, center=true);
        }

    }
}

frame(distance_betweek_propellers_axis,
        bumper_inner_radius, 
        bumper_inner_radius + bumper_width, 
        cross_height,
bumper_height);

//props(16,15, 1) ;