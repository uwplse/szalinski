// ----------------------
// Haptic slide rule V1.1
// ----------------------
//
// Fully parametric with 4 scales and three marker sizes
//
// CC-BY-SA 2019 Sebastian Ritterbusch for GJ50
//
// The scales are logarithmic, so that adding lengths result in multiplications
// on the haptic markers. When printed, slide the tongue inside the body so that 
// in landscape orientation the smaller markers on sides of body and tongue are both 
// on the left top side.
//
// Then the scale on top of the body is the A scale, then follows the B scale on top
// of the tongue, then the C scale is on bottom of the tongue, and the D scale is
// on bottom of the body.
// The A and B scales represent the numbers from 1 to 100, where 1 is represented by
// the smallest markers, 5 by middle markers and the 10 by the largest markers.
// Since the logarithmic scales gets denser at higher numbers the smallest scale only
// runs until 30, the 5er scale until 80.
// The C and D scales represent the numbers from 1 to 10, where the largest scale
// is represented by the largets markers, followed by 1/2 by middle markers and 
// 1/10 by the smallest markers.
//
// To multiply, shift the 1 of the tongue to the first multiplicator on the
// body. For example 2 on D scale, or 4 on A scale (which is the same position).
// If you want to multiply the 2 by 3 move your finger on the tongue to three on 
// the C scale (or, likewise 9 on B scale), and check on which number you end on the
// body scale. It should be 6 on D scale, since 2*3=6, or a bit above 35 on A scale
// as 4*9=36. 


// What objects to generate
//
// tongue: The tonngue is the middle part that is moving in the body
// body:   The body is holding the tongue
// slider: The slider is moving around the body and marks a position on the body or slider
//

/* [General] */

// What to generate
part="aside"; // [aside:All aside,body:Body only,tongue:Tongue only,slider:Slider only,arranged:All arranged]

// Total length of the body and tongue in Millimeters
length = 250;

// Width of the tongue in Millimeters
width = 15;

// Height of the tongue in Millimeters including haptic markers
// Must be significantly larger than the marker height to make sense
height = 3;

// Factor of body width to tongue width
// Must be at least 1.5 
bodywidthfactor=3;

bodywidth=bodywidthfactor*width;

// Factor of body height to tongue height
bodyheightfactor=1.5;

bodyheight=bodyheightfactor*height;

/* [Slider] */

// Width of the slider at sides and below in Millimeters
sliderwidth = 8;

// If a slider is to be printed, then the body needs slider rails on the sides
// leave this on "true", unless you do not need a slider
sliderrails=true;

// Width and height of slider rails
// Height must be equal or larger than highest haptic marker
railwidth = 0.5;
railheight = 1.5;

/* [Gaps] */

// Space left in gaps so objects are movable in Millimeters
space=0.375;

// Functions of marker positioning
// A simple ln(x)-function is the common C,D rail from 1 to 10
// A ln(10*x)-function is the common A,B rail from 1 to 100
function A(x) = ln(x*10);
function B(x) = ln(x*10);
function C(x) = ln(x);
function D(x) = ln(x);

/* [Scales] */

// Number of lines in rows A, B, C, D
// Usually 10
linesArray=[10,10,10,10];

// Until which line are the half dividers (0.5 or 5) drawn
// Usually 7 for A, B rail (1-100) and 10 for C, D rail (1-10)
// Mainly limited by what can be felt by the fingers
subcutoff=[7,7,10,10];

// Until which line are the 1:10 dividers (0.1 or 1) drawn
// Usually 2 for A, B rail (1-100), 4 for C, D rail (1-10)
// Mainly limited by what can be felt by the fingers
subsubcutoff=[2,2,4,4];

// Height of the major lines in Millimeters
// Be aware that this should be less than twice its width for stability
lineheight = 1.5;

// Width of the major lines in Millimeters
// Be aware that the higher the lines are, the thicker they have to be
linewidth  = 1;

