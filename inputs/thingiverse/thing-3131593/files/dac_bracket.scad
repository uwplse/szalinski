//Parametric Phone DAC Bracket

//by replayreb
//GPL License

//https://www.thingiverse.com/thing:3131593

//(25.4 mm = 1 inch)
overall_length = 25.4;
wall_thickness = 2;

phone_width = 81.5;
phone_thickness = 11.5;
phone_bezel_width = 3;

dac_width= 59.5;
dac_thickness = 12.8;
dac_bezel_width = 3;


//Make Phone bracket
difference(){
    cube([phone_width+wall_thickness*2,overall_length,phone_thickness+wall_thickness*2], center = true);
    
    cube([phone_width,overall_length,phone_thickness], center = true);

    translate([0, 0, wall_thickness/2])
    cube([phone_width-phone_bezel_width*2,overall_length,phone_thickness+wall_thickness], center = true);
}

//Make DAC bracket
translate([0, 0, -(phone_thickness/2+dac_thickness/2)-wall_thickness]){
    difference(){
        cube([dac_width+wall_thickness*2,overall_length,dac_thickness+wall_thickness*2], center = true);

        cube([dac_width,overall_length,dac_thickness], center = true);

    translate([0, 0, -wall_thickness/2])
    cube([dac_width-dac_bezel_width*2,overall_length,dac_thickness+wall_thickness], center = true);
    }
}    