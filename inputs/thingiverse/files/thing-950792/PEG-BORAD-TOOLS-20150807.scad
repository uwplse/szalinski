$fn=30;


board_pitch =25.4;
board_hole = 4;
board_thick = 5;
 
/////case

tool_depth=4; //  幅
tool_width= 2; //　奥行き
tool_height= 3; // 深さ

tool_w = board_pitch*tool_width;
tool_d = board_pitch*tool_depth;
tool_h = board_pitch*tool_height;

fillet =3; //角の丸み
offset =1.5; //厚み


//////joint
joint_w = 4; //奥行き
joint_d = 9;//幅
joint_h = 9; //高さ

jonit_r= joint_d/2;
joint_pawl=0.6;
joint_rod =board_thick+5;


//difference(){


case();


///////////////////////////////////

module case(){
module roundedcube(xdim,ydim,zdim,rdim){


hull(){
translate([rdim,rdim,rdim+fillet])cylinder(r=rdim,h=zdim-fillet);
translate([xdim-rdim,rdim,rdim+fillet])cylinder(r=rdim,h=zdim-fillet);
rotate([-90,0,0])translate([rdim,-rdim-fillet,rdim])cylinder(r=rdim,h=ydim-2*rdim);


translate([rdim,ydim-rdim,rdim+fillet])cylinder(r=rdim,h=zdim-fillet);
translate([xdim-rdim,ydim-rdim,rdim+fillet])cylinder(r=rdim,h=zdim-fillet);
rotate([-90,0,0])translate([xdim-rdim,-rdim-fillet,rdim])cylinder(r=rdim,h=ydim-2*rdim);


rotate([90,0,90])translate([rdim,rdim+fillet,rdim])cylinder(r=rdim,h=xdim-2*rdim);
rotate([90,0,90])translate([ydim-rdim,rdim+fillet,rdim])cylinder(r=rdim,h=xdim-2*rdim);

translate([rdim,rdim,rdim+fillet])sphere(rdim);
translate([xdim-rdim,rdim,rdim+fillet])sphere(rdim);
translate([rdim,ydim-rdim,rdim+fillet])sphere(rdim);
translate([xdim-rdim,ydim-rdim,rdim+fillet])sphere(rdim);

}
}

difference(){

union(){
translate([0,-offset/2,-tool_h-fillet])roundedcube(tool_w,tool_d,tool_h,fillet);
joint();
}
translate([offset,offset-offset/2,-tool_h+offset-fillet])roundedcube(tool_w-2*offset,tool_d-2*offset,tool_h+0.1,fillet-offset);
}

}

///////////////////////////////////////


module joint(){

roundcube2(joint_w,joint_d,joint_h,jonit_r);
mirror([0,1,0])translate([0,-tool_d,0])roundcube2(joint_w,joint_d,joint_h,jonit_r);

module roundcube2(xdim,ydim,zdim,rdim){
difference(){
union(){
rotate([-90,0,90])translate([0,board_hole/2-0.4,0])cylinder(r=board_hole/2,h=joint_rod-board_hole/2);
hull(){
translate([0,-ydim/2,-zdim+rdim])cube([xdim,ydim,zdim-rdim]);
rotate([90,0,90])translate([-ydim/2+rdim,-zdim+rdim,0])cylinder(r=rdim,h=xdim);
rotate([90,0,90])translate([ydim/2-rdim,-zdim+rdim,0])cylinder(r=rdim,h=xdim);
}
hull(){
translate([-(joint_rod-board_hole/2),0,-board_hole/2+0.4])sphere(r=board_hole/2);
rotate([-90,0,90])translate([joint_pawl,board_hole/2-0.4,board_thick])cylinder(r=board_hole/2,h=0.3);
}
}
rotate([0,-180,0])translate([2,-0.5,-5])cube([20,1,10]);
rotate([180,-180,0])translate([-100,-100,0])cube([200,200,10]);
}
}
}









