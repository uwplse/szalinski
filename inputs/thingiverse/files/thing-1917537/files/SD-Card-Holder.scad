num_cards =25;

mode="both"; // [base, cap, both]

module cards(){
for(i=[0:num_cards-1]){
  translate([3.1+(4.5*i),3.1,2]) 
  cube([2.5,24.4,32.4],false);
}    
}

module base(){
    color([1,0.75,0.75])
difference(){
union(){
cube([num_cards*4.5+4.2,30.6,15]);

translate([1.1,1.1,0])
cube([num_cards*4.5+2,28.4,20],false);
}

cards();
}}

module cap(){
    
    translate([0,30.6,21.4])
    rotate([180,0,0])
    color([0.75,0.75,1])
  //  translate([0,0,35.6])
    difference(){
        cube([num_cards*4.5+4.2,30.6,21.4]);
    
        color([1,0,1])
        translate([0.9,0.9,-1])
    
        cube([num_cards*4.5+2.4,28.8,6.2]);
        
        translate([2.9,2.9,5])
        cube([num_cards*4.5-1.6,24.8,14.4]);
    }
}

if (mode=="base"){
  base();
}else if (mode =="cap"){
    cap();
}else if (mode =="both"){
    base();
    translate([0,35.6,0])
    cap();
}