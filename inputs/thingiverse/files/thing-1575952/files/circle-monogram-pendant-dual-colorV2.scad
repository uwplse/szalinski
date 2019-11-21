//use <utils/build_plate.scad>

// preview[view:south, tilt:top]

//////////////////////////////////////////////////////////////////
/*						CUSTOMIZER CONTROLS						*/
//////////////////////////////////////////////////////////////////

/*[Letters]*/
first_letter = "G"; //[-:Blank,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z]
second_letter = "D"; //[-:Blank,&:Ampersand,+:Plus,$:Heart,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z]
third_letter = "D"; //[-:Blank,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z]
font_weight = 4; //[1:Super Thin,2:Thin,4:Medium,5:Thick]
letter_spacing = 1; //[0:None, 1:Narrow, 2:Medium, 3:Wide]

/*[Pendant]*/
//in mm
radius = 10; //[5:40]
//in mm
thickness = 2; //[1,2,3,4,5,6,7,8,9,10]
//number of facets around the circle
resolution = 64; //[64:Smooth,32:High,16:Medium,8:Low]
backing = 1; //[1:On,0:Off]
//  GDD
// With dual_color on, multiple STLs can be printed by selecting TopOnly or BottomOnly, use Combined to view
dual_color = 1; //[1:On,0:Off]
print_dual_top = 0; //[2:Combined,1:TopOnly,0:BottomOnly]
// end GDD
//how much bigger is the backing than the letters (will force a border if there is spacing between letters)
border = 2; //[0:None,2:Thin,4:Medium,6:Thick]

/*[Jewlery Loop]*/
//how strong is the jewlery loop
jewlery_loop_thickness = 1; //[1:Thin,2:Medium,3:Thick]
//adjust the position of the jewlery loop around the outside of the monogram
jewlery_loop_position = 0; //[0:360]
//number of loops
jewlery_loop_count = 1; //[0:10]

/*[Buildplate]*/
//for display only, doesn't contribute to final object
buildplate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic]

/*[Hidden]*/


//////////////////////////////////////////////////////////////////
/*								CODE							*/
//////////////////////////////////////////////////////////////////

if(preview_tab == "Pendant" || preview_tab == "Buildplate")
{
	build_plate(buildplate_selector);
}


if(radius < 10)
{
	monogram_pendant
	(
		[first_letter, second_letter, third_letter],
		thickness - thickness / 2 * backing,
		radius,
		min(font_weight * .4 * floor(radius/5), .8),
		min(letter_spacing * .4 * floor(radius/5), .8),
		resolution,
		backing,
		thickness / 2,
		min(border * .8 * floor(radius/5), .8),
		min(jewlery_loop_thickness * .8 * floor(radius/5), .8),
		jewlery_loop_position,
		jewlery_loop_count
	);
}
else
{
	monogram_pendant
	(
		[first_letter, second_letter, third_letter],
		thickness - thickness / 2 * backing,
		radius,
		font_weight * .4 * floor(radius/10),
		letter_spacing * .8 * floor(radius/10),
		resolution,
		backing,
		thickness / 2,
		border * .4 * floor(radius/10),
		jewlery_loop_thickness * .8 * floor(radius/10),
		jewlery_loop_position,
		jewlery_loop_count
	);
}



echo(floor(radius/10));

module loop_connector
(
	loop_connector_rotation = 0,
	radius = 10,
	backing_outset = 0,
	kerning = 0,
	loop_connector_line_thickness = .8,
	loop_connector_count = 1
)
{
	if(loop_connector_line_thickness != 0 && loop_connector_count > 0)
	{
		assign(rotation_offset = floor(360 / loop_connector_count))
		{
			for(i = [1:loop_connector_count]){
				assign(angle = (i * rotation_offset) - rotation_offset)
				{
					rotate([0, 0, -loop_connector_rotation + angle])
					translate([0, radius + backing_outset + kerning / 2 + loop_connector_line_thickness])
					{
						loop_connector_2D
						(
							loop_connector_line_thickness * 2,
							loop_connector_line_thickness,
							false
						);
					}
				}
			}
		}
	}
}

module monogram_pendant
(
	letters = ["A","B","C"],
	letter_thickness = 1,
	radius = 10,
	line_thickness = .8,
	kerning = 0,
	res = 32,
    backing = 1,
	backing_thickness = 1,
	backing_outset = 0,
	loop_connector_line_thickness = .8,
	loop_connector_rotation = 0,
	loop_count = 1,
)
{
	epsilon = .01;
    epsilon9 = 0.18;
	if(backing == 0)
	{
        //GDD
        if ((dual_color == 1) && (print_dual_top != 1)) // GDD 0 or 2 Backfill the other color when dual
        {
    		color([.26,.7,1])
	    	translate([0, 0, epsilon])
            difference() { // print a circle, letters, then reverse it (Everything inside the letters)
                linear_extrude(height = letter_thickness, convexity = 10)
                {
                    union()
                    {
                        scale([(radius + kerning)-epsilon9, (radius + kerning / 2)-epsilon9, 1]) // Make it smaller
                        circle( 1, $fn = res );
                    }
                }
                scale( [1,1,1+epsilon] )
                    monogram_3D(letters, letter_thickness, radius, line_thickness, kerning, res );
            }
        } // end GDD
        
		linear_extrude(height = letter_thickness, convexity = 10)
        {
			if(backing_outset != 0)
			{
                if ((dual_color == 0) || ((dual_color == 1) && (print_dual_top != 1))) // GDD 0 or 2 Backfill the other color
                {
                    color([.26,.7,1])
                    union()
                    {
                    color([.26,.7,1])
                        difference()
                        {
                            scale([radius + backing_outset + kerning, radius + backing_outset + kerning / 2, 1])
                            circle( 1, $fn = res );
                            scale([radius + kerning / 2 - epsilon, radius + kerning / 4 - epsilon, 1])
                            circle( 1, $fn = res );				
                        }
                        loop_connector(loop_connector_rotation,radius,backing_outset,kerning,loop_connector_line_thickness,loop_count);
                    }
                } // GDD 0 or 2
			} 
			else // if bo
			{
				if(kerning != 0)
				{
					assign(backing_outset = max(2 * .4 * floor(radius/10), .8))
					{
						union()
						{
							difference()
							{
								scale([radius + backing_outset + kerning, radius + backing_outset + kerning / 2, 1])
								circle
								(
									1,
									$fn = res
								);
				
								scale([radius + kerning / 2 - epsilon, radius + kerning / 4 - epsilon, 1])
								circle
								(
									1,
									$fn = res
								);
							}
							
							loop_connector(loop_connector_rotation,radius,backing_outset,kerning,loop_connector_line_thickness,loop_count);
						}
					}
				}
				else
				{
					loop_connector(loop_connector_rotation,radius,backing_outset,kerning,loop_connector_line_thickness,loop_count);
				}
			}
            
		}
		if ((dual_color==0)||(print_dual_top != 0)){monogram_3D(letters,letter_thickness,radius,line_thickness,kerning,res);}
	}
	else // GDD background then monogram, depending on print_dual_top or the bottom
	{
        if ((dual_color != 1) || (print_dual_top != 1)) // GDD 0 or 2
		color([.6,.7,1])
		linear_extrude(height = backing_thickness, convexity = 10)
		{
			union()
			{
				scale([radius + backing_outset + kerning, radius + backing_outset + kerning / 2, 1])
				circle
				(
					1,
					$fn = res
				);
				loop_connector(loop_connector_rotation,radius,backing_outset,kerning,loop_connector_line_thickness,loop_count);
			}
		}
        if ((dual_color == 1) && (print_dual_top != 1)) // GDD 0 or 2 Backfill the other color
        {
		color([.26,.7,1])
		translate([0, 0, backing_thickness - epsilon])
        difference() {
		linear_extrude(height = backing_thickness, convexity = 10)
		{
			union()
			{
				scale([radius + backing_outset + kerning, radius + backing_outset + kerning / 2, 1])
				circle
				(
					1,
					$fn = res
				);
				loop_connector(loop_connector_rotation,radius,backing_outset,kerning,loop_connector_line_thickness,loop_count);
			}
		}
        scale( [1,1,1+epsilon] )
 			monogram_3D
			(
				letters,
				letter_thickness,
				radius,
				line_thickness,
				kerning,
				res
			);

        }
        } // end GDD
        if ((dual_color != 1) || (print_dual_top != 0)) // GDD 1 or 2
		translate([0, 0, backing_thickness - epsilon])
		{
			monogram_3D
			(
				letters,
				letter_thickness,
				radius,
				line_thickness,
				kerning,
				res
			);
		}
	}
}

module monogram_3D
(
	letters = ["A","B","C"],
	thickness = 1,
	radius = 10,
	line_thickness = .8,
	kerning = 0,
	res = 32
)
{
	linear_extrude(height = thickness, convexity = 10)
	{
		monogram_2D
		(
			letters,
			radius,
			line_thickness,
			kerning,
			res
		);
	}
}

module monogram_2D
(
	letters = ["A","B","C"],
	radius = 10,
	line_thickness = .8,
	kerning = 0,
	res = 32
)
{
	for(i = [0:len(letters) - 1])
	{
		if(i == 0)
		{
			translate([-kerning, 0])
				monogram_letter_2D
				(
					letter_index(letters[i]),
					i,
					radius,
					line_thickness,
					kerning,
					res
				);
		}
		else
		{
			if(i == 2)
			{
				translate([kerning, 0])
					monogram_letter_2D
					(
						letter_index(letters[i]),
						i,
						radius,
						line_thickness,
						kerning,
						res
					);
			}
			else
			{
				monogram_letter_2D
				(
					letter_index(letters[i]),
					i,
					radius * (radius + kerning / 2) / radius,
					line_thickness,
					kerning,
					res
				);
			}
		}
	}
}


function letter_index(letter) = search(letter, "ABCDEFGHIJKLMNOPQRSTUVWXYZ&+$")[0];

