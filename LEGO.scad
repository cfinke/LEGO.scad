/**
 * Derived from http://www.thingiverse.com/thing:5699
 */

/* General */

// Width of the block, in studs
block_width = 2;

// Length of the block, in studs
block_length = 4;

// Height of the block. A ratio of "1" is a standard LEGO brick height; a ratio of "1/3" is a standard LEGO plate height.
block_height_ratio = 1; // [.33333333333:1/3, 1:1, 2:2, 3:3, 4:4, 5:5, 6:6, 7:7, 8:8]

// What type of block should this be? A normal brick, smooth-topped tile, or a wing? For wing options, see the "Wings" tab.
block_type = "brick"; // [brick:Brick, tile:Tile, wing:Wing]

// What stud type do you want? Hollow studs allow rods to be pushed into the stud.
stud_type = "solid"; // [solid:Solid, hollow:Hollow]

// Should the block include round horizontal holes like the Technics LEGO bricks have?
technic_holes = "no"; // [no:No, yes:Yes]

// Should the block include vertical cross-shaped axle holes?
vertical_axle_holes = "no"; // [no:No, yes:Yes]

// Should extra reinforcement be included to make printing on an FDM printer easier? Ignored for tiles, since they're printed upside-down and don't need the reinforcement. Recommended for block heights less than 1. 
use_reinforcement = "no"; // [no:No, yes:Yes]

/* [Wings] */

// What type of wing? Full is suitable for the front of a plane, left/right are for the left/right of a plane (not yet supported).
//wing_type = "full"; // [full:Full]

// The number of studs across the end of the wing. If block_width is odd, this needs to be odd, and the same for even.
wing_end_width = 2;

// The length of the rectangular portion of the wing, in studs.
wing_base_length = 4;

// Should the wing edges be notched to accept studs below?
wing_stud_notches = "yes"; // [yes:Yes, no:No]

// (foo * 1) is to prevent these from appearing in the Customizer.
stud_diameter=4.85 * 1; 
hollow_stud_inner_diameter = 3.1 * 1;
stud_height=1.8 * 1;
stud_spacing=8 * 1;
wall_thickness=1.2 * 1;
roof_thickness=1 * 1;
block_height=9.6 * 1;
pin_diameter=3 * 1; // pin for bottom blocks with width or length of 1
post_diameter=6.5 * 1; 
post_wall_thickness = 0.85 * 1;
reinforcing_width=1.5 * 1;
axle_spline_width=2.0 * 1;
axle_diameter=5 * 1;
cylinder_precision=0.1 * 1;
wall_play = 0.1 * 1;

horizontal_hole_diameter = 4.8 * 1;
horizontal_hole_wall_thickness = 1 * 1;
horizontal_hole_z_offset = 5.8 * 1;
horizontal_hole_bevel_diameter = 6.2 * 1;
horizontal_hole_bevel_depth = 0.9 * 1;

// Print tiles upside down.
translate([0, 0, (block_type == "tile" ? block_height_ratio * block_height : 0)]) rotate([0, (block_type == "tile" ? 180 : 0), 0]) {
    block(
    width=block_width,
    length=block_length,
    height=block_height_ratio,
    vertical_axle_holes=(vertical_axle_holes=="yes"),
    reinforcement=((use_reinforcement=="yes") && block_type != "tile"),
    smooth=(block_type == "tile"),
    type=block_type,
    stud_notches=(wing_stud_notches=="yes"),
    stud_type=stud_type,
    horizontal_holes=(technic_holes=="yes" && block_height_ratio == 1)
    );
}

module block(width=1, length=2, height=1, vertical_axle_holes=false, reinforcement=false, smooth=false, type="brick", stud_notches=false, stud_type="solid", horizontal_holes=false) {
    // Ensure that width is always less than or equal to length.
    real_width = min(width, length);
    real_length = max(width, length);

