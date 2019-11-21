/*
Configurable Ducting System for a Quadcopter

    According to the study below (and Richards work) the optimal optimal configuration found experimentally includes a δtip = 0.1%Dt,  rlip = 13%Dt, θd = 10◦ and Ld = 50% to 72%Dt.

    A Quick(ish) Key:
        prop_dia_upper:
            Longest Part of the Propellor.
            IDEAL: Whatever your prop measures.
        prop_spacing:
            The extra space that is added to both sides of the prop_dia_upper variable to give the inside wall of the duct.
            IDEAL: 0.1% of the dia_total, BUT you probably want more tolerance if you're printing/using cheaper props. I've left this as a millimeter value though, not a percentage so that you can define set tolerance.
        dia_total:
            Combines the variables as described above.
            IDEAL: N/A - don't change this unless you're really ripping things to pieces.
        lip_radius_pc:
            Affects the radius of the top curve of the duct, percentage based on the dia_total variable.
            IDEAL: 13%
        shroud_lower_length_pc:
            Affects the length of the duct section, based on the dia_total variable.
            IDEAL: 50 - 70%
        duct_angle:
            The angle off of vertical (Z) by which the inner duct wall pushes outwards.
            IDEAL: 10 degrees
        duct_resolution:
            Affects overall number of slices (the smoothness or quality of the end STL).
            IDEAL: 120. Higher is better, but will take ages if you go too high.

    NOTE ON REDUCING WEIGHT:
        I have a way of reducing weight -- look for the 'slice_extruded' module and replace the 'slice_final' with 'slice_final_hollow' - but be warned, you need to check that the placement doesn't leave you with overly thin walls as it does not always scale well with changes to certain variables. 
        
        You'll want to work with the translate and scale functions to find a good balance for your needs. 
        
        Comment out the 'slice_extruded' and call 'slice_final_hollow' - this will give you a cross section so that you can see what's going on and reduce render times to almost nothing. 


*References: 
    Based on the following sources by the following:
                https://capolight.wordpress.com/2015/01/14/quadcopter-rotor-duct/
        - Richard.
    
    HOVER AND WIND-TUNNEL TESTING OF SHROUDED ROTORS FOR IMPROVED MICRO AIR VEHICLE DESIGN
        - Jason L. Pereira Doctor of Philosophy, 2008.

    Design by Harlo,
    02/05/2016.

*/


///USER Variables START

//Propellor Diameter
prop_dia_upper = 123; //[30:0.5:500]
//Spacing between Duct and Prop
prop_spacing = 1.5; //[0.1:0.1:10]
dia_total = prop_dia_upper + (prop_spacing*2);
//Lip Radius Percentage
lip_radius_pc = 0.13; //[0.05:0.01:0.30]

//Length Percentage (Lower Z Height)
shroud_lower_length_pc = 0.50; //[0.10:0.01:0.80]
//Duct Angle (degrees)
duct_angle = 10; //[5:0.5:45]
//Resolution of Duct (> = smoother)
duct_resolution = 200;//[30:1:360]


///USER Variables END

//Internal/Calculated Variables
lip_dia = (dia_total * lip_radius_pc)*2;///We double for diameter to keep things "simple".
shroud_lower_length = shroud_lower_length_pc * dia_total;


//Output of Calculated Variables to User
echo ("Shroud Lower Height = ", shroud_lower_length); //does not include the curved diameter
echo ("Shroud Total Height = ", shroud_lower_length + lip_dia/2);
echo ("Lip Diameter = ", lip_dia); //OUTPUT
echo ("Duct_angle = ", duct_angle);


///RENDER


slice_extruded();


/*
//For Later Testing - based on the rough dimensions of an emax motor
translate([0,0,-12]){
    motor(16.5, 28, 6, 5);
}
*/

/*
//FOR TESTING DIMENSIONS

difference(){
    slice_extruded();
    rotate([90,0,0]){
        cylinder(h = 300, d = 8, center = true, $fn = 20);
    }   
}

cylinder (h = 1, d = prop_dia_upper, $fn = 32, center = true);
*/



/*
MAIN BUILD MODULES FOR THE SHROUD/DUCT
*/

module slice_extruded(){
    rotate_extrude(convexity = 10, $fn = duct_resolution){
        translate([dia_total/2,0,0]){
            slice_final();
        }
    }
}


/*
SLICES
    These build the initial housing in tiny slices (in theory..)
*/

module slice_final_hollow(){
difference(){
slice_final();
translate([3.5,-2,0]){
    scale([0.75,0.8,1]){
        slice_final();
    }
}
}
}

module slice_final(){
   
        slice_leading_edge();
        slice_lower_duct();
   
}

module slice_lower_duct(){
    //angles
    remain_angle = 180 - 90 - duct_angle;
    echo("Remain_angle = ", remain_angle);
    
    lower_length = (sin(duct_angle))/(sin(remain_angle)/shroud_lower_length);
    echo("Lower length = ", lower_length);
    
    //sinA/a = sinB/b = sinC/c
    //sin(remain_angle)/shroud_lower_length = sin(15 degress)/?
    //solving for the lower length of the triangle (x length)
    
    difference(){
    //Base cube for being cut from.
    translate([lip_dia/2,-shroud_lower_length/2,0]){
        square([lip_dia,shroud_lower_length], center = true);
    }
    
    //Cutting Triangle
        triangle_points = [[0,0], [0,-shroud_lower_length], [ lower_length, -shroud_lower_length]]; //TEST SO FAR
        polygon(triangle_points);
    }
}

module slice_leading_edge(){
    difference(){    
        translate([lip_dia/2,0,0])
        {
            //upper edge
            circle(d = lip_dia, center = true);
        }
        translate([lip_dia/2,-lip_dia/2,0]){
            square(lip_dia, center = true);
        }
        
    }
    
}

/*
Motor representation -- rough
    - maybe clean up to use as a library module
*/



module motor(body_height, body_dia, shaft_height, shaft_dia){
    total_height = body_height + shaft_height;
    echo("Motor Total Height = ", total_height);
    
    translate([0,0,0]){
        cylinder (h = body_height, d = body_dia, $fn = 32, center = true);
        }
    
    translate([0,0,body_height/2 + shaft_height/2]){
        cylinder (h = shaft_height, d = shaft_dia, center = true, $fn = 20);
    
        }
        
    translate([0,0,0]){
        
    }
    
}




////David Harlock, 02/05/2016.