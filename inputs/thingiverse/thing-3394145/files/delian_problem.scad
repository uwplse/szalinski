part = "Inner"; //[Inner:Cube, Outer: Doubling Part]

//Side length of the small cube (mm)
side_length=40;

//Magnet's diameter
diameter_of_the_magnets = 6; // [2.5:5 mm, 3:6 mm, 3.5:7 mm, 4:8 mm, 4.5:9 mm, 5: 10 mm]


//Magnet's height
height_of_the_magnets=10; // [2:2 mm, 3:3 mm, 4:4 mm, 5:5 mm, 6:6 mm]

b=side_length/2;


module smaller() {
translate ([0,0,b]) {
cube(side_length, center=true);
    }
}
module smallerLast () {
difference () {
    smaller();
    magnetHole();
    }
}
module topPart () {
    translate ([(c-side_length)/2,(c-side_length)/2,c/2]) {cube(c, center=true);
    cube(side_length, center=true);
    }
    }
    
c=pow(2*side_length*side_length*side_length,1/3);
module volumeTop () { difference () {
    topPart();
    smaller();
}
}
module topLast() {
difference () {
volumeTop();
magnetHole();
}
}

module magnetHole() {
translate([0,0,side_length-height_of_the_magnets]) {
    cylinder(r=diameter_of_the_magnets, h=2*height_of_the_magnets, $fn=30);
}

rotate(a=90, v=[0,1,0]) {translate([-side_length/2 ,0,b-height_of_the_magnets]) {
    cylinder(r=diameter_of_the_magnets, h=2*height_of_the_magnets, $fn=30);
}
}

rotate(a=90, v=[1,0,0]) {translate([0 ,side_length/2,-b-height_of_the_magnets]) {
    cylinder(r=diameter_of_the_magnets, h=2*height_of_the_magnets, $fn=30);
}
}
}

print_part();

module print_part()
{
	if (part == "Inner")
	{
		smallerLast();
	}
	else if (part == "Outer")
	{
		topLast();
	}
	
}

