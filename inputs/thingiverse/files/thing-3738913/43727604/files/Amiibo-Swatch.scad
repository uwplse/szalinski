/* [Top Text] */
//Top line of amiibo name
top_nfc_name = "Amiibo Line 1";
//Top line font size
top_font_size = 5; //[1:10]

/* [Bottom Text] */
//Bottom line of amiibo name
bottom_nfc_name = "Amiibo Line 2";
//Bottom line font size
bottom_font_size = 5; //[1:10]

/* [Other Settings] */
//Add a spot for a ring holder to go in.
add_ring = 4; //[0:No,4:Yes]

//Customize the ring diameter to fit.
ring_diameter = add_ring > 0 ? 2.5 : 0;

//Image to use. Preferably a 100x100 pixel image, white background, black logo. Remember to use 'Invert Colors'.
image_file = "smiley.png"; // [image_surface:30x30]

/* [Hidden] */
font = "Arial Rounded";
item_height = 25;
text_frame = 55;
sticker_size = 26;
spacer = 5;
//Calculated Values
ring_distance = spacer + ring_diameter;
logo_distance = spacer + ring_distance;
text_distance = item_height + (spacer * 2) + ring_distance;
raised_logo = spacer + 2 + ring_distance;
embossed_logo = raised_logo + (spacer * 2);
rasied_text = text_distance + 2;
text_space = rasied_text + 4;
sticker_distance = text_distance + text_frame + (spacer * 3.5);
body = item_height + text_frame + sticker_size + (spacer * 4) + ring_distance;


//Create the main body
difference() {
    //BASE
    cube([body,35,3]);
    
    //Logo Frame
    translate([logo_distance,5,2]) 
        cube([item_height,item_height,2]) ;

    //Text Frame
    translate([text_distance,5,2]) 
        cube([text_frame,item_height,2]);
        
    //Sticker
    translate([sticker_distance, 17.5, 2]) 
        cylinder(h=2,r=sticker_size/2);

    //Ring holder
    if (add_ring > 0) {
    translate([spacer + 1, 17.5, -1])
        cylinder(h=5, r=ring_diameter); 
    }
}


difference(){
    //Raised logo
    translate([raised_logo,7,2]) 
        cube([21,21,1]);
    
    //Embossed icon
    translate([embossed_logo,17,3]) 
        scale([60/100,60/100,-1]) 
            surface(file=image_file, center=true, convexity=10);
}

difference() 
{
    //Text Body
    translate([rasied_text,7,2]) 
        cube([51,21,1]);
    
    //Text Line 1
    translate([text_space, 20, 2]) 
        linear_extrude(height=2)
            text(top_nfc_name, font = font, size = top_font_size, spacing = 1 );

    //Text Line 2
    translate([text_space, 11, 2]) 
        linear_extrude(height=2)
            text(bottom_nfc_name, font = font, size = bottom_font_size, spacing = 1);
}
