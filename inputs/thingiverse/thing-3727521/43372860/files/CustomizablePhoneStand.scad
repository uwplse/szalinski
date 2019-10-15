//Variables

//Print the Stand, the Fit test or Both?
part = "Stand"; // [Stand:Full Stand,Test:Fit Test,Both:Print Both]

//All measurements in milimeters
//Width of the phone/tablet
width = 77.7;
//Thickness of the phone/tablet
thick = 9.7;
//Center of the USB jack from left
usbc = 38.85;
//Adjust USB +/- from center, front to back
usboff = 0;
//Width of USB connector shell
usbx = 12.7;
//Thickness of USB connector shell
usby = 6.35;
//Height of USB connector shell, including strain relief
usbz = 31.75;
//Diameter of USB cable
usbd = 4.75;
//Height of the cradle around the phone/tablet (for finished Stand only)
height = 50;
//Total Height of the TEST cradle (for fit test only)
theight = 20;

print_part();

module print_part() {
    if (part == "Stand"){
        stand();
    }else if (part == "Test"){
        test();
    }else if (part == "Both"){
        stand();
        test();
    }
}
//
module stand(){
difference(){
union(){
    rotate([-15,0,0])
        translate([0,-2.6,10])
            cube([width+8,thick+10,height+usbz-5]);
    cube([width+8,(usbz/10)+height,10.4]);
}
rotate([-15,0,0]){
    union(){
        translate([4,2,usbz+5])
            cube([width,thick,height+1]);
        translate([6,-thick,usbz+5])
            cube([width-4,thick+10,height+1]);
        translate([4+usbc-(usbx/2),2+(thick/2)-(usby/2)+usboff,5])
            cube([usbx,usby,usbz+1]);
    }
}
translate([4+usbc-(usbd/2),usboff+10,5.75-usbd])
    cube([usbd,(usbz/2)+height,usbd]);
translate([4.5+usbc-(usbd/2),usboff+10,-1])
    cube([usbd-1,(usbz/2)+height,usbd]);
translate([usbc-usbx/2+4,usboff+0.2,0])
    rotate([-15,0,0])
        cube([usbx,15,10]);
}}

module test(){
difference(){
    union(){
        cube([width+2,thick+2,theight+2]);
    }
    union(){
        translate([1,1,1])
            cube([width,thick,100]);
        translate([1+usbc-(usbx/2),1+(thick/2)-(usby/2)+usboff,-1])
            cube([usbx,usby,20]);
    }
}}