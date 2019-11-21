//Enter Phone Dimensions in mm here;


phone_length=158.4;
phone_width=78.1;
phone_height=7.5;


//look up your aspect ratio and diagonal length.

//use this site for a calculator for help:

//   http://screen-size.info/

screen_length=127;
screen_width=59;
diagonal=140;
home_button_radius=5;
head_phone_dia=2.5;

//text customization.
txtsize=20;
txt="MJ #29";
fonttype="Stencil";

pl=phone_length;
pw=phone_width;
ph=phone_height;
sl=screen_length;
sw=screen_width;
sd=diagonal;
hb=home_button_radius;
hf=head_phone_dia;
$fn=100;
module case_shape(){
union()hull(){
translate([pw/2,pl/2,0])rotate([90,0,0])cylinder(pl,ph*1.1,ph*1.1);
translate([-pw/2,pl/2,0])rotate([90,0,0])cylinder(pl,ph*1.1,ph*1.1);
translate([-pw/2,pl/2,0])rotate([0,90,0])cylinder(pw,ph*1.1,ph*1.1);
translate([-pw/2,-pl/2,0])rotate([0,90,0])cylinder(pw,ph*1.1,ph*1.1);}
}

module phone_in(){
    difference(){
        case_shape();
        cube([pw,pl,ph,],center=true);
    }
}
module screen_see(){
difference(){
    phone_in();
    translate([0,0,ph])cube([sw*1.1,sl*1.1,ph],center=true);}
    }
module charging_port(){
difference(){
    screen_see();
    intersection(){
    translate([0,-pl*.25,ph*.35])rotate([90,0,0])cylinder(pl/2,ph*1.1,ph*1.1);
    translate([0,-pl*.25,0])cube([pw,pl,ph],center=true);
    }}  
  
}
module home_button(){
difference(){    
    charging_port();
    translate([0,-(sl/2+hb*2),ph/2])cylinder(ph,hb*2,hb*2);
    hull()union(){
    translate([-pw/3,-(pl/2-hf*1.1),0])rotate([90,0,0])cylinder(pl*.3,hf,hf);
        translate([-pw/2.5,-(pl/2-hf*1.1),0])rotate([90,0,0])cylinder(pl*.3,hf,hf);}}}
module camera(){
difference(){
    home_button();
    hull()union(){
        translate([pw/4-pw*.1,pl*.45,-ph*1.1])cylinder(ph,hb,hb);
        translate([pw/4+pw*.1,pl*.45,-ph*1.1])cylinder(ph,hb,hb);}
        hull()union(){
        translate([pw*0.1,pl*.45,ph/2])cylinder(ph,hb,hb);
        translate([-pw*.1,pl*.45,ph/2])cylinder(ph,hb,hb);}}
    }
module buttons(){
    difference(){
    camera();
    hull()union(){
    translate([-pw/1.5,pl/2.35,0])rotate([0,90,0])cylinder(pl,ph*.5,ph*.5);
    translate([-pw/1.5,pl*.05,0])rotate([0,90,0])cylinder(pl,ph*.5,ph*.5);
    }
    hull()union(){
    translate([-pw/3,pl,0])rotate([90,0,0])cylinder(pl,ph*.5,ph*.5);
    translate([pw/3,pl,0])rotate([90,0,0])cylinder(pl,ph*.5,ph*.5);
    }}}
module text_stuff(){
    difference(){
    buttons();
    rotate([0,180,90])translate([0,-txtsize/2,ph*.5])linear_extrude(height=(ph))text(txt,font=fonttype,size=txtsize,halign="center");
}}
module Upper_Cut(){
difference(){    
    text_stuff();
    translate([0,-pl/1.5,0])cube(pw*1.5,pl,ph*1.1,center=true);}}
module female_end(){
difference(){
    Upper_Cut();
    
    translate([pw/1.85,-pl/4,0])rotate([90,90,0])cube([ph,ph*.4,pl*.2],center=true);
    translate([-pw/1.85,-pl/4,0])rotate([90,90,0])cube([ph,ph*.4,pl*.2],center=true);
    translate([-pw/2-ph,-pl/6-(ph*.4)/2,0])rotate([270,0,0])cube([ph,ph,ph],center=true);
    translate([pw/2+ph,-pl/6-(ph*.4)/2,0])rotate([270,0,0])cube([ph,ph,ph],center=true);}}
    
translate([50,0,0])female_end();
module Lower_Cut(){
intersection(){
    text_stuff();
    translate([0,-pl/1.5,0])cube(pw*1.5,pl,ph*1.1,center=true);}}
module Male_end(){
    difference(){
    union(){
    Lower_Cut();    
    translate([pw/1.85+ph*.2,-pl/4,0])rotate([90,90,0])cube([ph,ph*.2,pl*.2],center=true);
    translate([-pw/1.85-ph*.2,-pl/4,0])rotate([90,90,0])cube([ph,ph*.2,pl*.2],center=true);
    translate([-pw/2-ph,-pl/6-(ph*.4)/2,0])rotate([270,0,0])cube([ph,ph,ph],center=true);
    translate([pw/2+ph,-pl/6-(ph*.4)/2,0])rotate([270,0,0])cube([ph,ph,ph],center=true);}
    translate([-pw/2-ph*1.15,-pl/6-(ph*.4)/10,0])rotate([270,0,-15])cube([ph,ph*2,ph*1.4],center=true);
    translate([pw/2+ph*1.15,-pl/6-(ph*.4)/10,0])rotate([270,0,15])cube([ph,ph*2,ph*1.4],center=true);}}
module clean_up(){
    intersection(){
    Male_end();
    cube([pw+2*ph*1.1,pl+2*ph*1.1,ph*4],center=true);}
}
translate([-50,0,0])clean_up();    
    
    