module monogram_letter_2D
(
	index,
	position,
	radius,
	line_thickness,
	kerning,
	res
)
{
	if(index == 0)
	{
		if(position == 0)
		{
			A_left_2D(radius,line_thickness,res);
		}
		else
		{
			if(position == 1)
			{
				A_middle_2D(radius,line_thickness,res);
			}
			else
			{
				if(position == 2)
				{
				A_right_2D(radius,line_thickness,res);
				}
			}
		}
	}
	else
	{
		if(index == 1)
		{
			if(position == 0)
			{
				B_left_2D(radius,line_thickness,res);
			}
			else
			{
				if(position == 1)
				{
					B_middle_2D(radius,line_thickness,res);
				}
				else
				{
					if(position == 2)
					{
					B_right_2D(radius,line_thickness,res);
					}
				}
			}
		}
		else
		{
			if(index == 2)
			{
				if(position == 0)
				{
					C_left_2D(radius,line_thickness,res);
				}
				else
				{
					if(position == 1)
					{
						C_middle_2D(radius,line_thickness,res);
					}
					else
					{
						if(position == 2)
						{
							C_right_2D(radius,line_thickness,res);
						}
					}
				}
			}
			else
			{
				if(index == 3)
				{
					if(position == 0)
					{
						D_left_2D(radius,line_thickness,res);
					}
					else
					{
						if(position == 1)
						{
							D_middle_2D(radius,line_thickness,res);
						}
						else
						{
							if(position == 2)
							{
								D_right_2D(radius,line_thickness,res);
							}
						}
					}
				}
				else
				{
					if(index == 4)
					{
						if(position == 0)
						{
							E_left_2D(radius,line_thickness,res);
						}
						else
						{
							if(position == 1)
							{
								E_middle_2D(radius,line_thickness,res);

							}
							else
							{
								if(position == 2)
								{
									E_right_2D(radius,line_thickness,res);
								}
							}
						}
					}
					else
					{
						if(index == 5)
						{
							if(position == 0)
							{
								F_left_2D(radius,line_thickness,res);
							}
							else
							{
								if(position == 1)
								{
									F_middle_2D(radius,line_thickness,res);
								}
								else
								{
									if(position == 2)
									{
										F_right_2D(radius,line_thickness,res);
									}
								}
							}
						}
						else
						{
							if(index == 6)
							{
								if(position == 0)
								{
									G_left_2D(radius,line_thickness,res);
								}
								else
								{
									if(position == 1)
									{
										G_middle_2D(radius,line_thickness,res);
									}
									else
									{
										if(position == 2)
										{
											G_right_2D(radius,line_thickness,res);

										}
									}
								}
							}
							else
							{
								if(index == 7)
								{
									if(position == 0)
									{
										H_left_2D(radius,line_thickness,res);
									}
									else
									{
										if(position == 1)
										{
											H_middle_2D(radius,line_thickness,res);
										}
										else
										{
											if(position == 2)
											{
												H_right_2D(radius,line_thickness,res);
											}
										}
									}
								}
								else
								{
									if(index == 8)
									{
										if(position == 0)
										{
											I_left_2D(radius,line_thickness,res);
										}
										else
										{
											if(position == 1)
											{
												I_middle_2D(radius,line_thickness,res);
											}
											else
											{
												if(position == 2)
												{
													I_right_2D(radius,line_thickness,res);
												}
											}
										}
									}
									else
									{
										if(index == 9)
										{
											if(position == 0)
											{
												J_left_2D(radius,line_thickness,res);
											}
											else
											{
												if(position == 1)
												{
													J_middle_2D(radius,line_thickness,res);
												}
												else
												{
													if(position == 2)
													{
														J_right_2D(radius,line_thickness,res);
													}
												}
											}
										}
										else
										{
											if(index == 10)
											{
												if(position == 0)
												{
													K_left_2D(radius,line_thickness,res);
												}
												else
												{
													if(position == 1)
													{
														K_middle_2D(radius,line_thickness,res);
													}
													else
													{
														if(position == 2)
														{
															K_right_2D(radius,line_thickness,res);
														}
													}
												}
											}
											else
											{
												if(index == 11)
												{
													if(position == 0)
													{
														L_left_2D(radius,line_thickness,res);
													}
													else
													{
														if(position == 1)
														{
															L_middle_2D(radius,line_thickness,res);
														}
														else
														{
															if(position == 2)
															{
																L_right_2D(radius,line_thickness,res);
															}
														}
													}
												}
												else
												{
													if(index == 12)
													{
														if(position == 0)
														{
															M_left_2D(radius,line_thickness,res);
														}
														else
														{
															if(position == 1)
															{
																M_middle_2D(radius,line_thickness ,res);
															}
															else
															{
																if(position == 2)
																{
																	M_right_2D(radius,line_thickness,res);
																}
															}
														}
													}
													else
													{
														if(index == 13)
														{
															if(position == 0)
															{
																N_left_2D(radius,line_thickness,res);
															}
															else
															{
																if(position == 1)
																{
																	N_middle_2D(radius,line_thickness,res);
																}
																else
																{
																	if(position == 2)
																	{
																		N_right_2D(radius,line_thickness,res);
																	}
																}
															}
														}
														else
														{
															if(index == 14)
															{
																if(position == 0)
																{
																	O_left_2D(radius,line_thickness,res);
																}
																else
																{
																	if(position == 1)
																	{
																		O_middle_2D(radius,line_thickness,res);
																	}
																	else
																	{
																		if(position == 2)
																		{
																			O_right_2D(radius,line_thickness,res);
																		}
																	}
																}
															}
															else
															{
																if(index == 15)
																{
																	if(position == 0)
																	{
																		P_left_2D(radius,line_thickness,res);
																	}
																	else
																	{
																		if(position == 1)
																		{
																			P_middle_2D(radius,line_thickness,res);
																		}
																		else
																		{
																			if(position == 2)
																			{
																				P_right_2D(radius,line_thickness,res);
																			}
																		}
																	}
																}
																else
																{
																	if(index == 16)
																	{
																		if(position == 0)
																		{
																			Q_left_2D(radius,line_thickness,res);
																		}
																		else
																		{
																			if(position == 1)
																			{
																				Q_middle_2D(radius,line_thickness,res);
																			}
																			else
																			{
																				if(position == 2)
																				{
																					Q_right_2D(radius,line_thickness,res);
																				}
																			}
																		}
																	}
																	else
																	{
																		if(index == 17)
																		{
																			if(position == 0)
																			{
																				R_left_2D(radius,line_thickness,res);
																			}
																			else
																			{
																				if(position == 1)
																				{
																					R_middle_2D(radius,line_thickness,res);
																				}
																				else
																				{
																					if(position == 2)
																					{
																						R_right_2D(radius,line_thickness,res);
																					}
																				}
																			}
																		}
																		else
																		{
																			if(index == 18)
																			{
																				if(position == 0)
																				{
																					S_left_2D(radius,line_thickness,res);
																				}
																				else
																				{
																					if(position == 1)
																					{
																						S_middle_2D(radius,line_thickness,res);
																					}
																					else
																					{
																						if(position == 2)
																						{
																							S_right_2D(radius,line_thickness,res);
																						}
																					}
																				}
																			}
																			else
																			{
																				if(index == 19)
																				{
																					if(position == 0)
																					{
																						T_left_2D(radius,line_thickness,res);
																					}
																					else
																					{
																						if(position == 1)
																						{
																							T_middle_2D(radius,line_thickness,res);
																						}
																						else
																						{
																							if(position == 2)
																							{
																								T_right_2D(radius,line_thickness,res);
																							}
																						}
																					}
																				}
																				else
																				{
																					if(index == 20)
																					{
																						if(position == 0)
																						{
																							U_left_2D(radius,line_thickness,res);
																						}
																						else
																						{
																							if(position == 1)
																							{
																								U_middle_2D(radius,line_thickness,res);
																							}
																							else
																							{
																								if(position == 2)
																								{
																									U_right_2D(radius,line_thickness,res);
																								}
																							}
																						}
																					}
																					else
																					{
																						if(index == 21)
																						{
																							if(position == 0)
																							{
																								V_left_2D(radius,line_thickness,res);
																							}
																							else
																							{
																								if(position == 1)
																								{
																									V_middle_2D(radius,line_thickness,res);
																								}
																								else
																								{
																									if(position == 2)
																									{
																										V_right_2D(radius,line_thickness,res);
																									}
																								}
																							}
																						}
																						else
																						{
																							if(index == 22)
																							{
																								if(position == 0)
																								{
																									W_left_2D(radius,line_thickness,res);
																								}
																								else
																								{
																									if(position == 1)
																									{
																										W_middle_2D(radius,line_thickness,res);
																									}
																									else
																									{
																										if(position == 2)
																										{
																											W_right_2D(radius,line_thickness,res);
																										}
																									}
																								}
																							}
																							else
																							{
																								if(index == 23)
																								{
																									if(position == 0)
																									{
																										X_left_2D(radius,line_thickness,res);
																									}
																									else
																									{
																										if(position == 1)
																										{
																											X_middle_2D(radius,line_thickness,res);
																										}
																										else
																										{
																											if(position == 2)
																											{
																												X_right_2D(radius,line_thickness,res);
																											}
																										}
																									}
																								}
																								else
																								{
																									if(index == 24)
																									{
																										if(position == 0)
																										{
																											Y_left_2D(radius,line_thickness,res);
																										}
																										else
																										{
																											if(position == 1)
																											{
																												Y_middle_2D(radius,line_thickness,res);
																											}
																											else
																											{
																												if(position == 2)
																												{
																													Y_right_2D(radius,line_thickness,res);
																												}
																											}
																										}
																									}
																									else
																									{
																										if(index == 25)
																										{
																											if(position == 0)
																											{
																												Z_left_2D(radius,line_thickness,res);
																											}
																											else
																											{
																												if(position == 1)
																												{
																													Z_middle_2D(radius,line_thickness,res);
																												}
																												else
																												{
																													if(position == 2)
																													{
																														Z_right_2D(radius,line_thickness,res);
																													}
																												}
																											}
																										}
																										else
																										{
																											if(index == 26)
																											{
																												if(position == 1)
																												{
																													amp_middle_2D(radius,line_thickness,res);
																												}
																											}
																											else
																											{
																												if(index == 27)
																												{
																													if(position == 1)
																													{
																														plus_middle_2D(radius,line_thickness,res);
																													}
																													
																												}
																												else
																												{
																													if(index == 28)
																													{
																														if(position == 1)
																														{
																															heart_middle_2D(radius,line_thickness,res);
																														}
																													
																													}
																													else
																													{																								
																														if(position == 0)
																														{
																															left_monogram_2D(radius,res);
																														}
																														else
																														{
																															if(position == 1)
																															{
																																middle_monogram_2D(radius,res);
																															}
																															else
																															{
																																if(position == 2)
																																{
																																	right_monogram_2D(radius,res);
																																}
																															}
																														}
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																						}
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

module loop_connector_3D
(
	radius = 5,
	line_thickness = .8,
	height = .8,
	outset = false
)
{
	linear_extrude(height = height, convexity = 10)
	{
		loop_connector_2D
		(
			radius,
			line_thickness,
			outset
		);
	}
}

module loop_connector_2D
(
	radius = 5,
	line_thickness = .8,
	outset = false
)
{
	if(outset == false)
	{
		difference(){
			circle(r = radius, $fn = 32);
			circle(r = radius - line_thickness, $fn = 32);
		}
	}
	else
	{
		difference(){
			circle(r = radius + line_thickness, $fn = 32);
			circle(r = radius, $fn = 32);
		}
	}
}


module left_monogram_2D
(
	radius = 1,
	res = 32
)
{
	epsilon = .01;
	diameter = radius * 2;
	cutaway_width = diameter * 2 / 3;
	cutaway_height = diameter + epsilon * 2;

	difference()
	{
		circle(r = radius, $fn = res);
		translate
		(
			[diameter / 6 + epsilon, 0]
		)
		{
			square
			(
				[cutaway_width, cutaway_height],
				center = true
			);
		}
	}
}

module middle_monogram_2D
(
	radius = 1,
	res = 32
)
{
	epsilon = .01;
	diameter = radius * 2;
	cutaway_width = diameter / 3 + epsilon * 2;
	cutaway_height = diameter + epsilon * 2;

	intersection()
	{
		circle(r = radius, $fn = res);
		square
		(
			[cutaway_width, cutaway_height],
			center = true
		);
	}
}

module right_monogram_2D
(
	radius = 1,
	res = 32
)
{
	epsilon = .01;
	diameter = radius * 2;
	cutaway_width = diameter * 2 / 3;
	cutaway_height = diameter + epsilon * 2;

	difference()
	{
		circle(r = radius, $fn = res);
		translate
		(
			[-(diameter / 6 + epsilon), 0]
		)
		{
			square
			(
				[cutaway_width, cutaway_height],
				center = true
			);
		}
	}
}

module heart_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		translate([0, -radius / 32])
		scale([diameter / 3 - 1.6, diameter / 3 - 1.6])
		unit_heart();
	}

}

module plus_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		square
		(
			[diameter / 3 - line_width * 2, line_width * 1.5],
			center = true
		);
		
		square
		(
			[line_width * 1.5, diameter / 3 - line_width * 2],
			center = true
		);
	}

}

module amp_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		difference()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
			translate([0, -line_width * 3 / 2])
				square
				(
					[diameter, line_width],
					center = true
				);
				
			translate([(diameter / 6), -(diameter / 3 - (line_width * sqrt(2)))])
				rotate([0, 0, 45])
					translate([0, -radius])
						square
						(
							[diameter, diameter],
							center = true
						);
		}
		translate([-(radius + diameter / 6 - line_width),0])
			square
			(
				[diameter, diameter + epsilon * 2],
				center = true
			);
			

	}
	
	intersection()
	{
		difference()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
			translate([0, -(diameter / 3 + line_width - (line_width * sqrt(2)))])
			translate([0, line_width / 2])
				square
				(
					[diameter, line_width],
					center = true
				);
		}
		translate([(radius + diameter / 6 - line_width), -(radius - line_width / 2)])
			square
			(
				[diameter, diameter],
				center = true
			);
	}
	
	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		circle
		(
			radius - line_width,
			$fn = res
		);
		
		translate([radius + line_width, 0])
			square
			(
				[diameter, diameter + epsilon * 2],
				center = true
			);
			
		translate([(diameter / 6), -(diameter / 3 - (line_width * sqrt(2)))])
		rotate([0, 0, 45])
		translate([0, -radius])
			square
			(
				[diameter, diameter],
				center = true
			);
	}
	
	intersection()
	{
		difference()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
			
			translate([0, -radius + ((diameter / 6 + line_width) - (line_width * 2 + (sqrt(2) * line_width)))])
				square
				(
					[diameter, diameter],
					center = true
				);
		}
		translate([line_width / 2,0])
			square
			(
				[line_width, diameter + epsilon * 2],
				center = true
			);
	}
	
	intersection()
	{
		difference()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
			
		translate([radius + line_width, 0])
			square
			(
				[diameter, diameter + epsilon * 2],
				center = true
			);
		}
		
		translate([-(diameter / 6), -line_width * 2])
		rotate([0, 0, 45])
		translate([0, -line_width / 2])
			square
			(
				[diameter, line_width],
				center = true
			);
	}
	
	
	intersection()
	{
		difference()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
			
		}
		
		translate([-(diameter / 6), -line_width])
		rotate([0, 0, -45])
		translate([0, line_width / 2])
			square
			(
				[diameter, line_width],
				center = true
			);
	}
	
	intersection()
	{
		difference()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
			
		}
		
		translate([(diameter / 6), -(diameter / 3 - (line_width * sqrt(2)))])
		rotate([0, 0, 45])
		translate([0, line_width / 2])
			square
			(
				[diameter, line_width],
				center = true
			);
	}
}


module A_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([radius / 6 - line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 2 + line_width),0])
			square
			(
				[radius, line_width],
				center = true
			);
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		rotate([0,0,225])
		arc
		(
			radius + line_width,
			45,
			$fn = res
		);
	}
}

module A_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		square
		(
			[radius, line_width],
			center = true
		);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([(radius * 5 / 6) - line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		rotate([0,0,180])
		arc
		(
			radius + line_width,
			180,
			$fn = res
		);
	}
}

module A_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6) + line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([(radius / 2 + line_width),0])
			square
			(
				[radius, line_width],
				center = true
			);
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		rotate([0, 0, -90])
		arc
		(
			radius + line_width,
			45,
			$fn = res
		);
	}
}

module B_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([radius / 6 - line_width,0])
			{
				square
				(
					[radius, diameter],
					center = true
				);
			}
			circle
			(
				radius * 3 / 6,
				$fn = 4
			);
		}
	}

intersection()
{
	left_monogram_2D
	(
		radius,
		res
	);
	difference()
	{
		circle
		(
			radius * 3 / 6 + line_width * sqrt(2),
			$fn = 4
		);
		circle
		(
			radius * 3 / 6,
			$fn = 4
		);
		
	}
}

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
		translate([-(radius / 2 + line_width),0])
			square
			(
				[radius, line_width],
				center = true
			);
			circle
			(
				radius * 3 / 6,
				$fn = 4
			);
		}
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module B_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			square
			(
				[radius, line_width],
				center = true
			);
				translate([radius * 4 / 6, 0])
				circle
				(
					radius / 2,
					$fn = 4
				);
		}
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([radius * 4 / 6, 0])
				circle
				(
					radius / 2 + line_width * sqrt(2),
					$fn = 4
				);
			translate([radius * 4 / 6, 0])
				circle
				(
					radius / 2,
					$fn = 4
				);
		}
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([(radius * 5 / 6) - line_width,0])
				square
				(
					[radius, diameter + epsilon * 2],
					center = true
				);
			translate([radius * 4 / 6, 0])
				circle
				(
					radius / 2,
					$fn = 4
				);
		}
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module B_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6) + line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		difference()
		{
			translate([(radius / 2 + line_width),0])
				square
				(
					[radius, line_width],
					center = true
				);
			translate([radius * 8 / 6, 0])
				circle
				(
					radius / 2,
					$fn = 4
				);
		}
	}
	
	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		difference()
		{
			translate([radius * 8 / 6, 0])
				circle
				(
					radius / 2 + line_width * sqrt(2),
					$fn = 4
				);
			translate([radius * 8 / 6, 0])
				circle
				(
					radius / 2,
					$fn = 4
				);
		}
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([radius * 8 / 6, 0])
			circle
			(
				radius / 2,
				$fn = 4
			);
	}
}

