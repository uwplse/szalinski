//**************Constants********************
/* [Global] */


/* [Phone] */
// of your phone (mm)
LENGTH = 152.25;
// of your phone (mm)
WIDTH = 76.25;
// of your phone (mm)
HEIGHT = 8.3;
// of yout phone, Imagine the phone's round edge as a full circle and meassure its radius! If the edges are square type 0! (mm)
CORNER_RADIUS = 9;

/* [Camera] */

//Do you have a Backside camera?
CAMERA_HOLE = "yes"; // [yes,no]
//Meassure the camera from left to right! (mm)
CAMERA_LEFT_TO_RIGHT_SIZE = 15.0;
//Meassure the distance from the left edge of the phone to the middle of your camera! (mm)
CAMERA_LEFT_OFFSET = 38.125;
//Meassure the camera from bottom to top! (mm)
CAMERA_TOP_TO_BOTTOM_SIZE = 25.0;
//Meassure the distance from the top edge of the phone to the middle of your camera! (mm)
CAMERA_TOP_OFFSET = 23.4;
//Meassure the radius of the camera (like phones corner)! (mm)
CAMERA_RADIUS = 7.5;


/* [Flashlight] */

//Do you have a flashlight at the back?
FLASHLIGHT_HOLE = "yes"; // [yes,no]
//Meassure the flashlight from left to right! (mm)
FLASHLIGHT_LEFT_TO_RIGHT_SIZE = 5.0;
//Meassure the distance from the left edge of the phone to the middle of your flashlight! (mm)
FLASHLIGHT_LEFT_OFFSET = 50.7;
//Meassure the flashlight from bottom to top! (mm)
FLASHLIGHT_TOP_TO_BOTTOM_SIZE = 5.0;
//Meassure the distance from the top edge of the phone to the middle of your flashlight! (mm)
FLASHLIGHT_TOP_OFFSET = 18.3;
//Meassure the radius of the flashlight (like phones corner)! (mm)
FLASHLIGHT_RADIUS = 2.5;

/* [Fingerprint Sensor] */

//Do you have a fingerprint sensor at the back?
FINGERPRINT_HOLE = "yes"; // [yes,no]
//Meassure the fingerprint sensor from left to right! (mm)
FINGERPRINT_LEFT_TO_RIGHT_SIZE = 15;
//Meassure the distance from the left edge of the phone to the middle of your fingerprint sensor! (mm)
FINGERPRINT_LEFT_OFFSET = 38.125;
//Meassure the fingerprint sensor from bottom to top! (mm)
FINGERPRINT_TOP_TO_BOTTOM_SIZE = 15;
//Meassure the distance from the top edge of the phone to the middle of your fingerprint sensor! (mm)
FINGERPRINT_TOP_OFFSET = 41.5;
//Meassure the radius of the fingerprint sensor (like phones corner)! (mm)
FINGERPRINT_RADIUS = 7.25;
;

/* [Volume Button] */

//Do you have a volume button?
VOLUME_BUTTON_HOLE = "yes"; // [yes,no]
//On which side of your phone is it?
VOLUME_BUTTON_SIDE = "Right"; // [Right,Left,Top,Bottom]
//Which Shape do you want the hole to be?
VOLUME_BUTTON_SHAPE = "Roundy Rectangle"; // [Roundy Rectangle,Round]
//What size should the hole have?
VOLUME_BUTTON_SIZE = 20;
//Type in the offset (middle point) of your Hole from left (if the side is Top or Bottom) or top (if the side is Left or Right)
VOLUME_BUTTON_OFFSET = 29.5;

/* [Power Button] */

//Do you have a power button?
POWER_BUTTON_HOLE = "yes"; // [yes,no]
//On which side of your phone is it?
POWER_BUTTON_SIDE = "Right"; // [Right,Left,Top,Bottom]
//Which Shape do you want the hole to be?
POWER_BUTTON_SHAPE = "Roundy Rectangle"; // [Roundy Rectangle,Round]
//What size should the hole have?
POWER_BUTTON_SIZE = 9.5;
//Type in the offset (middle point) of your Hole from left (if the side is Top or Bottom) or top (if the side is Left or Right)
POWER_BUTTON_OFFSET = 52;

/* [USB Plug] */

