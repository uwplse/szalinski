// recursion level
iterations = 2;
// total size
element_size = 62;
// height at the edge
extrusion = 2;
// fudge
fudge = 0.05;

/* [Hidden] */
golden_cut = (sqrt(5) - 1) / 2;	 // 0.618033989
gc_pow_2 = pow(golden_cut, 2);
gc_pow_3 = pow(golden_cut, 3);
leg_span = element_size / 2;		 // 0.5
leg_drop = leg_span / tan(36);		 // 0.68819096
radius = leg_span / sin(36);		 // 0.850650808
wing_span = leg_span / golden_cut; // 0.809016994
wing_lift = radius * sin(18);		 // 0.262865556


q_outer = 1 / (3 + golden_cut);
shift_outer = [0, radius * (1 - q_outer)];
q_inner = q_outer * golden_cut;
shift_inner = [0, leg_drop * (q_outer + q_inner - 1)];

poly(iterations, 0, 0);

// 10 pentagons
module poly(i, outer, inner) {
	for (r = [0 : 4]) rotate([0, 0, r * 72]) {
		translate(shift_outer) scale(q_outer) penta(i, outer + 1, inner);
		translate(shift_inner) mirror([0, 1, 0]) scale(q_inner) penta(i, outer, inner + 1.16);
	}
	if (i > 0) 	scale(gc_pow_2) penta(i, outer + 0.5, inner + 0.5);
}

// 1 pentagon
module penta(i, outer, inner) {
	if (i > 0) { // TODO: && x * outer + y * inner < too_deep
		poly(i - 1, outer, inner);
	} else {
		rotate([0, 0, 0]) // triangulation alignment
		linear_extrude(extrusion / pow(q_outer, outer) / pow(q_inner, inner))
		scale(1 + fudge)
			polygon([
				[0, radius],
				[-wing_span, wing_lift],
				[-leg_span, -leg_drop],
				[leg_span, -leg_drop],
				[wing_span, wing_lift],
			]);
	}
}
