/*[Basic Cube Settings] */
// the size in mm of the cubes. The gap will be subtracted
size = 20; //[10:50]

// [mm] The minimal distance you can print without glueing neighboring objects together. This value will be used as distance between the cubes and within the mechanics. This should be slightly larger than your layer height
gap = 0.25; //[0.10:0.01:0.60]

// How many rows to print, it will always be 2 wide so the actual number of cubes is twice this number
numRows=4; //[2:12]

// how big the hinges should be. These are defined as a fraction of the cube "size". 
ratio_hinge_dia=0.3; //[0.2:0.01:0.4]
ratio_hinge_wid=0.6; //[0.3:0.01:0.8]

// this takes a lot of time to render so if you are just testing how the image fits then set this to true and the hinges will not be printed. It will be MUCH faster.
testImage=false; // [true,false]

//[Top Image]
// set to false if you have no image, it will render a lot faster
image1=true; //[true,false]

// the name of the first image file
//image1File="rg4.png";
image1File="willowglen systems 3.png";

// the number of pixels /size of the image file. If you want a blank border around the image then just increase the image size. It is assumed that the logo is wider in the X direction than the Y direction.
image1Xsize=490; //[20:1000]
image1Ysize=128;  //[20:1000]
image1Zscale=0.01; // [0.0:0.001:1]

//the number of mm to adjust the positioning of the logo away from center. This is useful to get the cut lines between the cubes to line up with something in the logo. Note that X and Y are reversed compared to the image file
image1TweakX=-12.4 ;//[-10:0.1:10]
image1TweakY=0;//[-10:0.1:10]

/* [Text] */
//This text appears below image1
text1="Fidget";
//should be less than "size"
text1Size=14;//[5:45]

//This text appears above image1
text2="Cube";
//should be less than "size"
text2Size=14;//[3:45]


//This text appears when the image1 is not displayed
text3="The"; 
//should be less than "size"
text3Size=4;//[3:45]

//This text appears when the image1 is not displayed
text4="Fisher"; 
//should be less than "size"
text4Size=4;//[3:45]

//This text appears when the image1 is not displayed
text5="One"; 
//should be less than "size"
text5Size=5;//[3:45]

// slide the text slightly higher to make way for descenders on g
fudge=0.8; //[-2:.01:2]

/* [Hidden] */
$fn=32;
//$fa=4;
//$fs=0.4;
small=0.02;

// x and y are flipped here on purpose because of the way the cubes were drawn
scale1X=size*2/image1Ysize;
scale1Y=size*numRows/image1Xsize;
scale1=min(scale1X,scale1Y);




module hinge()
{
    dia=size*ratio_hinge_dia;
    wid=size*ratio_hinge_wid;
    
    translate([-dia/2-gap,dia/2-small,(size-wid)/2+gap])
    cylinder(d=dia, h=wid);
    
    translate([ dia/2+gap,dia/2-small,(size-wid)/2+gap])
    cylinder(d=dia, h=wid);
    
    translate([-(2*gap+dia)/2,-small,(size-wid)/2+gap])
    cube([2*gap+dia,dia,wid]);
}
//!hinge();

module hingePin(adj=0)
{
    dia=size*ratio_hinge_dia*.9-2*adj;
    
    translate([0,0,-small])
    cylinder(d1=dia,d2=1.2,h=dia/2+small);
}
//!hingePin();
module fullHinge()
{
    dia=size*ratio_hinge_dia;
    wid=size*ratio_hinge_wid;
    difference()
    {
        
        
        hinge();
     
        translate([dia/2+gap/2,dia/2-small,(size-wid)/2+gap])
        hingePin();
        
        translate([-(dia/2+gap/2),dia/2-small,(size-wid)/2+gap])
        hingePin();
        
        translate([dia/2+gap/2,dia/2-small,wid+(size-wid)/2+gap])
        mirror([0,0,1])
        hingePin();
        
        translate([-(dia/2+gap/2),dia/2-small,wid+(size-wid)/2+gap])
        mirror([0,0,1])
        hingePin();
        
    }
}
//!fullHinge();
module hingeGap()
{
    dia=size*ratio_hinge_dia;
    wid=size*ratio_hinge_wid;
    
    difference()
    {
        translate([-(2*dia+4*gap)/2,-2*small,(size-wid)/2])
        cube([2*dia+4*gap,dia+gap+2*small,wid+2*gap]);
        
        //now the cones for the pins
        translate([dia/2+gap/2,dia/2-small,(size-wid)/2-2*small])
        hingePin();
        
        translate([-(dia/2+gap/2),dia/2-small,(size-wid)/2-2*small])
        hingePin();
        
        translate([dia/2+gap/2,dia/2-small,wid+(size-wid)/2+2*gap+2*small])
        mirror([0,0,1])
        hingePin();
        
        translate([-(dia/2+gap/2),dia/2-small,wid+(size-wid)/2+2*gap+2*small])
        mirror([0,0,1])
        hingePin();
        
    }
    translate([0,-2*small,(size+2*small)/2-small])
    rotate([0,0,45])
    cube([dia/2,dia/2,size+2*small],center=true);
    /*
    difference()
    {
    
        translate([-dia/2,-2*small,0+small])
        cube([dia,dia/2,size-2*small]);
        
        translate([dia/2-small,dia/2-small,0])
        cylinder(d=dia+gap/2+small, h=size);
        
        translate([-dia/2+small,dia/2-small,0])
        cylinder(d=dia+gap/2+small, h=size);
    }
    */
}
//!hingeGap();
module doCubes(num)
{
    for (i=[0:num-1])
    {
        translate([gap/2,i*size,0])
        cube([size-1*gap,size-1*gap,size-0*gap]);

        translate([-size+gap/2,i*size,0])
        cube([size-1*gap,size-1*gap,size-0*gap]);
    }
}
//!doCubes(4);
module doText3()
{
    translate([0,0,+.1])
    linear_extrude(height=2)
    text(text=text3, size=text3Size, halign="center",valign="center");
}
//!doText3();
module doText4()
{
    translate([-size/2,0,+.1])
    linear_extrude(height=2)
    text(text=text4, size=text4Size, halign="center",valign="center");
}
//!doText4();
module doText5()
{
    translate([-size/2,0,+.1])
    linear_extrude(height=2)
    text(text=text5, size=text5Size, halign="center",valign="center");
}
//!doText5();
module doText()
{
    
