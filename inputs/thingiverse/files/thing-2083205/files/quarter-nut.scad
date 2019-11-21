bearing_outer_d = 22.15;
bearing_h = 7;
hexnut_d = 11; // measures about 10.8
hexnut_h = 5.3;
wall_th = 1.5;

// put it all together
housing_knurled_3();

module housing_knurled_3() {
    num_weights = 3;
    difference()
    {
        // main housings
        union()
        {
            difference()
            {
                cylinder(r=bearing_outer_d/2+wall_th*4,h=bearing_h,center=true);

                // innie knurling
                for(i=[0:num_weights])
                {
                    rotate([0,0,(i*2+1)*360/num_weights/2])
                        translate([bearing_outer_d*1.5-wall_th*1,0,-bearing_h/2]) scale([1,1.3,1])
                            knurl(k_cyl_od=bearing_outer_d*1.7,k_cyl_hg=bearing_h,knurl_hg=bearing_h/2);
                }
            }

            for(i=[0:num_weights])
            {
                rotate([0,0,i*360/num_weights]) translate([bearing_outer_d+wall_th*2,0,-bearing_h/2])
                    knurl(k_cyl_od=bearing_outer_d+wall_th*4,k_cyl_hg=bearing_h,knurl_hg=bearing_h/2);
            }
        }

        // subtract bearing hole
        cylinder(r=bearing_outer_d/2,h=bearing_h+wall_th,center=true,$fn=100);

        // subtract weight holes
        for(i=[0:num_weights])
        {
            rotate([0,0,i*360/num_weights]) translate([bearing_outer_d+wall_th*2,0,bearing_h-hexnut_h])
                hexagon(hexnut_d,hexnut_h);
        }
    }
}

module hexagon(width,height) {
    angle = 360/6;
    cot = width / tan(angle);
    union()
    {
        rotate([0,0,0]) cube([width,cot,height],center=true);
        rotate([0,0,angle]) cube([width,cot,height],center=true);
        rotate([0,0,2*angle]) cube([width,cot,height],center=true);
    }
}



/* knurledFinishLib_v2.scad
 *
 * Written by aubenc @ Thingiverse
 *
 * This script is licensed under the Public Domain license.
 *
 * http://www.thingiverse.com/thing:31122
 *
 * Derived from knurledFinishLib.scad (also Public Domain license) available at
 *
 * http://www.thingiverse.com/thing:9095
 */

module knurl(k_cyl_hg = 12, k_cyl_od = 25, knurl_wd = 3, knurl_hg = 4, knurl_dp = 1.5, e_smooth = 2, s_smooth = 0) {
    knurled_cyl(k_cyl_hg, k_cyl_od, knurl_wd, knurl_hg, knurl_dp, e_smooth, s_smooth);
}

module knurled_cyl(chg, cod, cwd, csh, cdp, fsh, smt) {
    cord = (cod+cdp+cdp*smt/100)/2;
    cird = cord-cdp;
    cfn = round(2*cird*PI/cwd);
    clf = 360/cfn;
    crn = ceil(chg/csh);

    if (fsh < 0)
    {
        union()
        {
            shape(fsh, cird+cdp*smt/100, cord, cfn*4, chg);
            translate([0,0,-(crn*csh-chg)/2]) knurled_finish(cord, cird, clf, csh, cfn, crn);
        }
    }
    else if (fsh == 0)
    {
        intersection()
        {
            cylinder(h=chg, r=cord-cdp*smt/100, $fn=2*cfn, center=false);
            translate([0,0,-(crn*csh-chg)/2]) knurled_finish(cord, cird, clf, csh, cfn, crn);
        }
    }
    else
    {
        intersection()
        {
            shape(fsh, cird, cord-cdp*smt/100, cfn*4, chg);
            translate([0,0,-(crn*csh-chg)/2]) knurled_finish(cord, cird, clf, csh, cfn, crn);
        }
    }
}

module shape(hsh, ird, ord, fn4, hg) {
	x0 = 0;
    x1 = hsh > 0 ? ird : ord;
    x2 = hsh > 0 ? ord : ird;
	y0 = -0.1;
    y1 = 0;
    y2 = abs(hsh);
    y3 = hg-abs(hsh);
    y4 = hg;
    y5 = hg+0.1;

	if ( hsh >= 0 )
	{
		rotate_extrude(convexity=10, $fn=fn4)
		polygon(points=[[x0,y1],[x1,y1],[x2,y2],[x2,y3],[x1,y4],[x0,y4]], paths=[[0,1,2,3,4,5]]);
	}
	else
	{
		rotate_extrude(convexity=10, $fn=fn4)
		polygon(points=[[x0,y0],[x1,y0],[x1,y1],[x2,y2],[x2,y3],[x1,y4],[x1,y5],[x0,y5]], paths=[[0,1,2,3,4,5,6,7]]);
	}
}

module knurled_finish(ord, ird, lf, sh, fn, rn) {
    for(j=[0:rn-1])
    {
        h0 = sh*j;
        h1 = sh*(j+1/2);
        h2 = sh*(j+1);

        for(i=[0:fn-1])
        {
            lf0 = lf*i;
            lf1 = lf*(i+1/2);
            lf2 = lf*(i+1);

            polyhedron(
                points=[
                     [ 0,0,h0],
                     [ ord*cos(lf0), ord*sin(lf0), h0],
                     [ ird*cos(lf1), ird*sin(lf1), h0],
                     [ ord*cos(lf2), ord*sin(lf2), h0],

                     [ ird*cos(lf0), ird*sin(lf0), h1],
                     [ ord*cos(lf1), ord*sin(lf1), h1],
                     [ ird*cos(lf2), ird*sin(lf2), h1],

                     [ 0,0,h2],
                     [ ord*cos(lf0), ord*sin(lf0), h2],
                     [ ird*cos(lf1), ird*sin(lf1), h2],
                     [ ord*cos(lf2), ord*sin(lf2), h2]
                    ],
                faces=[
                     [0,1,2],[2,3,0],
                     [1,0,4],[4,0,7],[7,8,4],
                     [8,7,9],[10,9,7],
                     [10,7,6],[6,7,0],[3,6,0],
                     [2,1,4],[3,2,6],[10,6,9],[8,9,4],
                     [4,5,2],[2,5,6],[6,5,9],[9,5,4]
                    ],
                convexity=5);
         }
    }
}
