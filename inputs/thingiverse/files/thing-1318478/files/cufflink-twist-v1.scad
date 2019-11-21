// Cufflink with twist-latch v1.0
// -------------------------------
// Designed by Assaf Sternberg 2/4/2016
// License: Creative Commons 4.0 (Attribution)
// http://creativecommons.org/licenses/by/4.0/legalcode


// set to false to hide component
showtop=true;
showstem=true;
showbottom=true;

// parameters
toptext="A.S";
side1text="A.S";
side2text="A.S";
bottomheight = 4;
bottomradius=5.65;
stemlength=12;
stemradius=2;
holeradius =stemradius+0.15; // hole is slightly larger than stem to allow for turning
topx=7.5;
toplengthy=20;
notchlength = 4;
topz=7.5;
textdepth=2.5;

distancebetweenparts=15;
$fn=100;

//Implementation

module bottom()
{
    translate([0,0,bottomheight/2])
    difference(){
        cylinder(h=bottomheight, r1=bottomradius, r2=bottomradius, center=true);        
        cylinder(h=bottomheight, r1=holeradius, r2=holeradius, center=true);
        translate([-1,0,-bottomheight/2])
        cube([2.1,notchlength*1.05,bottomheight]);
        translate([0,0,bottomheight/2-0.7])
        cylinder(h=1.5,r1=notchlength*1.05, r2=notchlength*1.05,center=true);   }
}
module topwithstem(){
    
    translate([0,0,-bottomheight/2])
    union()
    {
            

        difference(){
         translate([0,0,bottomheight/2+topz/2])
         minkowski()
        {
            cube([topx,toplengthy,topz],center=true);
            cylinder(h = 1, r1 = 1, r2 = 1, center = true);
        }

        translate([0,0,bottomheight+topz-textdepth/2])
        linear_extrude(height = textdepth, center = true, convexity = 10)
        rotate([0,0,90])
           text(toptext,size=4.8,halign="center",valign="center");

        translate([topx/2+1,0,bottomheight/2+topz/2])
        rotate([90,180,90])
        linear_extrude(height = textdepth, center = true, convexity = 10)
        rotate([180,180,0]) // mirror
           text(side1text,size=4.8,halign="center",valign="center");


        translate([-(topx/2+1),0,bottomheight/2+topz/2])
        rotate([90,180,90])
        linear_extrude(height = textdepth, center = true, convexity = 10)
        rotate([180,0,0]) // mirror
           text(side2text,size=4.8,halign="center",valign="center");

         }


         }

            if (showstem){
            translate([0,0,-stemlength])         
            union()
            {
                translate([0,0,stemlength/2])
                    stem(stemlength,stemradius);
                translate([-1,0,0])
                    cube([2,notchlength,2]);
            }
    }
}

module stem(stemlength,stemradius)
{
    cylinder(h=stemlength, r1=stemradius,r2=stemradius,center=true);
}



if (showtop)
{
    translate([distancebetweenparts,0,-topz-1/2])
    topwithstem();
}
if (showbottom)
{
    rotate([0,180,0])
    bottom();
}

