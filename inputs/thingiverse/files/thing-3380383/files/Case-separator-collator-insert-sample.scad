//VARIABLES

//Resolution
RES = 20;
//Case diameter adjustment
CDA = 0.5;
//Sieve thickness
STN = 2;

//MODULES 


//Holes
module hole(){
    $fn=RES/4;
translate([-(6+CDA)/2,-10,0])
minkowski()
{
  cube([6+CDA,20,STN/2]);
  cylinder(r=2,h=STN/2);
}
}



//SAMPLE
difference(){translate([0,5+STN/2,STN/2])cube([10+CDA+STN*2,24+10+STN*3,STN],true);hole();translate([0,17+STN,0])cylinder(d=10+CDA,STN,$fn=RES);} 