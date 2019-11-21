/* [Parts] */
Facial_Expression = "Normal";//[Normal,Happy,Sad,Dumb,Scary]
Bow_Tie = "Yes";//[Yes,No]
Teeth = "Yes";//[Yes,No]
Cape = "Yes";//[Yes,No]
/* [Final] */
Part = "Whole";//[Whole,Bow_Tie,Ghost]
Supports = "Yes";//[Yes,No]
Render_Resolution = 50;//[10:200]
Scale = 1;//[0.25:0.25:4]
// preview[view:south, tilt:topdiagonal]
$fn = Render_Resolution;

scale([Scale,Scale,Scale]){
union(){
    if(Part == "Whole" || Part == "Ghost"){
        difference(){
            color("white"){
                union(){  
                    
                    hull(){                     //Head
                        translate([0,0,70]){
                            sphere(r=25,center=true);
                        }
                        translate([0,0,45]){
                            cylinder(h=1,r=21,center=true);
                        }
                    }
                    
                    
                    translate([0,0,27.5]){      //Body
                        cylinder(h=55,r1=25,r2=21,center=true);
                    }   
            
                    
                    rotate([0,0,270]){         //Protruding Waves in cloth
                        for(i = [45:45:315]){
                            rotate([0,-5.1,,i]){ 
                                translate([22,0,20]){
                                    cylinder(h=80,r=6,center= true);
                                    /*scale([1,1,10]){
                                       sphere(r=6);
                                    }*/
                                }
                            }
                        }
                    }
                    /*translate([0,-19,20]){
                        rotate([0,-8.5,-90]){
                            cylinder(h=40,r=6,center=true);
                        }
                    }*/
                } 
            }  
            
            
            union(){
                translate([0,0,-49.5]){     //makes flat bottom
                    color("white"){
                        cube([100,100,100],center=true);
                    }
                }
                
                if(Bow_Tie == "Yes"){
                    translate([0,-17,42]){
                        rotate([86,0,0]){
                            cylinder(h=10, r=2.8, center=true);
                        }
                    }
                }
                
                
                translate([10,-22,70]){     //eye
                    color("dimgrey"){
                        sphere(r=5);
                    }
                }
                translate([-10,-22,70]){    //other eye
                    color("dimgrey"){   
                        sphere(r=5);
                    }
                }
                
                if(Facial_Expression == "Happy"){
                    translate([0,-25,60]){ //mouth if Happy
                        color("dimgrey"){
                            rotate([0,0,0]){
                                difference(){
                                    sphere(r=10);
                                        translate([0,0,20]){
                                            sphere(r=20);
                                    }
                                } 
                            } 
                        }
                    }
                }
                
                if(Facial_Expression == "Normal"){
                    translate([0,-25,60]){  //mouth if Normal
                        color("dimgrey"){
                            rotate([0,0,0]){
                                difference(){
                                    sphere(r=10);
                                        translate([0,0,10]){
                                            sphere(r=15);
                                    }
                                } 
                            } 
                        }
                    }
                }
                
                if(Facial_Expression == "Sad"){
                    translate([0,-25,51]){  //mouth if Sad
                        color("dimgrey"){
                            rotate([0,180,0]){
                                difference(){
                                    sphere(r=10);
                                        translate([0,0,8]){
                                            sphere(r=15);
                                    }
                                } 
                            } 
                        }
                    }
                }
                
                if(Facial_Expression == "Dumb"){
                    translate([0,-25,60]){  //mouth if Dumb
                        color("dimgrey"){
                            rotate([0,0,0]){
                                difference(){
                                    sphere(r=10);
                                        translate([0,0,14]){
                                            sphere(r=15);
                                    }
                                } 
                            } 
                        }
                    }
                }
                
                if(Facial_Expression == "Scary"){
                    translate([0,-25,58]){  //mouth if Scary
                        color("dimgrey"){
                            rotate([0,0,0]){
                                difference(){
                                    scale([1,1,1.2]){
                                        sphere(r=6.5);
                                    }
                                }
                            } 
                        } 
                    }
               }
          }
                
                
                rotate([0,0,270]){          //cutout parts of cloth
                    color("white"){
                       for(i = [22.5:45:337.5]){
                           rotate([0,-2,i]){
                               translate([26,0,17]){
                                   /*scale([1,1,10]){
                                       sphere(r=5);
                                   }*/
                                   translate([0,0,30]){
                                       sphere(r=4.4,center=true);
                                   }
                                   cylinder(h=60,r=4.4,center=true);
                               }
                           }
                       }
                   }
                }
            }
        
        if(Facial_Expression == "Happy"){   
            translate([0,-17,70]){          //eyeballs if Happy
                translate([10,0,0]){
                    color("black"){
                        sphere(r=3.5);
                    }
                }
                translate([-10,0,0]){
                    color("black"){
                        sphere(r=3.5);
                    }
                }
            }
            
            
            if(Teeth == "Yes"){
                translate([0,-20,61.5]){   //teeth if Happy
                    translate([-4.5,0,0]){
                        color("black"){
                            scale([1,1,2]){
                                rotate([0,45,-8]){
                                    cube([3,3,3],center=true);
                                }
                            }
                        }
                    }
                    translate([4.5,0,0]){
                        color("black"){
                            scale([1,1,2]){
                                rotate([0,45,8]){
                                    cube([3,3,3],center=true);
                                }
                            }
                        }
                    }
                }
                if(Supports == "Yes"){
                    translate([-4.5,-20.8,54.4]){
                        cylinder(h=6.1,r=0.6,center=true);
                    }
                    translate([4.5,-20.8,54.4]){
                          cylinder(h=6.1,r=0.6,center=true);
                    }
                    translate([0,-22.2,56]){
                        rotate([10,0,0]){
                            cylinder(h=12,r=0.6,center=true);
                        }
                    }
                }
            }
        }
        
        if(Facial_Expression == "Normal"){   
            translate([0,-17,70]){          //eyeballs if Normal
                translate([10,0,0]){
                    color("black"){
                        sphere(r=3);
                    }
                }
                translate([-10,0,0]){
                    color("black"){
                        sphere(r=3);
                    }
                }
            }
            
            
            if(Teeth == "Yes"){
                translate([0,-20.1,57]){    //teeth if Normal
                    translate([-4.5,0,0]){
                        color("black"){
                            scale([1,1,2]){
                                rotate([-5	,45,-10]){
                                    cube([3,3,3],center=true);
                                }
                            }
                        }
                    }
                    translate([4.5,0,0]){
                        color("black"){
                            scale([1,1,2]){
                                rotate([5,45,10]){
                                    cube([3,3,3],center=true);
                                }
                            }
                        }
                    }
                }
                if(Supports == "Yes"){    
                    translate([-4.5,-21,52.4]){
                        cylinder(h=1.2,r=0.5,center=true);
                    }
                    translate([4.5,-21,52.4]){
                          cylinder(h=1.2,r=0.5,center=true);
                    }
                    translate([0,-21.8,53]){
                          rotate([10,0,0]){
                            cylinder(h=5.5,r=0.5,center=true);
                          }
                    }
                }
            }
        }
        
        if(Facial_Expression == "Sad"){   
            translate([0,-17,68.5]){        //eyeballs if Sad
                translate([9.5,0,0]){
                    color("black"){
                        sphere(r=2.5);
                    }
                }
                translate([-9.5,0,0]){
                    color("black"){
                        sphere(r=2.5);
                    }
                }
            }
            
            
            if(Teeth == "Yes"){
                translate([0,-20.8,60.7]){    //teeth if Sad
                    translate([-4,0,0]){
                        color("black"){
                            scale([1,1,2]){
                                rotate([0,45,-8]){
                                    cube([3,3,3],center=true);
                                }
                            }
                        }
                    }
                    translate([4,0,0]){
                        color("black"){
                            scale([1,1,2]){
                                rotate([0,45,8]){
                                    cube([3,3,3],center=true);
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if(Facial_Expression == "Dumb"){   
            translate([0,-17,68]){          //eyeballs if Dumb
                translate([8,0,0]){
                    color("black"){
                        sphere(r=2);
                    }
                }
                translate([-8,0,0]){
                    color("black"){
                        sphere(r=2);
                    }
                }
            }
            
            
            if(Teeth == "Yes"){
                translate([0,-20.5,61]){    //teeth if Dumb
                    translate([-4.5,0,0]){
                        color("black"){
                            scale([1,1,2]){
                                rotate([0,45,-8]){
                                    cube([3,3,3],center=true);
                                }
                            }
                        }
                    }
                    translate([4.5,0,0]){
                        color("black"){
                            scale([1,1,2]){
                                rotate([0,45,8]){
                                    cube([3,3,3],center=true);
                                }
                            }
                        }
                    }
                }
                if(Supports == "Yes"){
                    translate([-4.5,-21.2,54.3]){
                        rotate([5,0,0]){
                            cylinder(h=5.4,r=0.5,center=true);
                        }
                    }
                    translate([4.5,-21.2,54.3]){
                        rotate([5,0,0]){
                                cylinder(h=5.4,r=0.5,center=true);
                        }
                    }
                    translate([0,-22.2,55]){
                        rotate([10,0,0]){
                            cylinder(h=10,r=0.5,center=true);
                        }
                    }
                }
            }
        }
        
        if(Facial_Expression == "Scary"){   
            translate([0,-17,71]){          //eyeballs if Scary
                translate([10,0,0]){
                    color("black"){
                        sphere(r=4);
                    }
                }
                translate([-10,0,0]){
                    color("black"){
                        sphere(r=4);
                    }
                }
            }
            
            
            if(Teeth == "Yes"){
                translate([0,-21,65]){      //teeth if Scary
                    translate([-2.5,0,0]){
                        color("black"){
                            scale([1,1,2]){
                                rotate([0,-45,-8]){
                                    cube([3,3,3],center=true);
                                }
                            }
                        }
                    }
                    translate([2.5,0,0]){
                        color("black"){
                            scale([1,1,2]){
                                rotate([0,45,8]){
                                    cube([3,3,3],center=true);
                                    }
                                }
                            }
                        }
                    }
                    if(Supports == "Yes"){
                        translate([-2.5,-21.6,56]){
                            rotate([5,0,0]){
                                cylinder(h=10,r=0.5,center=true);
                            }
                        }
                        translate([2.5,-21.6,56]){
                            rotate([5,0,0]){
                                cylinder(h=10,r=0.5,center=true);
                            }
                        }
                        translate([0,-22.6,58]){
                            rotate([10,0,0]){
                                cylinder(h=17,r=0.5,center=true);
                            }   
                        }
                    }
                }
            }
         if(Cape == "Yes"){
            color("DarkRed"){
                difference(){
                    difference(){
                        union(){
                            translate([0,0,27.5]){
                                cylinder(h=55, r1=35,r2=24,center=true);
                            }
                            translate([0,0,62.3]){
                                difference(){
                                    cylinder(h=15,r1=24,r2=30,center=true);
                                    cylinder(h=16,r1=15,r2=28,center=true);	
                                }
                            }
                        }
                        union(){	
                            translate([0,-111,10]){
                                rotate([0,90,0]){
                                    cylinder(h=200,r=100,center=true);
                                }	
                            }
                          
                            translate([0,-10,-5]){
                                cylinder(h=100,r=15);
                            }
				    translate([0,-46,50]){
                                rotate([-10,0,0]){
                                    cube([100,50,100],center=true);
                                }
                            }	
				}
                    }
                    translate([0,0,-49.5]){
                        cube([100,100,100],center=true);
                    }
                }
            }
        }
    }
    if(Part == "Whole" || Part == "Bow_Tie"){
        if(Bow_Tie == "Yes"){
            translate([0,-50,2]){            //bowtie
                rotate([-90,0,0]){
                    color("red"){
                        difference(){
                            union(){
                                translate([7,0,0]){
                                    scale([1.5,1,1]){
                                        rotate([0,45,0]){
                                            cube([7,3,7],center=true);
                                        }
                                    }
                                }
                                translate([-7,0,0]){
                                    scale([1.5,1,1]){
                                        rotate([0,45,0]){
                                            cube([7,3,7],center=true);
                                        }
                                    }
                                }
                                cube([4,3,5],center=true);
                                translate([0,-3,0]){
                                    rotate([90,0,0]){
                                        cylinder(h=8,r=1.5,center=true);
                                    }
                                }
                            }
                            union(){
                                translate([12.5,0,0]){
                                    cube([10,10,20],center=true);
                                }
                                translate([-12.5,0,0]){
                                    cube([10,10,20],center=true);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
}