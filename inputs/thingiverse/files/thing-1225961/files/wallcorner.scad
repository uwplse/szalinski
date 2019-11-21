//h=127.3;//4.25 3(5/8)in
hi=107.9;//(4.25*25.4);//the height of your trim 

h=hi+19;//(.75*25.4);//add three quarters inch to that
w=19.5;//width of the corner
corner=8;//how much of the corner should this hug (for wrap-around corners)

t=8.6;//where the top should be??
r=5;//radius of rounded section
ca=3;//offset of the rounded section
angle=43;//angle of the slant at the top
erd=5;//edge rounded diameter
herd=erd/2;//edge radius
invisit=1;//unnecessary, used to make OpenSCAD previews cleaner


difference(){
minkowski(){//build the rounded rectangle
translate([herd,herd,0])cube([w,w,h]);
sphere(d=erd);//round that edge
}
translate([w,0,0])cube([w+erd,w+erd,h+erd]);//cut right edge
translate([0,w,0])cube([w+erd,w+erd,h+erd]);//cut back edge
translate([0,0,-w])cube([w+erd,w+erd,w]);//cut bottom edge
translate([0,0,h])cube([w+erd,w+erd,w]);//trim top edge
translate([0,herd,herd])translate([0,-ca,h-t])
	rotate([0,90,0])cylinder(h=w+invisit,r=r);//front rounded
translate([herd,0,herd])translate([-ca,0,h-t])
	rotate([-90,0,0])cylinder(h=w+invisit+erd,r=r);//left rounded
translate([herd,herd,herd])translate([0,0,h-t])
	rotate([angle,0,0])cube([w+invisit,h,w]);//front slant
translate([herd,herd,herd])translate([0,0,h-t])
	rotate([0,-angle,0])cube([h,w+invisit,w]);//left slant
translate([0,0,h-t])cube([3,3,20]);//takes out a little bit extra
translate([w-corner,w-corner,0])cube([corner+invisit,corner+invisit,h+invisit]);//remove the corner (use on mountain folds, not room corners)


}