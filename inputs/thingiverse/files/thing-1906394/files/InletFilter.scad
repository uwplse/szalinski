// Inlet Filter for half inch irrigation hose
// for use as a filter to keep leaves out of pool cover siphon hose. 



//Shaft Length
insertionDepth = 25;

//Shaft Outer Diameter
insert_O_D = 15;

//Shaft Inner Diameter
insert_I_D = 12;

//Rib Size
ribRadius = .75;




difference(){
    cylinder(insertionDepth, d= insert_O_D);
    cylinder(insertionDepth, d=insert_I_D);
}
rotate_extrude(convexity = 10, degrees = 360,$fs = .01)
translate([insert_O_D/2, insertionDepth/3, 0])
circle(r = ribRadius,$fs=.01);
rotate_extrude(convexity = 10, degrees = 360,$fs = .01)
translate([insert_O_D/2, insertionDepth/3*2, 0])
circle(r = ribRadius,$fs=.01);



translate([0,0,(insertionDepth+(insert_O_D)-(insert_O_D-(sqrt(pow(insert_O_D,2) - pow(insert_O_D/2,2)))))]){
    difference(){
        sphere(insert_O_D);
        sphere(insert_O_D-((insert_O_D-insert_I_D)/2));
        translate([0,0,-insert_O_D]){
            cylinder(insert_O_D, d=insert_I_D,true);  
        }      
        cylinder(insert_O_D*2,d= 4,center=true, $fs=.1);
        
        for (a=[0:360/6:360]){
            rotate([30,0,a]){
                cylinder(insert_O_D,d= 4,center=false, $fs=.1);
            }
        }
        
        for (a=[0:360/10:360]){
            rotate([60,0,a]){
                cylinder(insert_O_D*2,d= 4,center=true, $fs=.1);
            }
        }
        
        
        for (a=[0:360/12:360]){
            rotate([90,0,a]){
                cylinder(insert_O_D*2,d= 4,center=true, $fs=.1);
            }
        }
                
    }
    
}

