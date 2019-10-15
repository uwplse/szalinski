use <fillets_and_rounds.scad>

//How long do you want the attachment to be?
base_length=84; //[80:150]

//How wide do you want the attachment to be?
base_width=40; // [40:150]

//How high do you want the attachment to be?
base_height=40; //[30:150]

//How long do you want your slots to be?
slot_length = 66; //[66:130]

//How wide do you want your slots to be?
slot_width = 5; //[3:20]

//How deep do you want your slots to be?
slot_depth = 27; //[20:70]

//ignore variable values
slot1Lpos = base_length - 4;
slot1Wpos = 0.5*base_width+9;
slot1Hpos = base_height-slot_depth+1;

slot2Lpos = base_length - 4;
slot2Wpos = 0.5*base_width-14;
slot2Hpos = base_height-slot_depth+1;


module straightslot(){
difference(){
cube([base_length,base_width,base_height]);
translate([slot1Lpos,slot1Wpos,slot1Hpos])rotate([0,0,90])cube([slot_width,slot_length,slot_depth]);
translate([slot2Lpos,slot2Wpos,slot2Hpos])rotate([0,0,90])cube([slot_width,slot_length,slot_depth]);

translate([slot1Lpos-28,base_width+9,25.5])rotate([90,0,0]) cylinder(base_width+10,5,5,$fn=64);

translate([40,base_width/2,-1])cylinder(5,3.5,3.5,$fn=64);    
}
}

straightslot();
/*add_rounds(R=1)
{
    sample_object();
    straightslot();
}
*/