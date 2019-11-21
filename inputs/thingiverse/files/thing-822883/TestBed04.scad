// Testbed

inputs=4; // [1,2,3,4]
outputs=4; // [1,2,3,4]
sensor="Light"; // ["Temperature","Digital Microphone","Light","Motion","Relay"


board_len=33;
board_wid=23;
board_h=1.578;
wifi_len=17.4;
wifi_wid=12.2;
wifi_h=2;
pin_h=5.8+3.3+2.5;
pin_w=.64;
pin_l=.64;
pinstop_h=2.5;
pinstop_w=2.5;
pinstop_l=2.5;
temp_w=1.9;
temp_l=1.9;
temp_h=0.625;
mot_w=2;
mot_l=2;
mot_h=1;
lgt_w=2;
lgt_l=2;
lgt_h=0.65;
mic_w=3.5;
mic_l=2.65;
mic_h=1.08;
rel_w=1;
rel_l=2;
rel_h=1;

translate([0,0,-wifi_h/2]) wifi(wifi_len,wifi_wid,wifi_h){};
// Relay
if(sensor=="Relay"){
    color("black")
        translate([board_len*0.45,0,-rel_h/2])
        cube([rel_w,rel_l,rel_h],center=true);
        translate([board_len*0.45,rel_w+0.4*rel_w,-.1]) cap();
        translate([board_len*0.45,-rel_w-0.4*rel_w,-.1]) cap();
}
// Motion Sensor
if(sensor=="Digital Microphone"){
    color("black")
        translate([board_len*0.45,0,-mic_h/2])
        cube([mic_w,mic_l,mic_h],center=true);
        translate([board_len*0.45,mic_w+0.4*mic_w,-.1]) cap();
        translate([board_len*0.45,-mic_w-0.4*mic_w,-.1]) cap();
}
// Light Sensor
if(sensor=="Light"){
    color("black")
        translate([board_len*0.45,0,-mot_h/2])
        cube([lgt_w,lgt_l,lgt_h],center=true);
        translate([board_len*0.45,lgt_w+0.4*lgt_w,-.1]) cap();
        translate([board_len*0.45,-lgt_w-0.4*lgt_w,-.1]) cap();
}
// Motion Sensor
if(sensor=="Motion"){
    color("black")
        translate([board_len*0.45,0,-mot_h/2])
        cube([mot_w,mot_l,mot_h],center=true);
        translate([board_len*0.45,mot_w+0.4*mot_w,-.1]) cap();
        translate([board_len*0.45,-mot_w-0.4*mot_w,-.1]) cap();
}
// Temperature Sensor
if(sensor=="Temperature"){
    color("black")
        translate([board_len*0.45,0,-temp_h/2])
        cube([temp_w,temp_l,temp_h],center=true);
        translate([board_len*0.45,temp_w+0.4*temp_w,-.1]) cap();
        translate([board_len*0.45,-temp_w-0.4*temp_w,-.1]) cap();
}

// Input Pins
if(inputs<=4) {
    for(i=[1:1:inputs]){
        translate([board_len/2-3-i*2.54,board_wid/2-2,-pinstop_h/2])
        color("yellow")
        cube([pin_w,pin_l,pin_h],center=true);
        color("black")
        translate([board_len/2-3-i*2.54,board_wid/2-2,-pinstop_h/2])
        cube([pinstop_w,pinstop_l,pinstop_h],center=true);
    }
}

// Output Pins
if(outputs<=4) {
    for(i=[1:1:outputs]){
        translate([board_len/2-3-i*2.54,-board_wid/2+2,-pinstop_h/2])
        color("yellow")
        cube([pin_w,pin_l,pin_h],center=true);
        color("black")
        translate([board_len/2-3-i*2.54,-board_wid/2+2,-pinstop_h/2])
        cube([pinstop_w,pinstop_l,pinstop_h],center=true);
    }

// Power,Gnd,UART Pins
    for(i=[1:1:4]){
        translate([-board_len/2+2,-i*2.54+board_wid/4,-pinstop_h/2])
        color("yellow")
        cube([pin_w,pin_l,pin_h],center=true);
        color("black")
        translate([-board_len/2+2,-i*2.54+board_wid/4,-pinstop_h/2])
        cube([pinstop_w,pinstop_l,pinstop_h],center=true);
    }
}

// Sensor Section, quadrant 3

base_chip(board_len,board_wid,board_h){};

    
module wifi(length, width, height) {
color("gray")
    cube(size=[length, width, height], center=true){}
    }
module base_chip(length, width, board_t) {
    difference() {
    translate([0,0,board_t/2]) color("green") cube(size=[length, width, board_t-.1], center=true){};
    translate([board_len/2-2,board_wid/2-2,board_t/2]) color("silver") cylinder(h=board_t+0.1,r=1, center=true,$fn=100) {};
    translate([-board_len/2+2,board_wid/2-2,board_t/2]) color("silver") cylinder(h=board_t+0.1,r=1, center=true,$fn=100) {};
    translate([-board_len/2+2,-board_wid/2+2,board_t/2]) color("silver") cylinder(h=board_t+0.1,r=1, center=true,$fn=100) {};
    translate([board_len/2-2,-board_wid/2+2,board_t/2]) color("silver") cylinder(h=board_t+0.1,r=1, center=true,$fn=100) {};
}
    }
    
module cap(length, width, board_t) {
  color("orange")cube(size=[.3, .2, .2], center=true){};
  translate([.2,0,0])  color("gray") cube(size=[.1, .2, .2], center=true){};
  translate([-.2,0,0]) color("gray") cube(size=[.1, .2, .2], center=true){};
    }
    