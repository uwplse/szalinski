$fn=100;
/* [General] */
small_hole=8;
flare=20;
Thickness=20;
/* [Slots] */
Slot_width=5;
Slot_height=30;
//Slot_thickness=21;
Slot_Spacing=20;
Slot_distance_from_bottom=20;
Slot_distance_from_left=100;
/* [First Row] */
First_row_distance_from_bottom= 80;
First_row_distance_from_left= 27;
First_row_spacing=25;
/* [Second Row] */
Second_row_distance_from_bottom=120;
Second_row_distance_from_left= 40;
Second_row_spacing=25;
/* [Third Row] */
Third_row_distance_from_bottom=160;
Third_row_distance_from_left= 27;
Third_row_spacing=25;
module row1(){
}
difference(){
    cube ([254,190,Thickness]);
    //slot1
    translate ([Slot_distance_from_left,Slot_distance_from_bottom,-.5]) cube ([Slot_width,Slot_height,Thickness+1]);
    //slot2
    translate ([Slot_distance_from_left+Slot_Spacing,Slot_distance_from_bottom,-.5]) cube ([Slot_width,Slot_height,Thickness+1]);
    //slot3
    translate ([Slot_distance_from_left+Slot_Spacing*2,Slot_distance_from_bottom,-.5]) cube ([Slot_width,Slot_height,Thickness+1]);
    //translate ([120,20,-.5]) cube ([5,30,21]);
    //translate ([140,20,-.5]) cube ([5,30,21]);

    //row1
    translate ([First_row_distance_from_left,First_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([First_row_distance_from_left,First_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([First_row_distance_from_left+First_row_spacing,First_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([First_row_distance_from_left+First_row_spacing,First_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([First_row_distance_from_left+First_row_spacing*2,First_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([First_row_distance_from_left+First_row_spacing*2,First_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([First_row_distance_from_left+First_row_spacing*3,First_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([First_row_distance_from_left+First_row_spacing*3,First_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([First_row_distance_from_left+First_row_spacing*4,First_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([First_row_distance_from_left+First_row_spacing*4,First_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([First_row_distance_from_left+First_row_spacing*5,First_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([First_row_distance_from_left+First_row_spacing*5,First_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([First_row_distance_from_left+First_row_spacing*6,First_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([First_row_distance_from_left+First_row_spacing*6,First_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);

 translate ([First_row_distance_from_left+First_row_spacing*7,First_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([First_row_distance_from_left+First_row_spacing*7,First_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
 translate ([First_row_distance_from_left+First_row_spacing*8,First_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([First_row_distance_from_left+First_row_spacing*8,First_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
        
//second row
translate ([Second_row_distance_from_left,Second_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Second_row_distance_from_left,Second_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([Second_row_distance_from_left+Second_row_spacing,Second_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Second_row_distance_from_left+Second_row_spacing,Second_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([Second_row_distance_from_left+Second_row_spacing*2,Second_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Second_row_distance_from_left+Second_row_spacing*2,Second_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([Second_row_distance_from_left+Second_row_spacing*3,Second_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Second_row_distance_from_left+Second_row_spacing*3,Second_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([Second_row_distance_from_left+Second_row_spacing*4,Second_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Second_row_distance_from_left+Second_row_spacing*4,Second_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([Second_row_distance_from_left+Second_row_spacing*5,Second_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Second_row_distance_from_left+Second_row_spacing*5,Second_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([Second_row_distance_from_left+Second_row_spacing*6,Second_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Second_row_distance_from_left+Second_row_spacing*6,Second_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);

 translate ([Second_row_distance_from_left+Second_row_spacing*7,Second_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Second_row_distance_from_left+Second_row_spacing*7,Second_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);

    //row3
    translate ([Third_row_distance_from_left,Third_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Third_row_distance_from_left,Third_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([Third_row_distance_from_left+Third_row_spacing,Third_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Third_row_distance_from_left+Third_row_spacing,Third_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([Third_row_distance_from_left+Third_row_spacing*2,Third_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Third_row_distance_from_left+Third_row_spacing*2,Third_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([Third_row_distance_from_left+Third_row_spacing*3,Third_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Third_row_distance_from_left+Third_row_spacing*3,Third_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([Third_row_distance_from_left+Third_row_spacing*4,Third_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Third_row_distance_from_left+Third_row_spacing*4,Third_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([Third_row_distance_from_left+Third_row_spacing*5,Third_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Third_row_distance_from_left+Third_row_spacing*5,Third_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
    translate ([Third_row_distance_from_left+Third_row_spacing*6,Third_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Third_row_distance_from_left+Third_row_spacing*6,Third_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);

 translate ([Third_row_distance_from_left+Third_row_spacing*7,Third_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Third_row_distance_from_left+Third_row_spacing*7,Third_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);
 translate ([Third_row_distance_from_left+Third_row_spacing*8,Third_row_distance_from_bottom,-.5]) cylinder (d=10,h=21);
        translate ([Third_row_distance_from_left+Third_row_spacing*8,Third_row_distance_from_bottom,15]) cylinder (d1=small_hole,d2=flare,h=5.1);

}