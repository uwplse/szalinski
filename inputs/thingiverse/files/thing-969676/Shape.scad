$fn = 3;

height = 70;
radius = 20;
layerHeight = 0.1;
layers = floor(height / layerHeight);
edges = 6;
modulo = 1;
endRotation = 135;

$rot3 = 0.5;
$rot2 = -0.5;
$rot1 = 0;
$rot0 = 0;

$diff3 = 0;
$diff2 = 0;
$diff1 = 1;
$diff0 = 0;

function diff(x) = $diff3 * x * x * x + $diff2 * x * x + $diff1 * x + $diff0; //2 * ( x - 1 / 2) * ( x - 1 / 2); //0.5 * (1 + 0.5 * cos(360 * (x - 1)));
function rot(x) = $rot3 * x * x * x + $rot2 * x * x + $rot1 * x + $rot0; //exp(ln(x) * 2);

module shape(){
    union(){
        for(i = [1:layers]){
            translate([0,0,(i - 1) * layerHeight]){
                rotate([0,0,rot(i / layers) * endRotation]){
                    for(j = [1:edges]){
                        if(j%modulo == 0){
                            linear_extrude(height = layerHeight){
                                polygon(points  =   [   [0, 0],
                                                        [radius * sin(j / edges * 360), radius * cos(j / edges * 360)],
                                                        [radius * sin((j + diff(i / layers))/ edges * 360), radius * cos((j + diff(i / layers)) / edges * 360)]
                                                    ],
                                        paths   =   [   [0, 1, 2]   ]);
                                polygon(points  =   [   [0, 0],
                                                        [radius * sin((j + diff(i / layers))/ edges * 360), radius * cos((j + diff(i / layers)) / edges * 360)],
                                                        [radius * sin((j + 2) / edges * 360), radius * cos((j + 2) / edges * 360)],
                                                    ],
                                        paths   =   [   [0, 1, 2]   ]);
                            }
                        }
                        else if((j - 1)%modulo != 0){
                            linear_extrude(height = layerHeight){
                                polygon(points  =   [   [0, 0],
                                                        [radius * sin(j / edges * 360), radius * cos(j / edges * 360)],
                                                        [radius * sin((j + 1) / edges * 360), radius * cos((j + 1) / edges * 360)]
                                                    ],
                                        paths   =   [   [0, 1, 2]   ]);
                            }
                        }
                    }
                }
            }
        }
    }
}

shape();