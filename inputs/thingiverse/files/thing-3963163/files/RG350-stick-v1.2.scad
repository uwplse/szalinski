/*   ################################          
     #                              #
     #  Raven stick generator v1.2  #
     #                              #
     ################################


modify the parameters according to your needs.

once the correct parameters have been entered press F6 to start the rendering and then export it in stl format

n.b: 
1. before starting the rendering, make sure all the parameters are correct by pressing F5. A preview will start and will take less time to show.
   then press F6

2. you can increase the resolution to make the model smoother. if this value is set too high you could have problems with the generation of the stl file. I'm already trying to solve this problem

3. rendering may take several minutes

4. if you encounter bugs or various issues, please let me know and I will try to fix them


NEW!!!!!!!!

1. now you can add a custom text, just enter the text in the space provided and set the other parameters

2. now you can add a custom image. The image must be in png format and it is better if it contains only grayscale. insert the image in the same folder where the file is saved, and insert the name in the space provided




modify only these parameters */



thick = 1;                //dome thickness - default 1
dome_d = 19.5;               //dome diameter - default 19.5
skirt_h = 2;               //skirt height - default 1.1
skirt_r = 0.1;               //radius fitting skirt - default 0.1
nub_w = 8;                   //nub width - default 8
nub_h = 0;                   //nub height (starting from the top of the dome) - default 0
nub_rfillet = 0.1;           //radius of the fillet around the nub
addgridpattern = "n";        //add grid pattern ("y"/"n")
intcylinder_r = 2.5;         //radius of the internal cylinder - default 2.5
intcylinder_dist = 3.3;      //distance of the cylinder from the base of the dome (excluding the skirt) - default 3.3
tophole_s = [1.6,1.1];       //top hole size
tophole_h = 3.1;             //top hole height - default 3.1
bottomhole_s = [1.6,1.2];    //bottom hole size
bottomhole_h = 0.5;          //bottom hole height - default 0.5
resolution = 300;

addtext = "n";               //add text ("y"/"n")
text_t = "ok";            //insert text
text_i = "y";                //inverse text ("y"/"n")
text_dh = 0.3;               //text depth/height
text_s = 1;                  //text scale
text_o = 0;                  //text orientation ( ex. 0° / 45° / 62° / ecc. )
text_x = 0;                  //text shift - x axis (ex 0.5 / -0.5 / ecc.)
text_y = 0;                  //text shift - y axis (ex 0.5 / -0.5 / ecc.)                 

addimage = "n";              //add image ("y"/"n")
image_name = "example.png";     //insert image name ("example.png")
image_i= "n";                //invert image
image_dh = 0.3;              //image depth/height
image_sb = 5;                //image size (base)
image_sh = 5;                //image size (height)
image_o = 0;                 //image orientation ( ex. 0° / 45° / 62° / ecc. )
image_x = 0;                 //image shift - x axis (ex 0.5 / -0.5 / ecc.)
image_y = 0;                 //image shift - y axis (ex 0.5 / -0.5 / ecc.) 


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

con_factor = 1;
nub_d = dome_d*1.27*con_factor;

$fn=resolution;

//Stick module
 
module stick () {

//Dome

difference(){
difference (){
        
translate([dome_d/2,skirt_h,0])
circle(d=dome_d);
translate([dome_d/2,skirt_h,0])    
circle (d=dome_d-thick*2);    
   
}

translate([-1,-(dome_d+2-skirt_h),0])
square([dome_d+2,dome_d+2]);
}


//Skirt Module

module skirt (base,height,radius) {
    translate ([radius,radius,0])
    offset (r=radius)
    square([base-radius*2,height+0.2]);
    
}

//Skirt generation


    
if (skirt_r == thick/2) {

translate ([0,skirt_r])
square([thick,skirt_h-skirt_r]);
translate ([thick/2,skirt_r,0])
circle (r=skirt_r);
    
translate ([dome_d-thick,skirt_r])
square([thick,skirt_h-skirt_r]);
translate ([dome_d-thick/2,skirt_r,0])
circle (r=skirt_r);    
    
}  
else {
    
difference() {    
skirt (thick,skirt_h,skirt_r);
translate ([-1,skirt_h,0])
square ([thick+2,2]);
}
difference() {    
translate ([dome_d-thick,0,0])
skirt (thick,skirt_h,skirt_r);
translate ([dome_d-thick-1,skirt_h,0])
square ([thick+2,2]);
}

}


//Nub generation
offset(r=nub_rfillet) {
offset(delta=-nub_rfillet) {
intersection () {
difference (){
translate ([dome_d/2-nub_w/2,0,0])
square([nub_w,nub_h+skirt_h+dome_d/2+1]);
translate ([dome_d/2,skirt_h,0])    
circle(d=dome_d-thick);    
}
translate ([dome_d/2,-nub_d/2+nub_h+skirt_h+dome_d/2,0])
circle(d=nub_d);
}
}
}

}

