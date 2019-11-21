thermarest_outer=15;
thermarest_hight=14;
thermarest_con=1;

exped_outer=21;
exped_hight=10;

wall=2;
easy_fit=1.5;
$fn=60;

outer_outer = max(thermarest_outer,exped_outer);

difference(){
cylinder(r=outer_outer/2+wall,h=thermarest_hight);
    translate([0,0,-0.1]){
cylinder(r1=thermarest_outer/2+thermarest_con,r2=thermarest_outer/2,h=thermarest_hight+0.2);
        cylinder(r1=thermarest_outer/2+thermarest_con+easy_fit,r2=thermarest_outer/2,h=easy_fit*3);
    }
}
translate([0,0,thermarest_hight]){
difference(){
cylinder(r=outer_outer/2+wall,h=exped_hight);
    translate([0,0,-0.1]){
cylinder(r=exped_outer/2,h=exped_hight+0.2);
    }
}
}