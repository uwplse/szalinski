// rupee_magnet_master.scad
// author: easter_jedi
//TO CUSTOMIZE:
// (1) Change the height to change the size; the rest of the dimensions will adjust based on the height to keep the ratios correct.
// (2) Change the magnet module to fit your magnets.
// (3) Place the magnet cut-out in the rupee frame, about 0.5 mm (or less if your printer can handle it) in from a flat side; thinner means the overall magnet will be stronger.
// *customization points are marked with "NOTE" comments.

echo(version=version());

//NOTE: height defined here
height=35*5/6.25; //height, in mm

//NOTE: magnet shape defined here
module magnet(){
    //10x8x4mm + tolerance
    linear_extrude(height=10) //d=10.4 so h=5.2-0.5 = 4.7
        square([5,11],center=true);
}

h=height; //height, in mm (configurable, and the rest will adjust)
w=26 *h/44; //all the way across
s=21 *h/44; //side height
//front and back:
h2=24 *h/44;
w2=13 *h/44;
s2=12.5 *h/44;
//depth:
d=16*h/44;

module rupee_solid(){
    translate([0,0,d/2])rotate([180,0,0])
    polyhedron(points=[[-w/2,-s/2,0],[0,-h/2,0],[w/2,-s/2,0],
             [w/2,s/2,0],[0,h/2,0],[-w/2,s/2,0],
             [-w2/2,-s2/2,d/2],[0,-h2/2,d/2],[w2/2,-s2/2,d/2],
             [w2/2,s2/2,d/2],[0,h2/2,d/2],[-w2/2,s2/2,d/2],
             [-w2/2,-s2/2,-d/2],[0,-h2/2,-d/2],[w2/2,-s2/2,-d/2],
             [w2/2,s2/2,-d/2],[0,h2/2,-d/2],[-w2/2,s2/2,-d/2],],
           faces=[[6,7,8,9,10,11],//[17,16,15,14,13,12],
             [2,3,9,8],[5,0,6,11],[0,1,7,6],
             [4,5,11,10],[3,4,10,9],[1,2,8,7],
               [5,4,3,2,1,0]
            // [1,2,14,13],[2,3,15,14],[3,4,16,15],
             //[4,5,17,16],[5,0,12,17],[0,1,13,12]
           ]);
}

//print in two halves, magnet hole side up
//NOTE: magnet placement determined here
difference(){
    rupee_solid();
    translate([0,0,0.7]) magnet();
}
translate([25,0,0])
difference(){
    rupee_solid();
    translate([0,0,4.5]) magnet();
}