// Length of the lines on the tongue in Millimeters
// If B,C scale is differing it will be half that size
// Body line length will be propotional to this size
// Standard is the width of the tongue
linelength = width;

// Number of middle sized lines per major line
// Standard is 2 for half lines (0.5 or 5)
sublines=2;

// Height of the middle sized "half" lines in Millimeters
// Be aware that this should be less than twice its width for stability
sublineheight=1.0;

// Width of the half lines in Millimeters
// Be aware that the higher the lines are, the thicker they have to be
sublinewidth=0.75;

// Length of the lines on the tongue in Millimeters
// If B,C scale is differing it will be half that size
// Body line length will be propotional to this size
// Standard is the 3/4 width of the tongue
sublinelength=width*0.75;

// Number of small lines per middle line
// Standard is 5 for 1:10 lines (0.1 or 1)
subsublines=5;

// Height of the small sized "half" lines in Millimeters
// Be aware that this should be less than twice its width for stability
subsublineheight=0.8;

// Width of the small lines in Millimeters
// Be aware that the higher the lines are, the thicker they have to be
subsublinewidth=0.5;

// Length of the lines on the tongue in Millimeters
// If B,C scale is differing it will be half that size
// Body line length will be propotional to this size
// Standard is the 1/2 width of the tongue
subsublinelength=width*0.5;

// Computed remaining height of tongue bottom box below the markers in Millimeters
boxheight = height-lineheight;

// Width of the wider bottom part of the tongue in Millimeters
// To have a model printable without support a 45° angle is
// achieved with the bottom being larger by boxheight on both sides
bottomwidth = width+boxheight*2;

// Computed line lenghts on body propotional to the line lengths on the tongue
bodylinelength=linelength/width*(bodywidth-width-2*space);
bodysublinelength=sublinelength/width*(bodywidth-width-2*space);
bodysubsublinelength=subsublinelength/width*(bodywidth-width-2*space);

/* [Colors] */

// Colors
bodycolor="gold";
tonguecolor="red";
slidercolor="silver";


/* [Hidden] */

body=(part=="body")||(part=="aside")||(part=="arranged");
tongue=(part=="tongue")||(part=="aside")||(part=="arranged");
slider=(part=="slider")||(part=="aside")||(part=="arranged");

// Shifts for composite images

shifttonguex=(part=="arranged")?(length-linewidth)*C(2)/C(linesArray[3]):0;
shifttonguey=(part=="aside")?width*3:0;

shiftbodyx=0;
shiftbodyy=0;

shiftsliderx=(part=="arranged")?(length-linewidth)*C(6)/C(linesArray[3]):0;
shiftslidery=(part=="aside")?-width*4:0;


// Draw bottom box for tongue
if(tongue)
{
    color(tonguecolor,1.0) translate([shifttonguex,shifttonguey,0])
    polyhedron(
        points=[[0,-(bottomwidth-width)/2,-space/2],[0,0,boxheight-space/2],[0,width,boxheight-space/2],[0,width+(bottomwidth-width)/2,-space/2],
                [length,-(bottomwidth-width)/2,0-space/2],[length,0,boxheight-space/2],[length,width,boxheight-space/2],[length,width+(bottomwidth-width)/2,-space/2]],
        faces=[[0,1,2,3],[0,3,7,4],[0,4,5,1],[1,5,6,2],[2,6,7,3],[4,7,6,5]]
    );
}

