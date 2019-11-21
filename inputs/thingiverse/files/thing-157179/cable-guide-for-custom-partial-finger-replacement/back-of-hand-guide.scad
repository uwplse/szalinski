

//(knuckle width) - Measurement E
kw=80;

/*[hidden]*/
$fn=25;


union(){

difference(){
linear_extrude(height=2,center=true)polygon([ [kw/2,kw/2-3],[kw/2-3,kw/2],[-kw/2+3,kw/2],[-kw/2,kw/2-3],[-kw/4,-kw/2],[kw/4,-kw/2] ]);

//webbing spaces
translate([kw/3.5,40,0])scale([1,4,1])cylinder(r=kw/16,h=4,center=true);
translate([0,40,0])scale([1,4,1])cylinder(r=kw/16,h=4,center=true);
translate([-kw/3.5,40,0])scale([1,4,1])cylinder(r=kw/16,h=4,center=true);

//strap mount holes
cylinder(r=2,h=4,center=true);
translate([kw/4,0,0])cylinder(r=2,h=4,center=true);
translate([-kw/4,0,0])cylinder(r=2,h=4,center=true);

}

//knuckle guides
difference(){
translate([kw/2.4,kw/2-2,1.75])rotate([90,0,0])cylinder(r=2.5,h=3,center=true);
translate([kw/2.4,kw/2-2,1.75])rotate([90,0,0])cylinder(r=1.25,h=5,center=true);
}

difference(){
translate([kw/7,kw/2-2,1.75])rotate([90,0,0])cylinder(r=2.5,h=3,center=true);
translate([kw/7,kw/2-2,1.75])rotate([90,0,0])cylinder(r=1.25,h=5,center=true);
}

difference(){
translate([-kw/7,kw/2-2,1.75])rotate([90,0,0])cylinder(r=2.5,h=3,center=true);
translate([-kw/7,kw/2-2,1.75])rotate([90,0,0])cylinder(r=1.25,h=5,center=true);
}

difference(){
translate([-kw/2.4,kw/2-2,1.75])rotate([90,0,0])cylinder(r=2.5,h=3,center=true);
translate([-kw/2.4,kw/2-2,1.75])rotate([90,0,0])cylinder(r=1.25,h=5,center=true);
}


//wrist guides
difference(){
translate([(kw/2.4)/2,-kw/2+2,1.75])rotate([90,0,0])cylinder(r=2.5,h=3,center=true);
translate([(kw/2.4)/2,-kw/2+2,1.75])rotate([90,0,0])cylinder(r=1.25,h=5,center=true);
}

difference(){
translate([(kw/7)/2,-kw/2+2,1.75])rotate([90,0,0])cylinder(r=2.5,h=3,center=true);
translate([(kw/7)/2,-kw/2+2,1.75])rotate([90,0,0])cylinder(r=1.25,h=5,center=true);
}

difference(){
translate([(-kw/7)/2,-kw/2+2,1.75])rotate([90,0,0])cylinder(r=2.5,h=3,center=true);
translate([(-kw/7)/2,-kw/2+2,1.75])rotate([90,0,0])cylinder(r=1.25,h=5,center=true);
}

difference(){
translate([(-kw/2.4)/2,-kw/2+2,1.75])rotate([90,0,0])cylinder(r=2.5,h=3,center=true);
translate([(-kw/2.4)/2,-kw/2+2,1.75])rotate([90,0,0])cylinder(r=1.25,h=5,center=true);
}

}