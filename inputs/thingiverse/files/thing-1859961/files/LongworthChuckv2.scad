//dimensions are in inches
chuckdia=10;
chuckthick=.125; //thickness of material

adapterdia=3;
offsetedge=.75;
centerholedia=.25;

washerthick=1/16;
boltdia=.25;

numberarcs=4;
arcangle=75; //max 90 deg

numberholes=numberarcs;
fingerholedia=.75;
//manually enter angle for rotating the fingerholes as it changes with chuck diameter being on the inside or outside of the arc, also entering custom number of holes... 
fingerrotate=60;

res=100;

//calculations for inches
chuckdiain=chuckdia*25.4;
chuckthickin=chuckthick*25.4;
adapterdiain=adapterdia*25.4;
offsetedgein=offsetedge*25.4;
centerholediain=centerholedia*25.4;
washerthickin=washerthick*25.4;
boltdiain=boltdia*25.4;
fingerholediain=fingerholedia*25.4;

//calculations for centerpoint of arc
arcmidpoint=(((adapterdiain/2)+(chuckdiain-offsetedgein))/2);
arcradius=arcmidpoint+(adapterdiain/2);


module chuck(){

difference(){
    cylinder(h=chuckthickin, d=chuckdiain, center=true, $fn=res);
    cylinder(h=chuckthickin, d=centerholediain, center=true, $fn=res);
}
}

module arc(){
    translate([-arcmidpoint/2,0,0])
    rotate_extrude (angle=arcangle, convexity=10, $fn=res) translate([(arcradius/2)+(offsetedgein),0,0]) circle(r= boltdiain/2, $fn=res);
}

module fingerhole(){
    rotate([0,0,fingerrotate])
    translate([(chuckdiain/2)-(offsetedgein+(fingerholediain/2)), 0, 0])
    cylinder(h=chuckthickin, d=fingerholediain, center=true, $fn=res);
}
module longworthholes(){    
difference(){
difference(){
    chuck();
    for (i=[0:numberarcs])
        {rotate([0,0,i*360/numberarcs])
        arc();}
    }
    for (i=[0:numberarcs])
        {rotate([0,0,i*360/numberholes])
           fingerhole();
}
}
}

module longworth(){
    difference(){
    chuck();
    for (i=[0:numberarcs])
        {rotate([0,0,i*360/numberarcs])
        arc();}
    }
}

module longworthadapter(){
    difference(){
        longworthholes();
        cylinder(h=chuckthickin/2, d=adapterdiain, center=false, $fn=res);
    }
}

//longworth();
longworthholes();
//longworthadapter();