//Makes a hole grommet that a USB cable plug or socket can be jammed into.
//Locking ring has a side screw to hold it, and clamp USB connector
// anti-rotation key provided
/*[Global]*/
//Choose Which parts to show
Show="all"; //[all,flange,ring,usb]

//Choose the view
//View="printable"; //[assembly, exploded, printable]
//View="assembly";
View="exploded"; //[assembly, exploded, printable]

//Display USB Plug
ViewUSB="showusb"; //[showusb,hideusb]

/*[Panel]*/
//Diameter of hole that grommet goes through
MountingHoleD=17.6;

HoleR=MountingHoleD/2;

//Thickness of case material - small burring is OK as a broove is provided for it
PanelH=1.6;
//inside suffers from a raised edge from drilling, so recess it
PanelBurrBevel=1.5;

//correction for holes being small on UP printer
holeos=0.3;

/*[Flange]*/
//Outside Flange is bigger than Mounting Hole by this much (each side)
FlangeW=5;

FlangeOR=(MountingHoleD+FlangeW*2) /2;

FlangeH=FlangeW;
FlangeBevel=FlangeW*2/3;

//width of anti-rotation key tit. Set to 0 to not have it. (or just cut it off)
KeyW=2;
//Height of key above panel thickness, i.e. into ring
KeyH=4;

/*[Ring]*/
//Thickness of the internal Ring part (protrusion into the internal space)
InternalH=8;
//diameter of screw holes that screw ring to flange and locks USB in place. (Length of screw is shown on console)
ScrewD=2.4;
ScrewIR=(ScrewD+holeos)/2;

/*[USB]*/
//Size of USB plug moulding at widest part - this is a compression fit
USBX=16.1;
USBY=8.3;
//How to Grip the USB plug: Everything below here is relevant to positive retention only, for compression+screw you can ignore it.
USBGripStyle="compression"; //[compression, positive-not-implemented]
//Moulding length at main width. Only used when using positive restention
USBZ=18.7;
//Length of tapering moulding back to narrow rectangle part
USBZ1=4;
//Smaller rectangle before strain relief
USBZ2=8;
USBY2=7.8;
USBX2=10.9;
//diameter at the strain relief
USBReliefD=7.6;
USBReliefR=USBReliefD/2;
USBReliefZ=6;
//diameter of the cable
USBCableD=4/2;
USBCableR=USBCableD/2;
USBCableZ=5;

//Select Male or Female USB socket 
USBGender="female"; //[male,female]
//USBGender="female";
//Dimensions of metal part. 
USBMaleX=12.2;
USBMaleY=4.6;
USBMaleZ=12.8;

USBFemaleX=14.4;
USBFemaleY=7.3;
USBFemaleZ=9.4;

//-------------
H=PanelH+InternalH+FlangeH;


echo(str("Screw thread length = ", FlangeOR-USBY/2,"mm"));
echo(str("Flange Diameter = ",FlangeOR*2,"mm"));

//Make a cube which is centred on some axes
//center can be xy,x,y,z,true, 
// if ends with "-" then extends Z and offsets, for use in differences
module cubec(size=1, center="xy", offset=[0,0,0]) {
//    //if (center[len(center)-1] =="-") { 
//    if (offset=="-") {
//        size=size+[0, 0, .02];
//        //offset=offset - [0, 0, 0.01];
//         offset = [0, 0, 0.01];
//    }//if
// 
    if (center=="xy")  translate( offset + [-size[0]/2, -size[1]/2, 0]) cube(size);
    if (center=="x")   translate(offset+[-size[0]/2, 0, 0]) cube(size);
    if (center=="y")   translate(offset+[0, -size[1]/2, 0]) cube(size);
    if (center=="z")   translate(offset+[0,0,-size[2]/2]) cube(size);
    if (center==true || center=="xyz") translate(-size/2) cube(size);      
}//mod


module USBHole() {
    cubec([USBX,USBY,H+0.02],center="xy", offset=[0,0,-0.01]);
}//mod

//makes a USB plug shape
module USBPlug() {
    if (USBGender=="male") {
            translate([0,0,-USBMaleZ]) cubec([USBMaleX,USBMaleY,USBMaleZ],center="xy");
    }else{
            translate([0,0,-USBFemaleZ]) cubec([USBFemaleX,USBFemaleY,USBFemaleZ],center="xy");
    }//if
        
    hull() {
    cubec([USBX,USBY,USBZ],center="xy");
    translate([0,0,USBZ]) cubec([USBX2,USBY2,USBZ1],center="xy");
    }
    translate([0,0,USBZ+USBZ1]) cubec([USBX2,USBY2,USBZ2],center="xy");
    translate([0,0,USBZ+USBZ1+USBZ2]) cylinder(r=USBReliefR, h=USBReliefZ);
    translate([0,0,USBZ+USBZ1+USBZ2+USBReliefZ]) cylinder(r=USBCableR, h=USBCableZ);
}//mod

module Screw() {
    rotate([90,0,0]) cylinder(r=ScrewIR, h=FlangeOR*2+5,$fn=20,center=true);
}

//------------------------------------------------------------

module FlangePart() {
   color("red") 
difference() {    
    union() {
        //flange
        cylinder(r1=FlangeOR-FlangeBevel, r2=FlangeOR, h=FlangeBevel); 
        difference() {
            translate([0,0, FlangeBevel]) 
                cylinder(r=FlangeOR, h=FlangeH-FlangeBevel);
                translate([0,0,FlangeH-PanelBurrBevel+0.01]) cylinder(r1=HoleR+0.5, r2=HoleR+PanelBurrBevel, h=PanelBurrBevel);    
        }//diff
        //rod
        cylinder(r=HoleR, h=H);
        rotate([0,0,60]) translate([HoleR,0,FlangeH]) 
                cubec([KeyW*2,KeyW,KeyH+PanelH],center="xy");
    }//union
    USBHole();
    translate([0,0,FlangeH+PanelH+InternalH/2]) Screw();
    
}//diff 
}//mod

module Ring() {
        difference() {
        union() {
         cylinder(r=FlangeOR, h=InternalH*3/4);
         translate([0,0,InternalH*3/4]) cylinder(r1=FlangeOR,r2=FlangeOR-InternalH/4, h=InternalH/4);   
        }//union   
         USBHole();
         translate([0,0,-0.01]) {
             cylinder(r=HoleR+holeos, h=H+0.01);
             cylinder(r2=HoleR, r1=HoleR+PanelBurrBevel, h=PanelBurrBevel);    
         }
         translate([0,0,InternalH/2]) Screw(); //screw holes
         rotate([0,0,60]) translate([HoleR,0,-0.01]) 
                cubec([KeyW*2+0.2,KeyW+0.2,KeyH+0.02],center="xy"); //key slot
    }
}//mod



//Main
if ((ViewUSB=="showusb" && View!="printable") || Show=="usb") color("lightgreen") 
    if (View=="exploded") {
            translate([0,0,H+FlangeH+PanelH]+20) USBPlug();
    }else{
        USBPlug();
    }

if (Show=="all" || Show=="flange")  FlangePart();

if (Show=="all" || Show=="ring")
     color("cyan")
    if (View=="assembly") {
        translate([0,0,FlangeH+PanelH]) Ring();  
    } else {
         if (View=="exploded") {
            translate([0,0,H+FlangeH+PanelH]) Ring();  
         }else {
            translate([FlangeOR*2+5,0,InternalH]) rotate([0,180,0]) Ring();  //ready to print
         }
    }