//Do you have a USB plug?
USB_PLUG_HOLE = "yes"; // [yes,no]
//On which side of your phone is it?
USB_PLUG_SIDE = "Bottom"; // [Right,Left,Top,Bottom]
//Which Shape do you want the hole to be?
USB_PLUG_SHAPE = "Roundy Rectangle"; // [Roundy Rectangle,Round]
//What size should the hole have?
USB_PLUG_SIZE = 12;
//Type in the offset (middle point) of your Hole from left (if the side is Top or Bottom) or top (if the side is Left or Right)
USB_PLUG_OFFSET = 38.125;

/* [Speaker 1] */

//Do you have a Speaker?
SPEAKER_1_HOLE = "yes"; // [yes,no]
//On which side of your phone is it?
SPEAKER_1_SIDE = "Bottom"; // [Right,Left,Top,Bottom]
//Which Shape do you want the hole to be?
SPEAKER_1_SHAPE = "Roundy Rectangle"; // [Roundy Rectangle,Round]
//What size should the hole have?
SPEAKER_1_SIZE = 13;
//Type in the offset (middle point) of your Hole from left (if the side is Top or Bottom) or top (if the side is Left or Right)
SPEAKER_1_OFFSET = 19.5;

/* [Speaker 2] */

//Do you have a second Speaker?
SPEAKER_2_HOLE = "yes"; // [yes,no]
//On which side of your phone is it?
SPEAKER_2_SIDE = "Bottom"; // [Right,Left,Top,Bottom]
//Which Shape do you want the hole to be?
SPEAKER_2_SHAPE = "Roundy Rectangle"; // [Roundy Rectangle,Round]
//What size should the hole have?
SPEAKER_2_SIZE = 13;
//Type in the offset (middle point) of your Hole from left (if the side is Top or Bottom) or top (if the side is Left or Right)
SPEAKER_2_OFFSET = 57.5;

/* [Headphone Jack] */

//Do you have a Headphone jack?
HEADPHONE_JACK_HOLE = "yes"; // [yes,no]
//On which side of your phone is it?
HEADPHONE_JACK_SIDE = "Top"; // [Right,Left,Top,Bottom]
//Which Shape do you want the hole to be?
HEADPHONE_JACK_SHAPE = "Round"; // [Roundy Rectangle,Round]
//What size should the hole have?
HEADPHONE_JACK_SIZE = 0;
//Type in the offset (middle point) of your Hole from left (if the side is Top or Bottom) or top (if the side is Left or Right)
HEADPHONE_JACK_OFFSET = 19;
        

/* [Cover Settings] */

//Type in the thickness of the cover's groud plate! (mm)
BASEPLATE_THICKNESS = 1;
//Type in the thickness of the cover's walls around the phone! (mm)
WALL_THICKNESS = 2;
//Type in the length of the cover's walls around the phone! (%)
WALL_TOP_TO_BOTTOM_LENGHT = 100; //[0:100]
//Type in the length of the cover's walls around the phone! (%)
WALL_LEFT_TO_RIGHT_LENGHT = 100; //[0:100]
//Type in how much the holders should overlap your phone! (mm)
HOLDER_WIDTH = 1;
//Type in the thickness of the holders! (mm)
HOLDER_HEIGHT = 1;


/* [Fillets] */

//Do you want to use Inner Fillets on the upper side to make printing easier?
UPPER_FILLETS = "yes"; // [yes,no]

//Do you want to use Inner Fillets on the lower side to improve stability?
LOWER_FILLETS = "yes"; // [yes,no]



/* [Smoother Settings] */

//Which smoother do you want to use? A Smoother makes your cover less square and look more fancy. (Known to be buggy and slow at the moment, will be rewritten soon ;) )
SMOOTHER = 1; // [0:none,1:Roundy]
//How round do you want it to be?
S_RADIUS = 8; //[8:70]


/* [Hidden] */

//****************Variables******************
OVERTHICKNESS = 3;
H_OVERTHICKNESS = 4;
ABS_LENGTH = LENGTH + 2*WALL_THICKNESS;
ABS_WIDTH = WIDTH + 2*WALL_THICKNESS;
ABS_HEIGHT = HEIGHT + BASEPLATE_THICKNESS + HOLDER_HEIGHT;
OUTER_CORNER_RADIUS = CORNER_RADIUS+WALL_THICKNESS;
//Add some squareness to it?
S_INFILL = 0; //[0:300]
//If your phone isn't too square, you can leaf this standard value!
LOWER_FILLET_RADIUS = HOLDER_WIDTH;
//If your phone isn't too square, you can leaf this standard value!
UPPER_FILLET_RADIUS = HOLDER_WIDTH;
//****************Geometry*******************



