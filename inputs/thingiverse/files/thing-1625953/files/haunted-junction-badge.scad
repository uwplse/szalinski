
rBadge = 13;
hBadge = 3;
hBase = 1.8;
thickBadge = 2;
hStar = 1.0;
thickStar = 1.2;

module text_saint(h) {
    // size=[14.202833, 13.292667]
    scale([25.4/300.0,25.4/300.0,1]) {
        union() {
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [1.750000,157.000000],
                        [102.750000,156.500000],
                        [102.750000,147.750000],
                        [1.750000,148.500000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [95.500000,150.250000],
                        [161.750000,149.000000],
                        [161.500000,132.750000],
                        [95.750000,133.750000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [96.000000,150.250000],
                        [118.250000,150.250000],
                        [118.000000,74.000000],
                        [95.250000,74.500000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [139.500000,149.500000],
                        [161.500000,149.250000],
                        [161.250000,74.750000],
                        [139.500000,74.000000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [110.250000,97.750000],
                        [151.000000,97.500000],
                        [151.000000,81.250000],
                        [110.000000,82.000000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [15.500000,152.750000],
                        [37.750000,152.500000],
                        [36.750000,74.000000],
                        [15.250000,74.000000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [0.000000,82.500000],
                        [36.500000,82.250000],
                        [37.000000,73.500000],
                        [0.000000,73.500000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [58.250000,152.750000],
                        [81.500000,152.750000],
                        [81.500000,66.250000],
                        [58.000000,66.500000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [30.500000,134.750000],
                        [67.250000,134.750000],
                        [67.250000,127.000000],
                        [30.250000,126.500000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [31.500000,112.250000],
                        [65.750000,112.250000],
                        [65.500000,103.000000],
                        [31.250000,103.250000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [31.500000,89.500000],
                        [64.500000,89.500000],
                        [64.500000,82.000000],
                        [31.500000,82.500000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [6.750000,62.000000],
                        [161.750000,61.500000],
                        [162.250000,51.500000],
                        [7.000000,51.500000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [22.500000,38.500000],
                        [146.250000,38.000000],
                        [146.500000,28.250000],
                        [22.500000,29.250000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [1.500000,8.500000],
                        [167.500000,8.500000],
                        [167.750000,0.250000],
                        [1.250000,0.000000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
            linear_extrude(height=h) {
                polygon(
                    points = [
                        [72.250000,56.750000],
                        [96.500000,56.750000],
                        [96.000000,3.250000],
                        [72.250000,2.750000]
                    ],
                    paths = [
                        [ 0, 1, 2, 3 ]
                    ]
                );
            }
        }
    }
}

module triangleUp(r, h) {
    polyhedron(
        points = [ [r*cos(90), r*sin(90), 0],
                   [r*cos(330), r*sin(330), 0],
                   [r*cos(210), r*sin(210), 0],
                   [r*cos(90), r*sin(90), h],
                   [r*cos(330), r*sin(330), h],
                   [r*cos(210), r*sin(210), h]
		 ],
        faces = [ [0,2,1], [3,4,5],
	          [0,1,3], [1,4,3],
		  [1,2,4], [2,5,4],
		  [2,0,5], [0,3,5]
	        ]
    );
}

module star6(r, h) {
    union() {
        difference() {
            triangleUp(r,h);
            translate([0,0,-1]) {
                triangleUp(r-thickStar, h+2);
            }
        }
        rotate([0,0,180]) {
            difference() {
                triangleUp(r,h);
                translate([0,0,-1]) {
                    triangleUp(r-thickStar, h+2);
                }
            }
        }
    }
}

r2 = (hBadge*hBadge+rBadge*rBadge)/(2.0*hBadge);


translate([0,0,hBase]) {
    union() {
        translate([0,0,-r2+hBadge]) {
            difference() {
                sphere(r=r2, $fn=100);
                sphere(r=(r2-thickBadge/2), $fn=30);
                translate([0,0,-hBadge]) {
                    cube([2*r2+2, 2*r2+2, 2*r2], center=true);
                }
            }
        }

        intersection() {
            difference() {
                star6(rBadge, hBadge);
                translate([0,0,-r2+hBadge]) {
                    sphere(r=((r2-thickBadge/2)+r2)/2, $fn=30);
                }
            }
            translate([0,0,-r2+hBadge]) {
                sphere(r=(r2+hStar), $fn=50);
            }
        }

        difference() {
            scale([0.8*rBadge/13,0.8*rBadge/13,1]) {
                translate([-14.202833/2,-13.292667/2,0]) {
                    text_saint(hBadge+0.4);
                }
            }
            translate([0,0,-r2+hBadge]) {
                sphere(r=((r2-thickBadge/2)+r2)/2, $fn=30);
            }
        }
    }
}

thick2 = rBadge-sqrt((r2-thickBadge)*(r2-thickBadge) - (r2-hBadge)*(r2-hBadge));

difference() {
    cylinder(r=rBadge, h=hBase, $fn=100);
    translate([0,0,-1]) {
        cylinder(r=rBadge-thick2/2, h=hBase+3, $fn=30);
    }
}

difference() {
    intersection() {
        translate([-2,-2,0]) {
            cube([4,4,hBadge+hBase]);
        }
        translate([0,0,-r2+hBadge+hBase]) {
            sphere(r=((r2-thickBadge/2)+r2)/2, $fn=30);
        }
    }
    translate([-3,0,2]) {
        rotate([0,90,0]) {
            cylinder(r=1, h=6, $fn=50);
        }
    }
}
