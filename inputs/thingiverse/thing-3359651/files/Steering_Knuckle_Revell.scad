$fn=24;

$CONNECTOR_LENGTH=26.8;
$CONNECTOR_DIAMETER=3.7;
$MIDDLE_DIAMETER=6.9;
$MIDDLE_LENGTH=8.8;
$PLATE_HEIGHT=1.8;
$PLATE_LENGTH=17.15;
$PIN_DIAMETER=2.9;
$PIN_LENGTH=8.73;
$HOLE_DIAMETER=2.2;

difference(){
    union(){
        cylinder($CONNECTOR_LENGTH, $CONNECTOR_DIAMETER/2, $CONNECTOR_DIAMETER/2, center=true);
        cylinder($MIDDLE_LENGTH, $MIDDLE_DIAMETER/2, $MIDDLE_DIAMETER/2, center=true);

        translate([0,0,-($MIDDLE_LENGTH - $MIDDLE_DIAMETER)/2]){
            rotate([90,0,0]){
                cylinder($MIDDLE_LENGTH, $MIDDLE_DIAMETER/2, $MIDDLE_DIAMETER/2, center=true);   
            }
        }
    }
    translate([0,0,-($MIDDLE_LENGTH - $MIDDLE_DIAMETER)/2]){
        rotate([90,0,0]){
            cylinder($MIDDLE_LENGTH, $HOLE_DIAMETER/2, $HOLE_DIAMETER/2, center=true);
        }
    }
}

translate([0,0,$MIDDLE_DIAMETER/2 - $PLATE_HEIGHT/2]){
    hull(){
        cylinder($PLATE_HEIGHT, $MIDDLE_DIAMETER/2, $MIDDLE_DIAMETER/2, center=true);
        translate([$PLATE_LENGTH - $MIDDLE_DIAMETER,0,0])
            cylinder($PLATE_HEIGHT, $MIDDLE_DIAMETER/2, $MIDDLE_DIAMETER/2, center=true);
    }
}

translate([$PLATE_LENGTH-$MIDDLE_DIAMETER ,0,-$PLATE_HEIGHT/2])
    cylinder($PIN_LENGTH, $PIN_DIAMETER/2, $PIN_DIAMETER/2, center=true);