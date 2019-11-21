
//Scalable Soma Cube, by Alejandro Erickson
//Derived from: http://www.thingiverse.com/thing:3784 and http://www.thingiverse.com/thing:11644


//Size of Unit Cubes in mm.  Perhaps unit-shaveMM should be a multiple of your z-layer height
unit = 3; 

//Amount to shave off (inset) each piece.  Compensates for small print size.
shaveMM=.15;

//Box thickness (for the containing box)
boxThickness = .3;

part = "box";//[corner,ess,tee,rightsnake,leftsnake,angle,ell,all,box,lid]

module somaBox(){
render() 
	translate([0,0,0.5*(3*unit+boxThickness)]) difference(){
  		cube(size=[3*unit+2*boxThickness,3*unit+2*boxThickness, 3*unit+boxThickness],center=true);	
  		translate([0,0,boxThickness*0.5]) cube(size=3*unit, center= true);
	}
}

module somaLid(){
	render() translate([0,0, 1.5*boxThickness]) difference(){
		cube(size=[3*unit+4*boxThickness+shaveMM, 3*unit+4*boxThickness+shaveMM, 3*boxThickness],center=true);
		translate([0,0,0.5*boxThickness]) cube(size=[3*unit+2*boxThickness+shaveMM, 3*unit+2*boxThickness+shaveMM, 2*boxThickness],center=true);

}
}

module c()
{
	cube(size=unit, center=true);
}



module bigC()
{
	cube(size=100*unit, center=true);
}

module Shave(){
  for (i = [0 : $children-1])	{
	minkowski(){
	difference(){
		bigC(); 
		minkowski(){
			difference(){ 
				bigC(); 
				child(i);
			} 
			cube(size=2*shaveMM, center=true);
		}
	}
	}	
}
}


module c1()
{
  translate([0,0,0.5*unit]) Shave() rotate(180,[0,0,1])  union()
  {
    c();
    translate([unit,0,0]) c();
    translate([unit,unit,0]) c();
    translate([unit,0,unit]) c();
  }
}



module c2()
{
translate([0,0,1.5*unit])  //angle
Shave() rotate(180,[0,0,1]) rotate(90,[0,1,0]) union()
  {
    c();
    translate([unit,0,0]) c();
    translate([unit,unit,0]) c();
  }
}


module c3()
{
translate([0,0,0.5*unit])  //ess
  Shave() rotate(180,[1,0,0]) rotate(90,[0,0,1])  union()
  {
    c();
    translate([unit,0,0]) c();
    translate([unit,unit,0]) c();
    translate([2*unit,unit,0]) c();
  }
}


module c4()
{translate([0,0,0.5*unit])
  Shave() rotate(90,[1,0,0])  union()
  {
    c();
    translate([unit,0,0]) c();
    translate([unit,unit,0]) c();
    translate([2*unit,0,0]) c();
  }
}


module c5()
{translate([0,0,0.5*unit])
  Shave() rotate(180,[0,0,1]) union()
  {
    c();
    translate([unit,0,0]) c();
    translate([unit,unit,0]) c();
    translate([unit,unit,unit]) c();
  }
}


module c6()
{translate([0,0,0.5*unit])
  Shave() union()
  {
    c();
    translate([unit,0,0]) c();
    translate([unit,unit,0]) c();
    translate([0,0,unit]) c();
  }
}


module c7()
{
translate([0,0,2.5*unit])
  Shave() rotate(90,[0,1,0])  union()
  {
    c();
    translate([unit,0,0]) c();
    translate([2*unit,unit,0]) c();
    translate([2*unit,0,0]) c();
  }
}

translate([0,0,-shaveMM])
scale(1) rotate(90,[0,0,1])
{
if(part == "all"){
translate([-2*unit,5*unit,0])  c1(); //corner
translate([-2*unit,2*unit,0]) c3(); //ess
translate([0*unit,0*unit,0]) c4(); //tee
translate([0*unit,2*unit,0]) c6(); //rightsnake
translate([1*unit,6*unit,0]) c5(); //leftsnake
translate([3*unit,3*unit,0]) c2(); //angle
translate([3*unit,5*unit,0]) c7(); //ell
}
else if(part == "corner") c1();
else if(part == "ess") c2();
else if(part == "tee") c3();
else if(part == "leftsnake") c4();
else if(part == "rightsnake") c5();
else if(part == "angle") c6();
else if(part == "ell") c7();
else if(part == "box") somaBox();
else if(part == "lid") somaLid();
}


