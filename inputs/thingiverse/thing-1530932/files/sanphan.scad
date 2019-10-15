//smart phone thick in mm
smartphone_thick = 4; // [1:20]


//laptop screen thick in mm
laptop_screen_thick = 5; // [10:25]

// thing border thick in mm
my_thing_thick = 3; // [2:5]

// thing length
my_thing_length = 12; //[10:20]

//upper back high
upper_back_high = 10; // [10:20]

//upper front high
upper_front_high = 5; // [5:10]

//lower back high
lower_back_high = 20; // [10:20]

//lower front high
lower_front_high = 10; // [10:20]

upperPart();
lowerPart();

module upperPart(){    
    cube([smartphone_thick + my_thing_thick * 2 , my_thing_length, my_thing_thick/2]);
    translate([0, 0, my_thing_thick/2]) cube([my_thing_thick, my_thing_length, upper_back_high]);
    translate([my_thing_thick + smartphone_thick, 0, my_thing_thick/2]) cube([my_thing_thick, my_thing_length, upper_front_high]);
    
}

module lowerPart(){
    translate([0,0, -my_thing_thick/2]) cube([laptop_screen_thick + my_thing_thick * 2 , my_thing_length, my_thing_thick/2]);
    translate([0, 0, - lower_back_high - my_thing_thick/2]) cube([my_thing_thick, my_thing_length, lower_back_high]);
    translate([my_thing_thick + laptop_screen_thick, 0, - lower_front_high - my_thing_thick/2]) cube([my_thing_thick, my_thing_length, lower_front_high]);
    
}