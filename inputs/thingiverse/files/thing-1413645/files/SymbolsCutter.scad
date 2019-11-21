// The symbol to make a cookie cutter. 
// You can copy/paste from a text editor. Any symbol from the font allowed (e.g. "∫∞∑Ω℮π→")
text="π";
// Put 1 if you want to have supporting lines for the inner holes.
// It is necessary for symbols like 'o', 'a'. Symbols without inner holes don't need it ('s', 't',...)
lines=0;
// Angle of the supporting lines
lines_angle=45;

// The font you want to use. You can change style like that: "Times New Roman:style=Bold". There are a lot of fancy symbols in the "Symbol" font.
font = "Times New Roman";

// The letter size. If you have a problem cutting dough, use larger font.
letter_size = 48;

module solid()
mirror([1,0,0])
linear_extrude(height = 5, convexity = 10) {
projection(cut=false) 
letter(text);
}

$fn=16;

module letter(l) {
    linear_extrude(height = 1, convexity = 10) {
   
        text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 32);
    }
}

module OuterShape()
        minkowski()
        {
            solid();
            cylinder(d=2, h=8);
        }


module Cutter()
difference()
{
    union()
    {
        OuterShape();
        intersection()
        {
            scale([500,500,4])
            cube(1, center=true);
            
            minkowski()
            {
                solid();
                //sphere(1);
                cylinder(d=10, h=2);
            }
        }    
    }
    translate([0,0,-5])
    scale([1,1,20])
    solid();
}

module Lines()
{
    intersection()
    {
        rotate([0,0,lines_angle])
        for(i=[-50:15:50])
        translate([-200,i,0])
        scale([400,3,2])
        cube(1);
        
        OuterShape();
    }
}

if(lines==1)
{
    Lines();
}
Cutter();

