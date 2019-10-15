//Bit diameter
in=1.5;
//overhang of tab
tabhang=.75;
//Resolution
res=60;
//Calculation
in2mm=in*25.4;
diatabhang=2*tabhang;

module insert(){
union(){
union(){
    cylinder(2.5, d=97.5, $fn=60);
    translate([0,0,2.5]) cylinder(2.85, d=91, $fn=60);
}
   difference(){ 
       union(){
           translate([0,0,5.35]) cylinder(4, d=91, $fn=res);
           translate([0,0,7.35]) cylinder(2, d=91+diatabhang, $fn=res);
       }
           translate([0,0,5.35]) cylinder(6, d=88, $fn=res); 
}
}
}

difference(){
    insert();
    cylinder(5.35, d=in2mm, $fn=res);
}