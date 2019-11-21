$fn=100*1;

//All sizes are in mm
BusinessEnd   = "false";//[true,false]
OuterDiameter = 50;
InnerDiameter = 40;
PlateWidth    = 50;
PlateLength   = 80;
TubeLength    = 55; 

odr = OuterDiameter/2;
idr = InnerDiameter/2;


maintube = (OuterDiameter+10)/2;

difference(){
    pos();
    neg();
}


module pos(){
    
    if(BusinessEnd=="true"){
        cylinder(r=maintube,h=15);
    }else{
        cylinder(r=maintube,h=25);
    }
    
    
    //Inlet
    if(BusinessEnd=="false"){
        rotate([90,0,45]){
            translate([0,11,odr]){
               cylinder(r=4,h=TubeLength-odr); //OD=8
            }
        }
        //inlet support
        rotate([0,0,45+180]){
            translate([-0.5,odr,0]){
                cube([1,TubeLength-odr,7]);
            }
            translate([-3,TubeLength-1,0]){
                cube([6,1,8.5]);
            }
        }
    }
    
    //cross
    translate([-PlateLength/2,-PlateWidth/2,0]){
        cube([PlateLength,PlateWidth,4]);
    }
    translate([-PlateWidth/2,-PlateLength/2,0]){
        cube([PlateWidth,PlateLength,4]);
    }
    
}

module neg(){
    translate([0,0,-1]){
        cylinder(r=idr,h=42);
        }
    if(BusinessEnd=="true"){
        translate([0,0,5]){
            cylinder(r=odr,h=11);
        }
    }else{
        translate([0,0,15]){
            cylinder(r=odr,h=11);
        }
    }  
    
    if(BusinessEnd=="false"){
        rotate([90,0,45]){
            translate([0,11,0]){
                translate([0,0,-0.5]){ cylinder(r=2.5,h=TubeLength+1); } //ID=5
            } 
        }
    }
    translate([0,0,-0.1]){
        cylinder(r1=idr+1,r2=idr,h=1);
    }
}
    
 