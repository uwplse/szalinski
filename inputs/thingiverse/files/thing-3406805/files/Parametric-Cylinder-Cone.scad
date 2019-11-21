
//Parametric Cylinder / Cone

//(mm)
height = 20; //[10,20,30,40,50]

//(mm)
bottom_radius = 20; //[20,30,40,50]

//(mm)
top_radius = 0; //[0:0-Apex,1,2,4,6,8,10,20,30,40,50]

number_of_faces = 3; //[3:3-Triangular,4:4-Square,5:5-Pentagonal,6:6-Hexagonal,7:7-Heptagonal,8:8-Octogonal,9:9-Enneagonal,10:10-Decagonal,33:33-Round (Course),66:66-Round (Medium),99:99-Round (Fine)]

cylinder(height,bottom_radius,top_radius,$fn=number_of_faces);