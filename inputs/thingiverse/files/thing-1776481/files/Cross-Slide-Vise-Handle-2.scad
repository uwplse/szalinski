//Outer Handle
ohD1=12.5;
ohD2=17.5;
ohH=49.5;

//Shell
shell=3.5; //wall thickness
ihD1=ohD1-(2*shell);
ihD2=ohD2-(2*shell);
ihH=ohH;

res=60;

difference(){
    cylinder(h=ohH, d1=ohD1, d2=ohD2, $fn=res);
    cylinder(h=ihH, d1=ihD1, d2=ihD2, $fn=res);
}