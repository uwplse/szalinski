mirror=0;


function ngon(count, radius, i = 0, result = []) = i < count
    ? ngon(count, radius, i + 1, concat(result, [[ radius*sin(360/count*i), radius*cos(360/count*i) ]]))
    : result;
    
module blade_wedge(){

    translate([-0.002,0,0])
    rotate([90,0,90])
    polyhedron(points=
    [[-8.502,3.5,0],
    [-5,3.25,0],
    [2,2,0],
    [8.502,-0.501,0],
    [8.502,0.6-0.001,0],
    [2,4,0],
    [-5,5.25,0],
    [-8.502,5.5,0],
    
    [-8.502,4,10],
    [-5,3.75,10],
    [2,2.5,10],
    [8.502,-0.001,10],
    [8.502,0.1-0.001,10],
    [2,3.5,10],
    [-5,4.75,10],
    [-8.502,5,10]],
    
    faces=[[0,7,15,8],
    [0,8,9,1],
    [1,9,10,2],
    [2,10,11,3],
    [3,11,12,4],
    [4,12,13,5],
    [5,13,14,6],
    [6,14,15,7],
    [0,1,2,3,4,5,6,7],
    [8,15,14,13,12,11,10,9]]);
}    
    
    
module blade(){
    difference(){
        linear_extrude(5,convexity=10)
        polygon([[0,-4],[23,-8.5],[70,-6.5],[73,-5],[73,5],[70,6.5],[23,8.5],[0,4],[0,-4]]);
        
            translate([-0.001,0,0])
            rotate([90,0,90])
            linear_extrude(73.002,convexity=10)
            polygon([[-8.501,4],[-5,3.75],[2,2.5],[8.501,-0.001],[-8.501,-0.001],[-8.501,4]]);
        
        
            translate([-0.001,0,0])
            rotate([90,0,90])
            linear_extrude(73.002,convexity=10)
            polygon([[-8.501,5],[-5,4.75],[2,3.5],[8.501,0.1-0.001],[8.501,6],[-8.501,6]]);
    }
    
    intersection(){
        blade_wedge();
        blade_shape();
    }
}

module blade_shape(){
    
        linear_extrude(6,convexity=10)
        polygon([[0,-4],[23,-8.5],[70,-6.5],[73,-5],[73,5],[70,6.5],[23,8.5],[0,4],[0,-4]]);
}

module propeller(){
        
    translate([0,0,6]){
        difference(){
            union(){
                translate([0,0,-6])
                difference(){
                    cylinder(6.001,4,4,$fn=100);
                    
                    translate([0,0,-0.001])
                    linear_extrude(7.501,convexity=10)
                    rotate([0,0,30])
                    polygon(ngon(6,6.1/2));
                }
                cylinder(6,5,5,$fn=100);
                blade();
                rotate([0,0,180])
                blade();
            }
            translate([0,0,2])
            cylinder(4.002,3.9,3.9,$fn=100);
            
            translate([0,0,-6])
            cylinder(12,1,1,$fn=100);
        }
    }
}


if (mirror){
    mirror([0,1,0])
    translate([0,0,12])
    rotate([180,0,45])
    propeller();
}else{
    translate([0,0,12])
    rotate([180,0,-45])
    propeller();
}

