include <write/Write.scad>
//Input your label here
text="Thingie";
font = "write/braille.dxf"; //["write/Letters.dxf":Basic, "write/braille.dxf":Braille, "write/BlackRose.dxf":BlackRose]
//Length of the case's outside
length=160; //[160,200]
//Height of the case's outside
height=11; //[11,16]
//Width of the case's outside
width=28; //[38, 28, 16]

// preview[view:south,tilt:top]

union(){

difference()
{
    translate ([0,0,height/2])
    cube ([length,width,height],center=true);
    
    translate ([4,0,height/2])
    #cube ([length,width-4,height-4],center=true);
}

if (width == 38)
{
    writecube(text,[0,0,height],0,face="top",h=18,t=5);
}

if (width == 28)
{
    writecube(text,[0,0,height],0,face="top",h=14,t=5);
}

if (width == 16)
{

if (font == "write/Letters.dxf")
{
    writecube(text,[0,width/32,height],0,face="top",h=10,t=5);
}

else
{
    writecube(text,[0,width/8,height],0,face="top",h=10,t=5);

}
}
}