    total_studs_width = (stud_diameter * real_width) + ((real_width - 1) * (stud_spacing - stud_diameter));
    total_studs_length = (stud_diameter * real_length) + ((real_length - 1) * (stud_spacing - stud_diameter));
    
    total_posts_width = (post_diameter * (real_width - 1)) + ((real_width - 2) * (stud_spacing - post_diameter));
    total_posts_length = (post_diameter * (real_length - 1)) + ((real_length - 2) * (stud_spacing - post_diameter));
    
    total_axles_width = (axle_diameter * (real_width - 1)) + ((real_width - 2) * (stud_spacing - axle_diameter));
    total_axles_length = (axle_diameter * (real_length - 1)) + ((real_length - 2) * (stud_spacing - axle_diameter));
    
    total_pins_width = (pin_diameter * (real_width - 1)) + max(0, ((real_width - 2) * (stud_spacing - pin_diameter)));
    total_pins_length = (pin_diameter * (real_length - 1)) + max(0, ((real_length - 2) * (stud_spacing - pin_diameter)));

	total_horizontal_holes_length = total_studs_length;

    overall_length = (real_length * stud_spacing) - (2 * wall_play);
    overall_width = (real_width * stud_spacing) - (2 * wall_play);
    
    wing_slope = ((real_width - wing_end_width) / 2) / (real_length - wing_base_length);
    
