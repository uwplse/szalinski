debug = true;
$fn=200;


dish=true;
dishrad=85;
dishtall=20;
dishwall=2;

pipeheight=200;
piperad=50;
pipewall=3;

flaretall=0.6666*piperad;  // defines the height of the top bulge
flarerad= 1.2*piperad; // defines the how far out the top bulges related to 

basethick=2;

module drainholes(){
    translate([0,0,basethick+0.5])
    cube([2*(dishrad-dishwall)-2,3,basethick+3], center=true);
    translate([0,0,basethick+0.5])
    rotate(90,0,0)
    cube([2*(dishrad-dishwall)-2,3,basethick+3], center=true);
}

module dish(){  // builds the waterdish
    difference() {
        color("lime") cylinder(h=dishtall, r=dishrad);
        translate([0,0,basethick]) cylinder(h=dishtall, r= dishrad-dishwall);
    }  
}

module mainpipe(){
        color("lime") cylinder(h=pipeheight, r=piperad);
        color("lime") translate([0,0,pipeheight-flaretall]) cylinder(h=flaretall, r=flarerad);
}

module innerhollow(){
    translate([0,0,basethick])
    cylinder(h=pipeheight+0.1, r= piperad-pipewall);
}


module buildpipe(){  
    difference(){
        mainpipe();
        innerhollow();
    }
}


if(dish==true){   // builds pipe w/drain and adds waterdish
    difference(){
        buildpipe();
        drainholes();
    }
    dish();
}

if(dish==false){   // builds pipe without holes or waterdish
        buildpipe();
}