$fa=0.5; $fs=0.5;

Cover();
     
//WallHole(side = "Right", shape="Roundy Rectangle", off = 0, size = 33);
//Hole(xoff = 0, yoff = 0, xsize = 25, ysize = 15, radius = 7.5);
//****************Modules********************

//Main Modules
module Cover()
{
    difference()
    {
        union()
        {
            Baseplate(); 
            Walls(size_l= WALL_TOP_TO_BOTTOM_LENGHT, size_w = WALL_LEFT_TO_RIGHT_LENGHT,smoother = SMOOTHER);
            //HolderCorners();
            //HolderWalls();
        }
        if(CAMERA_HOLE == "yes")
        {
            Hole(yoff = CAMERA_LEFT_OFFSET, xoff = CAMERA_TOP_OFFSET, xsize = CAMERA_TOP_TO_BOTTOM_SIZE, ysize = CAMERA_LEFT_TO_RIGHT_SIZE, radius = CAMERA_RADIUS);
        }
        if(FLASHLIGHT_HOLE == "yes")
        {
            Hole(yoff = FLASHLIGHT_LEFT_OFFSET, xoff = FLASHLIGHT_TOP_OFFSET, xsize = FLASHLIGHT_TOP_TO_BOTTOM_SIZE, ysize = FLASHLIGHT_LEFT_TO_RIGHT_SIZE, radius = FLASHLIGHT_RADIUS);
        }
        if(FINGERPRINT_HOLE == "yes")
        {
            Hole(yoff = FINGERPRINT_LEFT_OFFSET, xoff = FINGERPRINT_TOP_OFFSET, xsize = FINGERPRINT_TOP_TO_BOTTOM_SIZE, ysize = FINGERPRINT_LEFT_TO_RIGHT_SIZE, radius = FINGERPRINT_RADIUS);
        }
        if(VOLUME_BUTTON_HOLE == "yes")
        {
            WallHole(side = VOLUME_BUTTON_SIDE, shape = VOLUME_BUTTON_SHAPE, off = VOLUME_BUTTON_OFFSET, size = VOLUME_BUTTON_SIZE);
        }
        if(POWER_BUTTON_HOLE == "yes")
        {
            WallHole(side = POWER_BUTTON_SIDE, shape = POWER_BUTTON_SHAPE, off = POWER_BUTTON_OFFSET, size = POWER_BUTTON_SIZE);
        }
        if(USB_PLUG_HOLE == "yes")
        {
            WallHole(side = USB_PLUG_SIDE, shape = USB_PLUG_SHAPE, off = USB_PLUG_OFFSET, size = USB_PLUG_SIZE);
        }
        if(SPEAKER_1_HOLE == "yes")
        {
            WallHole(side = SPEAKER_1_SIDE, shape = SPEAKER_1_SHAPE, off = SPEAKER_1_OFFSET, size = SPEAKER_1_SIZE);
        }
        if(SPEAKER_2_HOLE == "yes")
        {
            WallHole(side = SPEAKER_2_SIDE, shape = SPEAKER_2_SHAPE, off = SPEAKER_2_OFFSET, size = SPEAKER_2_SIZE);
        }
        if(HEADPHONE_JACK_HOLE == "yes")
        {
            WallHole(side = HEADPHONE_JACK_SIDE, shape = HEADPHONE_JACK_SHAPE, off = HEADPHONE_JACK_OFFSET, size = HEADPHONE_JACK_SIZE);
        }
    }
}

