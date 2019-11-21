pole_spacing=3; // Increase in size of pole hole to allow for mis-measurement
pole_width=25.4 + pole_spacing; // 1 inch in mm 
knob_width_ratio=3; // Number to multiply pole hole width by for knob width;
knob_width=knob_width_ratio*pole_width; //knob width

difference(){
    union(){
        difference()
        {
            // Round Top
            sphere(knob_width/2, $fa=5, $fs=0.1);
            translate([0,0,-(knob_width/2 - knob_width/10 - .1)])
            {
                cube(knob_width,center=true);    
            }
        }
        
        
        difference(){
            translate([0,0,knob_width/10])
            {
                minkowski()
                {
                    cylinder(h=knob_width/10,d=knob_width*.8);
            
                    sphere(knob_width*.09, $fa=5, $fs=0.1);
                }
            }
            translate([0,0,knob_width/2+knob_width/10])
            {
                cube(knob_width,center=true);   
            }
        }
        translate([0,0,knob_width/6-knob_width/7])
        {
            cylinder(d=pole_width+6,h=3*knob_width/16,$fa=5, $fs=0.1,center=true);
        }            
    }
    
    translate([0,0,knob_width/6-knob_width/7])
    {
        cylinder(d=pole_width,h=3*knob_width/16,$fa=5, $fs=0.1,center=true);
    }    
}