//smoothness
$fn=60;

//parameters
radius = 16;
drainRadius = 3.5;
sides = 16;
thickness = 1.5;

bodyHeight = 30;
baseHeight = 2;
drainHeight = baseHeight;
rimHeight = 3;
bodyTwist = -45;
bodyFlare = 2;

// extrude - body
//translate body to sit on top of base
translate([0,0,baseHeight])
linear_extrude(height = bodyHeight, twist = bodyTwist,
               scale = bodyFlare, slices = 2*bodyHeight) 
    vase(solid = "no");

//extrude - base
linear_extrude(height = baseHeight, twist = bodyTwist,
               scale = 1, slices = 2*bodyHeight) 
    vase(solid = "yes");
    
//extrude - rim
//translate rim to sit on top of body
translate([0,0,baseHeight+bodyHeight])
rotate(-bodyTwist)
scale(bodyFlare)
linear_extrude(height = rimHeight, twist = bodyTwist,
               slices = 2*bodyHeight) 
    vase(solid = "no");

//modules
module vase() {
    difference () {
    //outside shape start
    offset()
        difference () {
            circle(r = radius, $fn=sides, center=true);
            //drainage Hole
            circle(r = drainRadius, $fn=sides, center=true);
        }
    //subtract inside
    if (solid=="no"){
            circle(r = radius, $fn=sides, center= true);  
            //subtract drain Hole
            }
        }
    }