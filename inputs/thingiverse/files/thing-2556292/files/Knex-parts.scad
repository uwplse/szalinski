//this is all of the knex parts. all of them.
/*
    PARTS: dont be afraid to preview, these should render quickly.
        **RODS**
    0 = black/green connector
    1 = marble/white connector
    2 = blue connector
    3 = yellow connector
    4 = red connector
    5 = grey connector
    
        **SPACERS**
    6 = grey spacer
    7 = blue spacer
    
        **CONNECTORS**
    8 = grey connector (1 connector bit and hole)
    9 = marble connector
    10 = red connector
    11 = green connector
    12 = yellow connector
    13 = white connector
    14 = orange connector
    
    RodEnd for most things is = 8.15mm
    
    
    debugs = 100 and up.
    100 = male connector rod end
    101 = connector rod center
    102 = connector hole or spacer.
    103 = connector part center
    104 = connector part triangle
    105 = female connector part end
    106 = female connector full end
*/
part = 9;
/*
    PARTS: dont be afraid to preview, these should render quickly.
        **RODS**
    0 = black/green connector
    1 = marble/white connector
    2 = blue connector
    3 = yellow connector
    4 = red connector
    5 = grey connector
    
        **SPACERS**
    6 = grey spacer
    7 = blue spacer
    
        **CONNECTORS**
    8 = grey connector (1 connector bit and hole)
    9 = marble connector
    10 = red connector
    11 = green connector
    12 = yellow connector
    13 = white connector
    14 = orange connector
    
    RodEnd for most things is = 8.15mm
    
    
    debugs = 100 and up.
    100 = male connector rod end
    101 = connector rod center
    102 = connector hole or spacer.
    103 = connector part center
    104 = connector part triangle
    105 = female connector part end
    106 = female connector full end
*/
/*CHANGELOG
version 0.1: initial thing, not exact numbers and just rods
version 0.2: rods got updated dims, got digital calipers. beginning of connectors.
*/
    //rods
if(halved==1)
    
if(part==0)
    rotate([0,90,0])
    fullRod2(17.3,0);
if(part==1)
    rotate([0,90,0])
    fullRod(7,19);
if(part==2)
    rotate([0,90,0])
    fullRod(8.15,38.3);
if(part==3)
    rotate([0,90,0])
    fullRod2(85.5,69.2);
if(part==4)
    rotate([0,90,0])
    fullRod2(129.9,113.5);
if(part==5)
    rotate([0,90,0])
    fullRod(8.15,192);

    //spacers
if(part==6)
    ConnectorCenter(3,1.4);
if(part==7)
    ConnectorCenter(2.95,1.4);

    //connectors
if(part==8)
    Connector(1,360+360/8);
if(part==9)
    Connector(2,360+360/8);
if(part==10)
    Connector(3,360+360/8);
if(part==11)
    Connector(4,360+360/8);
if(part==12)
    Connector(5,360+360/8);
if(part==13)
    Connector(9,360+360/8);
if(part==14)
    Connector(2,360+360/2);


knexDiameter=6.25;


if(part==100)
    RodEnd(8.6);

if(part==101)
    RodCenter(19);

if(part==102)
    ConnectorCenter(9.20);
if(part==105)
    ConnectorEndpt(1,1,1);
if(part==106)
    ConnectorEnd();
if(part==104)
    ConnectorLinkCenter();

module RodEnd(height){
    difference(){
        cylinder(h=height,d=knexDiameter,$fn=50);
        translate([0,0,height-3.1])
        scale([1,1,1.93])
        rotate_extrude(convexity=10,$fn=30)
        translate([3.125, 0, 0])
        scale([1,1,0])
        circle(r=0.905,$fn=20);
    }
}
module RodCenter(length){
    //rotate([0,0,45])
    intersection(){
        cylinder(h=length,d=knexDiameter,$fn=50);
        union(){
            translate([-.95,-knexDiameter/2,0])
            cube([1.9,knexDiameter+1,length]);
            translate([-knexDiameter/2.,-.95,0])
            cube([knexDiameter+1,1.9,length]);
        }
    }
}
module fullRod(height,length){
    translate([0,0,length])
    RodEnd(height);
    RodCenter(length);
    mirror([0,0,1])
    RodEnd(height);
    
}
module fullRod2(external,internal){
    fullRod((external-internal)/2,internal);
}
module ConnectorCenter(height,width){
    //translate([(6.55+width)/2,0,0])
    difference(){
        cylinder(h=height,d=6.55+width*2,$fn=50);
        translate([0,0,-0.5])
        cylinder(h=height+1,d=6.55,$fn=50);
    }
}
module ConnectorEndpt(i,c,a,j){
    union(){
        translate([0,0,9.4-1])
        cube([6.16,9.35/2,1]);
        cube([6.16,1.2,9.4]);
        translate([6.16/2,1.23,6.16-3.8/5])
        scale([1,2.3,3.4])
        rotate([0,90,0])
        cylinder(d=1,h=6.16,$fn=25,center=true);
        linear_extrude(height=6)
        difference(){
            polygon(points=[[0,0],[6.16,0],[6.16,1.8],[6.16-1.46,2.15],[1.46,2.15],[0,1.8]]);
            translate([6.16/2,9.35/2,0])
            //resize([1,1])
            circle(d=6.25,$fn=90);
        }
    }
    if(i>0){
        if((((i==c&&j==1)||(i==1&&j==2))&&c<8)||a-360>80){
            echo(i,c,j);
            translate([0,0,9])
            cube([6.16,1.4,10]);}
        else {//if((((i!=c&&i!=1)&&(j!=2||i==j))||(j==1&&i==1&&c!=1))&&a<=70){//(i!=c&&i!=1)||a<45){
            echo(i,c,j);
            translate([0,0,9.25])
            rotate([-45/2])
            cube([6.16,1.4,7]);}
    }
    //cube([9.85,9.3,6.15]);
}
module ConnectorEnd(i=0,c=0,a=45){
    translate([0,-9.35/2,6.16])
    rotate([0,90,0])
    union(){
        ConnectorEndpt(i,c,a,1);
        translate([0,9.35,0])
        mirror([0,1,0])
        ConnectorEndpt(i,c,a,2);
    }
}
module ConnectorLinkCenter(angle,distance){
    
}
module Connector(c,a=45,hole=true){
    //c connector, a = angle, hole = hole in center. 
    union(){
        ConnectorCenter(6.16,1.4);
        for(i=[1:c]){
            rotate(a=[0,0,(i-1)*a])
            translate([-((23.15-(6.5+1.4)/2))+0.5,0,0])
            ConnectorEnd(i,c,a);
            //echo(i);
        }
    }
}