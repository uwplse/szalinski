tubeSize=20;
tubeThickness=1;
segmentSize=4;

tubeLength=50;
numSegments=2;

/*skew takes an array of six angles:
 *x along y
 *x along z
 *y along x
 *y along z
 *z along x
 *z along y
 */
module skew(dims) {
matrix = [
    [ 1, dims[0]/45, dims[1]/45, 0 ],
    [ dims[2]/45, 1, dims[4]/45, 0 ],
    [ dims[5]/45, dims[3]/45, 1, 0 ],
    [ 0, 0, 0, 1 ]
];
multmatrix(matrix)
children();
}



module base() {
    difference() {
        cube([tubeSize, tubeSize, segmentSize]);
        translate([tubeThickness, tubeThickness, 0])   
            cube([tubeSize-(tubeThickness*2), tubeSize-(tubeThickness*2), segmentSize]);
    }
}

module wall(h) {
    x=tubeSize-segmentSize;
    a = (x/h)*45;

    skew([0, 0, 0, 0, a, 0])
        cube([tubeThickness, segmentSize, h]);

    translate([tubeThickness, tubeSize, 0]) 
        rotate([0,0,180])
            skew([0, 0, 0, 0, a, 0])
                cube([tubeThickness, segmentSize, h]);
}

module section(h) {
    wall(h);
    
    translate([tubeSize, 0, 0])
        rotate([0, 0, 90])
            wall(h);

    translate([tubeSize, tubeSize, 0])
        rotate([0, 0, 180])
            wall(h);

    translate([0, tubeSize, 0])
        rotate([0, 0, -90])
            wall(h);
}

module tube(h, nsects) {
    htop = h-segmentSize;
    hsect = (h-(segmentSize*2))/nsects;

    *cube([tubeSize, tubeSize, h]);

    base();

    for(i = [segmentSize : hsect : htop-1])
        translate([0, 0, i]) 
            section(hsect);
    
    translate([0, 0, htop])
        base();
}

tube(tubeLength, numSegments);