module Hole(xoff = 0, yoff = 0, xsize = 20, ysize = 20, radius = 10)
{
    translate([LENGTH/2-xoff-xsize/2+radius,-WIDTH/2+yoff-ysize/2+radius,-BASEPLATE_THICKNESS*H_OVERTHICKNESS/2])
    {
        if (radius == 0) //rect 
        {
            cube([xsize-2*radius,ysize-2*radius,BASEPLATE_THICKNESS*H_OVERTHICKNESS]);
        }
        else if(radius*2 < xsize && radius*2 < ysize) //rounded rect
        {
            minkowski()
            {
                cube([xsize-2*radius,ysize-2*radius,BASEPLATE_THICKNESS*H_OVERTHICKNESS/2]);
                cylinder(h = BASEPLATE_THICKNESS*H_OVERTHICKNESS/2,r = radius);
            }
        }
        else if(radius*2 == xsize && radius*2 < ysize) //connected cyls 
        {
            hull() 
            {
                translate([0,ysize-2*radius,0]) {cylinder(h = BASEPLATE_THICKNESS*H_OVERTHICKNESS,r = radius);}
                cylinder(h = BASEPLATE_THICKNESS*H_OVERTHICKNESS,r = radius);
            }
        }
        else if(radius*2 == ysize && radius*2 < xsize) //connected cyls 
        {
            hull() 
            {
                translate([xsize-2*radius,0,0]) {cylinder(h = BASEPLATE_THICKNESS*H_OVERTHICKNESS,r = radius);}
                cylinder(h = BASEPLATE_THICKNESS*H_OVERTHICKNESS,r = radius);
            }
        }
        else if(radius*2 == ysize && radius*2 == xsize) //circle 
        {
            cylinder(h = BASEPLATE_THICKNESS*H_OVERTHICKNESS,r = radius);
        }
        else
        {
            echo ("ERROR when making hole, 2*radius has to be <= both sizes"); 
        }
    } 
}

module WallHole(side = "Right", shape="Round", off = 10, size = 20)
{
    if(shape=="Roundy Rectangle") //rounded rect
    {
        if(side == "Top")
        {
            translate([LENGTH/2,WIDTH/2-off,BASEPLATE_THICKNESS+HEIGHT/2]) rotate([0,270,0])
            {
                translate([0,0,0]) minkowski()
                {
                    cube([HEIGHT/2,size-HEIGHT/2,WALL_THICKNESS*OVERTHICKNESS/2],true);
                    cylinder(h = BASEPLATE_THICKNESS*H_OVERTHICKNESS/2,r = HEIGHT/4);
                }
            }
            
        }
        if(side == "Bottom")
        {
            translate([-LENGTH/2,WIDTH/2-off,BASEPLATE_THICKNESS+HEIGHT/2]) rotate([0,270,0])
            {
                translate([0,0,0]) minkowski()
                {
                    cube([HEIGHT/2,size-HEIGHT/2,WALL_THICKNESS*OVERTHICKNESS/2],true);
                    cylinder(h = BASEPLATE_THICKNESS*H_OVERTHICKNESS/2,r = HEIGHT/4);
                }
            }
        }
        if(side == "Left")
        {
            translate([LENGTH/2-off+size/2-HEIGHT/4,WIDTH/2+(WALL_THICKNESS),BASEPLATE_THICKNESS+HEIGHT/4]) rotate([0,270,90])
            {
                translate([0,0,0]) minkowski()
                {
                    cube([HEIGHT/2,size-HEIGHT/2,WALL_THICKNESS*OVERTHICKNESS/2]);
                    cylinder(h = BASEPLATE_THICKNESS*H_OVERTHICKNESS/2,r = HEIGHT/4);
                }
            }
        }
        if(side == "Right")
        {
            translate([LENGTH/2-off+size/2-HEIGHT/4,-(WIDTH/2)+(WALL_THICKNESS),BASEPLATE_THICKNESS+(HEIGHT/4)]) rotate([0,270,90])
            {
                translate([0,0,0]) minkowski()
                {
                    cube([HEIGHT/2,size-HEIGHT/2,WALL_THICKNESS*OVERTHICKNESS/2]);
                    cylinder(h = BASEPLATE_THICKNESS*H_OVERTHICKNESS/2,r = HEIGHT/4);
                }
            }
        }     
    }
    else if(shape=="Round") //circle 
    {
        if(side == "Top")
        {
            translate([LENGTH/2+(WALL_THICKNESS*OVERTHICKNESS)/2+1,WIDTH/2-off,BASEPLATE_THICKNESS+HEIGHT/2]) rotate([0,270,0])
            {
                translate([0,0,0]) {cylinder(h = WALL_THICKNESS*OVERTHICKNESS,r = HEIGHT/2);}
    
            }
        }
        if(side == "Bottom")
        {
            translate([-(LENGTH/2-(WALL_THICKNESS*OVERTHICKNESS)/2+1),WIDTH/2-off,BASEPLATE_THICKNESS+HEIGHT/2]) rotate([0,270,0])
            {
                translate([0,0,0]) {cylinder(h = WALL_THICKNESS*OVERTHICKNESS,r = HEIGHT/2);}
    
            }
        }
        if(side == "Left")
        {
            translate([LENGTH/2-off,WIDTH/2+(WALL_THICKNESS*OVERTHICKNESS)/2+1,BASEPLATE_THICKNESS+HEIGHT/2]) rotate([0,270,90])
            {
                translate([0,0,0]) {cylinder(h = WALL_THICKNESS*OVERTHICKNESS,r = HEIGHT/2);}
    
            }
        }
        if(side == "Right")
        {
            translate([LENGTH/2-off,-(WIDTH/2-(WALL_THICKNESS*OVERTHICKNESS)/2+1),BASEPLATE_THICKNESS+HEIGHT/2]) rotate([0,270,90])
            {
                translate([0,0,0]) {cylinder(h = WALL_THICKNESS*OVERTHICKNESS,r = HEIGHT/2);}
            }
        } 
    }   
}

