/*[Printbed shape, tool selection and more]*/
shape = "square";//[square,round]
tool = "spiral";//[spiral,square probes]
layer_height = 0.2;
nozzle_diameter = 0.4;
/*[Square Printbed dimensions]*/
//Printbed size in X direction
X_Dir = 50;
//Printbed size in Y direction
Y_Dir = 50;

/*[Round Printbed dimensions]*/
// radius ofthe printbed
rad = 200;
/*[cube dimesion]*/
side_length = 20;

/*[Hidden]*/

if (tool == "spiral"){   
r=1;
thickness=nozzle_diameter + 0.1;
if (shape == "square"){
    if (X_Dir > Y_Dir){
    loops=Y_Dir/4.5;
    linear_extrude(height=layer_height) polygon(points= concat(
        [for(t = [90:360*loops]) 
            [(r-thickness+t/90)*sin(t),(r-thickness+t/90)*cos(t)]],
        [for(t = [360*loops:-1:90]) 
            [(r+t/90)*sin(t),(r+t/90)*cos(t)]]
            ));
    }
    else{
    loops=X_Dir/4.5;
    linear_extrude(height=layer_height) polygon(points= concat(
        [for(t = [90:360*loops]) 
            [(r-thickness+t/90)*sin(t),(r-thickness+t/90)*cos(t)]],
        [for(t = [360*loops:-1:90]) 
            [(r+t/90)*sin(t),(r+t/90)*cos(t)]]
            ));  
    }
 
    }
    
if (shape == "round"){
    loops = rad/4.5;
    loops=Y_Dir/4.5;
    linear_extrude(height=layer_height) polygon(points= concat(
        [for(t = [90:360*loops]) 
            [(r-thickness+t/90)*sin(t),(r-thickness+t/90)*cos(t)]],
        [for(t = [360*loops:-1:90]) 
            [(r+t/90)*sin(t),(r+t/90)*cos(t)]]
            ));
    }

}

if (tool == "square probes"){ 
if (shape == "square"){
translate([side_length/2 - X_Dir/2 ,side_length/2-Y_Dir/2,0])
cube([side_length,side_length,layer_height],center=true);

//rear right square
translate([-side_length/2 + X_Dir/2 ,-side_length/2+Y_Dir/2,0])
cube([side_length,side_length,layer_height],center=true);

//front right square
translate([-side_length/2 + X_Dir/2 ,side_length/2-Y_Dir/2,0])
cube([side_length,side_length,layer_height],center=true);

//rear left square
translate([side_length/2 - X_Dir/2 ,-side_length/2+Y_Dir/2,0])
cube([side_length,side_length,layer_height],center=true);

//center square
cube([side_length,side_length,layer_height],center=true);
}
if (shape == "round"){
translate([side_length/2 - rad/2 ,side_length/2-rad/2,0])
cube([side_length,side_length,layer_height],center=true);

//rear right square
translate([-side_length/2 + rad/2 ,-side_length/2+rad/2,0])
cube([side_length,side_length,layer_height],center=true);

//front right square
translate([-side_length/2 + rad/2 ,side_length/2-rad/2,0])
cube([side_length,side_length,layer_height],center=true);

//rear left square
translate([side_length/2 - rad/2 ,-side_length/2+rad/2,0])
cube([side_length,side_length,layer_height],center=true);

//center square
cube([side_length,side_length,layer_height],center=true);    
    
}
}