module C_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([radius / 6 - line_width,0])
			{
				square
				(
					[radius, diameter],
					center = true
				);
			}
			square
			(
				[diameter, line_width * sqrt(2) * 2],
				center = true
			);	
		}
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module C_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([(radius * 5 / 6) - line_width,0])
				square
				(
					[radius, diameter + epsilon * 2],
					center = true
				);
			translate([radius / 2, 0])
				square
				(
					[radius, line_width * sqrt(2) * 2],
					center = true
				);				
		}
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module C_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6) + line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}


	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([radius, 0])
			square
			(
				[radius, line_width * sqrt(2) * 2],
				center = true
			);
	}
}

module D_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([radius / 6 - line_width,0])
		{
			square
			(
				[radius, diameter],
				center = true
			);
		}
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module D_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([(radius * 5 / 6) - line_width,0])
			square
			(
				[radius, diameter * 4 / 6],
				center = true
			);			
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([0,diameter * 2 / 6])
		{
			intersection()
			{
				difference()
				{
					scale([diameter / 6 + epsilon, diameter / 6])
						circle
						(
							r = 1,
							$fn = res
						);
					scale([diameter / 6 + epsilon - line_width, diameter / 6 - line_width])
						circle
						(
							r = 1,
							$fn = res
						);
				}
				arc
				(
					radius,
					90
				);
			}
		}
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([0,-diameter * 2 / 6])
		{
			intersection()
			{
				difference()
				{
					scale([diameter / 6 + epsilon, diameter / 6])
						circle
						(
							r = 1,
							$fn = res
						);
					scale([diameter / 6 + epsilon - line_width, diameter / 6 - line_width])
						circle
						(
							r = 1,
							$fn = res
						);
				}
				rotate([0,0,-90])
				arc
				(
					radius,
					90
				);
			}
		}
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([radius / 2, 0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}
}

module D_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6) + line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}


	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module E_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([radius / 6 - line_width,0])
			{
				square
				(
					[radius, diameter],
					center = true
				);
			}
			square
			(
				[diameter, line_width * sqrt(2) * 2],
				center = true
			);	
		}
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-diameter / 3, 0])
		square
		(
			[radius, line_width],
			center = true
		);	
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module E_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		square
		(
			[radius, line_width],
			center = true
		);	
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([(radius * 5 / 6) - line_width,0])
				square
				(
					[radius, diameter + epsilon * 2],
					center = true
				);
			translate([radius / 2, 0])
				square
				(
					[radius, line_width * sqrt(2) * 2],
					center = true
				);				
		}
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module E_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6) + line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([diameter / 3, 0])
		square
		(
			[radius, line_width],
			center = true
		);	
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([radius, 0])
			square
			(
				[radius, line_width * sqrt(2) * 2],
				center = true
			);
	}
}

module F_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([radius / 6 - line_width,0])
			{
				square
				(
					[radius, diameter],
					center = true
				);
			}
			translate([0, (-radius + line_width * sqrt(2)) / 2])
			square
			(
				[diameter, radius + line_width * sqrt(2)],
				center = true
			);
		}
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-diameter / 3, 0])
		square
		(
			[radius, line_width],
			center = true
		);	
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module F_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		square
		(
			[radius, line_width],
			center = true
		);	
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([(radius * 5 / 6) - line_width,0])
				square
				(
					[radius, diameter + epsilon * 2],
					center = true
				);
			translate([0, (-radius + line_width * sqrt(2)) / 2])
				square
				(
					[diameter, radius + line_width * sqrt(2)],
					center = true
				);			
		}
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([0, -(radius / 2 + epsilon)])
		square
		(
			[radius, radius + epsilon],
			center = true
		);
	}
}

module F_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6) + line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([diameter / 3, 0])
		square
		(
			[radius, line_width],
			center = true
		);	
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([0, (-radius + line_width * sqrt(2)) / 2])
			square
			(
				[diameter, radius + line_width * sqrt(2)],
				center = true
			);
	}
}

module G_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([radius / 6 - line_width,0])
			{
				square
				(
					[radius, diameter],
					center = true
				);
			}
			translate([0, line_width * sqrt(2) / 2])
			square
			(
				[diameter, line_width * sqrt(2)],
				center = true
			);	
		}
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([radius / 2 - diameter / 3, 0])
		square
		(
			[radius, line_width],
			center = true
		);	
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module G_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([radius / 2, 0])
		square
		(
			[radius, line_width],
			center = true
		);	
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([(radius * 5 / 6) - line_width,0])
				square
				(
					[radius, diameter + epsilon * 2],
					center = true
				);
			translate([radius / 2, line_width * sqrt(2) / 2])
				square
				(
					[radius, line_width * sqrt(2)],
					center = true
				);				
		}
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module G_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6) + line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([radius / 2 + diameter / 3, 0])
			square
			(
				[radius, line_width],
				center = true
			);	
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([radius, line_width * sqrt(2) / 2])
			square
			(
				[radius, line_width * sqrt(2)],
				center = true
			);
	}
}

module H_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([radius / 6 - line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 2 + line_width),0])
			square
			(
				[radius, line_width],
				center = true
			);
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		rotate([0,0,225])
			arc
			(
				radius + line_width,
				45,
				$fn = res
			);
		rotate([0,0,90])
			arc
			(
				radius + line_width,
				45,
				$fn = res
			);
	}
}

module H_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		square
		(
			[radius, line_width],
			center = true
		);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([(radius * 5 / 6) - line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}
}

module H_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6) + line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([(radius / 2 + line_width),0])
			square
			(
				[radius, line_width],
				center = true
			);
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		rotate([0, 0, 45])
			arc
			(
				radius + line_width,
				45,
				$fn = res
			);
		rotate([0, 0, -90])
			arc
			(
				radius + line_width,
				45,
				$fn = res
			);
	}
}

module I_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		difference()
		{
			left_monogram_2D
			(
				radius,
				res
			);
			
			square
			(
				[diameter, (sin(30) * radius) * 2],
				center = true
			);
		}
		translate([(radius - diameter / 6 - line_width),0])
			square
			(
				[diameter, diameter],
				center = true
			);
		
	}

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-(diameter * 7 / 24),0])
			square
			(
				[line_width, diameter],
				center = true
			);
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		rotate([0,0,150  ])
			arc
			(
				radius + line_width,
				60,
				$fn = res
			);
	}
}

