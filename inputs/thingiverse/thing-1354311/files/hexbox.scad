$border=1.2;
$knick_height = 50;
$knick_count = 4;
$bottom_height = 1;

difference(){
    union(){
        
        cylinder(r=80, h=1, $fn=6, center=true);
        
        for ( layer = [1:$knick_count]) {
            hull(){
                translate([0,0, $bottom_height + (layer-1)*$knick_height ]) 
                rotate([0, 0, 90/$knick_count * (layer-1) ]) 
                cylinder(r=80, h=2, $fn=6, center=true);
                
                translate([0, 0, $bottom_height + (layer)*$knick_height ]) 
                rotate([0,0,90/$knick_count * layer ]) 
                cylinder(r=80, h=2, $fn=6, center=true);             
            }
        }
    }// union
   
    union(){
        for ( layer = [1:$knick_count]) {
            hull(){
                translate([0,0, $bottom_height + (layer-1)*$knick_height ]) 
                rotate([0, 0, 90/$knick_count * (layer-1) ]) 
                cylinder(r=80-$border, h=2, $fn=6, center=true);
                
                translate([0, 0, $bottom_height + 0.1 + (layer)*$knick_height ]) 
                rotate([0,0,90/$knick_count * layer ]) 
                cylinder(r=80-$border, h=2, $fn=6, center=true);             
            }
        }
    } // union
} // difference
    