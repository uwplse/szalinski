// Number of batteries, not tested under 3
$num_bats = 3;

// Width of battery, or the "middle" of the three dimensions
$bat_width = 40;

// Height of the tallest part of the battery
$bat_height = 57;

// Thickness of thinest dimension
$bat_thick = 21;

// The "percent (0-1) of of the hight for the bottom (vs top)
$height_perc = .7;

// Outer wall thickness
$wall_thick = 1;

// Inner seperator thickness
$seperator_thick = 1;

$depth_total = ($wall_thick*2) + ($seperator_thick*($num_bats-1)) + ($bat_thick*$num_bats);
$width_total = ($wall_thick*2) + $bat_width;
$height_total = $wall_thick + ($bat_height*$height_perc);


difference(){
    cube([ $depth_total, $width_total, $height_total]);
    
    for( x=[0:$num_bats-1] ){
        echo(x);
        if( x == 0){
            translate( [$wall_thick,$wall_thick,$wall_thick]) {
                cube([ $bat_thick, $bat_width, $bat_height ]);
            }
        }else{
            translate( [$wall_thick+(($bat_thick+$seperator_thick)*x),
                        $wall_thick, $wall_thick]) {
                cube([ $bat_thick, $bat_width, $bat_height ]);
            }
        }
    }
}