module I_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		difference()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
			
			square
			(
				[diameter, (sin(30) * radius + line_width) * 2],
				center = true
			);
		}
		translate([(radius + diameter / 6 - line_width),0])
			square
			(
				[diameter, diameter],
				center = true
			);
		
	}
	
	intersection()
	{
		difference()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
			
			square
			(
				[diameter, (sin(30) * radius + line_width) * 2],
				center = true
			);
		}
		translate([-(radius + diameter / 6 - line_width),0])
			square
			(
				[diameter, diameter],
				center = true
			);
		
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		square
		(
			[line_width, diameter + epsilon],
			center = true
		);
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module I_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;


	intersection()
	{
		difference()
		{
			right_monogram_2D
			(
				radius,
				res
			);
			
			square
			(
				[diameter, (sin(30) * radius) * 2],
				center = true
			);
		}
		translate([-(radius - diameter / 6 - line_width),0])
			square
			(
				[diameter, diameter],
				center = true
			);
		
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([(diameter * 7 / 24),0])
			square
			(
				[line_width, diameter],
				center = true
			);
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		rotate([0, 0, -30])
			arc
			(
				radius + line_width,
				60,
				$fn = res
			);
	}
}

module J_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([radius / 6 - line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		rotate([0,0,150  ])
			arc
			(
				radius + line_width,
				30,
				$fn = res
			);
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-radius, 0])
			square
			(
				[diameter / 3, line_width],
				center = true
			);
	}
}

module J_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;


	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([(radius * 5 / 6) - line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6 - line_width), -radius + line_width / 2])
			square
			(
				[radius, diameter],
				center = true
			);
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-diameter / 6, 0])
			square
			(
				[diameter / 3, line_width],
				center = true
			);
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		rotate([0,0,90  ])
			arc
			(
				radius + line_width,
				90,
				$fn = res
			);
	}
}

module J_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6) + line_width, -radius])
			square
			(
				[radius, diameter],
				center = true
			);
	}
	
	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([diameter / 6, 0])
			square
			(
				[diameter / 3, line_width],
				center = true
			);
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		rotate([0, 0, 45])
			arc
			(
				radius + line_width,
				90,
				$fn = res
			);
	}
}

module K_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([radius / 6 - line_width,0])
				square
				(
					[radius, diameter],
					center = true
				);
			square
			(
				[diameter, diameter - line_width * 4],
				center = true
			);
		}
	}

	difference()
	{
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);
		rotate([0, 0, 135])
			arc
			(
				radius + line_width,
				90,
				$fn = res
			);
		}
		circle
		(
			radius - line_width,
			$fn = res
		);

	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-(diameter * 4 / 6), radius - line_width * 2])
		intersection()
		{
			difference()
			{
				circle
				(
					radius,
					$fn = res
				);
				circle
				(
					radius - line_width,
					$fn = res
				);
			}
			rotate([0, 0, -90])
				arc
				(
					radius + line_width,
					90,
					$fn = res
				);
		}
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-(diameter * 4 / 6), -(radius - line_width * 2)])
		intersection()
		{
			difference()
			{
				circle
				(
					radius,
					$fn = res
				);
				circle
				(
					radius - line_width,
					$fn = res
				);
			}
			rotate([0, 0, 0])
				arc
				(
					radius + line_width,
					45,
					$fn = res
				);
		}
	}
}

module K_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;


	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6 - line_width),0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([(radius * 5 / 6 - line_width),0])
				square
				(
					[radius, diameter + epsilon * 2],
					center = true
				);
			
				square
				(
					[diameter, diameter - line_width * 4],
					center = true
				);
		}
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(diameter / 3), radius - line_width * 2])
		{
			intersection()
			{
				difference()
				{
					circle
					(
						radius,
						$fn = res
					);
					circle
					(
						radius - line_width,
						$fn = res
					);
				}
				rotate([0, 0, -90])
					arc
					(
						diameter,
						90,
						$fn = res
					);
			}
		}
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(diameter / 3), -(radius - line_width * 2)])
		{
			intersection()
			{
				difference()
				{
					circle
					(
						radius,
						$fn = res
					);
					circle
					(
						radius - line_width,
						$fn = res
					);

				}
				rotate([0, 0, 0])
					arc
					(
						diameter,
						45,
						$fn = res
					);
			}
		}
	}
}

module K_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6) + line_width, 0])
			square
			(
				[radius, diameter],
				center = true
			);
	}
	
	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([diameter / 6 + line_width, 0])
			rotate([0, 0, 55])
			square
			(
				[diameter, line_width],
				center = true
			);
	}
	
	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([diameter / 6 + line_width, 0])
			rotate([0, 0, -55])
			square
			(
				[diameter, line_width],
				center = true
			);
	}

	difference()
	{
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);
			rotate([0, 0, -45])
				arc
				(
					radius + line_width,
					90,
					$fn = res
				);
		}
		circle
		(
			radius - line_width,
			$fn = res
		);
		rotate([0, 0, -15])
			arc
			(
				radius + line_width,
				30,
				$fn = res
			);
	}
}

module L_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([radius / 6 - line_width, -radius + line_width / 2])
			square
			(
				[radius, diameter],
				center = true
			);
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		rotate([0,0,45])
		arc
		(
			radius + line_width,
			90,
			$fn = res
		);
	}
}

module L_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([(radius * 5 / 6) - line_width, -radius + line_width / 2])
			square
			(
				[radius, diameter],
				center = true
			);
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		rotate([0,0,0])
		arc
		(
			radius + line_width,
			180,
			$fn = res
		);
	}
}

module L_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6) + line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([0, radius + line_width / 2])
			square
			(
				[diameter + epsilon * 2, diameter],
				center = true
			);
	}
}

module M_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);

		translate([radius / 6 - line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);

	}

	difference()
	{
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);
			translate([-(diameter / 6 + line_width), 0])
				rotate([0, 0, 115])
					arc
					(
						radius + line_width,
						130,
						$fn = res
					);
		}
		circle
		(
			radius - line_width,
			$fn = res
		);

	}
	left_location_y = sin( 180 - 115 - asin( sin(115) / (radius - line_width) * ((diameter / 6) + line_width))) * (radius - line_width);
	left_location_x = 1 / (tan(180 - 115 - asin( sin(115) / (radius - line_width) * ((diameter / 6) + line_width))) /  left_location_y);
	left_angle = atan((left_location_y - line_width) / ((left_location_x - diameter / 6 - line_width - (radius - line_width - left_location_x)/2) / 2));
	
	right_location_y = sin(acos((diameter / 6 + line_width) / radius)) * radius;
	right_location_x = diameter / 6 + line_width;
	right_angle = atan((right_location_y - line_width) / ((left_location_x - diameter / 6 - line_width + (radius - line_width - left_location_x)/2) / 2));
	
	intersection()
	{
	
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);

			translate([- left_location_x, left_location_y , 0])
				rotate([0, 0, -left_angle])
					translate([0, -line_width / 2])
						square
						(
							[diameter, line_width],
							center = true
						);
		}
	
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);

			translate([- right_location_x, right_location_y , 0])
				rotate([0, 0, right_angle])
					translate([0, -line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
	}
	
	difference()
	{
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);

			translate([- left_location_x, left_location_y , 0])
				rotate([0, 0, -left_angle])
					translate([0, -line_width / 2])
						square
						(
							[diameter, line_width],
							center = true
						);
		}

		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);

			translate([- right_location_x, right_location_y , 0])
				rotate([0, 0, right_angle])
					translate([0, -diameter])
						square
						(
							[diameter * 2, diameter * 2],
							center = true
						);
		}
	}
	
	difference()
	{
	
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);

			translate([- right_location_x, right_location_y , 0])
				rotate([0, 0, right_angle])
					translate([0, -line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}

		translate([- left_location_x, left_location_y , 0])
			rotate([0, 0, -left_angle])
				translate([0, -(diameter + epsilon)])
					square
					(
						[diameter * 2, diameter * 2],
						center = true
					);


	}
	
}

module M_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;


	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6 - line_width),0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([(radius * 5 / 6 - line_width),0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	location_y = sqrt(pow(radius, 2) - pow(diameter / 6 - line_width, 2));
	location_x = diameter / 6 - line_width;

	inner_angle = 90 - atan((diameter / 6 - line_width) / (location_y - line_width));

	intersection()
	{
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);

			translate([- location_x, location_y , 0])
				rotate([0, 0, -inner_angle])
					translate([0, -line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
	
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);

			translate([	location_x, location_y , 0])
				rotate([0, 0, inner_angle])
					translate([0, -line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
	}
	
	difference()
	{
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);

			translate([- location_x, location_y , 0])
				rotate([0, 0, -inner_angle])
					translate([0, -line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
	
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);

			translate([	location_x, location_y , 0])
				rotate([0, 0, inner_angle])
					translate([0, -diameter / 2])
						square
						(
							[diameter * 2, diameter],
							center = true
						);
		}
	}
	
	difference()
	{
	
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);

			translate([	location_x, location_y , 0])
				rotate([0, 0, inner_angle])
					translate([0, -line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
	
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);

			translate([- location_x, location_y , 0])
				rotate([0, 0, -inner_angle])
					translate([0, -(diameter / 2 + epsilon)])
						square
						(
							[diameter * 2, diameter],
							center = true
						);
		}
	

	}

}

module M_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;
	
	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		translate([-(radius / 6 - line_width),0])
			square
			(
				[radius, diameter],
				center = true
			);

	}

	difference()
	{
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);
			translate([diameter / 6 + line_width, 0])
				rotate([0, 0, -65])
					arc
					(
						radius + line_width,
						130,
						$fn = res
					);
		}
		circle
		(
			radius - line_width,
			$fn = res
		);

	}
	left_location_y = sin( 180 - 115 - asin( sin(115) / (radius - line_width) * ((diameter / 6) + line_width))) * (radius - line_width);
	left_location_x = 1 / (tan(180 - 115 - asin( sin(115) / (radius - line_width) * ((diameter / 6) + line_width))) /  left_location_y);
	left_angle = atan((left_location_y - line_width) / ((left_location_x - diameter / 6 - line_width - (radius - line_width - left_location_x)/2) / 2));
	
	right_location_y = sin(acos((diameter / 6 + line_width) / radius)) * radius;
	right_location_x = diameter / 6 + line_width;
	right_angle = atan((right_location_y - line_width) / ((left_location_x - diameter / 6 - line_width + (radius - line_width - left_location_x)/2) / 2));
	
	intersection()
	{
	
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);

			translate([left_location_x, left_location_y , 0])
				rotate([0, 0, left_angle])
					translate([0, -line_width / 2])
						square
						(
							[diameter, line_width],
							center = true
						);
		}
	
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);

			translate([right_location_x, right_location_y , 0])
				rotate([0, 0, -right_angle])
					translate([0, -line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
	}
	
	difference()
	{
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);

			translate([left_location_x, left_location_y , 0])
				rotate([0, 0, left_angle])
					translate([0, -line_width / 2])
						square
						(
							[diameter, line_width],
							center = true
						);
		}

		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);

			translate([right_location_x, right_location_y , 0])
				rotate([0, 0, -right_angle])
					translate([0, -diameter])
						square
						(
							[diameter * 2, diameter * 2],
							center = true
						);
		}
	}
	
	difference()
	{
	
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);

			translate([right_location_x, right_location_y , 0])
				rotate([0, 0, -right_angle])
					translate([0, -line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
		
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);

			translate([left_location_x, left_location_y , 0])
				rotate([0, 0, left_angle])
					translate([0, -(diameter + epsilon)])
						square
						(
							[diameter * 2, diameter * 2],
							center = true
						);
		}


	}
}