    //translate([-overall_length/2, -overall_width/2, 0]) // Comment to position at 0,0,0 instead of centered on X and Y.
        union() {
            difference() {
                union() {
                    // The mass of the block.
                    difference() {
                        cube([overall_length, overall_width, height * block_height]);
                        translate([wall_thickness,wall_thickness,-roof_thickness]) cube([overall_length-wall_thickness*2,overall_width-wall_thickness*2,block_height*height]);
                    }
                    
                    // The studs on top of the block (if it's not a tile).
                    if ( ! smooth ) {
                        translate([stud_diameter / 2, stud_diameter / 2, 0]) 
                        translate([(overall_length - total_studs_length)/2, (overall_width - total_studs_width)/2, 0]) {
                            for (ycount=[0:real_width-1]) {
                                for (xcount=[0:real_length-1]) {
                                    if (
                                        type != "wing" // Only wings need additional checking on a per-stud basis.
                                        || xcount < wing_base_length // No additional checking in the wing base.
                                        || ((wing_end_width % 2 == 0) && (ycount+1 > (real_width - (floor((real_width - ((xcount+1 - wing_base_length) * wing_slope*2))/2)*2)) / 2) && ycount+1 <= (real_width - ((real_width - (floor((real_width - ((xcount+1 - wing_base_length) * wing_slope*2))/2)*2)) / 2))) // Basically, check whether the width of the wing at the current x-count is wide enough to hold as many studs across as this y-count would require (even-count widths)
                                        || ((wing_end_width % 2 == 1) && (ycount+1 > (real_width - (floor((real_width - ((xcount+1 - wing_base_length) * wing_slope*2))/2)*2+1)) / 2) && ycount+1 <= (real_width - ((real_width - (floor((real_width - ((xcount+1 - wing_base_length) * wing_slope*2))/2)*2+1)) / 2))) // Basically, check whether the width of the wing at the current x-count is wide enough to hold as many studs across as this y-count would require (odd-count widths)
                                    ) {                   
                                        translate([xcount*stud_spacing,ycount*stud_spacing,block_height*height]) stud(stud_type);
                                    }
                                }
                            }
                       }
                    }
                    
                    if (real_width > 1 && real_length > 1) {
                        // Reinforcements and posts
                        translate([post_diameter / 2, post_diameter / 2, 0]) {
                            translate([(overall_length - total_posts_length)/2, (overall_width - total_posts_width)/2, 0]) {
                                union() {
                                    // Posts
                                    for (ycount=[1:real_width-1]) {
                                        for (xcount=[1:real_length-1]) {
                                            translate([(xcount-1)*stud_spacing,(ycount-1)*stud_spacing,0]) post(height,vertical_axle_holes);
                                        }
                                    }
    
                                    // Reinforcements
                                    if (reinforcement) {
                                        difference() {
                                            for (ycount=[1:real_width-1]) {
                                                for (xcount=[1:real_length-1]) {
                                                    translate([(xcount-1)*stud_spacing,(ycount-1)*stud_spacing,0]) reinforcement(height);
                                                }
                                            }

                                            for (ycount=[1:real_width-1]) {
                                                for (xcount=[1:real_length-1]) {
                                                    translate([(xcount-1)*stud_spacing,(ycount-1)*stud_spacing,-0.5]) cylinder(r=post_diameter/2-0.1, h=height*block_height+0.5, $fs=cylinder_precision);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    if ((real_width == 1 || real_length == 1) && real_width != real_length) {
                        // Pins
                        if (real_width == 1) {
                            translate([(pin_diameter/2) + (overall_length - total_pins_length) / 2, overall_width/2, 0]) {
                                for (xcount=[1:real_length-1]) {
                                    translate([(xcount-1)*stud_spacing,0,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);
                                }
                            }
                        }
                        else {
                            translate([overall_length/2, (pin_diameter/2) + (overall_width - total_pins_width) / 2, 0]) {
                                for (ycount=[1:real_width-1]) {
                                    translate([0,(ycount-1)*stud_spacing,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);
                                }
                            }
                        }
                    }
		
		            if (horizontal_holes) {
						// The holes for the horizontal axles.
						// 1-length bricks have the hole underneath the stud.
						// >1-length bricks have the holes between the studs.
						translate([(horizontal_hole_diameter / 2) + (real_length == 1 ? 0 : (stud_spacing / 2)), overall_width, 0]) 
						translate([(overall_length - total_studs_length)/2, 0, 0]) {
							for (axle_hole_index=[0:(real_length == 1 ? real_length-1 : real_length-2)]) {
								translate([axle_hole_index*stud_spacing,0,horizontal_hole_z_offset]) rotate([90, 0, 0])  cylinder(r=horizontal_hole_diameter/2 + horizontal_hole_wall_thickness, h=overall_width,$fs=cylinder_precision);
							}
						}
		            }
                }
                
                if (vertical_axle_holes) {
                    if (real_width > 1 && real_length > 1) {
                        translate([axle_diameter / 2, axle_diameter / 2, 0]) {
                            translate([(overall_length - total_axles_length)/2, (overall_width - total_axles_width)/2, 0]) {
                                for (ycount = [ 1 : real_width - 1 ]) {
                                    for (xcount = [ 1 : real_length - 1]) {
                                        translate([(xcount-1)*stud_spacing,(ycount-1)*stud_spacing,-block_height/2]) axle(height+1);
                                    }
                                }
                            }
                        }
                    }
                }
                
                if (type == "wing") {
                    translate([0, 0, -0.5]) linear_extrude(block_height * height + stud_height + 1) polygon(points=[
                        [stud_spacing * (wing_base_length-1), -0.01],
                        [overall_length + 0.01, -0.01],
                        [overall_length + 0.01, (overall_width / 2) - (wing_end_width * stud_spacing / 2) - (stud_spacing/2)]
                    ]
                    );

                    translate([0, 0, -0.5]) linear_extrude(block_height * height + stud_height + 1) polygon(points=[
                        [stud_spacing * (wing_base_length-1), overall_width + 0.01],
                        [overall_length + 0.01, overall_width + 0.01],
                        [overall_length + 0.01, (overall_width / 2) + (wing_end_width * stud_spacing / 2) + (stud_spacing/2)]
                    ]
                    );
                }

	            if (horizontal_holes) {
					// The holes for the horizontal axles.
					// 1-length bricks have the hole underneath the stud.
					// >1-length bricks have the holes between the studs.
					translate([(horizontal_hole_diameter / 2) + (real_length == 1 ? 0 : (stud_spacing / 2)), 0, 0]) 
					translate([(overall_length - total_studs_length)/2, 0, 0]) {
						for (axle_hole_index=[0 : ( real_length == 1 ? real_length-1 : real_length-2)]) {
							union() {
								translate([axle_hole_index*stud_spacing,overall_width,horizontal_hole_z_offset]) rotate([90, 0, 0])  cylinder(r=horizontal_hole_diameter/2, h=overall_width,$fs=cylinder_precision);
	
								// Bevels. The +/- 0.1 measurements are here just for nicer previews in OpenSCAD, and could be removed.
								translate([axle_hole_index*stud_spacing,horizontal_hole_bevel_depth-0.1,horizontal_hole_z_offset]) rotate([90, 0, 0]) cylinder(r=horizontal_hole_bevel_diameter/2, h=horizontal_hole_bevel_depth+0.1,$fs=cylinder_precision);
								translate([axle_hole_index*stud_spacing,overall_width+0.1,horizontal_hole_z_offset]) rotate([90, 0, 0]) cylinder(r=horizontal_hole_bevel_diameter/2, h=horizontal_hole_bevel_depth+0.1,$fs=cylinder_precision);
							}
						}
					}
	            }
            }

            if (type == "wing") {
                difference() {
                    union() {
                        linear_extrude(block_height * height) polygon(points=[
                            [stud_spacing * (wing_base_length-1), 0],
                            [overall_length, (overall_width / 2) - (wing_end_width * stud_spacing / 2) - (stud_spacing/2)],
                            [overall_length, (overall_width / 2) - (wing_end_width * stud_spacing / 2) - (stud_spacing/2) + wall_thickness],
                            [stud_spacing * (wing_base_length-1), wall_thickness]
                        ]);
                        
                        linear_extrude(block_height * height) polygon(points=[
                            [stud_spacing * (wing_base_length-1), overall_width],
                            [overall_length, (overall_width / 2) + (wing_end_width * stud_spacing / 2) + (stud_spacing/2)],
                            [overall_length, (overall_width / 2) + (wing_end_width * stud_spacing / 2) + (stud_spacing/2) - wall_thickness],
                            [stud_spacing * (wing_base_length-1), overall_width - wall_thickness]
                        ]);
                    }
                    
                    if (stud_notches) {
                        translate([overall_length/2, overall_width/2, 0])
                            translate([0, 0, -(1/3 * block_height)]) block(width=real_width,length=real_length,height=1/3);
                    }
                }
            }


    }
}

module post(height,axle_hole=false) {
    difference() {
        cylinder(r=post_diameter/2, h=height*block_height,$fs=cylinder_precision);
        if (axle_hole==true) {
            translate([0,0,-block_height/2])
                axle(height+1);
        } else {
            translate([0,0,-0.5]) cylinder(r=(post_diameter/2)-post_wall_thickness, h=height*block_height+1,$fs=cylinder_precision);
        }
    }
}

module reinforcement(height) {
    union() {
        translate([0,0,height*block_height/2]) union() {
            cube([reinforcing_width,stud_spacing+stud_diameter+wall_thickness/2,height*block_height],center=true);
            rotate(v=[0,0,1],a=90) cube([reinforcing_width,stud_spacing+stud_diameter+wall_thickness/2,height*block_height], center=true);
        }
    }
}

module axle(height) {
    translate([0,0,height*block_height/2]) union() {
        cube([axle_diameter,axle_spline_width,height*block_height],center=true);
        cube([axle_spline_width,axle_diameter,height*block_height],center=true);
    }
}

module stud(stud_type) {
    difference() {
        cylinder(r=stud_diameter/2,h=stud_height,$fs=cylinder_precision);
        
        if (stud_type == "hollow") {
            // 0.5 is for cleaner preview; doesn't affect functionality.
            cylinder(r=hollow_stud_inner_diameter/2,h=stud_height+0.5,$fs=cylinder_precision);
        }
    }
}