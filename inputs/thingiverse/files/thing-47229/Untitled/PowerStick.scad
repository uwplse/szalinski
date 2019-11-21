//How long is your motor (mm)?
depth_motor = 40;
//What is the diameter of your motor(mm)?
dia_motor = 30;

//What is the width of your switch(mm)?
width_button = 12.5;
//What is the length of your switch(mm)?
length_button = 20;

//What is the width of your battery holder(mm)?
width_battery = 33;
//What is the length of your battery holder(mm)?
length_battery = 33;
//What is the height of your battery holder (how long is it)(mm)?
depth_battery = 60;


overall_length = depth_battery+depth_motor+width_button+10;

difference(){

hull(){
rotate([0,90,0])translate([-15,-15,0])cylinder(r = 5, h = overall_length, center = false);
rotate([0,90,0])translate([+15,-15,0])cylinder(r = 5, h = overall_length, center = false);
rotate([0,90,0])translate([-15,+15,0])cylinder(r = 5, h = overall_length, center = false);
rotate([0,90,0])translate([+15,+15,0])cylinder(r = 5, h = overall_length, center = false);
}

//minus
translate([-1,-width_battery/2,-length_battery/2])cube([depth_battery+width_button+6,width_battery,length_battery]);

rotate([0,90,0])translate([0,0,overall_length-depth_motor+1])cylinder(r = dia_motor/2, h = depth_motor, center = false);

translate([depth_battery+5,-width_battery/8,-length_battery/2])cube([depth_battery+5,width_battery/4,length_battery]);

translate([depth_battery+5,-length_button/2,1])cube([width_button,length_button,20]);

translate([2,-17.5,-17.5])cube([3,35,40]);

translate([overall_length-6,-25,-5])cube([3,50,10]);
translate([overall_length-16,-25,-5])cube([3,50,10]);
translate([overall_length-26,-25,-5])cube([3,50,10]);
translate([overall_length-36,-25,-5])cube([3,50,10]);

translate([overall_length-6,-5,-25])cube([3,10,50]);
translate([overall_length-16,-5,-25])cube([3,10,50]);
translate([overall_length-26,-5,-25])cube([3,10,50]);
translate([overall_length-36,-5,-25])cube([3,10,50]);

rotate([0,90,0])translate([15,15,overall_length-9])cylinder(r = 2.5, h = 10, center = false);
rotate([0,90,0])translate([15,-15,overall_length-9])cylinder(r = 2.5, h = 10, center = false);
rotate([0,90,0])translate([-15,15,overall_length-9])cylinder(r = 2.5, h = 10, center = false);
rotate([0,90,0])translate([-15,-15,overall_length-9])cylinder(r = 2.5, h = 10, center = false);
}