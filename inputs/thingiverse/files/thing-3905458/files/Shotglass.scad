

//set radius

//How many shots would you like 
shots=1;


height=40*shots;

module outside(){
    cylinder(height+10,18.78844+5,18.78844+5,[0,0,(height/2)]);
}

module inside(){
    translate([0,0,10])cylinder(height+1,18.78844,18.78844);
}

module shotglass(){
difference(){
    outside();
    inside();
}
}
shotglass();