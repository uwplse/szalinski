//Prelim luggage handle fix

//These are the original dims from Beckman.
//rectanglength = 165.1;
//rectangwidth = 12.7;
//rectangheight = 5.84;
//rectanglastheight = 4.45;
//smallrectlength = 15.24;
//smallrectwidth = 14.24;
//guidedia = 7.87;
//guideXfromcenter = 92.25/2;
//pushlength = 48.26;
//pushwidth = 14.73;
//pushheight = 20.32;
//taperangle = 90-ceil(atan(((rectanglength/2)-((guideXfromcenter+smallrectlength/2)))/(rectangheight-rectanglastheight)));
//echo(taperangle);

//These are the new dims with my caliper
rectangwidth = 12.7;
rectanglength = 165.1-rectangwidth; //subtract out the diameter of the end circles
rectangheight = 5.84;
rectanglastheight = 4.45;
smallrectlength = 10.5;
smallrectwidth = 15.6;
guidedia = 8;
guideXfromcenter = (103-guidedia)/2;
pushlength = 49.5;
pushwidth = 14.5;
pushheight = 21.5;
filletdia = 5;
taperangle = 90-ceil(atan(((rectanglength/2)-((guideXfromcenter+smallrectlength/2)))/(rectangheight-rectanglastheight)));


difference(){
    union(){
        translate([-rectanglength/2,-rectangwidth/2,0])cube([rectanglength,rectangwidth,rectangheight]);
        for(i=[-1:2:1]){
            translate([i*rectanglength/2,0,0])cylinder(h=rectangheight,d=rectangwidth);
            translate([i*(guideXfromcenter)-(smallrectlength/2),-smallrectwidth/2,0])    cube([smallrectlength,smallrectwidth,rectangheight]);
        }
        minkowski(){
            scale([pushlength-filletdia,pushwidth-filletdia])cylinder(h=pushheight-(filletdia/2),d=1,$fn=50);
            sphere(d=filletdia,$fn=50);
        }
    }
    //Start difference
    for(i=[-1:2:1]){
        translate([i*(guideXfromcenter),0,0])cylinder(h=rectangheight,d=guidedia);
        translate([i*(guideXfromcenter+(smallrectlength/2)),0,rectangheight+rectangheight/2])rotate([0,i*taperangle,0])translate([i*(rectanglength/4),0,0])cube([rectanglength/2,smallrectwidth,rectangheight],center=true);
    }
    translate([0,0,-rectangheight/2])cube([pushlength,pushwidth,rectangheight],center=true);
    translate([0,0,pushheight-1.0])linear_extrude(height = 2, convexity = 10)text("BECKMAN", font="Oswald", size=7, valign="center", halign="center");
}
//#translate([0,0,0])import("suitecase repair.stl",convexity=20);