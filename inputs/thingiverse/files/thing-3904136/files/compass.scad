gap = .5; // gap between centerpiece and outerpiece (measured horizontally)
cen_dia_tmp = 25; // diameter of the centerpiece
hole_tmp = 8; // diamater of the hole in the middle of the centerpiece
ni_dia = 20.1; // diameter of the niche
ni_dep = 3.75;
corrid = 4; // width of the corridor inside the outerpiece
thick = 2; // indicator of minimal thickness of walls
height= corrid+2*thick; //height constrained by the thickness and the size of the corridor 
cen_dia = cen_dia_tmp/2 < ni_dia/2 + ni_dep + thick ? ni_dia + 2*ni_dep + 2*thick : cen_dia_tmp; // making sure the niche does not cut the centerpiece in two...
hole = hole_tmp > cen_dia - height - 2*thick ? cen_dia - height - 2*thick : hole_tmp; // making sure the hole does not cut the centerpiece in two...
ch_dia = cen_dia -4; // diameter of the crosshair below the centerpiece
ch_dep = .5; // depth of the crosshair
ch_wid = .25; // half-width of the crosshair
res = 200; // value to pass to $fn

echo(hole);

module centerpiece() {
    rotate_extrude(convexity = 10, $fn=res)
    polygon(points=[[hole/2,0],[hole/2,height],[cen_dia/2,height],[cen_dia/2 - height/2,height/2],[cen_dia/2,0]]);
}

module niche() {
    translate([0,0,height-ni_dep]) cylinder(r=ni_dia/2,h=ni_dep+.2, $fn=res);
}

c1x = cen_dia/2 - height/2 + gap + thick;
c1 = [c1x,height/2];
c2 = [c1x + corrid/2,height/2 + corrid/2];
c3 = [c1x + corrid,height/2];
c4 = [c1x + corrid/2,height/2 - corrid/2];

module corridor() {
    rotate_extrude(convexity = 10, $fn=res)
    polygon(points=[c1,c2,c3,c4]);
}

o1x = c1x - thick;
o1 = [o1x, height/2];
o2 = [o1x + height/2, height];
o3 = [c3.x + thick, height];
o4 = [c3.x + thick, 0];
o5 = [o1x + height/2, 0];

module outerpiece() {
    rotate_extrude(convexity = 10, $fn=res)
    polygon(points=[o1,o2,o3,o4,o5]);
}

module inout() {
    translate([c2.x, 0, height/2]) rotate(90,[0,1,0]) linear_extrude(height = 3*thick, convexity = 10, twist = 0)
    circle(r = corrid/2,$fn=4);
}

module crosshair() {
    translate([0,0,-.1])
    linear_extrude(height = ch_dep +.1, convexity = 10, twist = 0)
    polygon(points=[[ch_wid,ch_wid],[ch_wid,ch_dia/2],[-1*ch_wid,ch_dia/2],[-1*ch_wid,ch_wid],[-1*ch_dia/2,ch_wid],[-1*ch_dia/2,-1*ch_wid],[-1*ch_wid,-1*ch_wid],[-1*ch_wid,-1*ch_dia/2],[ch_wid,-1*ch_dia/2],[ch_wid,-1*ch_wid],[ch_dia/2,-1*ch_wid],[ch_dia/2,ch_wid]]);
}

difference() {
    centerpiece();
    niche();
    crosshair();
}

difference() {
    outerpiece();
    corridor();
    inout();
    mirror([1,0,0]) inout();
}

