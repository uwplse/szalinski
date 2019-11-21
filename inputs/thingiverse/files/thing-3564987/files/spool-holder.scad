//Hello World!
$fn=100.0;
bodyThickness=4.0;
bearingDiameter=22.0;
bearingWidth=7.0;
bearingInnerDiameter=8.0;
bearingClearance=2.0;
spoolDiameter=195.0;
spoolWidth=80.0;
spoolClearance=2.0;
union(){
  translate([sqrt((pow(((spoolDiameter/2.0)+(bearingDiameter/2.0)),2.0)-pow((((spoolDiameter/2.0)+spoolClearance)-(bearingDiameter/2.0)),2.0))),((spoolWidth/2.0)+1.0),(bearingDiameter/2.0)]){
    rotate([90.0, 0.0, 0.0]){
      union(){
        cylinder(1.0, ((bearingInnerDiameter/2.0)+2.0), ((bearingInnerDiameter/2.0)+2.0));
        cylinder(((1.0+bearingWidth)+2.0), (bearingInnerDiameter/2.0), (bearingInnerDiameter/2.0));
      }
    }
  }
  translate([sqrt((pow(((spoolDiameter/2.0)+(bearingDiameter/2.0)),2.0)-pow((((spoolDiameter/2.0)+spoolClearance)-(bearingDiameter/2.0)),2.0))),(((-spoolWidth)/2.0)-1.0),(bearingDiameter/2.0)]){
    rotate([-90.0, 0.0, 0.0]){
      union(){
        cylinder(1.0, ((bearingInnerDiameter/2.0)+2.0), ((bearingInnerDiameter/2.0)+2.0));
        cylinder(((1.0+bearingWidth)+2.0), (bearingInnerDiameter/2.0), (bearingInnerDiameter/2.0));
      }
    }
  }
  translate([(-sqrt((pow(((spoolDiameter/2.0)+(bearingDiameter/2.0)),2.0)-pow((((spoolDiameter/2.0)+spoolClearance)-(bearingDiameter/2.0)),2.0)))),((spoolWidth/2.0)+1.0),(bearingDiameter/2.0)]){
    rotate([90.0, 0.0, 0.0]){
      union(){
        cylinder(1.0, ((bearingInnerDiameter/2.0)+2.0), ((bearingInnerDiameter/2.0)+2.0));
        cylinder(((1.0+bearingWidth)+2.0), (bearingInnerDiameter/2.0), (bearingInnerDiameter/2.0));
      }
    }
  }
  translate([(-sqrt((pow(((spoolDiameter/2.0)+(bearingDiameter/2.0)),2.0)-pow((((spoolDiameter/2.0)+spoolClearance)-(bearingDiameter/2.0)),2.0)))),(((-spoolWidth)/2.0)-1.0),(bearingDiameter/2.0)]){
    rotate([-90.0, 0.0, 0.0]){
      union(){
        cylinder(1.0, ((bearingInnerDiameter/2.0)+2.0), ((bearingInnerDiameter/2.0)+2.0));
        cylinder(((1.0+bearingWidth)+2.0), (bearingInnerDiameter/2.0), (bearingInnerDiameter/2.0));
      }
    }
  }
  difference(){
    translate([((((-sqrt((pow(((spoolDiameter/2.0)+(bearingDiameter/2.0)),2.0)-pow((((spoolDiameter/2.0)+spoolClearance)-(bearingDiameter/2.0)),2.0))))-bearingClearance)-(bearingDiameter/2.0))-bodyThickness),((((-spoolWidth)/2.0)-1.0)-bodyThickness),(-bearingClearance)]){
      cube([((((2.0*sqrt((pow(((spoolDiameter/2.0)+(bearingDiameter/2.0)),2.0)-pow((((spoolDiameter/2.0)+spoolClearance)-(bearingDiameter/2.0)),2.0))))+(2.0*bearingClearance))+bearingDiameter)+(2.0*bodyThickness)), ((spoolWidth+2.0)+(2.0*bodyThickness)), (bearingDiameter+(2.0*bearingClearance))]);
    }
    translate([(((-sqrt((pow(((spoolDiameter/2.0)+(bearingDiameter/2.0)),2.0)-pow((((spoolDiameter/2.0)+spoolClearance)-(bearingDiameter/2.0)),2.0))))-bearingClearance)-(bearingDiameter/2.0)),(((-spoolWidth)/2.0)-1.0),((-bearingClearance)-0.5)]){
      cube([(((2.0*sqrt((pow(((spoolDiameter/2.0)+(bearingDiameter/2.0)),2.0)-pow((((spoolDiameter/2.0)+spoolClearance)-(bearingDiameter/2.0)),2.0))))+(2.0*bearingClearance))+bearingDiameter), (spoolWidth+2.0), ((bearingDiameter+(2.0*bearingClearance))+1.0)]);
    }
  }
}
//Goodbye World!
