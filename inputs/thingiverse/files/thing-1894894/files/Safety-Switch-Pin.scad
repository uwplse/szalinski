//millimeters

radius=1;
radius2=.5;
x=14;
x1=17;
y=8;
y1=9;
keyx=13;
keyx1=9.6;
keyy=3.8;
keyy1=2.8;

res=30;

module front(){
linear_extrude(.1){
hull()
{
    translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius, $fn=res);

    translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius, $fn=res);

    translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius, $fn=res);

    translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius, $fn=res);
        }
    }   
}

module step(){
linear_extrude(.1){
hull()
{
    translate([(-x1/2)+(radius/2), (-y1/2)+(radius/2), 0])
    circle(r=radius, $fn=res);

    translate([(x1/2)-(radius/2), (-y1/2)+(radius/2), 0])
    circle(r=radius, $fn=res);

    translate([(-x1/2)+(radius/2), (y1/2)-(radius/2), 0])
    circle(r=radius, $fn=res);

    translate([(x1/2)-(radius/2), (y1/2)-(radius/2), 0])
    circle(r=radius, $fn=res);
        }
    }
}

module key1(){
linear_extrude(.1){
hull()
{
    translate([(-keyx/2)+(radius2/2), (-keyy/2)+(radius2/2), 0])
    circle(r=radius2, $fn=res);

    translate([(keyx/2)-(radius2/2), (-keyy/2)+(radius2/2), 0])
    circle(r=radius2, $fn=res);

    translate([(-keyx/2)+(radius2/2), (keyy/2)-(radius2/2), 0])
    circle(r=radius2, $fn=res);

    translate([(keyx/2)-(radius2/2), (keyy/2)-(radius2/2), 0])
    circle(r=radius2, $fn=res);
        }
    }
}

module key2(){
linear_extrude(.1){
hull()
{
    translate([(-keyx1/2)+(radius2/2), (-keyy1/2)+(radius2/2), 0])
    circle(r=radius2, $fn=res);

    translate([(keyx1/2)-(radius2/2), (-keyy1/2)+(radius2/2), 0])
    circle(r=radius2, $fn=res);

    translate([(-keyx1/2)+(radius2/2), (keyy1/2)-(radius/2), 0])
    circle(r=radius2, $fn=res);

    translate([(keyx1/2)-(radius2/2), (keyy1/2)-(radius2/2), 0])
    circle(r=radius2, $fn=res);
        }
    }
}

module base(){
hull(){
    front();
    translate([0,0,5.65]) step();
}
}

module keys(){
    hull(){
    key1();
    translate([0,0,15.5]) key2();
}
}


module pin(){
    cube([6,4.5,1], center=true);
}
union(){
    base();
    translate([0,0,5.75]) keys();
    translate([0,0,8+5.75]) pin();
}