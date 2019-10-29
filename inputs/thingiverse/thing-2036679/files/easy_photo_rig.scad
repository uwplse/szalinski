$fn=50;



//CUSTOMIZER VARIABLES
/* [Easy Photo Rig] */
 
//the thickness of your phone
phone_depth = 12; 

//the width of your phone
phone_width = 78; 

//the width of your ruler 
ruler_width = 52; 

//the thickness of your ruler
ruler_thickness = 3;  


//the width of the bracket
bracket_width = 12;  

//the thickness of the walls and radius of the corners
corner_radius =3; 
  
  
//use this to angle the phone down slightly. values above 10 are not recommended
tilt_angle = 0;

//CUSTOMIZER VARIABLES END




module ruler_holder()
{
    //offset the ruler holder from the phone holder
    rotate([0,0,tilt_angle])
    translate([-(phone_depth/2+corner_radius)-(ruler_thickness/2),phone_width/2,0])
difference()
{
hull()
{
    translate([-ruler_thickness/2,ruler_width/2,0])
        cylinder(h=bracket_width,r1=corner_radius,r2=corner_radius);
     translate([ruler_thickness/2,ruler_width/2,0])
        cylinder(h=bracket_width,r1=corner_radius,r2=corner_radius);  
   
   
       translate([-ruler_thickness/2,-ruler_width/2,0])
        cylinder(h=bracket_width,r1=corner_radius,r2=corner_radius);
     translate([ruler_thickness/2,-ruler_width/2,0])
        cylinder(h=bracket_width,r1=corner_radius,r2=corner_radius) ;
   
    
};

    cube([ruler_thickness/2*2,ruler_width/2*2,bracket_width*2+2],true);

}
}



module phone_holder()
{
difference()
{
hull()
{
    translate([-phone_depth/2,phone_width/2,0])
        cylinder(h=bracket_width,r1=corner_radius,r2=corner_radius);
     translate([phone_depth/2,phone_width/2,0])
        cylinder(h=bracket_width,r1=corner_radius,r2=corner_radius);  
   
   
       translate([-phone_depth/2,-phone_width/2,0])
        cylinder(h=bracket_width,r1=corner_radius,r2=corner_radius);
     translate([phone_depth/2,-phone_width/2,0])
        cylinder(h=bracket_width,r1=corner_radius,r2=corner_radius) ;
   
    
};

    cube([phone_depth/2*2,phone_width/2*2,bracket_width*2+2],true);

translate([bracket_width-2,0,0])
    cube([phone_depth/2*2,phone_width/2,bracket_width*2+2],true);
}
}



ruler_holder();
phone_holder();



