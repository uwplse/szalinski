//PARAMETERS
$fa=2;
$fs=.1;

//Defined
design=0; //display things differently during design
plug=0;
shaftD=33.3;
shaftCapOverlap=33;
capT=5; //roundover radius, too, but ignored otherwise for plug
capRnd=10;
capTTaper=0; // ratio of final thickness to initial thickness; ignored for plug
shaftToCapTol=.2; //ignored for plug
tetherExtraL=40;
tetherT=0;
tetherShaftTol=0; 
shaftCapTol=plug==1?0:shaftToCapTol;
//capD=15; //calculated if not set
capD=capD==undef?shaftD+capT*2+shaftCapTol*2:capD;
tetherID=tetherID==undef?shaftD+2*tetherShaftTol:tetherID; //because of weirdness, this calculation needs to come before the actual definition of tetherID to a concrete value
tetherID=30; // if undefined will be calculated based on shaftD

//Calculated
capT1Ratio=plug==1?0:capTTaper;
capCylinderH=shaftCapOverlap;
capD1=shaftD+capT*2*capT1Ratio+shaftCapTol*2;
capR=capD/2;
capR1=capD1/2;
capRX=capR-capRnd;
capID=shaftD+shaftCapTol*2;
capIR=capID/2;
capOaH=capCylinderH+capRnd;
tetherL=capR+capOaH*PI/2+capT+tetherExtraL;

union(){
    difference(){
        hull(){
            //main cylinder
            cylinder(d1=capD1,d2=capD,h=capCylinderH);
            //top
            translate([0,0,capCylinderH])
                rotate_extrude(){
                    translate([capRX,0,0])
                        circle(r=capRnd);
                    square([capRX,capRnd]);
                }
        };
        //hole
        if(plug==0)
            cylinder(d=capID,h=shaftCapOverlap);
        if(design==1)
            cube([2*capOaH,2*capOaH,2*capOaH]);
    };

    //tether
    translate([0,0,capOaH-tetherT]){
        translate([0,-tetherT/2,0])
            cube([tetherL,tetherT,tetherT]);
        //loop
        translate([tetherL+tetherID/2,0,0])
            difference(){
                cylinder(d=tetherID+2*tetherT+2*tetherShaftTol,h=tetherT);
                cylinder(d=tetherID,h=tetherT);
            }    
    }
}
echo(capD1,capD,capRX,capRnd,capOaH);    

