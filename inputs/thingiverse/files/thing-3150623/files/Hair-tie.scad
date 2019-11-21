$fn=36;
length=100;
width=16;
wire_radius=0.75;


difference()
    {
    union()
        {
        hull()
            {
            translate([-length/2,0,0])
                sphere(r=width/2);

            translate([length/2,0,0])
                sphere(r=width/2);
            
            }



        }
        translate([0,width/5,width/5])
        hull()
            {
            translate([-length,0,0])
                sphere(r=wire_radius);

            translate([length,0,0])
                sphere(r=wire_radius);
            
            }

        translate([0,-width/5,width/5])
        hull()
            {
            translate([-length,0,0])
                sphere(r=wire_radius);

            translate([length,0,0])
                sphere(r=wire_radius);
            
            }

        translate([-length,-width,-width*2])
            cube([length*2,width*2,width*2]);

    }