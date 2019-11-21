thick = 2;
innerdia=3.5;
outerdia=6.25;
res=60;

difference(){
    cylinder(thick, d=outerdia, $fn=res);
    cylinder(thick, d=innerdia, $fn=res);
}