module Baseplate() 
{
    translate([-(LENGTH-2*CORNER_RADIUS)/2,-(WIDTH-2*CORNER_RADIUS)/2,0]) 
    minkowski()
    {
        cube([LENGTH-2*CORNER_RADIUS, WIDTH-2*CORNER_RADIUS,BASEPLATE_THICKNESS/2]);
        cylinder(h = BASEPLATE_THICKNESS/2,r = CORNER_RADIUS);
    }  
}
module WallCorners(smoother = 1)
{
    translate([0,0,0])
    {
        translate([(LENGTH+(2*WALL_THICKNESS))/2,(WIDTH+(2*WALL_THICKNESS))/2,0])
        rotate([0,0,180])
        {
            curve(smoother);    
        }
        translate([-(LENGTH+(2*WALL_THICKNESS))/2,(WIDTH+(2*WALL_THICKNESS))/2,0])
        rotate([0,0,270])
        {
            curve(smoother);
        }
        translate([-(LENGTH+(2*WALL_THICKNESS))/2,-(WIDTH+(2*WALL_THICKNESS))/2,0])
        rotate([0,0,0])
        {
            curve(smoother);
        }
        translate([(LENGTH+(2*WALL_THICKNESS))/2,-(WIDTH+(2*WALL_THICKNESS))/2,0])
        rotate([0,0,90])
        {
            curve(smoother);
        }
    }
}

module Walls(size_l=17, size_w=20, smoother = 1)
{
    translate([0,0,0])
    {
        //Top
        translate([LENGTH/2+WALL_THICKNESS/2,0,0])  difference()
            {
                translate([WALL_THICKNESS/2,WIDTH/2-CORNER_RADIUS,0]) rotate([0,270,90]) linear_extrude(height = WIDTH-(2*CORNER_RADIUS))
                {
                    ShapeSmoother(smoother);
                }
                translate([0,0,BASEPLATE_THICKNESS]) linear_extrude(height = ABS_HEIGHT)
                {
                    translate([0,0,BASEPLATE_THICKNESS])
                    {square([WALL_THICKNESS*2+HOLDER_WIDTH, (WIDTH-(2*CORNER_RADIUS))*(100-size_w)/100], center = true);}
                }
        }
        //Bottom
        translate([-(LENGTH/2+WALL_THICKNESS/2),0,0]) difference()
            {
                translate([-WALL_THICKNESS/2,-WIDTH/2+CORNER_RADIUS,0]) rotate([0,270,270]) linear_extrude(height = WIDTH-(2*CORNER_RADIUS))
                {
                    ShapeSmoother(smoother);
                }
                translate([0,0,BASEPLATE_THICKNESS]) linear_extrude(height = ABS_HEIGHT)
                {
                    translate([0,0,BASEPLATE_THICKNESS])
                    {square([WALL_THICKNESS*2+HOLDER_WIDTH, (WIDTH-(2*CORNER_RADIUS))*(100-size_w)/100], center = true);}
                }
        }
        //Right
        translate([0,(WIDTH/2+WALL_THICKNESS/2),0])
        {
            difference()
            {
                translate([-(LENGTH-(2*CORNER_RADIUS))/2,WALL_THICKNESS/2,0]) rotate([0,270,180]) linear_extrude(height = LENGTH-(2*CORNER_RADIUS))
                {
                    ShapeSmoother(smoother);
                }
                translate([0,0,BASEPLATE_THICKNESS]) linear_extrude(height = ABS_HEIGHT)
                {
                    translate([0,0,BASEPLATE_THICKNESS])
                    {square([(LENGTH-(2*CORNER_RADIUS))*(100-size_l)/100,WALL_THICKNESS*2+HOLDER_WIDTH], center = true);}
                }
            }
        }
        //Left
        translate([0,-(WIDTH/2+WALL_THICKNESS/2),0])
        {
            difference()
            {
                translate([(LENGTH-(2*CORNER_RADIUS))/2,-WALL_THICKNESS/2,0]) rotate([0,270,0]) linear_extrude(height = LENGTH-(2*CORNER_RADIUS))
                {
                    ShapeSmoother(smoother);
                }
                translate([0,0,BASEPLATE_THICKNESS]) linear_extrude(height = ABS_HEIGHT)
                {
                    
                    {square([(LENGTH-(2*CORNER_RADIUS))*(100-size_l)/100,WALL_THICKNESS*2+HOLDER_WIDTH], center = true);}
                }
            }
        }
    }
    WallCorners(smoother );
}




