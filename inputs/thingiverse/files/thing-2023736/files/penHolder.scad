

// Parameters..................................
pen_diameter = 11.7;
nb_pen = 10;
height = 180; //Height of the pen 
height2 = 25; // Height of the print you want
angle = 30;     



//..................................................

offset = pen_diameter*0.1;
tot_radius = ((pen_diameter )*nb_pen)/(2*PI);

t = sqrt(pow((sin(angle)*height/2),2)+pow(tot_radius,2));

difference(){
    union(){

            cylinder(r=t, h = 5, $fn=50);

            pen_holders();
    }
    translate([0,0,height2]) cylinder(r = 10*tot_radius, h = height);
}





module pen_holders(empty = true, stylo = false){
    
    difference(){
        translate([0,0,(height*cos(angle))/2-5]){
            for(e=[0:360.0/nb_pen:360-360.0/nb_pen]){
                rotate([0,0,e]){
                    translate([tot_radius,0,0]){
                        rotate([angle,0,0]){
                            
                            if(empty){
                                difference(){
                                cylinder(r = pen_diameter/2+2*offset, h = height, center = true);
                                translate([0,0,5]) cylinder(r = pen_diameter/2, h = height-5, center = true);
                                }
                            }else{
                                if(stylo){
                                    color([0.5,0,0.5]) cylinder(r = pen_diameter/2-1, h = height, center = true);
                                    }
                                else{
                                    cylinder(r = pen_diameter/2+2*offset, h = height, center = true);
                                }
                            }
                        }
                    }
                }
            }
        }
        translate([0,0,-20]) cube([10*tot_radius,10*tot_radius,40], center = true);
    }
}

