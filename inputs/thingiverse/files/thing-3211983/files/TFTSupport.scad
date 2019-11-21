/* [ TFT Base Size] */
//Base Width
$display_w = 120;   
//Base Height
$display_h = 56;

/* [ TFT Screen Size] */
//TFT Width must be less than Width Hole
$TFT_w = 62; 
//TFT Height
$TFT_h = 36; 
//Thickness // Min 5
$TFT_thickness = 5; 

/* [ Holes Define ] */
//Width distance between Holes
$width_hole = 60; 
//Height distance between TFT Holes
$height_hole = 30;
//Height distance between External Holes
$height_outhole = 44;
//Distance from sides
$distance_outhole = 8; 
//Thickness holes distance 
$hole_thickness = 5;  

//Internal Metric Hole diameter
$m = 3;
//External Hole diameter
$extd = 5.4; 


/* [ Pin Holes ] */
//Left Pin Holes Distance from TFT
$pinLeft_d = 3.3; 
//Right Pin Holes Distance from TFT
$pinRight_d = 5.5; 
//Height Left Wire
$pinLeft_h = 13; 
//Height Right Wire
$pinRight_h = 40; 
//Thickness for Wire Holes
$pin_e = 3.5; 

/* [Hidden] */
$m3 = $m;
$fn=20;

//Height distance between TFT Holes
$hole_h = $height_hole;
//$hole_h = (($height_hole > $TFT_h)?($height_hole): ($TFT_h + $hole_extd));
//Height distance between External Holes
$hole_sh = $height_outhole;
//$hole_sh = (($height_outhole > $TFT_h)?($height_outhole): ($TFT_h + $hole_extd));
//Distance from sides
$hole_sd = ( $distance_outhole > ($display_w-$TFT_w)/2)? 4: $distance_outhole; 
//Thickness holes distance 
$hole_s = $hole_thickness ;  
$hole_extd = (($extd > $m)? $extd: $m + 2.4 ); 

$hole_w = (($width_hole > $TFT_w)?($width_hole): ($TFT_w + $hole_extd)); 

$base_h = (($display_h < $TFT_h)? ($TFT_h+20): $display_h);
$base_w = (($display_w < $TFT_w)?ceil((($TFT_w+2*$hole_sd+20)/8)*8):(ceil($display_w/8)*8));

$rm = 2;
$hm = 2*$rm;

$TFT_thick = ($TFT_thickness < 5)? 5:$TFT_thickness; 
$TFT_e  = $TFT_thick - $hm/2-$rm;
$hole_height = $hole_s+$TFT_e;

//Hole for support
$hole_sw = $base_w-2*$hole_sd;

//TFT Base
tftbase();

module tftbase(){
    difference (){
        pinbase();
    for(i = [ [  $hole_w/2,  $hole_h/2,   0],
           [ $hole_w/2, -$hole_h/2,0],
           [-$hole_w/2, $hole_h/2,  0],
           [ -$hole_w/2, -$hole_h/2,  0],
            [ $hole_sw/2,  $hole_sh/2,   0],
           [ $hole_sw/2, -$hole_sh/2,0],
           [-$hole_sw/2, $hole_sh/2,  0],
           [ -$hole_sw/2, -$hole_sh/2,  0] ])
{
    translate(i){
        translate([0,0,$hole_s/2+$TFT_thick])
        cylinder(h = $hole_height+2*$TFT_thick, d = $m3 , center = true );
    }
}
        }
}

module pinbase(){
    union(){
        
        tftpins();
        pinholes();
    }
}
module pinholes(){
for(i = [ [  $hole_w/2,  $hole_h/2,   0],
           [ $hole_w/2, -$hole_h/2,0],
           [-$hole_w/2, $hole_h/2,  0],
           [ -$hole_w/2, -$hole_h/2,  0],
            [ $hole_sw/2,  $hole_sh/2,   0],
           [ $hole_sw/2, -$hole_sh/2,0],
           [-$hole_sw/2, $hole_sh/2,  0],
           [ -$hole_sw/2, -$hole_sh/2,  0] ])
{
    translate(i){
        translate([0,0,$hole_s/2+$TFT_thick])
        cylinder(h = $hole_s, d = $hole_extd , center = true );
    }
}
}

//TFT with pins space
module tftpins(){
difference(){
    tftsupport();
    if($pinLeft_d != 0){
        translate([-$TFT_w/2-$pinLeft_d-$pin_e,-$pinLeft_h/2,0])
        cube(size = [$pin_e,$pinLeft_h,$hole_thickness ]);
    }
    if($pinRight_d != 0){
        translate([$TFT_w/2+$pinRight_d,-$pinRight_h/2,0])
        cube(size = [$pin_e,$pinRight_h,$hole_thickness ]);
    }
}
}
module tftsupport(){
difference(){
    translate([0,0,$TFT_e/2])
    cubekowski();
    translate([0,0,$TFT_thick/2])
    cube(size = [$TFT_w,$TFT_h,$TFT_thick], center = true);
}
}
module cubekowski(){
    minkowski()
    {
      cube(size = [$base_w-2*$rm,$base_h-2*$rm,$TFT_e], center = true);
      rcylinder(r=$rm,h=$hm);
    }
}


module rcylinder(r = 4, 
                 h = 20, 
                 center = false, 
                 both = false, $fn = 30)
{

  hc = (both == true) ? h - 2 * r : h - r;
  posc = (center == true) ? 0 : h/2;
  
  translate([0, 0, posc]) 
  
    if (both == true) {
      cylinder(r = r, h = hc, center = true, $fn = $fn);
      for (i = [-1, 1])
        translate([0, 0, i * hc / 2])
          sphere(r = r);
          
    }
    else
      translate([0, 0, -h/2]) {
      
        cylinder(r = r, h = hc, $fn = $fn);
          translate([0, 0, hc]) sphere(r = r, $fn = $fn);
      }
        
}