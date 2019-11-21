SIZEX=135;
SIZEY=135;
PLATE_THICKNESS=1.5;
TEXT_THICKNESS=0.5;
CORNER_RADIUS=10;
OUTER_BORDER=1;
FRAME_WIDTH=3;
PLATE_ANGLE=45;

FONT_SIZE=19;
LINE_HEIGHT=24;
TEXT=["WATCH", "FOR", "DRUNKS"];

rotate(PLATE_ANGLE) {
    translate([-SIZEX/2, -SIZEY/2, -PLATE_THICKNESS]) {
        drawFrame();
        drawPlate();
    }
}
drawText();

module drawPlate() {
    roundedRect(SIZEX, SIZEY, CORNER_RADIUS, PLATE_THICKNESS);
}    

module drawFrame() {
    x=SIZEX-2*OUTER_BORDER;
    y=SIZEY-2*OUTER_BORDER;
    r=CORNER_RADIUS-OUTER_BORDER;
    
    color("DimGray") {
        translate([OUTER_BORDER, OUTER_BORDER, PLATE_THICKNESS]) {
            difference() {
                roundedRect(x, y, r, TEXT_THICKNESS);
                translate([FRAME_WIDTH, FRAME_WIDTH, -.5]) 
                    roundedRect(x-2*FRAME_WIDTH, y-2*FRAME_WIDTH, r-FRAME_WIDTH, TEXT_THICKNESS+1);
            }
        }
    }
}

module drawText() {
    translate([0, ((len(TEXT)-1)/2)*LINE_HEIGHT, 0]) {
        for(i=[0:len(TEXT)]) {
            translate([0,-i*LINE_HEIGHT, 0])
                textLine(TEXT[i]);
        }
    }
}

module textLine(str) {
    color("DimGray") {
        linear_extrude(TEXT_THICKNESS) {
            text(
                    str, 
                    valign="center", 
                    halign="center", 
                    font="Liberation Sans:style=Bold",
                    size=FONT_SIZE);
        }
    }
}

module roundedRect(a, b, r, h) {
    hull() {        
        translate([r, r, 0]) 
            cylinder(h=h, r=r);
        translate([a-r, r, 0]) 
            cylinder(h=h, r=r);
        translate([r, b-r, 0]) 
            cylinder(h=h, r=r);
        translate([a-r, b-r, 0]) 
            cylinder(h=h, r=r);
    }
}