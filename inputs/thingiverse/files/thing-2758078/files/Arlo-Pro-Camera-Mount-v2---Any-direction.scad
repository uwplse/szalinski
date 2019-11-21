// Arlo Pro ceiling mount

// Stem height. 1.5"
stem_height=38; //[27,38,50]
// Screw shaft major diameter
screw_dia=4; //[4,4.8,5.4,6.9]
// Which parts to print?
part = "both"; // [first:stem,second:ball,both:both]

    bolt_head=7/16*25.4+5;
    
    bolt_hh=0.163*25.4;
print_part();

module print_part() {
	if (part == "first") {
		mirror([0,0,1])stem();
	} else if (part == "second") {
		ball();
	} else if (part == "both") {
		both();
	} else {
		both();
	}
}

$fa=1;
tolx=0.25;
ball=1.75*25.4;
wall=3;

module stem(){
    recess_depth=sqrt(pow(ball/2,2)-pow(0.9*25.4/2,2));
    mirror([0,0,0])difference(){
        union(){
            cylinder(d=ball,h=stem_height);
            sphere(d=ball+2*tolx);
        }
        union(){
            translate([0,0,tolx])cylinder(d=screw_dia+tolx,h=stem_height);
            rotate([90,0,0])cylinder(d=7,h=ball+2*(wall+2*tolx),center=true);
 //           sphere(d=ball+2*tolx);
            translate([0,bolt_head/2,0])cube([ball+2*(wall+tolx),2*recess_depth+2,ball+2*(wall+tolx)],center=true);
            translate([0,-(ball-2*wall)/2,0])rotate([90,0,0])cylinder(d=bolt_head,h=bolt_hh);
        }
    }
}

module ball(){
    recess_depth=sqrt(pow(ball/2,2)-pow(0.9*25.4/2,2));

    mirror([0,0,1])difference(){
        union(){
            sphere(d=ball-tolx);
      
            translate([-recess_depth,-ball/4+tolx,0]) cube([recess_depth*2,ball/2-2*tolx,ball/2+wall]);
            echo(recess_depth*2);
        }
        union(){
           rotate([0,90,0]){
               cylinder(d=7,h=ball+2*(wall+2*tolx));
               translate([0,0,ball/2-(5)])cube([7.5,7.5,5],center=true);
               translate([0,0,ball/2-bolt_hh-1])cylinder(d=bolt_head,h=bolt_hh+1);
           }
           rotate([90,0,0])cylinder(d=6.4,h=ball+2*(wall+2*tolx),center=true);
           translate([0,0,1.5/2*25.4]){
                rotate([0,90,0])cylinder(d=7,h=ball+2*tolx,center=true);
                translate([0,0,-2])rotate([0,90,0])rotate([0,0,45])cube([4,4,ball+2*tolx],center=true);}
           translate([0,-ball+bolt_head/2+wall,0])cube([ball,ball,ball],center=true);
        }
    }
}

module both(){
    stem();
    ball();
}