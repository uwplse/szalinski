// More means moar quality
$fn=200;

// Width of the thick part in mm
diameter_1_text_box = 15; 

// Width of the thinner part in mm
diameter_2_text_box = 12.6;

// Adapter length in mm
adapter_length_text_box = 21; 

// Internal hole diameter in mm
internal_diameter_text_box = 7; 

// Button Width
button_width_numerical_slider = 16.3; // [8:20]

// Button Thickness
button_thickness_numerical_slider = 2; // [1:10]

// Button Taper Percentage %
button_taper_numberical_slider = 6; //[-100:100]

omgwtf = button_width_numerical_slider*((100-button_taper_numberical_slider)/100);

// Easy Valve Adapter Diameter
diameterTweak_text_box = 8.18;

if(diameter_1_text_box<internal_diameter_text_box+1){
    diameter_1_text_box=internal_diameter_text_box+1;
}
wtfxone = diameter_1_text_box;
wtfxtwo = diameter_2_text_box;



module adapter (){
    cylinder(6,5,5);
    translate([0,0,6]){
        cylinder(2,diameterTweak_text_box,diameterTweak_text_box);
        translate([0,0,2]){
            cylinder(.5,diameterTweak_text_box,7.5);
            translate([0,0,.5]){
                cylinder(4.76,7.5,7.5);
                translate([0,0,4.76]){
                    cylinder(1,7.5,diameterTweak_text_box);
                    translate([0,0,1]){
                        cylinder(16.61,diameterTweak_text_box,diameterTweak_text_box);
                        translate([0,0,16.61]){
                            
                            if (omgwtf < 8.05){
                                cylinder(button_thickness_numerical_slider,button_width_numerical_slider,8.05);
                            }
                            else {
                                cylinder(button_thickness_numerical_slider,button_width_numerical_slider,omgwtf);
                                }
                            
                            
                            
                            
                            translate([0,0,button_thickness_numerical_slider]){
                                
                                
                                if (wtfxone < internal_diameter_text_box+1 && internal_diameter_text_box <= 7) {
                                    
                                    if(wtfxtwo <  internal_diameter_text_box+1){
                                        cylinder(adapter_length_text_box,(internal_diameter_text_box/2)+1,(internal_diameter_text_box/2)+1);
                                        }
                                    else cylinder(adapter_length_text_box,wtfxone/2,(internal_diameter_text_box/2)+1);
                                    
                                    
                                    }


                                else if (wtfxtwo < internal_diameter_text_box+1 && internal_diameter_text_box <= 7) {
                                    
                                    
                                              if(wtfxone <  internal_diameter_text_box+1){
                                        cylinder(adapter_length_text_box,(internal_diameter_text_box/2)+1,(internal_diameter_text_box/2)+1);
                                        }
                                    else cylinder(adapter_length_text_box,wtfxone/2,(internal_diameter_text_box/2)+1);
                                    
                                    
                                    
                                    
                                    }
                                    else if (internal_diameter_text_box > 7 && (wtfxone || wtfxteo) > internal_diameter_text_box){
                                        cylinder(adapter_length_text_box,internal_diameter_text_box/2,internal_diameter_text_box/2);
                                        }
                                    else {
                                        if(wtfxone>wtfxtwo){
                                        cylinder(adapter_length_text_box,wtfxone/2,wtfxtwo/2);
                                        }
                                        else cylinder(adapter_length_text_box,wtfxone/2,wtfxone/2);
                                        
                                        }
                                
                               
                            }
                        }
                    }
                }
            }
        }
    }
}


difference(){
    adapter();
    translate([0,0,-1]){
        if(internal_diameter_text_box >= 7 ){
            cylinder(1000,4,4);
        }
        else {cylinder(1000,internal_diameter_text_box/2,internal_diameter_text_box/2);}
    
    }
}
