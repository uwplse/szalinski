//Measured distances:
//78 mm - Dimension from outermost point to outermost point. (squared up) 
//69.2 mm - Dimension from inside most outer edge point to inside most outer edge point on other side.
//63.5 mm - Dimension on outermost inside edge to outermost inside edge on other side.
//12.5 mm - rough width of shell
//6.5mm - dimension from outermost part to inside wall.
//75mm outer shell diameter

//82.5 outer most edge to outer most edge diameter

//nut edges are 10.9 towards inside, flaring to 11.1 towards shell.

module mainShell(outerd,shellwidth,height,fn=80){
difference(){
    cylinder(r1=outerd/2.,r2=outerd/2.,h=height,$fn=fn);
    translate([0,0,-0.1])
    cylinder(r1=(outerd-shellwidth)/2.,r2=(outerd-shellwidth)/2.,h=height+0.2,$fn=fn);
}
}

difference(){
    union(){
        mainShell(81.5,20,25.5);
        translate([23.7,-22,0]) linear_extrude(25.5) square([8,44]);
        translate([-23.7-8,-22,0]) linear_extrude(25.5) square([8,44]);
        translate([-22,23.7,0]) linear_extrude(25.5) square([44,8]);
        translate([-22,-23.7-8,0]) linear_extrude(25.5) square([44,8]);
    }
    union(){
        translate([49.4,0,-0.1]) cylinder(r1=30.6/2,r2=30.6/2,h=25.5+0.2,$fn=120);
        translate([-49.4,0,-0.1]) cylinder(r1=30.6/2,r2=30.6/2,h=25.5+0.2,$fn=120);
        translate([0,49.4,-0.1]) cylinder(r1=30.6/2,r2=30.6/2,h=25.5+0.2,$fn=120);
        translate([0,-49.4,-0.1]) cylinder(r1=30.6/2,r2=30.6/2,h=25.5+0.2,$fn=120);
        translate([-50,0,12.25]) rotate([0,90,0]) cylinder(r1=5.25/2,r2=5.25/2,h=100);
        translate([0,0,12.25]) rotate([90,90,0]) cylinder(r1=5.25/2.,r2=5.25/2.,h=100,center=true);
        translate([18.7,-6.5,-0.1]) linear_extrude(25.7) square([11,13]);
        translate([-18.7-5.5*2,-6.5,-0.1]) linear_extrude(25.7) square([11,13]);        
        translate([-6.5,-18.7-5.5*2,-0.1]) linear_extrude(25.7) square([13,11]);
        translate([-6.5,18.7,-0.1]) linear_extrude(25.7) square([13,11]);
    }
}
    
//28.6 - Dimension of legs at screw hole
//30.6 - Dimension of legs above/below screw hole