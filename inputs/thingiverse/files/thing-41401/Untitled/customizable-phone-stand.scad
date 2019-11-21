//Customizable Phone Stand
//Height of the phone //default 125.45
phone_height = 125.45;
//Width of the phone //default 66.35
phone_width = 66.35; 
//Thickness of the phone //default 8.7
phone_thickness = 8.7;  

//Height of the stand //default 80
stand_height = 80; //[30:120]
//Width of the stand //default 80
stand_width = 80; //[60:200]
//Thickness of the stand //default 50
stand_thickness = 50; //[35:100]

//Angle at which the phone stands //default 350
phone_stand_angle = 350; //[335:360]
//The height from the bottom of the stand, to where the phone begins //default 10
phone_stand_min_height = 10; //[2:60]
//From the front of the stand to where the phone starts //default 5
phone_stand_to_back = 5; //[2 : 20]
//to hold back the phone //default 0.9
holdback = 0.9;
//not used at this time
holdback_multiplier = 10; 

//Make!
phone_stand();

module phone_stand(){
  difference(){
    cube([stand_width,stand_thickness,stand_height]);
    //The Phone
    translate([stand_width/2 - phone_width/2,phone_stand_to_back,phone_stand_min_height]) 
    rotate(phone_stand_angle,[1,0,0]) 
    cube([phone_width,phone_thickness,phone_height]);
    //The Holdback
    translate([stand_width/2 - phone_width*holdback/2,phone_stand_to_back+(phone_thickness/2)-(phone_thickness*5*holdback),phone_stand_min_height + phone_height - (phone_height*holdback)]) 
    rotate(phone_stand_angle,[1,0,0]) 
    cube([phone_width*holdback,phone_thickness*5*holdback,phone_height*holdback]);
  }
}