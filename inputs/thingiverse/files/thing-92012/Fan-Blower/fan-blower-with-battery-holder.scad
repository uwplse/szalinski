add_battery_holder=true;
pipe_diameter=33;
fan_size=40;
battery_depth=16.5;
battery_width=25.3;
battery_height=52;
block_height=battery_depth + 3;
//block_height=16.5;

module fan_blower(){
difference(){
union(){
//create fan block
translate([0,0,block_height/2]) cube([fan_size+5,fan_size+5,block_height], center=true);
//add top shroud
translate([0,0,block_height]) cylinder(r=(fan_size+5)/2,h=25,$fn=80);
}
//create tube mount
translate([0,0,block_height]) cylinder(r=pipe_diameter/2,25,$fn=80);
//create air path
cylinder(r1=pipe_diameter/2,r2=(pipe_diameter-4)/2,29/2,h=block_height,$fn=80);
}
}


//create battery holder
module battery_holder(){
difference(){
union(){
//create main battery block bigger than battery dimensions
translate([0,((fan_size/2)+(battery_height/2)+(pipe_diameter/2)),block_height/2]) cube([battery_width+10,battery_height+35,block_height],center=true);

//add rounded end to it
translate([0,(fan_size/2+battery_height+10)+((battery_width/2+2.5)/2)+(pipe_diameter/2)-2,block_height/2]) cylinder(r=battery_width/2+5,h=battery_depth+3,$fn=80,center=true);
}

//take away battery recess
translate([0,(fan_size+5/2)+battery_height/2+5,block_height/2+1.5]) cube([battery_width,battery_height+10,battery_depth], center=true);

//create some slots for cable_tie
translate([(battery_width-10),(fan_size+5/2)+(battery_height/2)+5,block_height]) cube([2,5,block_height*2],center=true);
translate([(battery_width-(battery_width*2)+10),(fan_size+5/2)+(battery_height/2)+5,block_height]) cube([2,5,block_height*2],center=true);

//create a cable channel
//battery_height+30
translate([0,fan_size/2+20,block_height/2+5]) cube([5,10,10], center=true);

//create pocket for switch
translate([0,fan_size/2+13,battery_depth/2]) cube([16,8,block_height-3], center=true);
//translate([0,fan_size/2+13,battery_depth/2]) cube([23.3,7.6,2], center=true);

}
}

if (add_battery_holder==true)
{
union(){
fan_blower();
battery_holder();
}
} else {
fan_blower();
}