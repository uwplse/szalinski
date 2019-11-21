
tubeDia=30;
thick=3;
stageHeight=45;
stageLength=150;
rotateAngle=93;

stageWidth=tubeDia+thick*2;
tubeLength=(stageLength-thick)*cos(rotateAngle-90);

gapHeight=(stageHeight-thick)/cos(rotateAngle-90)-tubeDia/2;
gapXmove=(gapHeight+tubeDia/2)*sin(rotateAngle-90);
x=(tubeDia/2)/tan(rotateAngle-90);
gapZmove=(x+tubeLength)*sin(rotateAngle-90)+thick;



difference(){
linear_extrude(stageHeight)
square([stageLength,stageWidth]);

translate([-gapXmove,stageWidth/2,gapZmove])
rotate([0,rotateAngle,0])
linear_extrude(tubeLength){
    #circle(d=tubeDia);
    translate([-gapHeight,-tubeDia/2])
        square([gapHeight,tubeDia]);

    }

}