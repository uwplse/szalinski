


//corner cube

x=18;

boxheight = 8;
lipwidth=13.5;
lipheight=2.0;
width=10.5;
length= 20;
/* [Hidden] */
y=x;
wall = 0.75;
h=boxheight+wall;
difference(){//cube([x,y,h]);
hull(){

translate([2,2,0])cylinder(r=2,h=h,$fn=60);
translate([x,0,0])cylinder(r=.001,h=h,$fn=60);
translate([x,y,0])cylinder(r=.001,h=h,$fn=60);
translate([0,y,0])cylinder(r=.001,h=h,$fn=60);

}
// cord cutout

translate([x,y,lipheight+1.5*wall])cylinder(r=x-width-wall-1,5*wall,h=h,$fn=60);
}

// arm
arm();
rotate([0,0,-90])mirror() arm();


module arm(){translate([x,wall,0])cube([length,width,h-wall]);
hull(){
   translate([length+x,wall+2,0]) cylinder(r=2,h=h-wall,$fn=60);
   translate([length+x,wall+width-2,0]) cylinder(r=2,h=h-wall,$fn=60);
    }
//lip
    translate([0-2,lipwidth-width,0]){
        
    translate([x,wall,0])cube([length,width,lipheight]);
        hull(){
   translate([length+x,wall+2,0]) cylinder(r=2,h=lipheight,$fn=60);
   translate([length+x,wall+width-2,0]) cylinder(r=2,h=lipheight,$fn=60);
    }
}
}

