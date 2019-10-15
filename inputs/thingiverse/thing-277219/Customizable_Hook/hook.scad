Hook_width=120;

Hook_length=290;
Hook_size=90;

module example005()
{



difference(){


union(){
cube([Hook_width,Hook_length,10],false);

translate([Hook_width/2,0,0])
cylinder(10,Hook_width/2,Hook_width/2,false);
}



translate([Hook_width/2,0,0])
cylinder(50,Hook_width/5,Hook_width/5,true);

}

translate([0,Hook_length-10,10])
cube([Hook_width,10,50],false);

translate([0,Hook_length-Hook_size,50])
cube([Hook_width,Hook_size,10],false);

}


example005();

