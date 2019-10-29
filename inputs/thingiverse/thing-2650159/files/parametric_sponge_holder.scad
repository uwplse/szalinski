$fn=50/15;
spongecount=2;
sponge1depth=70;
sponge2depth=70;
sponge3depth=100;
sponge1angle=80;
sponge2angle=80;
sponge3angle=80;
sponge1thickness=2.5;
sponge2thickness=2.5;
sponge3thickness=2.5;
sponge1height=70;
sponge2height=70;
sponge3height=58;
sponge1width=20;
sponge2width=20;
sponge3width=20;
spongespacer=7;
basethickness=2.5;
depth=max(sponge1depth,sponge2depth,sponge3depth);
sponge1adj=(cos(sponge1angle)* sponge1height);
sponge2adj=(cos(sponge2angle)* sponge2height);
sponge3adj=(cos(sponge3angle)* sponge3height);
width1=(sponge1adj*2)+sponge1width+spongespacer/2;
width2=(sponge2adj*2)+sponge2width+spongespacer/2;
width3=(sponge3adj*2)+sponge3width+spongespacer/2;
vertholewidth=15;
vertholewidthspacer=2;
vertholewidthspace=vertholewidth+vertholewidthspacer;
vertholeheight=4;
vertholeheightspacer=4;
vertholeheightspace=vertholeheight+vertholeheightspacer;
vertholeedge=4;
sponge1supportwidth=sponge1width+sponge1thickness;
sponge2supportwidth=sponge2width+sponge2thickness;
sponge3supportwidth=sponge3width+sponge3thickness;
sponge1supportheight=4;
sponge2supportheight=4;
sponge3supportheight=4;
sponge1supportdepth=2;
sponge2supportdepth=2;
sponge3supportdepth=2;
sponge1supporthole=3;
sponge2supporthole=3;
sponge3supporthole=3;
spongeholeratio=3;




module spongearm (move,spongeadj,spongespacer,spongethickness,spongedepth, spongeheight,spongeangle){
    rotate([0,spongeangle,0]) hull(){
        cube([spongethickness,1,1], center=true);
        translate([0,spongedepth-1,0]) cube([spongethickness,1,1], center=true);
        translate([0,0,spongeheight-spongethickness/2]) sphere(d=spongethickness, center=true);
        translate([0,spongedepth-spongethickness/2,spongeheight-spongethickness/2]) sphere(d=spongethickness, center=true);
    }
}

module spongeholder(move,spongespacer,basewidth,spongedepth,basethickness,spongeadj,spongeangle,spongethickness,spongeheight,spongewidth,spongesupportheight,spongesupportwidth,spongesupportdepth,spongesupporthole) {
    union(){
        difference() {
            union(){
                translate([move+spongeadj+spongespacer/4,.5,basethickness/3]) spongearm(move,spongeadj,spongespacer,spongethickness,spongedepth,spongeheight,spongeangle-90);
                translate([move+spongeadj+spongewidth+spongespacer/4,.5,basethickness/3])spongearm(move+spongewidth,spongeadj,spongespacer,spongethickness,spongedepth,spongeheight,10);
                translate([move,0,0]) cube([basewidth,spongedepth,basethickness]);
                translate([move+basewidth/2,spongesupportdepth/2,basethickness+spongesupportheight/2+spongesupporthole]) cube([spongesupportwidth,spongesupportdepth,spongesupportheight], center=true);
            }
            translate([move,0,-spongeheight]) cube([basewidth,spongedepth,spongeheight]);
 
            numiverthole=floor((spongeheight-vertholeedge-basethickness)/vertholeheightspace)+1;
            for (i=[spongeheight-numiverthole*vertholeheightspace-((spongeheight-numiverthole*vertholeheightspace)/2)+vertholeedge*2:vertholeheightspace:numiverthole*vertholeheightspace]){     //for (i=[3+basethickness: 7 : spongeheight]){


                numjverthole=floor((spongedepth-vertholeedge*2)/vertholewidthspace)+1;
                for (j=[(spongedepth-vertholeedge*2-(numjverthole-1)*vertholewidthspace )-((spongedepth-numjverthole*vertholewidthspace)/2)+vertholewidthspacer/2+vertholeheight/2:vertholewidthspace:numjverthole*vertholewidthspace]) {
                    echo("J");
                    echo(i,j,spongedepth,numjverthole,vertholeedge,vertholewidthspace,spongedepth-vertholeedge*2,(spongedepth-vertholeedge*2)/vertholewidthspace );
        
                    if((i+vertholeedge+vertholeheight<=spongeheight)) {
                        if(j+vertholewidth<=spongedepth){
                            echo("make");
                            translate([move+basewidth/2,j,i]) {
                                hull(){
                                    rotate([0,90,0]) cylinder(d=vertholeheight,h=basewidth, center=true);
                                    translate([0,vertholewidth-vertholeheight,0]) rotate([0,90,0]) cylinder(d=vertholeheight, h=basewidth, center=true);
                                }
                            }
                            translate([move+spongeadj+spongewidth/2+spongespacer/4,j,0]) {
                                //need to fix scale here to use variables
                                scale([spongeholeratio,1,1]) 
                                hull(){
                                    cylinder(d=vertholeheight,h=basewidth, center=true);
                                    translate([0,vertholewidth-vertholeheight,0]) cylinder(d=vertholeheight, h=basewidth, center=true);
                                }
                            }
                            
                            
                            
                        }
                    }
                }
            } 
        }
        translate([move,spongedepth/4,0]) scale([1,1.5,1]) rotate([0,90,0]) cylinder(r=basethickness,h=basethickness);
        translate([move+basewidth-basethickness,spongedepth/4,0]) scale([1,1.5,1]) rotate([0,90,0]) cylinder(r=basethickness,h=basethickness);
        translate([move,spongedepth/4*3,0]) scale([1,1.5,1]) rotate([0,90,0]) cylinder(r=basethickness,h=basethickness);
        translate([move+basewidth-basethickness,spongedepth/4*3,0]) scale([1,1.5,1]) rotate([0,90,0]) cylinder(r=basethickness,h=basethickness);
    }
}

module makesponge(){
    union(){
        spongeholder(0,spongespacer,width1,sponge1depth,basethickness,sponge1adj,sponge1angle,sponge1thickness,sponge1height,sponge1width,sponge1supportheight,sponge1supportwidth,sponge1supportdepth,sponge1supporthole);
        if (spongecount>1) {
            spongeholder(width1,spongespacer,width2,sponge2depth,basethickness,sponge2adj,sponge2angle,sponge2thickness,sponge2height,sponge2width,sponge2supportheight,sponge2supportwidth,sponge2supportdepth,sponge2supporthole);
        }
        if (spongecount>2){
            spongeholder(width1+width2,spongespacer,width3,sponge3depth,basethickness,sponge3adj,sponge3angle,sponge3thickness,sponge3height,sponge3width,sponge3supportheight,sponge3supportwidth,sponge3supportdepth,sponge3supporthole);
        }
    }
}



makesponge();
