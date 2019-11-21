//Enter in inches long each side is
side = 3.5;

//Enter in inches how high it is
height = 0.7;

//Leave the back flat?
flat_back = 0; // [1:Leave Back Flat, 0:No! Both Sides]

s = side*25.4;
h = height*25.4*5;

module triangle()
{
scale([s,s,h]){
difference(){
translate([-0.5, -0.289, 0])
polyhedron(
	points=[[0,0,0],[1,0,0],[0.5,0.866,0],[0.5,0.289,0.25]],
	faces =[[0,1,2],[1,0,3],[2,1,3],[0,2,3]]
);
translate([-1.5,-1.5,0.1])cube(3);
}
}}

union()
{
triangle();
if (flat_back == 0)
{
mirror([0,0,1]){
triangle();
}
}
}