//Pattern module (grid)

module gridpattern (){
gpatternpoint = ([[0,0],[0.5+0.1,0.25],[0.5+0.1,-0.25]]);

rotate([0,0,90])
rotate_extrude (angle = 180)
translate ([-0.5,0,0])
translate ([nub_d/2,0,0])   
polygon (gpatternpoint);

}


//Pattern generation (grid)

module patterngen (){
translate ([0,0,skirt_h+dome_d/2+nub_h])
translate ([0,0,-nub_d/2])
for (i=[69:3:111])
rotate([0,i,0])
gridpattern();
}


//Stick generation

module stickgen () {
rotate_extrude (angle = 360)
difference(){
translate ([-dome_d/2,0,0])
stick ();
square ([dome_d,dome_d+skirt_h]);
}
}

// activation/deactivation gridpattern

if (addgridpattern == "y") {
    difference() {
    
    stickgen();

        difference (){

            union (){
            patterngen();
            rotate([0,0,90])
            patterngen();
    
}
   
        difference (){
        translate ([0,0,-10])
        cylinder (h=dome_d/2+skirt_h+nub_h+20,r=dome_d);
        translate ([0,0,-11])
        cylinder (h=dome_d/2+skirt_h+nub_h+22,r=nub_w/2-nub_rfillet);
}

}
hole();
}

}




// internal cylinder module

module intcylinder() {

translate ([0,0,intcylinder_dist+skirt_h])
cylinder (h=dome_d/2-thick-intcylinder_dist, r =intcylinder_r); 

}



// hole module

module hole() {
    
    translate ([0,0,intcylinder_dist+skirt_h-0.2]) {
    linear_extrude (bottomhole_h+0.2)
    square(bottomhole_s, center=true);
    
    linear_extrude (bottomhole_h+tophole_h)
    square(tophole_s, center=true);
    }
}

difference(){
    
    intcylinder();
    hole();
    
}

// text module

module  nub_text (){
   
   scale (text_s){ 
   text (text_t, halign="center", valign = "center", size = 1); 
   
}

}


// text generation

if (addtext== "y") {
    
    
    if (text_i=="n"){
    difference (){
    stickgen ();
    hole();
    }
    difference () {
    rotate (-text_o)    
    translate ([text_x,text_y,0])
    translate ([0,0,dome_d/2-thick+nub_h+skirt_h])
    linear_extrude (height=text_dh+thick)
    nub_text ();
    hole();   
    }
    }
    
    if (text_i=="y") {
    difference (){
   stickgen ();
    rotate (-text_o)    
    translate ([text_x,text_y,0])       
    translate ([0,0,dome_d/2+nub_h+skirt_h-text_dh])
    linear_extrude (height=text_dh+0.1)
    nub_text (); 
    hole();    
    }
    }
    

}

// image module

module nub_image () {
    
    resize ([image_sb,image_sh,1])
    surface(file = image_name, center = true, invert = true);
    
}


// image generation

if (addimage == "y") {
    
    
    if (image_i=="n"){
    difference (){
    stickgen ();
    hole();
    }
    rotate (-image_o)    
    translate ([image_x,image_y,0])
    translate ([0,0,dome_d/2+skirt_h+nub_h+image_dh])
    resize ([image_sb,image_sh,1+image_dh])
    nub_image ();
    }
    
    if (image_i=="y") {
    difference () {
    stickgen ();
    rotate (-image_o)    
    translate ([image_x,image_y,0])    
    translate ([0,0,dome_d/2+skirt_h+nub_h-image_dh])
    rotate ([0,180,0])    
    nub_image ();
    hole();    
    }
        
    }
}
   




if (addgridpattern=="n"&&addtext=="n"&&addimage=="n") {
    
   difference () {
    stickgen();
    hole();
   }
}