module N_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);

		translate([radius / 6 - line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);

	}

	difference()
	{
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);
			translate([-(diameter / 6 + line_width), 0])
				rotate([0, 0, 115])
					arc
					(
						radius + line_width,
						130,
						$fn = res
					);
		}
		circle
		(
			radius - line_width,
			$fn = res
		);

	}
	left_location_y = sin( 180 - 115 - asin( sin(115) / (radius - line_width) * ((diameter / 6) + line_width))) * (radius - line_width);
	left_location_x = 1 / (tan(180 - 115 - asin( sin(115) / (radius - line_width) * ((diameter / 6) + line_width))) /  left_location_y);
	right_location_y = sqrt(pow(radius , 2) - pow(diameter / 6 + line_width, 2));
	
	left_angle = atan((left_location_x - line_width - diameter / 6) / (left_location_y + right_location_y)) - 90;
	
	small_distance = sqrt(pow(left_location_x - line_width - diameter / 6, 2) + pow(left_location_y + right_location_y, 2));
	small_angle = asin(line_width / small_distance);
	
	echo(left_angle);

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);

		translate([- left_location_x, left_location_y , 0])
			rotate([0, 0, left_angle + small_angle])
				translate([0, -line_width / 2])
					square
					(
						[diameter * 2, line_width],
						center = true
					);
	}
	
}

module N_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;


	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6 - line_width),0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([(radius * 5 / 6 - line_width),0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	location_y = sqrt(pow(radius, 2) - pow(diameter / 6 - line_width, 2));
	location_x = diameter / 6 - line_width;
	
	left_angle = atan(location_x / location_y ) - 90;
	
	small_distance = sqrt(pow(location_x * 2, 2) + pow(location_y * 2, 2));
	small_angle = asin(line_width / small_distance);

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);

		translate([- location_x, location_y , 0])
			rotate([0, 0, left_angle + small_angle])
				translate([0, -line_width / 2])
					square
					(
						[diameter * 3, line_width],
						center = true
					);
	}
}

module N_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		translate([-(radius / 6 - line_width),0])
			square
			(
				[radius, diameter],
				center = true
			);

	}

	difference()
	{
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);
			translate([diameter / 6 + line_width, 0])
				rotate([0, 0, -65])
					arc
					(
						radius + line_width,
						130,
						$fn = res
					);
		}
		circle
		(
			radius - line_width,
			$fn = res
		);

	}
	left_location_y = sin( 180 - 115 - asin( sin(115) / (radius - line_width) * ((diameter / 6) + line_width))) * (radius - line_width);
	left_location_x = 1 / (tan(180 - 115 - asin( sin(115) / (radius - line_width) * ((diameter / 6) + line_width))) /  left_location_y);
	right_location_y = sqrt(pow(radius , 2) - pow(diameter / 6 + line_width, 2));
	
	left_angle =atan((left_location_x - line_width - diameter / 6) / (left_location_y + right_location_y)) - 270;
	
	small_distance = sqrt(pow(left_location_x - line_width - diameter / 6, 2) + pow(left_location_y + right_location_y, 2));
	small_angle = asin(line_width / small_distance);
	
	echo(left_angle);

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		translate([left_location_x, -left_location_y , 0])
			rotate([0, 0, left_angle + small_angle])
				translate([0, -line_width / 2])
					square
					(
						[diameter * 2, line_width],
						center = true
					);
	}
}

module O_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([radius / 6 - line_width,0])
		{
			square
			(
				[radius, diameter],
				center = true
			);
		}
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([-(diameter / 2 + diameter * 7 / 18 + line_width / 2), 0])
			square
			(
				[diameter, diameter  + epsilon * 2],
				center = true
			);
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-(diameter * 7 / 18),0])
		{
			square
			(
				[line_width, diameter],
				center = true
			);
		}
	}
}

module O_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([(radius * 5 / 6) - line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);			
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module O_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6 - line_width),0])
		{
			square
			(
				[radius, diameter],
				center = true
			);
		}
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([diameter / 2 + diameter * 7 / 18 + line_width / 2, 0])
			square
			(
				[diameter, diameter  + epsilon * 2],
				center = true
			);
	}
	
	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([diameter * 7 / 18,0])
		{
			square
			(
				[line_width, diameter],
				center = true
			);
		}
	}
}

module P_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;
	
	small_radius = diameter / 12;


	intersection()
	{
		difference()
		{
			left_monogram_2D
			(
				radius,
				res
			);
			translate([0,-(radius + line_width / 2)])
			{
				square
				(
					[diameter * 2, diameter],
					center = true
				);
			}
		}
		translate([radius / 6 - line_width,0])
		{
			square
			(
				[radius, diameter],
				center = true
			);
		}
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		
		circle
		(
			radius - line_width,
			$fn = res
		);
		
		translate([-(diameter / 2 + diameter * 7 / 18 + line_width / 2), 0])
		{
			square
			(
				[diameter, diameter  + epsilon * 2],
				center = true
			);
		}
		rotate([0, 0, 180])
		{
			arc
			(
				diameter,
				90
			);
		}
	}

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);

		translate([-(line_width / 2 + diameter * 7 / 18 - line_width / 2), 0])
		{
			square
			(
				[line_width, diameter  + epsilon * 2],
				center = true
			);
		}
	}

	intersection()
	{
		difference()
		{
			left_monogram_2D
			(
				radius,
				res
			);
			translate([-(diameter / 2 + diameter * 7 / 18 + line_width / 2), 0])
			{
				square
				(
					[diameter, diameter  + epsilon * 2],
					center = true
				);
			}
		}
		translate([-(diameter / 6 + small_radius), -line_width / 2])
		{
			rotate([0, 0, -30])
			{
				translate([-diameter / 2, -(line_width / 2 + (small_radius - line_width)), 0])
				{
					square
					(
						[diameter, line_width],
						center = true
					);
				}
			}
		}
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		
		translate([-(diameter / 6 + small_radius), -line_width/2, 0])
		{
			intersection()
			{
				difference()
				{
					scale([small_radius, small_radius])
						circle
						(
							r = 1,
							$fn = res
						);
					scale([small_radius - line_width, small_radius - line_width])
						circle
						(
							r = 1,
							$fn = res
						);
				}
				rotate([0,0,-120])
				{
					arc
					(
						radius,
						120
					);
				}
			}
		}
	}
}

module P_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	small_radius = diameter / 12;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		difference()
		{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([0, -(radius + line_width/2)])
			square
			(
				[diameter, diameter],
				center = true
			);
		}
		translate([(radius * 5 / 6) - line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);			
	}
	

	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([diameter / 6 - small_radius, -line_width / 2])
		{
			intersection()
			{
				difference()
				{
					circle
					(
						r = small_radius,
						$fn = res
					);
					circle
					(
						r = small_radius - line_width,
						$fn = res
					);
				}
				rotate([0, 0, -90])
				arc
				(
					small_radius,
					90
				);
			}
		}
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		translate([-(radius - (diameter / 6 - small_radius)), -small_radius])
			square
			(
				[diameter, line_width],
				center = true
			);
	}
	

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		circle
		(
			radius - line_width,
			$fn = res
		);
		
		translate([0, -radius])
			square
			(
				[diameter, diameter],
				center = true
			);
	}
}


module P_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;
	
	small_radius = diameter / 12;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6) + line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}
	
	intersection()
	{
		difference()
		{
			right_monogram_2D
			(
				radius,
				res
			);
			
			translate([0, -(radius)])
			{
				square
				(
					[diameter * 2, diameter],
					center = true
				);
			}
		}
		translate([(diameter * 7 / 18), 0])
		{
			square
			(
				[line_width, diameter  + epsilon * 2],
				center = true
			);
		}
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([diameter * 7 / 18 + line_width / 2 - small_radius, 0])
		{
			intersection()
			{
				difference()
				{
					circle
					(
						r = small_radius,
						$fn = res
					);
					circle
					(
						r = small_radius - line_width,
						$fn = res
					);
				}
				rotate([0, 0, -60])
				arc
				(
					small_radius,
					60
				);
			}
		}
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([diameter * 7 / 18 + line_width / 2 - small_radius, 0])
		rotate([0, 0, 30])
		translate([-(radius - epsilon), -(line_width / 2 + (small_radius - line_width))])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}
		
	}


	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		circle
		(
			radius - line_width,
			$fn = res
		);
		
		translate([0, -(radius + line_width / 2)])
		{
			square
			(
				[diameter * 2, diameter],
				center = true
			);
		}
		
		translate([radius/2 + diameter * 7 / 18, 0])
		{
			square
			(
				[radius, diameter],
				center = true
			);
		}
	}
}

module Q_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([radius / 6 - line_width,0])
		{
			square
			(
				[radius, diameter],
				center = true
			);
		}
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([-(diameter / 2 + diameter * 7 / 18 + line_width / 2), 0])
			square
			(
				[diameter, diameter  + epsilon * 2],
				center = true
			);
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-(diameter * 7 / 18),0])
		{
			square
			(
				[line_width, diameter],
				center = true
			);
		}
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		
		difference()
		{
			translate([-(((diameter * 7 / 18 + line_width / 2) - diameter / 6) / 2 + diameter / 6), -radius])
			{
				square
				(
					[line_width, diameter],
					center = true
				);
			}
			scale([1, 1/3])
			{
				circle
				(
					radius,
					$fn = 6
				);
			}
		}
	}
	
}

module Q_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([(radius * 5 / 6) - line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);			
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		difference()
		{
			translate([0, -radius])
			{
				square
				(
					[line_width, diameter],
					center = true
				);
			}
			scale([1, 1/3])
			{
				circle
				(
					radius,
					$fn = 6
				);
			}
		}
	}
	
}

module Q_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6 - line_width),0])
		{
			square
			(
				[radius, diameter],
				center = true
			);
		}
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([diameter / 2 + diameter * 7 / 18 + line_width / 2, 0])
			square
			(
				[diameter, diameter  + epsilon * 2],
				center = true
			);
	}
	
	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([diameter * 7 / 18,0])
		{
			square
			(
				[line_width, diameter],
				center = true
			);
		}
	}
	
	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		
		difference()
		{
			translate([(((diameter * 7 / 18 + line_width / 2) - diameter / 6) / 2 + diameter / 6), -radius])
			{
				square
				(
					[line_width, diameter],
					center = true
				);
			}
			scale([1, 1/3])
			{
				circle
				(
					radius,
					$fn = 6
				);
			}
		}
	}
	
}

