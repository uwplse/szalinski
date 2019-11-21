//more is smoother
$fn=50;

//diameter in mm
diameter = 50;

radius = diameter/2;

//seal size
seal = 4;


module mold_bottom()
{
    difference()
    {
        translate([0,0,-radius-seal*2])
            cylinder(r=radius+seal*4, h= radius+seal*4);
    
        difference()
        {
            translate([0,0,-radius-seal*2])
                cylinder (r=radius + seal*3, h=radius + seal*3);
            difference()
            {
                union(){
                    sphere (d=diameter);
                    translate([0,0,seal])rotate_extrude()
                        translate([radius + seal ,-seal,0])
                                square([seal,seal]);
                }
                translate([-radius - seal*3,-radius - seal*3,seal])
                    cube([diameter + seal*6,diameter + seal*6,radius]);
            }
        }
    }
    
}

module mold_top()
{
    difference()
    {
        translate([0,0,-radius])
            cylinder(r=radius+seal*4, h= radius+seal*5);
        translate([0,0,+seal])union()
        {
            difference()
            {
                translate([0,0,-radius-seal*2])
                    cylinder (r=radius + seal*3, h=radius + seal*2);
                union()
                {
                    difference(){
                        sphere (d=diameter);
                        translate([-radius - seal*3,-radius - seal*3,0])
                            cube([diameter + seal*6,diameter + seal*6,radius]);

                    }


                }
            }
            rotate_extrude()
                            translate([radius + seal ,-seal,0])
                                    square([seal,seal*2]);
        }
    //translate([0,0,-radius])cylinder(r=diameter/8, h=radius);
    } 
                        translate([0,0,-radius])
                        cylinder(r=diameter/8, h=radius);
}

rotate([180,0,0])
    union(){
    translate([diameter + radius + seal * 3,0,+seal*3])mold_bottom();
    mold_top();
    }