// Draw box for body 
if(body)
{
    color(bodycolor,1.0) translate([shiftbodyx,shiftbodyy,0])
    polyhedron(
            points=[[0,-(bodywidth-width)/2,-(bodyheight-height)],[0,-(bodywidth-width)/2,boxheight],[0,width+(bodywidth-width)/2,boxheight],[0,width+(bodywidth-width)/2,-(bodyheight-height)],
                    [0,-(bottomwidth-width)/2-space,-space],[0,-space,boxheight],[0,width+space,boxheight],[0,width+(bottomwidth-width)/2+space,-space],
                    [length,-(bodywidth-width)/2,-(bodyheight-height)],[length,-(bodywidth-width)/2,boxheight],[length,width+(bodywidth-width)/2,boxheight],[length,width+(bodywidth-width)/2,-(bodyheight-height)],
                    [length,-(bottomwidth-width)/2-space,-space],[length,-space,boxheight],[length,width+space,boxheight],[length,width+(bottomwidth-width)/2+space,-space]],
            faces=[[0,1,5,4,7,6,2,3],[0,3,11,8],[0,8,9,1],[1,9,13,5],[5,13,12,4],[4,12,15,7],[7,15,14,6],[6,14,10,2],[2,10,11,3],[8,11,10,14,15,12,13,9]]
        ); 
    
    if(sliderrails)
    {
        color(bodycolor,1.0) translate([shiftbodyx,shiftbodyy,0])
        translate([0, -(bodywidth-width)/2, boxheight])
        cube([length,railwidth,railheight], center = false);
        
        color(bodycolor,1.0) translate([shiftbodyx,shiftbodyy,0])
        translate([0, width+(bodywidth-width)/2-railwidth, boxheight])
        cube([length,railwidth,railheight], center = false);
    }
}

// Draw slider
if(slider)
{
    color(slidercolor,1.0) translate([shiftsliderx,shiftslidery,0])
    translate([0, -(bodywidth-width)/2-space-linewidth, height+space])
    cube([linewidth,bodywidth+space*2+linewidth*2,lineheight], center = false);
    
    color(slidercolor,1.0) translate([shiftsliderx,shiftslidery,0])
    translate([-(sliderwidth-linewidth)/2, -(bodywidth-width)/2-space-linewidth, -(bodyheight-height)-space-lineheight])
    cube([sliderwidth,bodywidth+space*2+linewidth*2,lineheight], center = false);
    
    color(slidercolor,1.0) translate([shiftsliderx,shiftslidery,0])
    translate([-(sliderwidth-linewidth)/2, -(bodywidth-width)/2-space-linewidth, -(bodyheight-height)-space-lineheight])
    cube([sliderwidth,linewidth,bodyheight+2*space+2*lineheight], center = false);
    
    color(slidercolor,1.0) translate([shiftsliderx,shiftslidery,0])
    translate([-(sliderwidth-linewidth)/2, width+(bodywidth-width)/2+space, -(bodyheight-height)-space-lineheight])
    cube([sliderwidth,linewidth,bodyheight+2*space+2*lineheight], center = false);
}