module R_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;
	
	small_radius = diameter / 12;
	big_radius = small_radius * 2;


	intersection()
	{
		difference()
		{
			left_monogram_2D
			(
				radius,
				res
			);
			translate([0,-(radius + line_width / 2)])
			{
				square
				(
					[diameter * 2, diameter],
					center = true
				);
			}
		}
		translate([radius / 6 - line_width,0])
		{
			square
			(
				[radius, diameter],
				center = true
			);
		}
	}
	
	intersection()
	{
		difference()
		{
			left_monogram_2D
			(
				radius,
				res
			);
			translate([0, radius - (line_width / 2 + big_radius)])
			{
				square
				(
					[diameter * 2, diameter],
					center = true
				);
			}
		}
		translate([radius / 6 - line_width,0])
		{
			square
			(
				[radius, diameter],
				center = true
			);
		}
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		
		circle
		(
			radius - line_width,
			$fn = res
		);
		
		translate([-(diameter / 2 + diameter * 7 / 18 + line_width / 2), 0])
		{
			square
			(
				[diameter, diameter  + epsilon * 2],
				center = true
			);
		}
		rotate([0, 0, 180])
		{
			arc
			(
				diameter,
				90
			);
		}
	}

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);

		translate([-(line_width / 2 + diameter * 7 / 18 - line_width / 2), 0])
		{
			square
			(
				[line_width, diameter  + epsilon * 2],
				center = true
			);
		}
	}

	intersection()
	{
		difference()
		{
			left_monogram_2D
			(
				radius,
				res
			);
			translate([-(diameter / 2 + diameter * 7 / 18 + line_width / 2), 0])
			{
				square
				(
					[diameter, diameter  + epsilon * 2],
					center = true
				);
			}
		}
		translate([-(diameter / 2 + diameter / 6 + small_radius), -small_radius])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}
	} 
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		
		translate([-(diameter / 6 + small_radius), -line_width/2, 0])
		{
			intersection()
			{
				difference()
				{
					scale([small_radius, small_radius])
						circle
						(
							r = 1,
							$fn = res
						);
					scale([small_radius - line_width, small_radius - line_width])
						circle
						(
							r = 1,
							$fn = res
						);
				}
				rotate([0,0,-90])
				{
					arc
					(
						radius,
						90
					);
				}
			}
		}
	}
	
		intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		
		translate([-(diameter / 6 + big_radius), -(small_radius + big_radius - line_width / 2), 0])
		{
			intersection()
			{
				difference()
				{
					scale([big_radius, big_radius])
						circle
						(
							r = 1,
							$fn = res
						);
					scale([big_radius - line_width, big_radius - line_width])
						circle
						(
							r = 1,
							$fn = res
						);
				}

				arc
				(
					radius,
					90
				);
			}
		}
	}
}

module R_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	small_radius = diameter / 12;
	big_radius = small_radius * 2;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		difference()
		{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([0, -(radius + line_width/2)])
			square
			(
				[diameter, diameter],
				center = true
			);
		}
		translate([(radius * 5 / 6) - line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);			
	}
	
	intersection()
	{
		difference()
		{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([0, radius - (line_width / 2 + big_radius)])
			square
			(
				[diameter, diameter],
				center = true
			);
		}
		translate([(radius * 5 / 6) - line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);			
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([diameter / 6 - small_radius, -line_width / 2])
		{
			intersection()
			{
				difference()
				{
					circle
					(
						r = small_radius,
						$fn = res
					);
					circle
					(
						r = small_radius - line_width,
						$fn = res
					);
				}
				rotate([0, 0, -90])
				arc
				(
					diameter,
					90
				);
			}
		}
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([diameter / 6 - big_radius, -(small_radius + big_radius - line_width / 2)])
		{
			intersection()
			{
				difference()
				{
					circle
					(
						r = big_radius,
						$fn = res
					);
					circle
					(
						r = big_radius - line_width,
						$fn = res
					);
				}

				arc
				(
					diameter,
					90
				);
			}
		}
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		translate([-(radius - (diameter / 6 - small_radius)), -small_radius])
			square
			(
				[diameter, line_width],
				center = true
			);
	}
	

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		circle
		(
			radius - line_width,
			$fn = res
		);
		
		translate([0, -radius])
			square
			(
				[diameter, diameter],
				center = true
			);
	}
}

module R_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;
	
	small_radius = diameter / 12;
	big_radius = small_radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6) + line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);
	}
	
	intersection()
	{
		difference()
		{
			right_monogram_2D
			(
				radius,
				res
			);
			
			translate([0, -(radius + line_width / 2)])
			{
				square
				(
					[diameter * 2, diameter],
					center = true
				);
			}
		}
		translate([(diameter * 7 / 18), 0])
		{
			square
			(
				[line_width, diameter  + epsilon * 2],
				center = true
			);
		}
	}

	intersection()
	{
		difference()
		{
			right_monogram_2D
			(
				radius,
				res
			);
			
			translate([0, radius - (big_radius + line_width / 2)])
			{
				square
				(
					[diameter * 2, diameter],
					center = true
				);
			}
		}
		translate([(diameter * 7 / 18), 0])
		{
			square
			(
				[line_width, diameter  + epsilon * 2],
				center = true
			);
		}
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([diameter * 7 / 18 + line_width / 2 - small_radius, -line_width / 2])
		{
			intersection()
			{
				difference()
				{
					circle
					(
						r = small_radius,
						$fn = res
					);
					circle
					(
						r = small_radius - line_width,
						$fn = res
					);
				}
				rotate([0, 0, -90])
				arc
				(
					small_radius,
					90
				);
			}
		}
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius - diameter * 7 / 18 + line_width / 2), -small_radius])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}
		
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([diameter * 7 / 18 + line_width / 2 - big_radius, -(big_radius + small_radius - line_width / 2)])
		{
			intersection()
			{
				difference()
				{
					circle
					(
						r = big_radius,
						$fn = res
					);
					circle
					(
						r = big_radius - line_width,
						$fn = res
					);
				}
				arc
				(
					diameter,
					90
				);
			}
		}
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		circle
		(
			radius - line_width,
			$fn = res
		);
		
		translate([0, -(radius + line_width / 2)])
		{
			square
			(
				[diameter * 2, diameter],
				center = true
			);
		}
		
		translate([radius/2 + diameter * 7 / 18, 0])
		{
			square
			(
				[radius, diameter],
				center = true
			);
		}
	}
}

module S_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([radius / 6 - line_width,0])
			{
				square
				(
					[radius, diameter],
					center = true
				);
			}
			translate([0, line_width])
			{
				square
				(
					[diameter, line_width],
					center = true
				);
			}	
		}
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-diameter / 3, 0])
		{
			square
			(
				[radius, line_width],
				center = true
			);
		}	
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([0, -line_width])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}
	}
}

module S_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([-(radius * 5 / 6) + line_width,0])
				square
				(
					[radius, diameter + epsilon * 2],
					center = true
				);
			translate([0, -line_width])
			{
				square
				(
					[diameter, line_width],
					center = true
				);
			}
		}
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		square
		(
			[radius, line_width],
			center = true
		);	
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([(radius * 5 / 6) - line_width,0])
				square
				(
					[radius, diameter + epsilon * 2],
					center = true
				);
			translate([0, line_width])
				square
				(
					[diameter, line_width],
					center = true
				);				
		}
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module S_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([-(radius / 6) + line_width,0])
			{
				square
				(
					[radius, diameter],
					center = true
				);
			}
			
			translate([0, -line_width])
			{
				square
				(
					[diameter, line_width],
					center = true
				);
			}
		}
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([0, 0])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([0, line_width])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}
	}
}

module T_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-(diameter * 2 / 6),0])
		{
			square
			(
				[line_width, diameter],
				center = true
			);
		}
	}

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([diameter / 3 - line_width, 0])
			{
				square
				(
					[diameter, diameter],
					center = true
				);
			}
			
			translate([0, -(radius + line_width / 2)])
			{
				square
				(
					[diameter, diameter],
					center = true
				);
			}
		}
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([0, -(radius + line_width / 2)])
		{
			square
			(
				[diameter + epsilon * 2, diameter],
				center = true
			);
		}
	}
}

module T_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;


	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		square
		(
			[line_width, diameter + epsilon],
			center = true
		);
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([0, -(radius + line_width / 2)])
		{
			square
			(
				[diameter, diameter],
				center = true
			);
		}
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([diameter * 2 / 3 - line_width, 0])
			{
				square
				(
					[diameter, diameter],
					center = true
				);
			}
			
			translate([0, -(radius + line_width / 2)])
			{
				square
				(
					[diameter, diameter],
					center = true
				);
			}
		}
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([-(diameter * 2 / 3 - line_width), 0])
			{
				square
				(
					[diameter, diameter],
					center = true
				);
			}
			
			translate([0, -(radius + line_width / 2)])
			{
				square
				(
					[diameter, diameter],
					center = true
				);
			}
		}
	}
	
}

module T_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([diameter * 2 / 6,0])
		{
			square
			(
				[line_width, diameter],
				center = true
			);
		}
	}

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([-(diameter / 3 - line_width), 0])
			{
				square
				(
					[diameter, diameter],
					center = true
				);
			}
			
			translate([0, -(radius + line_width / 2)])
			{
				square
				(
					[diameter, diameter],
					center = true
				);
			}
		}
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([0, -(radius + line_width / 2)])
		{
			square
			(
				[diameter + epsilon * 2, diameter],
				center = true
			);
		}
	}
}

module U_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([radius / 6 - line_width,0])
		{
			square
			(
				[radius, diameter],
				center = true
			);
		}
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		
		translate([-(diameter / 2 + diameter * 7 / 18 + line_width / 2), 0])
		{
			square
			(
				[diameter, diameter  + epsilon * 2],
				center = true
			);
		}
		
		translate([0, radius])
		{
			square
			(
				[diameter + epsilon * 2, diameter],
				center = true
			);
		}
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-(diameter * 7 / 18),0])
		{
			square
			(
				[line_width, diameter],
				center = true
			);
		}
	}
}

module U_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6) + line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([(radius * 5 / 6) - line_width,0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);			
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		circle
		(
			radius - line_width,
			$fn = res
		);
		
		translate([0, radius])
		{
			square
			(
				[diameter + epsilon * 2, diameter],
				center = true
			);
		}
	}
}

module U_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius / 6 - line_width),0])
		{
			square
			(
				[radius, diameter],
				center = true
			);
		}
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		
		translate([diameter / 2 + diameter * 7 / 18 + line_width / 2, 0])
		{
			square
			(
				[diameter, diameter  + epsilon * 2],
				center = true
			);
		}
		
		translate([0, radius])
		{
			square
			(
				[diameter + epsilon * 2, diameter],
				center = true
			);
		}
	}
	
	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([diameter * 7 / 18,0])
		{
			square
			(
				[line_width, diameter],
				center = true
			);
		}
	}
}

module V_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);

		translate([radius / 6 - line_width,0])
		{
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
		}
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		
		rotate([0, 0, 90])
		{
			arc
			(
				diameter,
				60,
				$fn = res
			);
		}

		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module V_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([-(radius * 5 / 6) + line_width,0])
			{
				square
				(
					[radius, diameter + epsilon * 2],
					center = true
				);
			}
			translate([0, -(radius + line_width / 2)])
			{
				square
				(
					[diameter, diameter],
					center = true
				);
			}
		}
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([(radius * 5 / 6) - line_width, 0])
				square
				(
					[radius, diameter + epsilon * 2],
					center = true
				);
			translate([0, -(radius + line_width / 2)])
				square
				(
					[diameter, diameter],
					center = true
				);
		}			
	}

	bottom_angle = atan((radius - line_width * 3 / 2) / (diameter / 6 - line_width));
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([diameter / 6 - line_width, -line_width / 2])
		rotate([0, 0, bottom_angle])
		translate([0, -line_width / 2])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}	
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(diameter / 6 - line_width), -line_width / 2])
		rotate([0, 0, -bottom_angle])
		translate([0, -line_width / 2])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}	
	}
// 	difference()
// 	{
// 		middle_monogram_2D
// 		(
// 			radius,
// 			res
// 		);
// 		
// 		intersection()
// 		{
// 			circle
// 			(
// 				radius - line_width,
// 				$fn = res
// 			);
// 		
// 			translate([0, radius])
// 			{
// 				square
// 				(
// 					[diameter + epsilon * 2, diameter],
// 					center = true
// 				);
// 			}
// 		}
// 	}
}

