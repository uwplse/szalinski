/*[Main Settings]*/

//The number of pins you need for your connector
num_pins =3;
//extra material on eith end of the connector in addition to the usual material between each pin
extra_ends=0.4;

/*[fine tuning]*/
//overall thickness of the connectors
thickness =2.4;
//Total height of the connectors
height=8.5;
//side length of the hole for the male pin
pin_width=1.15;
//thickness of the slot for the female connector
slot_thickness=0.6;
//height of the slot for the female connector
slot_height=6;
//width of the slot for the female connector
slot_width=2.3;
//distance between each pin. Note this is only designed for 2.54mm (0.1 inch) spaced pins so different sizes will probably not work
offset=2.54;
//increasing this increases the depth of the champfer where the male pins are pushed in
champfer=2;



w=offset*num_pins+extra_ends*2;


difference(){
    translate([w/2-offset/2-extra_ends,0,0])cube([w,thickness,height],true);//the main body
    for(i=[0:num_pins-1])//loops to insert each hole and geometry for each pin
    {
        translate([offset*i,0,0])hole();
	
    }
}




module hole()//does all the internal geometry for one pin
{
    union()
    {
        cube([pin_width,pin_width,height], true);//pin hole
        translate([0,0,-(height-slot_height)/2])	cube([slot_width,slot_thickness,    slot_height], true);//slot for female connector
        translate ([0,0,(height/2)-champfer])rotate([0,0,45])cylinder(h=champfer, r1=0, r2=thickness*0.55, $fn=4);//champfer 
	}
}

