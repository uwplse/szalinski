/*
SpiralSphere - Christmas tree ornament - Thingiverse Customizer compatible
2013-11-23 kowomike
*/



//Number of "ribbons"
ribbons=5; //[1:20]

//Spiral type
type=1; //[0:single helix (harder to print),1:double helix]

//Tree diameter at base [mm]
diameter=50; //[20:100]

//Wall thickness
wall=0.75; //[0.25:very thin (0.25 mm),0.4:1x nozzle (0.4mm),0.5:thin (0.5 mm),0.75:standard (0.75 mm),0.8:2x nozzle (0.8mm),1:thick (1 mm)],1.2:3x nozzle (1.2mm)

//Width of spiral ribbons [mm]
spiral_width=5; //[2:10]


/* [Hidden] */

//Calculate Twist angle
twist=360/ribbons*2;

difference () {
	union () {
        rotate ([0,0,360/ribbons/2])
        spiralsphere(number=ribbons,
                    radius=diameter/2,
                    wall=wall,twist=twist,
                    direction=-1,
                    spiral_width=spiral_width);
        if (type==1) {
            spiralsphere(number=ribbons,
                     radius=diameter/2,
                     wall=wall,twist=twist,
                     direction=1,
                     spiral_width=spiral_width);
        }
    }

    //Cut away base to become flat
    cube ([diameter,diameter,1],center=true);

}

//Add Flat baseplate
translate ([0,0,0.5])
cylinder (r=max(4,diameter/20),h=0.5,$fn=50);


//Hanger
translate([0,0,diameter+2])
rotate([90,0,0])
scale([1,1,1])
rotate_extrude(convexity = 10, $fn = 100)
translate([3, 0, 0])
circle(r = 1, $fn = 100);	


module spiralsphere (number=6,radius=30,wall=0.5,twist=-90,direction=1, spiral_width) {

points=[[wall*0.5,0],
        [wall*0.5,radius-1],
        [wall*0.4,radius-0.6],
        [wall*0.2,radius],
        [0,radius],
        [wall*-0.2,radius],
        [wall*-0.4,radius-0.6],
        [wall*-0.5,radius-1],
        [wall*-0.5,0]];

intersection () {

for (i=[1:number]) {
    difference() {
        rotate ([0,0,i*360/number])
        linear_extrude($fa=1, $fs=0.5,
                   height = diameter,
                   twist = twist*direction)
        polygon(points);
    
        translate ([0,0,diameter/2])
        sphere(r=diameter/2-spiral_width);
    }

}
	translate ([0,0,radius])
	sphere(r=radius);
}

}





