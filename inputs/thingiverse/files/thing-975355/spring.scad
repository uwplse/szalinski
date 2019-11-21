//  The length of the spring
length = 19;

//  Dimension of the frontal square form of the spring
radiusSpring = 5.1;

//  Radius of the (optional) hole through the spring
radiusHole = 6.8 / 2;

//  Amount of leaves in the spring
cuts = 16;  //   [2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,39,40,42,44,46,48,50]

//  Depth of the leaves
cutDepth = 8;

module spring(){
    difference(){
        translate([-radiusSpring, 0, -radiusSpring]){
            cube([2 * radiusSpring, length, 2 * radiusSpring]);
        }
        rotate([-90,30,0]){
            translate([0,0,-0.1]){
                cylinder(r = radiusHole, h = length + 0.2, $fn = 6);
            }
        }
        translate([-radiusSpring, 0, -radiusSpring]){
            triangleCut();
        }
    }
}

module triangleCut(){
    length2 = length * cuts / (cuts + 0.5);
    for(i = [1:cuts]){
        if(i%2 == 0){
            translate([0,0,-0.1]){
                linear_extrude(height = 2 * radiusSpring + 0.2){
                    polygon(points  =   [   [-0.1, length2 / cuts * (i - 1.5)],
                                            [cutDepth, length2 / cuts * (i - 1.5)],
                                            [-0.1, length2 / cuts * (i - 0.5)],
                                        ],
                            paths = [[0,1,2]]);
                }
            }
        }
        else{
            translate([0,0,-0.1]){
                linear_extrude(height = 2 * radiusSpring + 0.2){
                    polygon(points  =   [   [2 * radiusSpring + 0.1, length2 / cuts * (i + 1)],
                                                [-cutDepth +2 * radiusSpring, length2 / cuts * (i + 1)],
                                                [2 * radiusSpring + 0.1, length2 / cuts * (i)],
                                            ],
                                paths = [[0,1,2]]);
                }
            }
        }
    }
}

spring();
//triangleCut();