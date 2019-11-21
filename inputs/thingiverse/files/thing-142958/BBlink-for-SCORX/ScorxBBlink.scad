// (C) Michał (yru) Liberda 2013
// rel under GPL

//joint ball radius
linkrad=6;
//link lenth
llen=25;
//middle dia
lwi=6;
//cutout coef.
lhi=0.66;


legu();

module legu(lrad=linkrad,ll=llen,lw=lwi,lh=lhi,sthns=34){

difference(){

translate([0,0,lrad/3.5]) union(){ //translate([0,0,0])
translate([ll/2,0,0]) sphere(r=lrad/2,$fn=sthns);
translate([-ll/2,0,0]) sphere(r=lrad/2,$fn=sthns);


hull(){
translate([ll/2,0,-1]) rotate([0,90,0]) cylinder(r=lrad/5,$fn=sthns);
translate([0,0,-1]) rotate([0,90,0]) cylinder(r=lw/2,$fn=sthns);
translate([-ll/2,0,-1]) rotate([0,90,0]) cylinder(r=lrad/5,$fn=sthns);
}

translate([ll/2,0,0]) rotate([90,0,0]) cylinder(r=lrad/1.5,h=lrad/3,$fn=sthns,center=true);
translate([-ll/2,0,0]) rotate([90,0,0]) cylinder(r=lrad/1.5,h=lrad/3,$fn=sthns,center=true);

}//union ends

translate([0,0,(lrad+lw)/-2]) cube([ll+lrad*2,lrad+lw,lrad+lw],center=true);
translate([0,0,(lrad+lw)/2+lrad*.9-.5]) cube([ll+lrad*2,lrad+lw,lrad+lw],center=true);
translate([0,0,(lrad+lw)/2+lw*lh-1]) cube([ll/2,lrad+lw,lrad+lw],center=true);

}//difer ends

}//moudle ends


