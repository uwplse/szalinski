//CUSTOMIZER VARIABLES

//Printer nozzle diameter (choose 0.3 if unknown)
nozzle = 0.3;

//Taper height
tap_height=35;

//Bottom inner diameter
bot_in_dia = 23;

//Top inner diameter
top_in_dia = 21;

// Bottom outer diameter
bot_out_dia = 32.5;

//Top outer diameter
top_out_dia = 29;

//Do you want a flange?
is_flange = 1; //[1:Yes, 0:No]

//Flange diameter
flange_dia = 37;

//Flange height
flange_height = 5;

// Quality
quality = 360;


difference(){
	union() {
		cylinder(d=bot_out_dia, d2=top_out_dia, h=tap_height,$fn=quality);
        if (is_flange==1){
            translate([0,0,-flange_height]) cylinder(d=flange_dia,h=flange_height, $fn=quality);
        }
	}
    if (is_flange==1){
	translate([0,0,-flange_height]) cylinder(d=bot_in_dia+nozzle, d2=top_in_dia+nozzle, h=tap_height+flange_height+0.01, $fn=quality);
    } else {
	translate([0,0,-0.01]) cylinder(d=bot_in_dia+nozzle, d2=top_in_dia+nozzle, h=tap_height+0.01, $fn=quality);
    }
}
