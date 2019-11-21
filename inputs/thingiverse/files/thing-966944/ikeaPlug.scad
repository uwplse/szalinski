$fn = 100;

$baseHeight = 12;
$baseRadius = 2.4;
$coneDimension = 3;
$topHeight = 10;
spacing = 2 * ($baseRadius + $coneDimension) + 1;
$amount = 10;

module cone(){
    union(){
        cylinder(r = $baseRadius, h = $topHeight);
        translate([0,0,$topHeight]){
            cylinder(r1 = $baseRadius, r2 = $baseRadius + $coneDimension, h = $coneDimension);
            translate([0,0,$coneDimension]){
                cylinder(r = $baseRadius, h = $baseHeight);
            }
        }
    }
}

module array(x){
    dimension = ceil(sqrt(x));
    for(i = [0:dimension - 1]){
        for(j = [0:dimension - 1]){
            if(dimension * i + j < x){
                translate([i * spacing, j * spacing, 0]){
                    cone();
                }
            }
        }
    }
}

array($amount);