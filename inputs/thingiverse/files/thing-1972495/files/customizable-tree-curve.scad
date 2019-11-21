init_leng = 40;
leng_limit = 7;
leng_scale = 0.7;
z_a = 31;
x_a = 71;
fn = 4;
sym_offset = 11; 

function x(pt) = pt[0];
function y(pt) = pt[1];
function z(pt) = pt[2];

function pt3D(x, y, z) = [x, y, z];
    
function turtle3D(pt, coordVt) = [pt, coordVt];
function getPt(turtle) = turtle[0];
function getCoordVt(turtle) = turtle[1];

function plus(pt, n) = pt3D(x(pt) + n, y(pt) + n, z(pt) + n);
function minus(pt, n) = pt3D(x(pt) - n, y(pt) - n, z(pt) + n);
function mlt(pt, n) = pt3D(x(pt) * n, y(pt) * n, z(pt) * n);
function div(pt, n) = pt3D(x(pt) / n, y(pt) / n, z(pt) / n);
function neg(pt, n) = mlt(pt, -1);

function ptPlus(pt1, pt2) = pt3D(x(pt1) + x(pt2), y(pt1) + y(pt2), z(pt1) + z(pt2));

function moveX(turtle, leng) = turtle3D(
    ptPlus(getPt(turtle), mlt(getCoordVt(turtle)[0], leng)),
    getCoordVt(turtle)
);

function moveY(turtle, leng) = turtle3D(
    ptPlus(getPt(turtle), mlt(getCoordVt(turtle)[1], leng)),
    getCoordVt(turtle)
);

function moveZ(turtle, leng) = turtle3D(
    ptPlus(getPt(turtle), mlt(getCoordVt(turtle)[2], leng)),
    getCoordVt(turtle)
);

function turnX(turtle, a) = turtle3D(
    getPt(turtle),
    [
        getCoordVt(turtle)[0], 
        ptPlus(mlt(getCoordVt(turtle)[1], cos(a)), mlt(getCoordVt(turtle)[2], sin(a))), 
        ptPlus(mlt(neg(getCoordVt(turtle)[1]), sin(a)), mlt(getCoordVt(turtle)[2], cos(a)))
    ]
);

function turnY(turtle, a) = turtle3D(
    getPt(turtle),
    [
        ptPlus(mlt(getCoordVt(turtle)[0], cos(a)), mlt(neg(getCoordVt(turtle)[2]), sin(a))),
        getCoordVt(turtle)[1], 
        ptPlus(mlt(getCoordVt(turtle)[0], sin(a)), mlt(getCoordVt(turtle)[2],cos(a)))
    ]
);

function turnZ(turtle, a) = turtle3D(
    getPt(turtle),
    [
        ptPlus(mlt(getCoordVt(turtle)[0], cos(a)), mlt(getCoordVt(turtle)[1],sin(a))),
        ptPlus(mlt(neg(getCoordVt(turtle)[0]), sin(a)), mlt(getCoordVt(turtle)[1], cos(a))),
        getCoordVt(turtle)[2], 
    ]
);

module line3D(p1, p2, thickness, fn = 24) {
    $fn = fn;

    hull() {
        translate(p1) sphere(thickness / 2);
        translate(p2) sphere(thickness / 2);
    }
}

module polyline3D(points, thickness, fn) {
    module polyline3D_inner(points, index) {
        if(index < len(points)) {
            line3D(points[index - 1], points[index], thickness, fn);
            polyline3D_inner(points, index + 1);
        }
    }

    polyline3D_inner(points, 1);
}

function rand1OrNeg1() = round(rands(0, 1, 1)[0]) == 0 ? 1 : -1;

module tree(t, leng, z_a, x_a, leng_limit, leng_scale, fn, sym_offset) {
    t2 = moveX(t, leng);
    polyline3D([getPt(t), getPt(t2)], leng * 0.075, fn);
    
    if(leng > leng_limit) {
        tree(
            turnZ(t2, z_a), 
            leng * leng_scale, 
            z_a, 
            x_a, 
            leng_limit, 
            leng_scale, 
            fn, 
            sym_offset
        );
        tree(
            turnZ(turnX(t2, sym_offset * rand1OrNeg1()), -z_a), 
            leng * leng_scale, 
            z_a, 
            x_a, 
            leng_limit, 
            leng_scale, 
            fn, 
            sym_offset
        );
        
        tree(
            turnZ(turnX(t2, x_a), z_a), 
            leng * leng_scale, 
            z_a, 
            x_a, 
            leng_limit, 
            leng_scale, 
            fn, sym_offset
        );
        tree(
            turnZ(turnX(t2, x_a + sym_offset * rand1OrNeg1()), -z_a), 
            leng * leng_scale, 
            z_a, 
            x_a, 
            leng_limit, 
            leng_scale, 
            fn, 
            sym_offset
        );
    }
}

rotate([0, -90, 0]) tree(
    turtle3D( 
        pt3D(0, 0, 0), 
        [pt3D(1, 0, 0), pt3D(0, 1, 0), pt3D(0, 0, 1)] // 海龜座標向量
    ), 
    init_leng, 
    z_a, 
    x_a, 
    leng_limit, 
    leng_scale, 
    fn, 
    sym_offset
); 

linear_extrude(0.1 * init_leng, center = true) 
    circle(init_leng / 2, $fn = 48);