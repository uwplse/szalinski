
//---[ USER Customizable Parameters ]-----------------------------------------

//: Length of tapered section
pointHeight = 40;//[0:100]
//: Length of stake body
stakeHeight = 150;//[0:300]
//: Radius of stake
stakeRadius = 15;//[0:40]
//: Ratio of inner profile to outer profile
radiusScale = .7;//[0:.05:1]
//: Twist in the upper portion of the stake
upperTwist = 250;//[0:10000]
//: Number of sides 
numberOfSides = 4;//[3:10]

smallRadius = stakeRadius * radiusScale;
r=stakeRadius/numberOfSides;
smallR=smallRadius/numberOfSides;
rotationAngle = 360/numberOfSides/2;
lowerTwist=(upperTwist*pointHeight)/stakeHeight;


module hypotrochoid(R, r, d, n=50, rev=1) {
    function x(R,r,a) = (R-r) * cos(a) + d*cos((R-r)/r*a);
    function y(R,r,a) = (R-r) * sin(a) - d*sin((R-r) / r*a);
    dth=rev*360/n;

    for(i = [0:n-1] ) {
        polygon ( 
            [
                [0,0],
                [x(R,r,dth*(i)), y(R,r,dth*(i))],
                [x(R,r,dth*(i+1)), y(R,r,dth*(i+1))]
            ]
        );
    }
}

difference() {
    union() {
        union() {
            linear_extrude(height=stakeHeight,twist=upperTwist,slices=100)
            hypotrochoid(stakeRadius,r,r,rev=3);
            linear_extrude(height=stakeHeight,twist=upperTwist,slices=100)
            rotate([0,0,rotationAngle]) hypotrochoid(smallRadius,smallR,smallR,rev=3);
        }
    
        rotate([180,0,0]){
        
            union() {
                linear_extrude(height=pointHeight,twist=lowerTwist,slices=50,scale=0)
                    hypotrochoid(stakeRadius,r,r,rev=3);
                linear_extrude(height=pointHeight,twist=lowerTwist,slices=50,scale=0)
                    rotate([0,0,rotationAngle]) hypotrochoid(smallRadius,smallR,smallR,rev=3);
            }
        }
    }
    translate([0,0,stakeHeight-12]){
        rotate([90,0,0]) {
            cylinder(r=3.7, h=50,center=true);
        }
    }
}