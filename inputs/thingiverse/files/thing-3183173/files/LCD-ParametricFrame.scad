//LCD Rows
$lcd_rows =2; 
//LCD Height
$lcd_s = 4; 
//LCD Section
$lcd_section = 6; 
//Hole Height
$hole_h = 15; 
//Hole Screw
$hole_s = 3; 

/* [Hidden] */
$fn=60;
$radiuscorner = 3;

$lcd_w = (($lcd_rows == 2)? 75: 93);
$lcd_h = (($lcd_rows == 2)? 33: 55);

//Holes for screws distances
$width_holes = $lcd_w;
$height_holes = $lcd_h;
$w_holes = $width_holes/2;
$h_holes = $height_holes/2;

//Holes Dimensions
$hole_d = $hole_s+5;

module frameholes(){
difference(){

    framePoints();

    for(i = [ [  $w_holes, $h_holes, $lcd_section*2],
           [ -$w_holes, $h_holes, $lcd_section*2],
           [$w_holes, -$h_holes, $lcd_section*2],
           [ -$w_holes, -$h_holes, $lcd_section*2] ]){
   translate(i)
   cylinder(h = $hole_h+20, d = $hole_d - $hole_s , center = true );
}
}
}
    
    
module framePoints(){
    $zero_holes = $hole_h/2-$lcd_s;
union(){
    for(i = [ [  $w_holes, $h_holes, $zero_holes],
           [ -$w_holes, $h_holes, $zero_holes],
           [$w_holes, -$h_holes, $zero_holes],
           [ -$w_holes, -$h_holes, $zero_holes] ]){
   translate(i)
   cylinder(h = $hole_h, d = $hole_d , center = true);
    frame();
    }
    }
}


module frame(){
    minkowski(){
        difference() {
            cube([$lcd_w, $lcd_h, $lcd_s],center=true);
            cube([$lcd_w-$lcd_section, $lcd_h-$lcd_section, $lcd_s],center=true);
        }
           sphere(r=$radiuscorner,$fn=20);
    }
}


frameholes();
