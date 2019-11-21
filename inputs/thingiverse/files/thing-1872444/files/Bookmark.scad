// preview[view:north west, tilt:top diagonal]

/* Customizable Bookmark */


/* [Tag] */
// Text of the tag (use ♥ for heart)
text = "Name";
//Lenght of the tag
lenght = 50;//[20:1:100]
// Thickness of the tag
thick = 0.6; //[0.1:0.1:2]
/* [Head] */
//Thickness of the head
head_thick = 0.2; //[0.2:0.2:4]
//Height of the print on the head
head_height = 0.8; //[0.2:0.2:3]
//Rotation of image
rotation = 0;//[270:Bottom,0:Right,90:Top,180:Left]
//15x15 image on the head
image = "img.png";//[image_surface:61x61]

/*[ Miscellaneous] */
tag_color = "Crimson";
head_color = "Olive";
//Scale of image. You should NOT change that. 
image_scale = 1/15;
//Second scale for customizer. You should NOT change that. 
imgs = 1/4;
//If in customizer should be true. Do NOT change ! 
customizer = 1;//[1:True,0:False]

//// 0 : LOCAL ||||| 1 : CUSTOMIZER (Images are not generated the same way)


/* [Hidden] */
//Thickness to prevent 0 thick surface. DO NOT ALTER. 
over = 0.2;

//Width of the tag
width = 15;

//Space around the text
gap = 2;

//size of the head
head = width;

/*Start*/

/*We draw the tag and the text with the corresponding size*/
hsize = (width-(2*gap));
vsize = (lenght-gap)/(len(text));

//if(hsize*len(text)>(lenght-gap)) Change this if you want to change the size of the tag
rotate([0,0,90]) translate([0,lenght/2+head/2,-head_thick/2-thick/2]) if(hsize*len(text)>(lenght-gap)){//if(len(text)>=6){
    echo("Other size\n             ========");
   drawTag(width,lenght,thick,text,vsize,head);
}
else
{
   drawTag(width,lenght,thick,text,hsize,head);
}

/*We draw the head*/

color(head_color) rotate([0,0,rotation]) drawHead(head,head_thick,image,image_scale,head_height);



/*MODULES*/

//Let's draw the tag with the text
module drawTag(width,lenght,thick,string,textSize,head)
{
    union()
    {
    color(tag_color) difference(){
    cube([width,lenght,thick],center=true);
    translate([0,0,-thick/2-over/2]) linear_extrude(thick+over) rotate([0,0,90]) text(string,textSize,halign="center",valign="center");
    }
    color(head_color)
    translate([0,-lenght/2-head/2,0]) cube([width,head,thick],center=true);
    }
}

//Let's draw the head
module drawHead(head,head_thick,image,image_scale,head_height) {
    cube([head,head,head_thick],center=true);
    
    if(customizer==0)
    {
    translate([0,0,head_height+head_thick/2]) rotate([0,0,270]) scale([image_scale,image_scale,head_height/100]) surface(image,center=true,invert=true);
    }
    else
    {
        translate([0,0,head_thick/2+head_height/2+thick]) rotate([0,0,270]) scale([imgs,imgs,head_height]) surface(image,center=true);
    }
}