//Helper Modules

module WallShape ()
{
    
    union()
    {    
        //WALL
        square([ABS_HEIGHT,WALL_THICKNESS]);
        //Holder
        translate ([ABS_HEIGHT-HOLDER_HEIGHT,0,0]) {square([HOLDER_HEIGHT,HOLDER_WIDTH+WALL_THICKNESS]);}
        //Upper fillet
        if(UPPER_FILLETS == "yes")
        {
            translate([ABS_HEIGHT-HOLDER_HEIGHT-UPPER_FILLET_RADIUS,UPPER_FILLET_RADIUS+WALL_THICKNESS,0])
            rotate([0,0,270])
            difference()
            {
                square([UPPER_FILLET_RADIUS,UPPER_FILLET_RADIUS]);
                circle(UPPER_FILLET_RADIUS);
            }
        }
        if(LOWER_FILLETS == "yes")
        {
            translate([LOWER_FILLET_RADIUS+BASEPLATE_THICKNESS,LOWER_FILLET_RADIUS+WALL_THICKNESS,0])
            rotate([0,0,180])
            difference()
            {
                square([LOWER_FILLET_RADIUS,LOWER_FILLET_RADIUS]);
                circle(LOWER_FILLET_RADIUS);
            }
        }
    }
    
}

module ShapeSmoother(smoother = 1)
{
    
        intersection()
        {
            if(smoother == 1)
            {
                translate([ABS_HEIGHT/2,S_RADIUS])
                {circle(S_RADIUS);}
            }
            WallShape ();
        }
        
    
}
    

module curve(smoother = 1)
{
    translate([OUTER_CORNER_RADIUS,OUTER_CORNER_RADIUS,0])rotate([0,0,90])
    difference()
    {
        rotate_extrude()translate([WALL_THICKNESS+CORNER_RADIUS,0,0]) rotate([0,0,90])
        {
            difference()
            {   
                
                ShapeSmoother(smoother);
                translate([-ABS_HEIGHT*OVERTHICKNESS/4,WALL_THICKNESS+CORNER_RADIUS])
                {  
                     
                     square([ABS_HEIGHT*OVERTHICKNESS,WALL_THICKNESS+HOLDER_WIDTH]);
                }
            }
        }
        translate([0,0,-(ABS_HEIGHT*OVERTHICKNESS)/2]) linear_extrude(height=ABS_HEIGHT*OVERTHICKNESS)
        {
            polygon(points=[
            [0,0],
            [0,OUTER_CORNER_RADIUS*OVERTHICKNESS],
            [OUTER_CORNER_RADIUS*OVERTHICKNESS,OUTER_CORNER_RADIUS*OVERTHICKNESS],
            [OUTER_CORNER_RADIUS*OVERTHICKNESS,-OUTER_CORNER_RADIUS*OVERTHICKNESS],
            [-OUTER_CORNER_RADIUS*OVERTHICKNESS,-OUTER_CORNER_RADIUS*OVERTHICKNESS],
            [-OUTER_CORNER_RADIUS*OVERTHICKNESS,0]]);
        }
    }
}

