//Created By Matthew Andres
//OSAT Project


prong_height = 60; //how tall prong is
prong_width = 15; //how wide the prong is 
prong_depth = 6; //how thick the prong is
prong_length = 75; //length from handle 
support_distance = 20; //how big the triangle on the corner is

hub_radius = 20; //radius of hub that connects all prongs
total_length =50; //total length of hub
end_width = 30; //end width of hub
hub_height = 6; // how tall hub is

//not working for other values need to change code below to organize how you want if change value
num_prongs = 3; //total number of prongs

//handle variables -- these do not all work properly when changing values
grip_radius = 15; //radius of handle
finger_depth = 10; //how deep fingers go
grip_length = 130; //length of handle
finger_radius= 10; //how wide fingers are
num_fingers = 4; //how many finger grips


//need to change if change number of prongs
for (i = [1:num_prongs]){
    rotate(i*(180/num_prongs)/2+(180/num_prongs)/2)
    prong();   
};
translate([-15,0,prong_height-(hub_height)/2])
rotate([0,0,0])
//hub();
//rotate([0,180,90])

handle();

module hub(){
difference(){
linear_extrude(height=hub_height){
circle(r=hub_radius,$fn=100);
}
translate([0,hub_radius/2,hub_height/2])
cube([2*hub_radius,hub_radius,2*hub_height],center=true);
}


linear_extrude(height=hub_height)
polygon([[-hub_radius,0],[hub_radius,0],[end_width/2,total_length-hub_radius],[-end_width/2,total_length-hub_radius]],[[0,1,2,3]]);

}
module prong(){
translate([0,prong_length-1,0])
union(){
difference(){
    cylinder(h=prong_height, d = prong_width,$fn =100);
    translate([-prong_width/2,prong_depth/2,-1])
    cube([prong_width,prong_width,prong_height+2]);
    translate([-prong_width/2,-prong_width-prong_depth/2,-1])
    cube([prong_width,prong_width,prong_height+2]);
}

rotate([0,45,0])
cube([prong_width/sqrt(2),prong_depth,prong_width/sqrt(2)], center=true);


translate([0,prong_depth/2,prong_height])
rotate([90,0,0])
difference(){
    cylinder(h=prong_length, d = prong_width,$fn =100);
    translate([-prong_width/2,prong_depth/2,-1])
    cube([prong_width,prong_width,prong_length+2]);
    translate([-prong_width/2,-prong_width-prong_depth/2,-1])
    cube([prong_width,prong_width,prong_length+2]);
}

mod = support_distance/8;
translate([+prong_width/2-1,-prong_depth/2,prong_height-prong_depth/2])
rotate([0,90,180])
difference(){
linear_extrude(height=prong_width-2)
polygon([[0,0],[0,support_distance],[support_distance,0]],[[0,1,2]]);

translate([mod,mod,-1])    
linear_extrude(height=prong_width/4)
polygon([[0,0],[0,support_distance/2],[support_distance/2,0]],[[0,1,2]]);
    
translate([mod,mod,prong_width*3/4-1])    
linear_extrude(height=prong_width/4)
polygon([[0,0],[0,support_distance/2],[support_distance/2,0]],[[0,1,2]]);
}}
}

module handle(){
difference(){
rotate([0,180,0])
hull(){
rotate([0,180,0])
union(){
translate([total_length-hub_radius,0,hub_height])
rotate([90,180,90])
difference(){
cylinder(h=grip_length, r=grip_radius, $fn=100);
translate([-grip_radius*3/2,-grip_radius*2,-grip_length/2])
cube([3*grip_radius,2*grip_radius,2*grip_length],center=false);
}

rotate([0,0,-90])
hub();
}
}

for (i = [1:num_fingers]){
    
    translate([i*(grip_length-num_fingers*finger_radius)/(num_fingers-.5)+total_length-hub_radius,finger_radius*2,-grip_radius+1])
    rotate([90,90,0])
    cylinder(r=finger_radius, h = 4*grip_radius);   
};
}

}

