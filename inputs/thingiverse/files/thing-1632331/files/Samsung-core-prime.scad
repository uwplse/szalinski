 $fa=0.5; $fs=0.5 ; // set surfaces default smoothness, set to > 1 during design , 0.5 when done
 
c_overprint = 0.3; // how much does the printer print wider than what is measured
c_phone_width = 68.3;
c_phone_length = 130.8;
c_phone_thickness = 9.7;
c_phone_corner_r = 10;
c_back_rounding = 11;  // not used

c_camera_from_top = 22;
c_camera_square = 14; // square central opening
c_camera_to_flash = 15;  // how far is the flash offset from the camera (center to center)
c_camera_to_speaker = 15; // how far is the flash offset from the camera (center to center)
c_flash_size = 6;
c_speaker_size = 7;

c_head_jack = 8;
c_head_jack_x_offset = -14.5;

// some of the volume button measurements are not used (two persons' mixup)
c_volume = 25;
c_volume_x = -4;
c_volume_y = 28;
c_volume_z = 7;
c_volume_z_offset = 3;
c_volumebox_x = 7;
c_volumebox_y = 26;
c_volumebox_z = 12;
c_volumebox_z_offset = 3;

// some of the on-off button measurements are not used (two persons' mixup)
c_on_off = 15;
c_on_off_x = 4;
c_on_off_y = 17.5;
c_on_off_z = 7;
c_on_off_box_x = 7;
c_on_off_box_y = 17;
c_on_off_box_z = 11;
c_on_off_box_z_offset = 3;

// charging port
c_charging_x = 11;
c_charging_z= 7;
c_charging_z_offset = 1;

side_thickness = 3;
bottom_thickness = 2; // in the end side thickness was used because we used rounded corners 
c_lip_width = 3; // how far does the lip overhand the phone

module mod_roundedbox(box_x,box_y,box_z,rounding_r)
{
    union ()
        { 
        cube ([box_x - rounding_r*2, box_y,box_z],center=true); //narrower in x direction
        cube ([box_x,box_y - rounding_r*2,box_z],center=true); //narrower in y direction
       
        for (x = [rounding_r-box_x/2,-rounding_r+box_x/2])
            for (y = [rounding_r-box_y/2,-rounding_r+box_y/2])
                translate ([x,y,0]) cylinder (r=rounding_r, h=box_z, center=true);; 
        };            
};

module main_box () {
   difference() {
       minkowski() {
           mod_roundedbox (c_phone_width, c_phone_length, c_phone_thickness,c_phone_corner_r);
           sphere (r=side_thickness);
           };
           // deduct the space for the phone
      translate ([0,0,0]) mod_roundedbox (c_phone_width+c_overprint*2, c_phone_length+c_overprint*2, c_phone_thickness+c_overprint,c_phone_corner_r);
           // deduct space above the phone slightly smaller as to create the lip
      translate ([0,0,c_phone_thickness-1]) mod_roundedbox (c_phone_width+c_overprint*2-c_lip_width, c_phone_length+c_overprint*2, c_phone_thickness,c_phone_corner_r-c_lip_width);

   };
};

module side_cutouts () {
    // headset
    translate ([c_head_jack_x_offset,c_phone_length/2,0]) rotate ([-90,0,0]) cylinder (r=c_head_jack/2, h=side_thickness);
    // charging cable
    translate ([0,-c_phone_length/2-side_thickness/2,c_charging_z_offset]) rotate ([90,0,0]) cube ([c_charging_x, c_charging_z, side_thickness+1], center=true);
    // on off
    translate ([(c_phone_width+1)/2,c_on_off_y,c_on_off_box_z_offset]) rotate ([0,0,0]) cube ([side_thickness+3, c_on_off_box_y, c_on_off_box_z ], center=true);
    // volume
    translate ([-(c_phone_width+1)/2,c_volume_y,c_volume_z_offset]) rotate ([0,0,0]) cube ([side_thickness+3, c_volumebox_y, c_volumebox_z ], center=true);
    // lens - flash - speaker
       translate ([0,c_phone_length/2-c_camera_from_top,-(c_phone_thickness+side_thickness)/2 ]) mod_roundedbox (c_camera_square,c_camera_square,side_thickness+1,1);
       translate ([-c_camera_to_speaker,c_phone_length/2-c_camera_from_top,-(c_phone_thickness+side_thickness)/2 ]) mod_roundedbox (c_speaker_size,c_speaker_size,side_thickness+1,1);
       translate ([c_camera_to_flash,c_phone_length/2-c_camera_from_top,-(c_phone_thickness+side_thickness)/2 ]) mod_roundedbox (c_flash_size,c_flash_size,side_thickness+1,1);
};

module main_body() {
    difference () {
        main_box ();
        side_cutouts ();
    //    cube ([100,100,100],center=true);
    };
};


main_body ();
//side_cutouts () ;
//main_box ();

        



