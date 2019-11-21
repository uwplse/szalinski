// Twist box
/* [ Global ] */

// Wall Thickness
wallthickness=3;

// Base Thickness
basethickness=3;

// Diameter
diameter=40;

// Height
height=50;

// Margin / clearance
margin=0.5;

// Sides to print
sides=0; // [0:all,1:A,2:B]

// Initials to embed in ends
initials="";

// Steps
$fn=100;

if(sides!=1)
{
    difference()
    {
        twists(0);
        translate([0,0,-0.01])
        linear_extrude(height=1)
        
        mirror([-1,0])
        text(initials,valign="center",halign="center");

        //scale(diameter/8.5)
        //translate([-3,-2.15,0])
        //import("../DXF/charmed.dxf");
    }
}

if(sides!=2)
{
    translate([sides?0:diameter*1.1,0,0])
    difference()
    {
        twists(1);
        translate([0,0,-0.01])
        linear_extrude(height=1)
        mirror([-1,0])
        text(initials,valign="center",halign="center");
    }
}

// A&A logo - Trademark and Copyright 2013 Andrews & Arnold Ltd
module aa(w=100,white=0,$fn=100)
{   // w is the 100%, centre line of outer ring, so overall size (white=0) if 1.005 times that
    scale(w/100)
    {
        if(!white)difference()
        {
            circle(d=100.5);
            circle(d=99.5);
        }
        difference()
        {
            if(white)circle(d=100);
            difference()
            {
                circle(d=92);
                for(m=[0,1])
                mirror([m,0,0])
                {
                    difference()
                    {
                        translate([24,0,0])
                        circle(r=22.5);
                        translate([24,0,0])
                        circle(r=15);
                    }
                    polygon([[1.5,22],[9,22],[9,-18.5],[1.5,-22]]);
                }
            }
        }
    }
}

module arc(a,d,w)
difference()
{
    circle(d=d);
    circle(d=d-w*2);
    translate([-d,0])
    square(diameter*2);
    rotate([0,0,180-a])
    translate([-d,0])
    square(d*2);
}

module twists(f)
{
    amargin=360*margin/PI/diameter;
    cylinder(d=diameter-wallthickness*2-margin*2,h=basethickness);
    linear_extrude(height=basethickness+1)
    aa(w=(diameter-wallthickness*4-margin*4)/1.1,white=1);
    twist(f,basethickness,diameter,wallthickness+margin*2,60-amargin);
    twist(f,height+margin,diameter,wallthickness,60-amargin);
    twist(f,height-basethickness-margin,diameter-margin,wallthickness*2+margin/2,5,0,20,wallthickness-margin/2);
    twist(f,height-basethickness-margin,diameter-wallthickness*2-margin*2,wallthickness,15,10);
}

module twist(f,h,d,w,s,o=0,s2=0,w2=0)
intersection()
{
    linear_extrude(height=height,twist=90*height/diameter)
    mirror([f,0,0])
    for(a=[0:120:359])
    rotate([0,0,a+o])
    if(w2)hull()
    {
        arc(s,d,w);
        arc(s2,d,w2);
    }else arc(s,d,w);
    translate([-diameter,-diameter,0])
    cube([diameter*2,diameter*2,h]);
}
