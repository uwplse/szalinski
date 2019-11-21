// mathgrrl five cent hammer

/////////////////////////////////////////////////////////////////////////
// notes

// pennies after 1982 weigh 2.5 grams
// pennies before 1982 weigh 3.11 grams

// learned how to do this from anoved's Customizable Chalice Lathe code
// http://www.thingiverse.com/thing:270289/
// thank you anoved for commenting your code so well!

/////////////////////////////////////////////////////////////////////////
// parameters for the user

number_of_coins = 5;  

// In millimeters; default is for US pennies
coin_diameter = 19.05;

// In millimeters; default is for US pennies
coin_height = 1.52;

// Open (coin visible) or closed (plastic cover)
end_type = 0; //[0:Open,1:Closed]

/////////////////////////////////////////////////////////////////////////
// parameters NOT for the user

coinRadius = coin_diameter/2;

extraHorizontal = .4*1; 
extraVertical = .5*1;

thickness = 1.3*1;
baseThickness = .6*1;

binRadius = coinRadius + extraHorizontal + thickness;
binHeight = baseThickness + number_of_coins*coin_height + extraVertical;

lipWidth = 2*1;
lipHeight = 1*1;

fudge = 0.1*1;

$fn = 48*1;

/////////////////////////////////////////////////////////////////////////
// renders

miniHammer();

/////////////////////////////////////////////////////////////////////////
// module for hammer without handle
// yeah maybe someday I should add a handle

module miniHammer(){
    difference(){
        union(){
            base();
            post();
        }
        //cube(50); // if you want cutaway
        if (end_type==0) {
            translate([0,0,-fudge])
            cylinder(r=binRadius-thickness-2,h=baseThickness+1);
        }
    }
}

/////////////////////////////////////////////////////////////////////////
// module for post
echo(binHeight+lipHeight);

postSketch = [
	[[binRadius,binHeight], 
	 [binRadius,binHeight+lipHeight],
	 [5.6,binHeight+6],
	 [5.6,binHeight+8],
     [7.9,binHeight+9],
	 [9,binHeight+10],
	 [9,binHeight+14],
     [7.9,binHeight+15],
	 [5.6,binHeight+16],
	 [4.5,binHeight+18],
	 [4.5,binHeight+29],
	 [5.6,binHeight+31],
	 [10,binHeight+34],
	 [10,binHeight+37],
	 [9,binHeight+39],
	 [7.3,binHeight+39],
	 [5.6,binHeight+37],
	 [0,binHeight+37], 
	 [0,binHeight], 
	 [.92*binRadius-thickness,binHeight]
	],
	[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]]
];

module post(){
	rotate_extrude()
		polygon(points=postSketch[0], paths=postSketch[1]); 
}

/////////////////////////////////////////////////////////////////////////
// module for penny-weighted base

baseSketch = [
	[[binRadius,0],
	 [binRadius,binHeight],
	 [.92*binRadius,binHeight+lipHeight],
	 [.92*binRadius-thickness,binHeight+lipHeight],
	 [binRadius-thickness,binHeight],
	 [binRadius-thickness,0]
	],
	[[0,1,2,3,4,5]]
];

module base(){
	cylinder(r=binRadius,h=baseThickness);
	rotate_extrude()
		polygon(points=baseSketch[0], paths=baseSketch[1]); 
}