    translate([size-2,size*numRows/2+fudge, size/2])
    rotate([90,0,90])
    linear_extrude(height=2)
    text(text=text1, size=text1Size, halign="center",valign="center");
    
    translate([-(size-2),size*numRows/2+fudge, size/2])
    rotate([90,0,-90])
    linear_extrude(height=2)
    text(text=text2, size=text2Size, halign="center",valign="center");
    
    if (len(text3)>0)
    {
        yOffset3=[1,0,0,1];
        zOffset3=[-1,2,-1,2];
        upDown3=[0,1,1,0];
        leftRight3=[1,1,-1,-1];
        for (i=[0:1])
        {
            translate([-small,size*(0.5+yOffset3[i]),(zOffset3[i])*size])
            rotate([180*upDown3[i],0,0])
            rotate([0,leftRight3[i]*90,0])
                translate([-size*(i+1.15),0,0])
                mirror([0,0,1])
                doText3();
        }
        if (len(text4)>0)
        {
        for (i=[0:1])
        {
            translate([-small,size*(0.5+yOffset3[i+2]),(zOffset3[i+2])*size])
            rotate([180*upDown3[i+2],0,0])
            rotate([0,leftRight3[i+2]*90,0])
                translate([-size*(i+0.35),0,0])
                mirror([0,0,1])
                doText4();
        }
    }
    }   
   
    if (len(text5)>0)
    {
        yOffset5=[1,0,0,1];
        zOffset5=[-1,2,-1,2];
        upDown5=[0,1,1,0];
        leftRight5=[1,1,-1,-1];
        for (i=[0:1])
        {
            translate([-small,size*(0.5+yOffset5[i]+2),(zOffset5[i])*size])
            rotate([180*upDown5[i],0,0])
            rotate([0,leftRight5[i]*90,0])
                translate([-size*(i+0.35),0,0])
                mirror([0,0,1])
                doText5();
        }

    } 

}
//!doText();

module doImage()
{
        translate([image1TweakX,size*2+image1TweakY,size+.05])
        mirror([0,0,1])
        scale([scale1,scale1,image1Zscale])
        rotate([0,0,90])
        surface(file=image1File,center=true, convexity=5);
}
//!doImage();
if (image1 && testImage)
{
    difference()
    {
        doCubes(numRows);
        
        doImage();
        
        doText();

    }
} 
else
{
intersection()
    {
    difference()
    {
        union()
        {
            difference()
            {
                doCubes(numRows);
                
                //start on top
                translate([0,0,size])
                rotate([-90,0,0])
                hingeGap();
                
                //finish on top
                translate([0,(numRows-1)*size,size])
                rotate([-90,0,0])
                hingeGap();
                
                for (i=[1:numRows/2])
                {
                    //on bottom pair 1
                    translate([0,(i*2-1)*size,0])
                    rotate([90,0,90])
                    hingeGap();
                    
                    translate([0,(i*2-1)*size,0])
                    rotate([90,0,-90])
                    hingeGap();
                    
                }

                for (j=[1:(numRows-1)/2])
                {        
                    //on side pair 1
                    translate([size,j*2*size,0])
                    rotate([0,0,90])
                    hingeGap();
                    
                    translate([-size,j*2*size,0])
                    rotate([0,0,-90])
                    hingeGap();
                }

            }
           
        //start on top
            translate([0,0,size])
            rotate([-90,0,0])
            fullHinge();
            
            //finish on top
            translate([0,(numRows-1)*size,size])
            rotate([-90,0,0])
            fullHinge();
   
            for (i=[1:numRows/2])
            {
                //on bottom pair 1
                translate([0,(i*2-1)*size,0])
                rotate([90,0,90])
                fullHinge();
                
                translate([0,(i*2-1)*size,0])
                rotate([90,0,-90])
                fullHinge();
                
            }

            for (j=[1:(numRows-1)/2])
            {        
                //on side pair 1
                translate([size-.15,(j*2)*size,0])
                rotate([0,0,90])
                fullHinge();
                
                translate([-size+.15,(j*2)*size,0])
                rotate([0,0,-90])
                fullHinge();
            }
           
        }

        if (image1)
        {
            doImage();
        }
        doText();
        
    }
    translate([-100,0,0])
    cube([200,200,200]);
}
}
//translate([-5,small,small])cube([10,10,3]);