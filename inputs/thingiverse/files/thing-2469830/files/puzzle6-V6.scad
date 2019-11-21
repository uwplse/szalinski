// [What to Print]
WhatToPrint=7; // [0:All 6, 1,2,3,4,5,6, 7:Test Fit just 2 pieces]

//[Dimensions]
// the overall size. The square area available to write on
X=30; //[10:50]
// The size of the tabs that fit together (also overall thickness)
Y=5; // [1:10]
// The gap so that pieces will fit together, this depends on the printer
gap=0.4; // [0.00:0:05:1.00]

//[Text]
// You can use Help menu Font List to see what is available
// the word "style" is case sensitive, the other words are not
// whitespace does not seem to matter
font="Caladea:style= bold";

// These do not have to be single letters, you can print words, 
// but then you have to reduce the font size so that they fit
text1="I";
text1_size=20;
text2="D";
text2_size=20;
text3="I";
text3_size=20;
text4="G";
text4_size=20;
text5="3";
text5_size=20;
text6="D";
text6_size=20;

//[Hidden]
$fn=25;
small=0.01;
K1=(X+2*Y)/8;
K2=(X+2*Y)*2/8;
K3=(X+2*Y)*3/8;

module piece()
{
    cube([X+2*Y, X+2*Y,Y]);
}

module nibble(len, in=true)
{
    y=Y+2*small; // small to make sure the piece to cutout is slightly larger than what we are cutting
    
    translate([len/2,y/2-small,y/2-small])
    cube([len,y,y],center=true);


}
//!nibble(10,false);

module edge(s1,p1,s2,p2=10,s3=10, p3=10, s4=10)
{
    translate([-2,0,0])
    nibble(s1+2);
    translate([s1+p1,0,0])
    nibble(s2);
    translate([s1+p1+s2+p2,0,0])
    nibble(s3);
    translate([s1+p1+s2+p2+s3+p3,0,0])
    nibble(s4);
}
//!edge();
module matchingEdge(s1,p1,s2,p2=10,s3=10,p3=10,s4=10)
{
    s4=p3;
    p3=s3;
    s3=p2;
    p2=s2;
    s2=p1;
    p1=s1;
    s1=0;
    translate([-2,0,0])
    nibble(s1+2,false);
    translate([s1+p1,0,0])
    nibble(s2,false);
    translate([s1+p1+s2+p2,0,0])
    nibble(s3,false);
    translate([s1+p1+s2+p2+s3+p3,0,0])
    nibble(s4,false);
}

module piece1()
{ //A
        
    translate([Y+X/2, Y+X/2, Y-1])
    linear_extrude(height=2)
    text(text=text1, size=text1_size,halign="center", valign="center", font=font);
    difference()
    {
        piece();
        
        edge(K3,K2,K3+2);
        
        translate([0,Y+X,0])
        edge(K2,K2,K1,K1,K2+2);
        
        translate([Y,0,0])
        rotate([0,0,90])
        edge(K2,K1,K2,K1,K2+2);
        
        translate([2*Y+X,0,0])
        rotate([0,0,90])
        edge(K3,K2,K3+2);
    }
}

module piece1_test()
{
    
    translate([Y+X/2, Y+X/2, Y-1])
    linear_extrude(height=2)
    text(text=text2, size=text2_size,halign="center", valign="center", font=font);
    difference()
    {
        piece();

        matchingEdge(K2,K2,K1,K1,K2+2);
        
        translate([0,Y+X,0])
        matchingEdge(K3,K2,K3+2);
        
        translate([Y,0,0])
        rotate([0,0,90])
        matchingEdge(K2,K1,K2,K1,K2+2);
        
        
        translate([2*Y+X,0,0])
        rotate([0,0,90])
        matchingEdge(K3,K2,K3+2);
    }
}
module piece2()
{ //P
    translate([Y+X/2, Y+X/2, Y-1])
    linear_extrude(height=2)
    text(text=text2, size=text2_size,halign="center", valign="center", font=font);
    difference()
    {
        piece();
        
        
        edge(K2,K1,K2,K1,K2+2);
        
        translate([0,Y+X,0])
        matchingEdge(K3,K2,K3+2);
        
        translate([Y,0,0])
        rotate([0,0,90])
        edge(K2,K2,K1,K1,K2+2);
        
        translate([2*Y+X,0,0])
        rotate([0,0,90])
        edge(K3,K2,K2,K1+2);
    }
}
module piece3()
{ //E
        
