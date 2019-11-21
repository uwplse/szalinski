DIA_MIN = 15.5;
DIA_MAX = 24;
DIA_STEP = 0.5;

COLUMNS = 3;

HEIGHT = 3;

FONT="Ruler Stencil";
//FONT="Taurus Mono Stencil:style=Bold";
SPACE_X=2.5;
SPACE_Y=2.5;
$fn=128;
holes = (DIA_MAX-DIA_MIN) / DIA_STEP;
holes_row = ceil(holes/COLUMNS);
echo (holes, holes_row);

module template(dia) {
    difference(){
        square([DIA_MAX+SPACE_X, DIA_MAX+SPACE_Y+10]);
        union() {
            translate([(DIA_MAX+SPACE_X)/2, (DIA_MAX+SPACE_Y)/2]){
                circle(d=dia);
                translate([0,DIA_MAX/2+5]) {
                    text(str(dia), font=FONT, valign="center", halign="center", size=5);
                }
            }
        }
    }
}


linear_extrude(HEIGHT) {
    for (step=[0:holes]){
        yPos=floor(step/holes_row)*(DIA_MAX+SPACE_Y+10);
        translate([(step%6)*(DIA_MAX+SPACE_X),yPos,0]) {
            template(DIA_MIN+(step*DIA_STEP));
        }
    }
}