module V_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		translate([-(radius / 6 - line_width),0])
		{
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
		}
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		
		rotate([0, 0, 30])
		{
			arc
			(
				diameter,
				60,
				$fn = res
			);
		}

		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module W_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);

		translate([radius / 6 - line_width,0])
			square
			(
				[radius, diameter],
				center = true
			);

	}

	difference()
	{
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);
			translate([-(diameter / 6 + line_width), 0])
				rotate([0, 0, 115])
					arc
					(
						radius + line_width,
						130,
						$fn = res
					);
		}
		circle
		(
			radius - line_width,
			$fn = res
		);

	}
	left_location_y = sin( 180 - 115 - asin( sin(115) / (radius - line_width) * ((diameter / 6) + line_width))) * (radius - line_width);
	left_location_x = 1 / (tan(180 - 115 - asin( sin(115) / (radius - line_width) * ((diameter / 6) + line_width))) /  left_location_y);
	left_angle = atan((left_location_y - line_width) / ((left_location_x - diameter / 6 - line_width - (radius - line_width - left_location_x)/2) / 2));
	
	right_location_y = sin(acos((diameter / 6 + line_width) / radius)) * radius;
	right_location_x = diameter / 6 + line_width;
	right_angle = atan((right_location_y - line_width) / ((left_location_x - diameter / 6 - line_width + (radius - line_width - left_location_x)/2) / 2));
	
	intersection()
	{
	
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);

			translate([- left_location_x, -left_location_y , 0])
				rotate([0, 0, left_angle])
					translate([0, line_width / 2])
						square
						(
							[diameter, line_width],
							center = true
						);
		}
	
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);

			translate([- right_location_x, -right_location_y , 0])
				rotate([0, 0, -right_angle])
					translate([0, line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
	}
	
	difference()
	{
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);

			translate([- left_location_x, -left_location_y , 0])
				rotate([0, 0, left_angle])
					translate([0, line_width / 2])
						square
						(
							[diameter, line_width],
							center = true
						);
		}

		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);

			translate([- right_location_x, -right_location_y , 0])
				rotate([0, 0, -right_angle])
					translate([0, diameter])
						square
						(
							[diameter * 2, diameter * 2],
							center = true
						);
		}
	}
	
	difference()
	{
	
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);

			translate([- right_location_x, -right_location_y , 0])
				rotate([0, 0, -right_angle])
					translate([0, line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
		
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);

			translate([- left_location_x, -left_location_y , 0])
				rotate([0, 0, left_angle + 1])
					translate([0, diameter])
						square
						(
							[diameter * 2, diameter * 2],
							center = true
						);
		}


	}
	
}

module W_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;


	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([-(radius * 5 / 6 - line_width),0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		translate([(radius * 5 / 6 - line_width),0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	location_y = sqrt(pow(radius, 2) - pow(diameter / 6 - line_width, 2));
	location_x = diameter / 6 - line_width;

	inner_angle = 90 - atan((diameter / 6 - line_width) / (location_y - line_width));

	intersection()
	{
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);

			translate([- location_x, -location_y , 0])
				rotate([0, 0, inner_angle])
					translate([0, line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
	
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);

			translate([	location_x, -location_y , 0])
				rotate([0, 0, -inner_angle])
					translate([0, line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
	}
	
	difference()
	{
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);

			translate([- location_x, -location_y , 0])
				rotate([0, 0, inner_angle])
					translate([0, line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
	
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);

			translate([	location_x, -location_y , 0])
				rotate([0, 0, -inner_angle])
					translate([0, diameter / 2])
						square
						(
							[diameter * 2, diameter],
							center = true
						);
		}
	}
	
	difference()
	{
	
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);

			translate([	location_x, -location_y , 0])
				rotate([0, 0, -inner_angle])
					translate([0, line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
	
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);

			translate([- location_x, -location_y , 0])
				rotate([0, 0, inner_angle])
					translate([0, diameter / 2])
						square
						(
							[diameter * 2, diameter],
							center = true
						);
		}
	

	}

}

module W_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		translate([-(radius / 6 - line_width),0])
			square
			(
				[radius, diameter],
				center = true
			);

	}

	difference()
	{
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);
			translate([diameter / 6 + line_width, 0])
				rotate([0, 0, -65])
					arc
					(
						radius + line_width,
						130,
						$fn = res
					);
		}
		circle
		(
			radius - line_width,
			$fn = res
		);

	}
	left_location_y = sin( 180 - 115 - asin( sin(115) / (radius - line_width) * ((diameter / 6) + line_width))) * (radius - line_width);
	left_location_x = 1 / (tan(180 - 115 - asin( sin(115) / (radius - line_width) * ((diameter / 6) + line_width))) /  left_location_y);
	left_angle = atan((left_location_y - line_width) / ((left_location_x - diameter / 6 - line_width - (radius - line_width - left_location_x)/2) / 2));
	
	right_location_y = sin(acos((diameter / 6 + line_width) / radius)) * radius;
	right_location_x = diameter / 6 + line_width;
	right_angle = atan((right_location_y - line_width) / ((left_location_x - diameter / 6 - line_width + (radius - line_width - left_location_x)/2) / 2));
	
	intersection()
	{
	
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);

			translate([left_location_x, -left_location_y , 0])
				rotate([0, 0, -left_angle])
					translate([0, line_width / 2])
						square
						(
							[diameter, line_width],
							center = true
						);
		}
	
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);

			translate([right_location_x, -right_location_y , 0])
				rotate([0, 0, right_angle])
					translate([0, line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
	}
	
	difference()
	{
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);

			translate([left_location_x, -left_location_y , 0])
				rotate([0, 0, -left_angle])
					translate([0, line_width / 2])
						square
						(
							[diameter, line_width],
							center = true
						);
		}

		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);

			translate([right_location_x, -right_location_y , 0])
				rotate([0, 0, right_angle])
					translate([0, diameter])
						square
						(
							[diameter * 2, diameter * 2],
							center = true
						);
		}
	}
	
	difference()
	{
	
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);

			translate([right_location_x, -right_location_y , 0])
				rotate([0, 0, right_angle])
					translate([0, line_width / 2])
						square
						(
							[diameter * 2, line_width],
							center = true
						);
		}
		
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);

			translate([left_location_x, -left_location_y , 0])
				rotate([0, 0, -(left_angle + 1)])
					translate([0, diameter])
						square
						(
							[diameter * 2, diameter * 2],
							center = true
						);
		}


	}
}

module X_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;
	
	cross_angle = 45;
	cross_center_ratio = 50;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([radius / 6 - line_width,0])
			{
				square
				(
					[radius, diameter],
					center = true
				);
			}
			
			translate([-(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), 0])
			{
				rotate([0, 0, -cross_angle])
				{
					arc
					(
						diameter,
						cross_angle * 2,
						$fn = res
					);
				}
			}
		}
	}

	difference()
	{
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);
		rotate([0, 0, 135])
			arc
			(
				radius + line_width,
				90,
				$fn = res
			);
		}
		circle
		(
			radius - line_width,
			$fn = res
		);
		
		translate([-(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), 0])
		{
			rotate([0, 0, 180 - cross_angle])
			{
				arc
				(
					diameter,
					cross_angle * 2,
					$fn = res
				);
			}
		}
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);

		translate([-(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)),0])
		rotate([0, 0, cross_angle])
		{
			square
			(
				[diameter * 2, line_width],
				center = true
			);
		}
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);

		translate([-(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)),0])
		rotate([0, 0, -cross_angle])
		{
			square
			(
				[diameter * 2, line_width],
				center = true
			);
		}
	}
}

module X_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	cross_angle = 45;

	intersection()
	{
		difference()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
			
			rotate([0, 0, 180 - cross_angle])
			{
				arc
				(
					diameter,
					cross_angle * 2,
					$fn = res
				);
			}
		}
		translate([-(radius * 5 / 6 - line_width),0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	
	intersection()
	{
		difference()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
		
			rotate([0, 0, -cross_angle])
			{
				arc
				(
					diameter,
					cross_angle * 2,
					$fn = res
				);
			}
		}
		
		translate([(radius * 5 / 6 - line_width),0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		rotate([0, 0, cross_angle])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}
	}
	
	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		
		rotate([0, 0, -cross_angle])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}
	}
	

}

module X_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;
	
	cross_angle = 45;
	cross_center_ratio = 50;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([-(radius / 6 - line_width),0])
			{
				square
				(
					[radius, diameter],
					center = true
				);
			}
			
			translate([(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), 0])
			{
				rotate([0, 0, 180 - cross_angle])
				{
					arc
					(
						diameter,
						cross_angle * 2,
						$fn = res
					);
				}
			}
		}
	}

	difference()
	{
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);
		rotate([0, 0, -45])
			arc
			(
				radius + line_width,
				90,
				$fn = res
			);
		}
		circle
		(
			radius - line_width,
			$fn = res
		);
		
		translate([(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), 0])
		{
			rotate([0, 0, -cross_angle])
			{
				arc
				(
					diameter,
					cross_angle * 2,
					$fn = res
				);
			}
		}
	}
	
	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		translate([(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)),0])
		rotate([0, 0, -cross_angle])
		{
			square
			(
				[diameter * 2, line_width],
				center = true
			);
		}
	}
	
	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);

		translate([(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)),0])
		rotate([0, 0, cross_angle])
		{
			square
			(
				[diameter * 2, line_width],
				center = true
			);
		}
	}
}

module Y_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;
	
	cross_angle = 30;
	cross_center_ratio = 35 ;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		intersection()
		{
			translate([radius / 6 - line_width,0])
			{
				square
				(
					[radius, diameter],
					center = true
				);
			}
			
			translate([-(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), -radius / 6])
			{
				rotate([0, 0, cross_angle])
				{
					arc
					(
						diameter,
						(90 - cross_angle) * 2,
						$fn = res
					);
				}
			}
		}
	}

	difference()
	{
		intersection()
		{
			left_monogram_2D
			(
				radius,
				res
			);
			
			translate([-(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), -radius / 6])
			{
				rotate([0, 0, cross_angle])
				{
					arc
					(
						diameter,
						(90 - cross_angle) * 2,
						$fn = res
					);
				}
			}
		}
		circle
		(
			radius - line_width,
			$fn = res
		);
		
		rotate([0, 0, 45])
		{
			arc
			(
				diameter * 2,
				90,
				$fn = res
			);
		}
	}
	
	intersection()
	{
		difference()
		{
			left_monogram_2D
			(
				radius,
				res
			);
		
			translate([-(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), -radius / 6])
			{
				rotate([0, 0, 180])
				{
					arc
					(
						diameter * 2,
						90,
						$fn = res
					);
				}
			}
		
		}
		translate([-(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), -radius / 6])
		rotate([0, 0, cross_angle])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}
	}
	
	intersection()
	{
		difference()
		{
			left_monogram_2D
			(
				radius,
				res
			);
			translate([-(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), -radius / 6])
			{
				rotate([0, 0, -90])
				{
					arc
					(
						diameter * 2,
						90,
						$fn = res
					);
				}
			}
		}
		translate([-(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), -radius / 6])
		{
			rotate([0, 0, -cross_angle])
			{
				square
				(
					[diameter, line_width],
					center = true
				);
			}
		}
	}
	
	intersection()
	{
		difference()
		{
			left_monogram_2D
			(
				radius,
				res
			);
			translate([-(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), radius - radius / 6])
			{
				square
				(
					[diameter, diameter],
					center = true
				);
			}
		}
		translate([-(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), 0])
		{
			square
			(
				[line_width, diameter],
				center = true
			);
		}
	}
}

