//Height of plug follower, if base is generated this height includes the base
plug_follower_height = 75;
//Diameter of plug follower
plug_follower_diameter = 14;
//Generate base plate, 0 = no base, 1 = base
generate_base = 1;
//Height of Base, 2mm default
base_height = 2;
//Type of follower 1 = center notch, 2 = Half moon, 3 = Hollow
plug_follower_type = 1;
//Determines width of notch for type 1 followers and width of keyway for type 3 followers
notch_width = 3;
//Determines depth of reccess for all types
notch_depth = 15;

module plug_notch(){
    translate([0,0,plug_follower_height+1-notch_depth+(notch_depth/2)]) cube([plug_follower_diameter+2,notch_width,notch_depth+1],center=true);
}

module plug_moon(){
    translate([0,(plug_follower_diameter/2)/2,plug_follower_height+1-notch_depth+(notch_depth/2)]) cube([plug_follower_diameter+2,plug_follower_diameter/2,notch_depth+1],center=true);
}

module plug_hollow(){
    translate([0,0,plug_follower_height-notch_depth]) cylinder(r=(plug_follower_diameter-1)/2,h=notch_depth+1,$fn=40);
    
    translate([(plug_follower_diameter-1)/2,0,(plug_follower_height-notch_depth)+(notch_depth/2)+1]) cube([notch_width,notch_width,notch_depth+1],center=true);
}

module make_base(){
translate([0,0,base_height/2]) cube([plug_follower_diameter + 2, plug_follower_diameter + 20, base_height],center=true);
translate([0,(plug_follower_diameter + 20)/2,0]) cylinder(r=(plug_follower_diameter + 4)/2,h=base_height);
translate([0,-((plug_follower_diameter + 20)/2),0]) cylinder(r=(plug_follower_diameter + 4)/2,h=base_height);
}

difference(){
cylinder(r=plug_follower_diameter/2,plug_follower_height,$fn=40);

if (plug_follower_type==1) plug_notch();
if (plug_follower_type==2) plug_moon();
if (plug_follower_type==3) plug_hollow();
}

if (generate_base==1) make_base();
 