    translate([Y+X/2, Y+X/2, Y-1])
    linear_extrude(height=2)
    text(text=text3, size=text3_size,halign="center", valign="center", font=font);
    
    difference()
    {
        piece();
        edge(K1,K2,K2,K1,K1+2);
        
        translate([0,Y+X,0])
        matchingEdge(K3,K2,K3+2);
        
        translate([Y,0,0])
        rotate([0,0,90])
        matchingEdge(K3,K2,K2,K1+2);
        
        translate([2*Y+X,0,0])
        rotate([0,0,90])
        edge(K1,K1,K1,K1,K1,K1,K2+2);
    }
}

module piece4()
{ //G
        
    translate([Y+X/2, Y+X/2, Y-1])
    linear_extrude(height=2)
    text(text=text4, size=text4_size,halign="center", valign="center", font=font);

    difference()
    {
        piece();
        
        edge(0,K3,K2,K3,K1,K2+2);
        
        translate([0,Y+X,0])
        matchingEdge(K2,K1,K1,K2,K1,K2+2);
        
        translate([Y,0,0])
        rotate([0,0,90])
        matchingEdge(K1,K1,K1,K1,K1,K1,K2+2);
        
        translate([2*Y+X,0,0])
        rotate([0,0,90])
        edge(0,K1,K1,K1,K2,K2,K1+2);
    }
}

module piece5()
{ //g
        
    translate([Y+X/2, Y+X/2, Y-1])
    linear_extrude(height=2)
    text(text=text5, size=text5_size,halign="center", valign="center", font=font);

    difference()
    {
        piece();
        
        edge(K3,K1,K1,K1,K1,K1+2);
        
        translate([0,Y+X,0])
        matchingEdge(K2,K1,K2,K1,K2+2);
        
        translate([Y,0,0])
        rotate([0,0,90])
        matchingEdge(0,K1,K1,K1,K2,K2,K1+2);
        
        translate([2*Y+X,0,0])
        rotate([0,0,90])
        matchingEdge(K2,K2,K1,K1,K2+2);
    }
}

module piece6()
{ //a
        
    translate([Y+X/2, Y+X/2, Y-1])
    linear_extrude(height=2)
    text(text=text6, size=text6_size,halign="center", valign="center", font=font);

    difference()
    {
        piece();
        
        matchingEdge(0,K3,K2,K3,K1,K2+2);
        
        translate([0,Y+X,0])
        matchingEdge(K2,K1,K2,K1,K2+2);
        
        translate([Y,0,0])
        rotate([0,0,90])
        matchingEdge(K3,K1,K1,K1,K1,K1+2);
        
        translate([2*Y+X,0,0])
        rotate([0,0,90])
        matchingEdge(0,K1,K1,K1,K2,K2,K1+2);
    }
}

if ((WhatToPrint==0) || (WhatToPrint==1) || (WhatToPrint==7))
piece1();

if ((WhatToPrint==7))
translate([0,-X-3*Y,0])
piece1_test();


if ((WhatToPrint==0) || (WhatToPrint==2))
translate([0,1*(-X-3*Y),0])
piece2();

if ((WhatToPrint==0) || (WhatToPrint==3))
translate([0,2*(-X-3*Y),0])
piece3();

if ((WhatToPrint==0) || (WhatToPrint==4))
translate([X+3*Y,0,0])
piece4();

if ((WhatToPrint==0) || (WhatToPrint==5))
translate([X+3*Y,1*(-X-3*Y),0])
piece5();

if ((WhatToPrint==0) || (WhatToPrint==6))
translate([X+3*Y,2*(-X-3*Y),0])
piece6();