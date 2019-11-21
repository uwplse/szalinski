/* Cool Sphere
 * By Antyos
 * Can be either a hangabable object or a cat toy or something else 
 */
// Inner radius of the rings
Inner_Radius = 15; 
// The thickness (radius) of each of the rings
Ring_Radius = 1.25; 
// Generates a loop on top of the sphere
Generate_Loop = "false"; // [true, false]
// Inner Radius of the loop
Loop_Inner_Radius = 1.75; 
// Thickness of the loop
Loop_Radius = 1; 
// Generates the center sphere
Generate_Ball = "false"; // [true, false]
// Radius of inner ball
Ball_Radius = 8.75; 
// Resolution of everything; Lower resolution generates faster but is not as smooth
Resolution = 50; 


$fn = Resolution; // Set the resolution of the model

// Module for creating the rings
module torus(inRad, ringRad){
    rotate_extrude()// Revolve the circle to make the torus
    translate([inRad+ringRad,0,0]) // Move into position for the correct ring inner radius
    circle(r = ringRad);    
    
}

// Create the 3 rings of each plane (XYZ)
for(i = [[0,0,1],[0,1,0],[1,0,0]],  // Each plane
    j = [[0,0,0],[1,1,0],[-1,-1,0]]){ // Each group
    rotate(45*j) // Each group rotation
    rotate(90, i) // Each circle of the base 3
    torus(Inner_Radius, Ring_Radius); // Draw ring
}

// Create the loop on the top
if(Generate_Loop == "true"){
    translate([0,0,Inner_Radius+(Ring_Radius*2)+Loop_Inner_Radius]) // Move the loop up into position
    rotate(90,[0,1,0]) // Rotate the ring
    torus(Loop_Inner_Radius, Loop_Radius); // Draw loop   
}

// Create the ball inside
if(Generate_Ball == "true")
    sphere(r = Ball_Radius);