// Loop for A, B, C, D scales
for(line=[0:1:3])
{
    lines=linesArray[line];
    
    // Loop for major lines in scale
    for (i = [0:1:lines])
    {
        // Major lines on tongue
        if(tongue && i>0)
        {
            if(line==2)
            {
                color(tonguecolor,1.0) translate([shifttonguex,shifttonguey,0])
                translate([(length-linewidth)*C(i)/C(lines), 0, boxheight-space/2])
                cube([linewidth,linelength/2,lineheight], center = false);
            }
            
            if(line==1)
            {
                color(tonguecolor,1.0) translate([shifttonguex,shifttonguey,0])
                translate([(length-linewidth)*B(i)/B(lines), width-linelength/2, boxheight-space/2])
                cube([linewidth,linelength/2,lineheight], center = false);
            }
        } 
        
        // Major lines on body
        if(body && i>0)
        {
            if(line==3)
            {
                color(bodycolor,1.0) translate([shiftbodyx,shiftbodyy,0])
                translate([(length-linewidth)*D(i)/D(lines), -space-bodylinelength/2, boxheight])
                cube([linewidth,bodylinelength/2,lineheight], center = false);
            }
            
            if(line==0)
            {
                color(bodycolor,1.0) translate([shiftbodyx,shiftbodyy,0])
                translate([(length-linewidth)*A(i)/A(lines), width+space, boxheight])
                cube([linewidth,bodylinelength/2,lineheight], center = false);
            }
        } 

        if(i<lines) 
        {
            // Medium lines loop
            for (j = [0:1:sublines-1])
            {
                if(i<subcutoff[line])
                {
                    // Medium lines on tongue
                    if(tongue)
                    {
                        if(line==2 && C(i+j/sublines)>=0)
                        {
                            color(tonguecolor,1.0) translate([shifttonguex,shifttonguey,0])
                            translate([(length-linewidth)*C(i+j/sublines)/C(lines), 0, boxheight-space/2])
                            cube([sublinewidth,sublinelength/2,sublineheight], center = false);
                        }
                        
                        if(line==1 && B(i+j/sublines)>=0)
                        {
                            color(tonguecolor,1.0) translate([shifttonguex,shifttonguey,0])
                            translate([(length-linewidth)*B(i+j/sublines)/B(lines), width-sublinelength/2, boxheight-space/2])
                            cube([sublinewidth,sublinelength/2,sublineheight], center = false);
                        }
                    }
                    
                    // Medium lines on body
                    if(body)
                    {
                        if(line==3 && D(i+j/sublines)>=0)
                        {
                            color(bodycolor,1.0) translate([shiftbodyx,shiftbodyy,0])
                            translate([(length-linewidth)*D(i+j/sublines)/D(lines), -space-bodysublinelength/2, boxheight])
                            cube([sublinewidth,bodysublinelength/2,sublineheight], center = false);
                        }
                        
                        if(line==0 && A(i+j/sublines)>=0)
                        {
                            color(bodycolor,1.0) translate([shiftbodyx,shiftbodyy,0])
                            translate([(length-linewidth)*A(i+j/sublines)/A(lines), width+space, boxheight])
                            cube([sublinewidth,bodysublinelength/2,sublineheight], center = false);
                        }
                    }
                }
            }
            
            if(i<subsubcutoff[line])
            {
                for (j = [0:1:sublines-1])
                {
                    // Minor lines loop
                    for (k = [1:1:subsublines-1])
                    {
                        // Minor lines on tongue
                        if(tongue)
                        {
                            if(line==2 && C(i+(j+k/subsublines)/sublines)>=0)
                            {
                                color(tonguecolor,1.0) translate([shifttonguex,shifttonguey,0])
                                translate([(length-linewidth)*C(i+(j+k/subsublines)/sublines)/C(lines), 0, boxheight-space/2])
                                cube([subsublinewidth,subsublinelength/2,subsublineheight], center = false);
                            }
                        
                            if(line==1 && B(i+(j+k/subsublines)/sublines)>=0)
                            {
                                color(tonguecolor,1.0) translate([shifttonguex,shifttonguey,0])
                                translate([(length-linewidth)*B(i+(j+k/subsublines)/sublines)/B(lines), width-subsublinelength/2, boxheight-space/2])
                                cube([subsublinewidth,subsublinelength/2,subsublineheight], center = false);
                            }
                        }
                        
                        // Minor lines on body
                        if(body)
                        {
                            if(line==3 && D(i+(j+k/subsublines)/sublines)>=0)
                            {
                                color(bodycolor,1.0) translate([shiftbodyx,shiftbodyy,0])
                                translate([(length-linewidth)*D(i+(j+k/subsublines)/sublines)/D(lines), -space-bodysubsublinelength/2, boxheight])
                                cube([subsublinewidth,bodysubsublinelength/2,subsublineheight], center = false);
                            }
                        
                            if(line==0 && A(i+(j+k/subsublines)/sublines)>=0)
                            {
                                color(bodycolor,1.0) translate([shiftbodyx,shiftbodyy,0])
                                translate([(length-linewidth)*A(i+(j+k/subsublines)/sublines)/A(lines), width+space, boxheight])
                                cube([subsublinewidth,bodysubsublinelength/2,subsublineheight], center = false);
                            }
                        }
                    }
                }
            }
        }
    }
}
