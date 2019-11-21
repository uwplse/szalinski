// Olimpics 2016
// By Magonegro JUL-2016
// Customizer for the Olympics 2016
// Just put them together... or use the customizer before...

// Outer radius of the spring. Determines the overall size:
RADIUS=10;
// Base and overall height. defaults to 5mm:
HEIGHT=6;
// Custom text in the platter:
TEXT="Rio 2016";
// Text size:
TEXTSIZE=10;
// Text height:
TEXTHEIGHT=2;
// To adjust X text pos :
XTEXTOFFSET=0;
// To adjust Y text pos :
YTEXTOFFSET=3;

// [hidden]
RADIUSOUT=1.2*RADIUS; // You can change the factor to a more robust circles here
RADIUSIN=RADIUSOUT*0.8;
SEPARATION=RADIUS/3.6;
SEP=RADIUS+SEPARATION+RADIUSOUT;
XSIZE=SEP*2+2*SEPARATION+2*RADIUS;
// Some calcs
WTH=(-RADIUSOUT*2-RADIUSIN)-(RADIUSOUT*2)-(-RADIUSOUT*2-RADIUSIN-HEIGHT)-(RADIUSOUT*2+RADIUSIN+HEIGHT)-HEIGHT*1.2;
WTI=(-RADIUSOUT*2-RADIUSIN)-(RADIUSOUT*2)-(-RADIUSOUT*2-RADIUSIN-HEIGHT)-(RADIUSOUT*2+RADIUSIN+HEIGHT)*1.2;

module washer(X,Y)
{
    translate([X,Y,0])
    difference()
    {
	cylinder(h=HEIGHT,r=RADIUSOUT,$fn=60);
	cylinder(h=HEIGHT,r=RADIUSIN,$fn=60);
    }
}

union()
{
    washer(0,0);
    washer(-RADIUS-SEPARATION,RADIUS+SEPARATION);
    washer(RADIUS+SEPARATION,RADIUS+SEPARATION);
    washer((RADIUS+SEPARATION)*2,0);
    washer((RADIUS+SEPARATION)*3,RADIUS+SEPARATION);
    translate([-SEP,-RADIUSOUT*2-RADIUSIN,0])
        cube([XSIZE,RADIUSOUT*2,HEIGHT]);
    // Teeth for the base
    translate([-SEP,-RADIUSOUT*2-RADIUSIN-HEIGHT,0])
        cube([XSIZE/5,HEIGHT,HEIGHT]);
    translate([-SEP+(XSIZE/5)*2,-RADIUSOUT*2-RADIUSIN-HEIGHT,0])
        cube([XSIZE/5,HEIGHT,HEIGHT]);
    translate([-SEP+(XSIZE/5)*4,-RADIUSOUT*2-RADIUSIN-HEIGHT,0])
        cube([XSIZE/5,HEIGHT,HEIGHT]);
    // HERE comes the base
    difference()
    {
    translate([-SEP,WTH-2,0])
        cube([XSIZE,RADIUSOUT*2,HEIGHT]);
        union()
        {
        translate([-SEP,WTI+(RADIUSOUT*2)/1.5,0])
            rotate([90,0,0])
                cube([XSIZE/5+0.3,HEIGHT,HEIGHT+0.3]);
        translate([-SEP+(XSIZE/5)*2-0.3,WTI+(RADIUSOUT*2)/1.5,0])
            rotate([90,0,0])
                cube([XSIZE/5+0.6,HEIGHT,HEIGHT+0.3]);
        translate([-SEP+(XSIZE/5)*4-0.3,WTI+(RADIUSOUT*2)/1.5,0])
            rotate([90,0,0])
                cube([XSIZE/5+0.3,HEIGHT,HEIGHT+0.3]);
        }
    }
    
    translate([-SEP+TEXTSIZE/2+XTEXTOFFSET,-RADIUSOUT*2-YTEXTOFFSET,HEIGHT]) linear_extrude(height = TEXTHEIGHT, convexity = 10)
    // Put your text preferences here acording to your system
        text(TEXT, font = "Arial:style=Black",size=TEXTSIZE);
}