// Olimpics 2016
// By Magonegro JUL-2016
// Customizer for the Olympics Rio2016 rotating logo

// Stake height
HEIGHT=30;
// Custom text in the platter:
TEXT="A";
// Text size:
TEXTSIZE=35;
// To adjust X text pos :
XTEXTOFFSET=3;
// To adjust Y text pos (assure text is attached to baseline):
YTEXTOFFSET=-1;

/// [hidden]
STAKE=5; // 5mm square stake fixed

union()
{
    translate([-STAKE/2,0,0]) cube([STAKE,HEIGHT,STAKE]);
    translate([-22,HEIGHT,0]) cube([44,STAKE,STAKE]);
    translate([XTEXTOFFSET-22,HEIGHT+STAKE+YTEXTOFFSET,0]) 
        linear_extrude(height = STAKE, convexity = 10)
        text(TEXT, font = "Arial:style=Black",size=TEXTSIZE);
}
