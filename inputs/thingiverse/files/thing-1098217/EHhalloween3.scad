//Elizabeth Henning
//Monster 2.0 (Printable Version)


mouth_dude = 1; //[1:On,0:Off]
the_teeth = 1; //[1:On, 0:Off]
middleEye = 1; //[1:On, 0:Off]


/* [Hidden] */
$fn=120;
body = 30; 
differenceCube=50;

module eyeStem()
{
    translate([0,0,body*1.9])
    {
        hull()
        {
            cylinder(r=8, h=.1);
            translate([0,2,16])
                cylinder(r=4,h=.1);
        } 
    } 
}

module teeth()
    {
        cylinder(r=2, r2=.5, h=10);
         
    }
    
 module theDude()
 {   
    difference() 
    {
        translate([0,0,body]) //body
        {
            sphere(r=body);
        }

        //the mouth
        union() 
        {
            translate([body,0,body+body/10])
            {
                scale([1.1,1.1,1.1])
                {
                    difference()
                    {
                        sphere(r=body/2);
                        union()
                        {
                            translate([0,0,-body])
                                cube([body*3, body*3, body*2], center=true);
                            translate([0, -body*3/2, 0])
                                cube([body*3, body*3, body*3]);
                        }

                    }
                }
            }
            
        }
    }
    
    //the eyes
    if (middleEye==1)
    {
        translate([0,-2,0]) //top eye
        {

            eyeStem();
            translate([0,0,body*1.9+20]) 
            {
                sphere(r=9); 
                translate([6,0,2])
                    sphere(r=5); //pupil
            }
        }
    }

    translate([0,12,-2]) //left eye
    {
        rotate([30,0,0])
            eyeStem();
    }
    translate([0,-25,body*1.9+10])
    {
        sphere(r=8); 
        translate([5,0,2])
            sphere(r=4); //pupil
    }

    translate([0,-15,-2]) //right eye
    {
        rotate([-25,0,0])
            eyeStem();
    }
    translate([0,20,body*1.9+10]) 
    {
        sphere(r=6.5); 
        translate([4.5,0,2])
            sphere(r=3); //pupil
    }
}

rotate([0,0,180])
{
    translate([0,0,-8])
    {
        difference()
        {
            theDude();
            cube([100,100,16], center=true); //make bottom flat
        }

        if (mouth_dude==1)
        {
            translate([22,0,30]) //mini Dude
                scale([.2,.2,.2])
                    theDude();
        }

        if (the_teeth==1)
        {
            translate([25.5,-11,32.9]) //big left tooth
                rotate([0,5,0])
                        teeth();
        

            translate([25.5,11,32.9]) //big right tooth
                rotate([0,5,0])
                    teeth();
        }

    }
}