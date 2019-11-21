// This makes use of the $fn function to limit the number of facets (sides) of cylinders.
// So essentially this is just a cylinder with a couple of cones stacked on top.
// Setting $fn to 3 gives a 3 sided funnel (triangular) funnel.
// Setting $fn to 4 gives a 4 sided (square) funnel.
// etc. The higher the number, the more "round" it becomes.

// REALLY IMPORTANT. THE STL PRODUCES A SOLID OBJECT WHICH WON'T BE MUCH USE AS A FUNNEL. 
// TO MAKE THIS WORK, YOU NEED TO SLICE IT WITH NO TOP AND BOTTOM LAYERS, NO INFILL, BUT 3 OR 4 PERIMETERS.
// THAT WILL PRODUCE A G-CODE WHICH WILL MAKE A HOLLOW FUNNEL.


// Number of sides. 3 makes a trangular funnel, 4 makes a square funnel, 5 would be pentagonal, etc
Number_Of_Sides = 4;

$fn=Number_Of_Sides;

// Width across corners . NOTE this is the width across the corners, not across the flats. 
// Essentialy, the width is the diameter of a circle within which your funnel will fit.
// So for example, if you want a 4 sided cone that is 100 mm across flats, you will need 
// to set the width to approximately 1.4 times greater - i.e. 140mm.

Width_Across_Corners = 70;

dia1=Width_Across_Corners;


// If you want, you can change the proportions by playing around with the following variables.


dia2=dia1/3;
dia3=dia2/3;
h1=dia1/7;
h2=dia1/3;
h3=dia1/2;


// This is the main code section

rotate ([0,0,45])
cylinder (d=dia1, h=h1);
rotate ([0,0,45])
translate ([0,0,(h1-.001)]) // Set the z axis starting point very slightly lower to ensure that it is manifold 
cylinder (d1=dia1, d2=dia2, h= h2);
rotate ([0,0,45])
translate ([0,0,(h1+h2-.002)]) // As above comment.
cylinder (d1=dia2, d2=dia3, h= h3);