module Y_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;

	cross_angle = 30;
	cross_depth = radius * 2 / 6 - line_width / 2;

	intersection()
	{
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
			
			translate([0, -cross_depth])
			{
				rotate([0, 0, cross_angle])
				{
					arc
					(
						diameter,
						(90 - cross_angle) * 2,
						$fn = res
					);
				}
			}
		}
		translate([-(radius * 5 / 6 - line_width),0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}

	
	intersection()
	{
		intersection()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
		
			translate([0, -cross_depth])
			{
				rotate([0, 0, cross_angle])
				{
					arc
					(
						diameter,
						(90 - cross_angle) * 2,
						$fn = res
					);
				}
			}
		}
		
		translate([(radius * 5 / 6 - line_width),0])
			square
			(
				[radius, diameter + epsilon * 2],
				center = true
			);
	}
	
	intersection()
	{
		difference()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
			
			translate([0, -cross_depth])
			{
				rotate([0, 0, 180])
				{
					arc
					(
						diameter,
						90,
						$fn = res
					);
				}
			}
		}
		translate([0, -cross_depth])
		{
			rotate([0, 0, cross_angle])
			{
				square
				(
					[diameter, line_width],
					center = true
				);
			}
		}
	}
	
	intersection()
	{
		difference()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
			
			translate([0, -cross_depth])
			{
				rotate([0, 0, -90])
				{
					arc
					(
						diameter,
						90,
						$fn = res
					);
				}
			}
		}
		
		translate([0, -cross_depth])
		{
			rotate([0, 0, -cross_angle])
			{
				square
				(
					[diameter, line_width],
					center = true
				);
			}
		}
	}
	
	intersection()
	{
		difference()
		{
			middle_monogram_2D
			(
				radius,
				res
			);
			
			translate([0, radius - cross_depth])
			{
				square
				(
					[diameter, diameter],
					center = true
				);
			}
		}
		
		square
		(
			[line_width, diameter],
			center = true
		);
	}

}

module Y_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;
	
	cross_angle = 30;
	cross_center_ratio = 35 ;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		intersection()
		{
			translate([-(radius / 6 - line_width),0])
			{
				square
				(
					[radius, diameter],
					center = true
				);
			}
			
			translate([(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), -radius / 6])
			{
				rotate([0, 0, cross_angle])
				{
					arc
					(
						diameter,
						(90 - cross_angle) * 2,
						$fn = res
					);
				}
			}
		}
	}

	difference()
	{
		intersection()
		{
			right_monogram_2D
			(
				radius,
				res
			);
			
			translate([(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), -radius / 6])
			{
				rotate([0, 0, cross_angle])
				{
					arc
					(
						diameter,
						(90 - cross_angle) * 2,
						$fn = res
					);
				}
			}
		}
		circle
		(
			radius - line_width,
			$fn = res
		);
		
		rotate([0, 0, 45])
		{
			arc
			(
				diameter * 2,
				90,
				$fn = res
			);
		}
	}
	
	intersection()
	{
		difference()
		{
			right_monogram_2D
			(
				radius,
				res
			);
		
			translate([(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), -radius / 6])
			{
				rotate([0, 0, -90])
				{
					arc
					(
						diameter * 2,
						90,
						$fn = res
					);
				}
			}
		
		}
		translate([(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), -radius / 6])
		rotate([0, 0, -cross_angle])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}
	}
	
	intersection()
	{
		difference()
		{
			right_monogram_2D
			(
				radius,
				res
			);
			translate([(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), -radius / 6])
			{
				rotate([0, 0, 180])
				{
					arc
					(
						diameter * 2,
						90,
						$fn = res
					);
				}
			}
		}
		translate([(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), -radius / 6])
		{
			rotate([0, 0, cross_angle])
			{
				square
				(
					[diameter, line_width],
					center = true
				);
			}
		}
	}
	
	intersection()
	{
		difference()
		{
			right_monogram_2D
			(
				radius,
				res
			);
			translate([(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), radius - radius / 6])
			{
				square
				(
					[diameter, diameter],
					center = true
				);
			}
		}
		translate([(diameter / 6 + (diameter / 3 * cross_center_ratio / 100)), 0])
		{
			square
			(
				[line_width, diameter],
				center = true
			);
		}
	}
}

module Z_left_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;


	cross_angle = 65;
	cross_center_percent = 40;

	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([radius / 6 - line_width,0])
			{
				square
				(
					[radius, diameter],
					center = true
				);
			}
			
			square
			(
				[diameter, (tan(cross_angle) * ((diameter / 3 * cross_center_percent / 100) - (line_width / 2 / sin(cross_angle)))) * 2],
				center = true
			);
		}
	}
	
	intersection()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		translate([-(diameter / 6 + (diameter / 3 * cross_center_percent / 100)), 0])
		rotate([0, 0, cross_angle])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}	
	}

	difference()
	{
		left_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([-(diameter / 6 + diameter / 3 * cross_center_percent / 100), 0])
		rotate([0, 0, 180])
		{
			arc
			(
				diameter,
				cross_angle,
				$fn = res
			);
		}

		rotate([0, 0, 180 - 30])
		{
			arc
			(
				diameter,
				30,
				$fn = res
			);
		}
	}
}

module Z_middle_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;
	epsilon = .01;
	
	cross_angle = 70;

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([-(radius * 5 / 6) + line_width,0])
				square
				(
					[radius, diameter + epsilon * 2],
					center = true
				);
				
			square
			(
				[diameter, (tan(cross_angle) * ((diameter / 6) - (line_width / 2 / sin(cross_angle)))) * 2],
				center = true
			);
		}
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		rotate([0, 0, cross_angle])
		square
		(
			[diameter, line_width],
			center = true
		);	
	}

	intersection()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([(radius * 5 / 6) - line_width,0])
				square
				(
					[radius, diameter + epsilon * 2],
					center = true
				);

			square
			(
				[diameter, (tan(cross_angle) * ((diameter / 6) - (line_width / 2 / sin(cross_angle)))) * 2],
				center = true
			);				
		}
	}

	difference()
	{
		middle_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
	}
}

module Z_right_2D
(
	radius = 10,
	line_width = .8,
	res = 32
)
{
	diameter = radius * 2;


	cross_angle = 65;
	cross_center_percent = 40;

	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		difference()
		{
			translate([-(radius / 6 - line_width),0])
			{
				square
				(
					[radius, diameter],
					center = true
				);
			}
			
			square
			(
				[diameter, (tan(cross_angle) * ((diameter / 3 * cross_center_percent / 100) - (line_width / 2 / sin(cross_angle)))) * 2],
				center = true
			);
		}
	}
	
	intersection()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		translate([(diameter / 6 + (diameter / 3 * cross_center_percent / 100)), 0])
		rotate([0, 0, cross_angle])
		{
			square
			(
				[diameter, line_width],
				center = true
			);
		}	
	}

	difference()
	{
		right_monogram_2D
		(
			radius,
			res
		);
		circle
		(
			radius - line_width,
			$fn = res
		);
		translate([(diameter / 6 + diameter / 3 * cross_center_percent / 100), 0])
		rotate([0, 0, 0])
		{
			arc
			(
				diameter,
				cross_angle,
				$fn = res
			);
		}

		rotate([0, 0,  -30])
		{
			arc
			(
				diameter,
				30,
				$fn = res
			);
		}
	}
}

function heart_paths() =	[
								[
									0,1,2,3,4,5,6,7,8,9,10,
									11,12,13,14,15,16,17,18,19,20,
									21,22,23,24,25,26,27,28,29,30,
									31,32,33,34,35,36,37,38,39,40,
									41,42,43,44,45,46,47,48,49,50,
									51,52,53,54,55,56,57,58,59
								]
							];

function heart_points() =	[
								[0.000000,0.597930],
								[-0.055507,0.720679],
								[-0.138351,0.821203],
								[-0.242369,0.898328],
								[-0.361399,0.950878],
								[-0.489278,0.977677],
								[-0.619844,0.977550],
								[-0.746934,0.949322],
								[-0.864385,0.891818],
								[-0.966036,0.803861],
								[-1.045722,0.684277],
								[-1.097283,0.531889],
								[-1.114555,0.345524],
								[-1.103280,0.207359],
								[-1.073834,0.084087],
								[-1.028634,-0.025968],
								[-0.970098,-0.124480],
								[-0.900644,-0.213122],
								[-0.822691,-0.293570],
								[-0.738655,-0.367498],
								[-0.650956,-0.436580],
								[-0.562012,-0.502490],
								[-0.474239,-0.566904],
								[-0.390057,-0.631495],
								[-0.311883,-0.697937],
								[-0.236123,-0.766302],
								[-0.178445,-0.817526],
								[-0.132423,-0.859057],
								[-0.091626,-0.898347],
								[-0.049628,-0.942844],
								[0.000000,-1.000000],
								[0.049628,-0.942844],
								[0.091626,-0.898347],
								[0.132423,-0.859057],
								[0.178445,-0.817526],
								[0.236123,-0.766302],
								[0.311883,-0.697937],
								[0.390057,-0.631495],
								[0.474239,-0.566904],
								[0.562012,-0.502490],
								[0.650956,-0.436580],
								[0.738655,-0.367498],
								[0.822691,-0.293570],
								[0.900644,-0.213122],
								[0.970098,-0.124480],
								[1.028634,-0.025968],
								[1.073834,0.084087],
								[1.103280,0.207359],
								[1.114555,0.345524],
								[1.097283,0.531889],
								[1.045722,0.684277],
								[0.966036,0.803861],
								[0.864385,0.891818],
								[0.746934,0.949322],
								[0.619844,0.977550],
								[0.489278,0.977677],
								[0.361399,0.950878],
								[0.242369,0.898328],
								[0.138351,0.821203],
								[0.055507,0.720679]
							];
module unit_heart() {
	scale([1/2.229109, 1/2.229109])
    	polygon(points = heart_points(), paths = heart_paths());
};

module arc	
(
	radius,
	angle,
	$fn = 36
)
{
	scale([radius,radius]){
		if (angle % 360 != 0)
		{
			if (angle % 360 <= 90)
			{
				difference()
				{
					circle(r = 1);
					polygon(
						points = [
							[0,0],[2,0],[cos(270)*2,sin(270)*2],
							[cos(180)*2,sin(180)*2],[cos(91)*2,sin(91)*2],
							[cos(angle)*2,sin(angle)*2]
						],
						paths = [[0,1,2,3,4,5]],
						convexity = 10
					);
				}
			}
			else
			{
				if (angle % 360 <= 180)
				{
					difference()
					{
						circle(r = 1);
						polygon(		
							points = [	
								[0,0],[2,0],[cos(270)*2,sin(270)*2],
								[cos(181)*2,sin(181)*2],[cos(angle)*2,sin(angle)*2]
							], 
							paths = [[0,1,2,3,4]], 
							convexity = 10
						);
					}
				}
				else
				{
					if (angle % 360 <= 270)
					{
						difference()
						{
							circle(r = 1);
							polygon(
								points = [
									[0,0],[2,0],[cos(271)*2,sin(271)*2],
									[cos(angle)*2,sin(angle)*2]],
								paths = [[0,1,2,3]],
								convexity = 10
							);
						}
					}
					else
					{
						if (angle % 360 < 360)
						{
							difference()
							{
								circle(r = 1);
								polygon(
									points = [[0,0],[2,0],[cos(angle)*2,sin(angle)*2]],
									paths = [[0,1,2]],
									convexity = 10
								);
							}
						}
					}
				}
			}
		}
		else
		{
			circle(r = 1);
		}
	}
}
