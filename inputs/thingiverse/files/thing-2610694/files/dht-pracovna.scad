tol = 0.2;

quality = 200;
wall_thickness = 1.2;
box_inner = 58;
box_height = 20;
hollow = 3; 


translate([0,0, 20])
difference() {
    box();
    connector();
}
    
//  translate([0,0,-box_height/2-wall_thickness]) mcu();

module connector() {
    translate([-(44.8+2*wall_thickness)/2+wall_thickness,-(26.2+2*wall_thickness)/2+wall_thickness,4*wall_thickness])
        translate([0,0,-box_height/2-wall_thickness])
        union() {
            $fn=quality/2;
            rr = 1.5;
            translate([-0.3513,26.2/2,1.45]) rotate([90,0,90])
            minkowski()
            {
              cube([10.2-2*rr,7.3-2*rr,15],true);
              cylinder(r=rr,h=0.001);
            }
    }
}

module mcu() {
    
    //translate([box_inner/2,0,0])
   // translate([wall_thickness/2,wall_thickness/2,0]) 
    cylinder(wall_thickness, box_inner/2+wall_thickness, box_inner/2+wall_thickness, $fn=quality);
    
    translate([-(44.8+2*wall_thickness)/2+wall_thickness,-(26.2+2*wall_thickness)/2+wall_thickness,4*wall_thickness])
    difference() 
    {
        
        translate([-wall_thickness/2,-wall_thickness/2,-wall_thickness-2.3])
        cube([44.8+2*wall_thickness/2, 26.2+2*wall_thickness/2, 8]);
        
        connectorusb();
    }
    
    difference() 
    {

    translate([0,0,box_height/2+wall_thickness])
    color("green",1) lock();
    
    translate([-44.8/2,-26.2/2,4.8])
    connectorusb();
        
    }
        
}


module connectorusb() {
    union() {
        cube([44.8,26.2,18.36]);
        $fn=quality/2;
        rr = 1.5;
        translate([-0.3513,26.2/2,1.45]) rotate([90,0,90])
        minkowski()
        {
          cube([10.2-2*rr,7.3-2*rr,15],true);
          cylinder(r=rr,h=0.001);
        }
    }    
}


module lock() {
    
    //bottom locks
    intersection() 
    {
        radi = box_inner/2-wall_thickness;
        difference() 
        {   translate([0,0,wall_thickness/2])
            color("blue",1) translate([0,0,-box_height/2 + wall_thickness/2]) 
            cylinder(2*wall_thickness, radi - 2*tol, radi - 2*tol, true, $fn=quality);
            
            translate([0,0,wall_thickness/2])
            color("blue",1) translate([0,0,-box_height/2 + wall_thickness/2]) 
            cylinder(2*wall_thickness+tol, radi - wall_thickness - 4*tol, radi - wall_thickness - 2*tol, true, $fn=quality);
           
        }
        
        //cutting boxs
        union() {
            translate([0,0,-box_height/2+wall_thickness/2-tol]) 
            cube([(box_inner+wall_thickness)/3, box_inner+wall_thickness, 2*wall_thickness+tol], true);
            
            rotate([0,0,90])
            translate([0,0,-box_height/2+wall_thickness/2-tol]) 
            cube([(box_inner+wall_thickness)/3, box_inner+wall_thickness, 2*wall_thickness+tol], true);
        }
    }
    
    
    //upper locks -------------------------------
    translate([0,0, wall_thickness + tol])
    intersection() 
    {
        radi = box_inner/2;
        difference() 
        {   translate([0,0,wall_thickness/2+tol])
            color("blue",1) translate([0,0,-box_height/2 + wall_thickness/2]) 
            cylinder(2*wall_thickness, radi - tol, radi - tol, true, $fn=quality);
            
            translate([0,0,wall_thickness/2])
            color("blue",1) translate([0,0,-box_height/2 + wall_thickness/2]) 
            cylinder(2*wall_thickness+tol, radi - 2*wall_thickness - 3*tol, radi - 1.2*wall_thickness - 3*tol, true, $fn=quality);
           
        }
        
        union() {
            
            translate([0,0,-box_height/2+wall_thickness/2-tol]) 
            cube([(box_inner+wall_thickness)/3, box_inner+wall_thickness, 2*wall_thickness+tol], true);
            
            rotate([0,0,90])
            translate([0,0,-box_height/2+wall_thickness/2-tol]) 
            cube([(box_inner+wall_thickness)/3, box_inner+wall_thickness, 2*wall_thickness+tol], true);
        }
    }
    // ------------------------------- 
}



module box() {
    
    intersection() 
    {
        difference() 
        {
            color("blue",1) translate([0,0,-box_height/2 + wall_thickness/2]) 
            cylinder(wall_thickness, box_inner/2, box_inner/2, true, $fn=quality);
            
            color("blue",1) translate([0,0,-box_height/2 + wall_thickness/2]) 
            cylinder(wall_thickness+tol, box_inner/2 - wall_thickness+tol, box_inner/2 - wall_thickness+tol, true, $fn=quality);
           
        }
        
        union() {
            
            translate([0,0,-box_height/2+wall_thickness/2-tol]) 
            cube([(box_inner+wall_thickness)/3, box_inner+wall_thickness*2, wall_thickness], true);
            
            rotate([0,0,90])
            translate([0,0,-box_height/2+wall_thickness/2-tol]) 
            cube([(box_inner+wall_thickness)/3, box_inner+wall_thickness*2, wall_thickness], true);
        }
    }
    difference() {
        union() {
            difference() {
                difference() {
                    translate([0,0,box_height/2]) 
                    resize([0,0,10]) 
                    sphere(box_inner/2+wall_thickness, $fn=quality);
                    
                    translate([0,0,box_height/2-wall_thickness]) 
                    resize([0,0,10]) 
                    sphere(box_inner/2, $fn=quality);
                }
        
                translate([0,0,box_height/2-(wall_thickness+2*tol)]) 
                cylinder(3, box_inner/2+wall_thickness+tol, box_inner/2+wall_thickness+tol, true, $fn=quality);
            }
        
            
            difference() {
                cylinder(box_height, box_inner/2+wall_thickness, box_inner/2+wall_thickness, true, $fn=quality);
                cylinder(box_height+tol, box_inner/2, box_inner/2, true, $fn=quality);
            }
        
        }
        trny();
    }
}

module trny() {
    
    //center hollow
    trn();
    
    step = hollow*6+hollow*2;
    rad = box_inner / 3.5;
    for(a = [0:step:360]) {
        color("red", 1) translate([sin(a)*rad, cos(a)*rad ,0]) trn();
    }
    
    rad2 = box_inner / 6.5;
    step2 = hollow*12+hollow*1.4;
    for(a = [0:step2:360]) {
        color("red", 1) translate([sin(a)*rad2, cos(a)*rad2,0]) trn();
    }
}

module trn() {
    cylinder(box_height*2, hollow/2, hollow/2, true, $fn=quality);
}