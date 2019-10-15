
$arm=60;
$crosspiece=40;
$width=16;

tinySquare($arm,$crosspiece,$width);

module tinySquare(arm,crosspiece,width){
union(){
cube([width,arm,3]);
translate([0,0,-3])cube([crosspiece,width,9]);
}
}