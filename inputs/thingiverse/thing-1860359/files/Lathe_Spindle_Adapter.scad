//Chuck Adapter for Wooden Lathe

spindle=.75;

chuck=3;

nutsurround=.25;
nutsize=1.26; //longest point to point outside of nut
nutthick=.62;

materialthick=.125;

centerbolt=.25;

mountholenum=4;
mountholedia=.25;

res=60;

module nut(){
difference(){
cylinder(h=nutthick, d=nutsize, center=true, $fn=6);
cylinder(h=nutthick, d=spindle, center=true, $fn=res);
}
}

module solidnut(){
difference(){
    cylinder(h=nutthick, d=nutsize, center=true, $fn=6);
}
}

module nutspindle(){
    difference(){
        cylinder(h=materialthick, d=nutsize+nutsurround, center=true, $fn=res);
        cylinder(h=materialthick, d=spindle, center=true, $fn=res);
    }
}

module chucknut(){
difference(){
    cylinder(h=nutthick-materialthick, d=nutsize+nutsurround, center=true, $fn=res);
    solidnut();
}
}

module mountnut(){
    difference(){
        difference(){
        cylinder(h=materialthick, d=chuck, center=true, $fn=res);
        solidnut();
    }
    for (i=[0:mountholenum])
        {rotate([0,0,i*360/mountholenum])
        translate ([(chuck/2-(nutthick/2+nutsurround)/2), 0, 0])cylinder(h=materialthick, d=mountholedia, center=true, $fn=res);}
}
}

module mountplate(){
difference(){
    difference(){
        cylinder(h=materialthick, d=chuck, center=true, $fn=res);
        cylinder(h=materialthick, d=centerbolt, center=true, $fn=res);
    }
    for (i=[0:mountholenum])
        {rotate([0,0,i*360/mountholenum])
        translate ([(chuck/2-(nutthick/2+nutsurround)/2), 0, 0])cylinder(h=materialthick, d=mountholedia, center=true, $fn=res);}
}
}


module fulladapter(){
    mountplate();
    translate([0,0,materialthick]) mountnut();
    translate([0,0,3.5*materialthick]) chucknut();
    translate([0,0,(nutthick+materialthick)]) nutspindle();
}

scale([25.4,25.4,25.4])

fulladapter();
//mountplate();
//mountnut();
//chucknut();
//nutspindle();