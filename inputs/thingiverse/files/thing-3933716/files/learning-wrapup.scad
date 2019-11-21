// Customizable and randomized learning math wrap-ups
// Matthew (Nick) Veldt

// Scaling factor
scale = 1;

// Number to perform math with (integer)
num = 10;

// Multiplication or Addition?
type = "+"; // [+,*]


perm1 = randperm(12);
perm2 = randperm(12);
perm3 = (type == "+") ? perm2 + num * [1,1,1,1,1,1,1,1,1,1,1,1]:perm2 * num;

module segment() {
    minkowski(){
        cube([80,1,5]);
        cylinder(r = 10,h = 5);
    }
}

module tile() {
    difference(){
    union(){
        translate([20,240,10])
        scale([2,2,10])
        text(str(type,num));
        
        
    translate([40,250,0])
    cylinder(r = 45, h = 10);
    for (i = [0:12]) {
        translate([0,i*20,0])
        segment();
    }

    translate([40,-40,0])
    rotate([0,0,45])
    cube([60,60,10]);
    }
    
    union(){
            translate([40,280,0])
            cylinder(r = 7,h = 40,center = true);
            
            translate([20,-20,0])
            rotate([0,0,45])
            cube([15,4,40],center = true);
    }
}
    
}

function randperm(n) = (
let (r=floor(rands(1,n+1,1)[0]))
(n<2) ? [1] : concat([r],[for (L=randperm(n-1), a= (L>= r) ? L+1:L) a ])

);

module numbers() {
    
    for (i = [0:11]){
        
        translate([0,5+20*i,10])
        scale([1.25,1.25,5])
        text(str(perm1[i]));
        
        x = (perm3[i]>99)? 50:60;
        translate([x,5+20*i,10])
        scale([1.25,1.25,5])
        text(str(perm3[i]));
    }
    
}



module solution() {
    for (i = [10:-1:0]){
        k = search(perm1[i+1],perm2)[0];
        echo(k);
        echo(perm1[k]);
        alph = atan(2 * (k-i)/8);
        
        
        translate([0,20*i+10,-0.05])
        rotate([0,0,alph])
        scale([1/(cos(alph)),1,1])
        groove();
    }
    k = search(perm1[0],perm2)[0];
    echo(k);
    alph = atan((20*k+25)/(80-25));
    
    translate([25,-15,-0.05])
    rotate([0,0,alph])
    scale([.55/.8/(cos(alph)),1,1])
    groove();
    
}
/*
function swap(perm,i,j) = ((i == j)?perm: 
     (i < j)?
        cat(decompose(perm,0,i-1),cat(perm[j],cat(decompose(perm,i+1,j-1),cat(perm[i],decompose(perm,j+1,len(perm)-1))))):
        cat(decompose(perm,0,j-1),cat(perm[i],cat(decompose(perm,j+1,i-1),cat(perm[j],decompose(perm,i+1,len(perm)-1))))));

*/
/*
    function decompose(perm,i,j) = [for (k = [i:1:j]) perm[k]];
function cat(L1, L2) = [for(L=[L1, L2], a=L) a];
*/

module groove() {
    cube([80,3,3]);
}

difference(){
    union(){
tile();
numbers();
}
solution();
}