//Title: Cabochon Template and Dop Stick Mount
//Author: Alex English - ProtoParadigm
//Date: 8/5/16
//License: Creative Commons - Share Alike - Attribution

//Notes: This is intended to be used as a printed dop stick for cutting and finishing cabochons. The base forms a template that can be used as a guide for shaping rounds and ovals in any size.


IN=25.4*1; //multiplication by 1 to prevent customizer from presenting this as a configurable value

//Diameter of the shaft of the dop stick (inches)
dop_stick_diameter = 0.5;
dop_stick_d = dop_stick_diameter*IN;

//Length of the dop stick (if enabled) (inches)
length=3;
l=length*IN;

//Height of the template (the length of the taper) (inches) - Only change if there is a problem
height=0.5;
h=height*IN;

//Enable or disable the texture on the template surface
texture=1; //[1:Enable,0:Disable]

//Enable or disable printing the dop stick - if disabled, a socket will be printed for a dowel to be inserted
stick=1; //[1:Enable,0:Disable]

//Enable or disable a notch on the end of the dop stick for indexing in a holder - only used if the stick is enabled
notch=0; //[1:Enable,0:Disable]

//Round or Oval
shape="oval";//["round":Round,"oval":Oval]

//Major Diameter
major=30;

//Minor Diameter (set smaller than major) (not used for rounds)
minor=22;

template_thick = 3*1; //not intended to be configurable - the thickness of the template

wall=3*1; //not intended to be configurable - the extra width at the socket for the template that the stick can be inserted into

hole_d=1.5*1;//not intended to be configurable - the size of the holes that make up the texture on the bottom surface

module cab_oval(a, b)
{
    scale([1, min(a,b)/max(a,b), 1]) cylinder(d=max(a,b),h=template_thick, $fn=180);
    translate([0, 0, -0.3]) scale([0.97, 0.97, 1]) scale([1, min(a,b)/max(a,b), 1]) cylinder(d=max(a,b),h=template_thick, $fn=180);
}

module cab_round(a)
{
    cab_oval(a, a);
}

//acceptable types are "round","oval"
//round must have two dimensions passed, the larger will be used
module template(type,a,b)
{
    difference()
    {
        hull()
        {
            cylinder(d=wall*2+dop_stick_d, h=h, $fn=6);
            if(type=="oval")
                cab_oval(a, b);
            else if(type=="round")
                cab_round(a);
        }
     if(texture) for(x=[-b/2:hole_d*2:b/2]) for(y=[-a/2:hole_d*2:a/2]) translate([x+hole_d/2, y+hole_d/2, -0.4]) cylinder(d=hole_d, h=0.7, $fn=6);
     }
 }
 
module template_mount(type, a, b)
{
    difference()
    {
        template(type, a, b);
        translate([0, 0, wall]) cylinder(d=dop_stick_d, h=h-wall+1, $fn=32);
    }       
}

module template_with_stick(type, a, b)
{
    template(type, a, b);
    difference()
    {
        translate([0, 0, wall]) cylinder(d=dop_stick_d, h=l-wall, $fn=36);
        if(notch) { translate([-dop_stick_d/2-1, -3/2, -3+l]) cube([dop_stick_d+2, 3, 3+1]); }
    }
}

if(stick) { template_with_stick(shape,major,minor); }
else { template_mount(shape, major, minor); }