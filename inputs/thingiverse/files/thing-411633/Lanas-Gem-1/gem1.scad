//Enter in inches how far the gem goes forward
height = 1.5;

//Enter in inches how wide it must be
width = 2.5;

//Enter in inches how long it must be (equal or higher than width!)
length = 3;

//Leave the back flat?
flat_back = 0; // [1:Leave Back Flat, 0:No! Both Sides]

cubehelp = (length + 10)*25.4;


if (flat_back == 1)
{
difference(){
	resize([width*25.4, length*25.4, height*25.4]) sphere(10);
	translate([-cubehelp/2, -cubehelp/2, -cubehelp]) cube(cubehelp);
	}
}
else
{
	resize([width*25.4, length*25.4, height*25.4]) sphere(10);
}