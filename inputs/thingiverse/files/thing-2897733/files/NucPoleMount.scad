//adjust this value as needed for your monitor mount
pole_radius= 35.2;


/////////////////////////////////////////////////////
pole_dia=pole_radius/2;
thick=4;
winglength=thick*5;

height=30;
gap=2;
screw_hole_dia=2.5;
 
        // Calculate the nut hole size
        // convert the engish nut size to metric
        // and divide by 2
        EnglishNut=3/8;
        b=(EnglishNut/0.039370079)/2;
            // if you take a hexagram and divide it into 12 right triangles
        // by bisecting the center of the hexagram, the angle in each triangle closest to the
        // center of the hexagram is 30 degrees
        // the value b above divided by the cosine of 30 = the hypotenuse
        // use this as the radius value in the cylinder function and set $fn=6
        // and this will get you a hole for a nut
        nut_dia=b/cos(30);
        
difference()
{
    union()
    {
        // create a cylinder with a hole
        difference()
        {
            union()
            {
    
                cylinder(h=height,r1=pole_dia+thick,r2=pole_dia+thick,center=false,$fn=180);
                translate([-1*(thick+gap/2),pole_dia])
                    color ("blue")
                    cube ([2*thick+gap,winglength,height]);
            }
    
            cylinder(h=height+1,r1=pole_dia,r2=pole_dia,center=false,$fn=180);
    
            // create a gap for adjustments
    

            translate([(gap/-2),pole_dia-1])
            color ("red")
            cube ([gap,winglength+2,height+1]);
    
            // screw for a clamp
           
        }


        // support bar
        support_bar(pole_dia,thick,height,nut_dia,screw_hole_dia);
        
    }
    
    // clamp holes
    
    
    translate([-1*(thick+gap/2),pole_dia+(winglength/3)*2,height/2])
        rotate([0,90,0])
            cylinder(h=2*thick+gap,r1=screw_hole_dia,r2=screw_hole_dia,center=false,$fn=180) ; 
    

    translate([(thick/3)*2+gap/2,pole_dia+(winglength/3)*2,height/2])
        rotate([0,90,0])
            cylinder(h=2*thick+gap,r1=nut_dia,r2=nut_dia,center=false,$fn=6) ; 
    
    
    
}  
    


    module support_bar(pole_dia,thick,height,nut_dia,screw_hole_dia)
    {
        // vesa mounting holes
    // https://www.toptvmounts.com/pages/which-mounts-will-fit-my-tv
    // the outer holes are 3.94" or 100 mm apart 
    // inner holes are 2.95 or 75 mm apart
    
           support_len=117;
    
    distance_between_holes=(100-75)/2;
        //nut_dia=screw_hole_dia+1;
        
       
            
        
         // calculate where vertically to put the 75mm spaced holes
            z1=(height-distance_between_holes)/2 ;
            // calculate distance from center of bar to put 100mm spaced holes
            x1=+(support_len/2)-(support_len-75)/2;   
        
        
        
        
        difference()
        {
            translate([support_len/-2,pole_dia*-1-thick,0]) 
            cube([support_len,thick,height]);

      
            
       
            // calculate where vertically to put the 100 spaced holes
            z=(height-distance_between_holes)/2 +distance_between_holes;
            // calculate distance from center of bar to put 100mm spaced holes
            x=+(support_len/2)-(support_len-100)/2;   
        //hole
         color("green")
            translate([x,-1*(pole_dia-1),z])
            rotate([90,0,0])
            cylinder(h=thick*2,r1=screw_hole_dia,r2=screw_hole_dia,center=false,$fn=90);
            //nut
         color("red")
            translate([x,-1*(pole_dia),z])
            rotate([90,0,0])
            cylinder(h=thick/3,r1=nut_dia,r2=nut_dia,center=false,$fn=6);
            
            
        //hole 
        color("green")
            translate([x*-1,-1*(pole_dia-1),z])
            rotate([90,0,0])
            cylinder(h=thick*2,r1=screw_hole_dia,r2=screw_hole_dia,center=false,$fn=90);
         //nut
        color("red")
            translate([x*-1,-1*(pole_dia),z])
            rotate([90,0,0])
            cylinder(h=thick/3,r1=nut_dia,r2=nut_dia,center=false,$fn=6);
            
        color("green")
            translate([x1,-1*(pole_dia-1),z1])
            rotate([90,0,0])
            cylinder(h=thick*2,r1=screw_hole_dia,r2=screw_hole_dia,center=false,$fn=90);
            //nut
         color("red")
            translate([x1,-1*(pole_dia),z1])
            rotate([90,0,0])
            cylinder(h=thick/3,r1=nut_dia,r2=nut_dia,center=false,$fn=6);
          
            
         
        color("green")
            translate([x1*-1,-1*(pole_dia-1),z1])
            rotate([90,0,0])
            cylinder(h=thick*2,r1=screw_hole_dia,r2=screw_hole_dia,center=false,$fn=90);
         //nut
       color("red")
            translate([x1*-1,-1*(pole_dia),z1])
            rotate([90,0,0])
            cylinder(h=thick/3,r1=nut_dia,r2=nut_dia,center=false,$fn=6);
    
    
        // clamp screw
        
    
            
        }    
            
          
        
        
        // extra supports
        translate([-1*(pole_dia+thick),pole_dia*-1,0])
        cube([thick,pole_dia,height]);

        translate([(pole_dia),pole_dia*-1,0])
        cube([thick,pole_dia,height]);
     
        
     
        
    }
    