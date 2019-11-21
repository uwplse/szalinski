top_diameter    = 100; // [40:1:500]
middle_diameter =  20; // [10:1:60]
bottom_diameter =  10; // [5:1:40]
top_rim         =   0; // [0:1:50]

wall = 1.5; // [0.5:0.05:4]
create_ventilation = "true"; // [true, false]
create_handle = "true"; // [true, false]

all();

module all()
{
    difference()
    {
        union()
        {
            funnel();
            if(create_ventilation == "true") ventilation();
            if(create_handle == "true") handle();
        }
        funnel(wall);
        
    }
}

module funnel(wall=0)
{
    cylinder(d=top_diameter-2*wall, h=top_rim, $fn=top_diameter);
    translate([0,0,top_rim])
        cylinder(d1=top_diameter-2*wall, d2=middle_diameter-2*wall, top_diameter/2, $fn=top_diameter);
    translate([0,0,top_diameter/2+top_rim-0.1]) 
        cylinder(d1=middle_diameter-2*wall, d2=bottom_diameter-2*wall, top_diameter/2);
}

module handle()
{
    translate([x_handle(),middle_diameter/2,middle_diameter/2]) rotate([90,0,0]) 
        difference()
        {
            cylinder(d=middle_diameter, h=middle_diameter);
            cylinder(d=middle_diameter-2*wall, h=middle_diameter);
        }
}

function x_handle() = (top_rim>5) ? top_diameter/2+middle_diameter/4 : top_diameter/2;


module ventilation()
{
    for(alpha=[0,120,240])
    {
        rotate([0,0,alpha])
        union()
        {
            hull()
            {
                // bottom of funnel
                translate([0,-wall/2,top_diameter+top_rim-0.2]) 
                    cube([bottom_diameter/2,wall,0.1]);
                // middle of funnel
                translate([0,-wall/2,top_diameter/2+top_rim]) 
                    cube([middle_diameter/2+2.5*wall,wall,0.1]);
            }
            hull()
            {
                // middle of funnel
                translate([0,-wall/2,top_diameter/2+top_rim]) 
                    cube([middle_diameter/2+2.5*wall,wall,0.1]);
                // top of funnel
                translate([0,-wall/2,top_rim]) 
                    cube([top_diameter/2*0.9,wall,0.1]);
            }
        }
    }
}
