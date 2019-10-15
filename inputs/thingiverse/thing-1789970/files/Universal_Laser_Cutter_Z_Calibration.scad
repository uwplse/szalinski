

baseH=.6;
baseD=1;
baseholeD=.375;
cutaway=.2;
    
stemD=baseholeD;
stem1H=.5;
stem2H=1;
stem3H=baseH;
cutaway1=.1;
cutaway2=.05;

//model is in inches
res=60;
//distance from table to laser carriage (min=stem2H+stem3H)
laser=1.875;
//minimum height adj - none
minmove=stem2H+stem3H;
//print the base part, enter 1 or 0
printbase=1;
//print the stem part, enter 1 or 0
printstem=1;

    
module base(){

    scale([25.4,25.4,25.4])
    difference(){
        difference(){
            cylinder(h=baseH, d=baseD, center=true, $fn=res);
            translate([(.5*baseD-.5*cutaway),0,0]) cube([cutaway,baseD,baseH], center=true);
    }
        
        cylinder(h=baseH, d=baseholeD, center=true, $fn=res);
}
}

if (printbase==1)
    base();
else if (printbase==0)
    echo("NOT PRINTING BASE");

module stem(){
  
    scale([25.4,25.4,25.4])
    cylinder(h=stem3H, d=stemD, center=true, $fn=res);
    
    scale([25.4,25.4,25.4])
    translate([0,0,(.5*stem3H+.5*stem2H)]) 
    difference(){
        cylinder(h=stem2H, d=stemD, center=true, $fn=res);
        translate([(.5*stemD-.5*cutaway2),0,0]) cube([cutaway2,stemD,stem2H], center=true);
    }
    
    scale([25.4,25.4,25.4])
    translate([0,0,(.5*stem1H+stem2H+.5*stem3H)]) 
    difference(){
        cylinder(h=stem1H, d=stemD, center=true, $fn=res);
        translate([(.5*stemD-.5*cutaway1),0,0]) cube([cutaway1,stemD,stem1H], center=true);
    }
}   

if (printstem==1)
    if (laser>=(minmove))
    translate([0,0,25.4*(laser-(stem3H+stem2H))])
    stem();
    else echo("Must be larger or equal to stem2H + stem3H");
else if (printstem==0)
    echo("NOT PRINTING STEM");