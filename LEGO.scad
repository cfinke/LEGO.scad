/**
 * Derived from http://www.thingiverse.com/thing:5699
 */

// Width of the block, in studs
block_width = 2;

// Length of the block, in studs
block_length = 4;

// Height of the block. A ratio of "1" is a standard LEGO brick height; a ratio of "1/3" is a standard LEGO plate height.
block_height_ratio = 1; // [.33333333333:1/3, 1:1, 2:2, 3:3, 4:4, 5:5, 6:6, 7:7, 8:8]

// What type of block should this be? A normal brick, or a smooth-topped tile?
block_type = "brick"; // [brick:Brick, tile:Tile]

// What stud type do you want? Hollow studs allow rods to be pushed into the stud.
stud_type = "hollow"; // [solid:Solid, hollow:Hollow]

// Should the block include axle holes? This allows axles to be pushed through the block vertically.
include_axle_holes = "no"; // [no:No, yes:Yes]

// Should extra reinforcement be included to make printing on an FDM printer easier? Ignored for tiles, since they're printed upside-down and don't need the reinforcement. Recommended for block heights less than 1. 
use_reinforcement = "no"; // [no:No, yes:Yes]

// (foo * 1) is to prevent these from appearing in the Customizer.
stud_diameter=4.85 * 1; //studs on top of blocks
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

// Print tiles upside down.
translate([0, 0, (block_type == "tile" ? block_height_ratio * block_height : 0)]) rotate([0, (block_type == "tile" ? 180 : 0), 0]) {
	block(
	width=block_width,
	length=block_length,
	height=block_height_ratio,
	axle_hole=(include_axle_holes=="yes"),
	reinforcement=((use_reinforcement=="yes") && block_type != "tile"),
	smooth=(block_type == "tile")
	);
}

total_studs_width = (stud_diameter * block_width) + ((block_width - 1) * (stud_spacing - stud_diameter));
total_studs_length = (stud_diameter * block_length) + ((block_length - 1) * (stud_spacing - stud_diameter));

total_posts_width = (post_diameter * (block_width - 1)) + ((block_width - 2) * (stud_spacing - post_diameter));
total_posts_length = (post_diameter * (block_length - 1)) + ((block_length - 2) * (stud_spacing - post_diameter));

total_axles_width = (axle_diameter * (block_width - 1)) + ((block_width - 2) * (stud_spacing - axle_diameter));
total_axles_length = (axle_diameter * (block_length - 1)) + ((block_length - 2) * (stud_spacing - axle_diameter));

total_pins_width = (pin_diameter * (block_width - 1)) + max(0, ((block_width - 2) * (stud_spacing - pin_diameter)));
total_pins_length = (pin_diameter * (block_length - 1)) + max(0, ((block_length - 2) * (stud_spacing - pin_diameter)));

module block(width, length, height, axle_hole, reinforcement, smooth) {
	overall_length = (length * stud_spacing) - (2 * wall_play);
	overall_width = (width * stud_spacing) - (2 * wall_play);
	
	translate([-overall_length/2, -overall_width/2, 0]) // Comment to position at 0,0,0 instead of centered on X and Y.
		union() {
			difference() {
				union() {
					// The mass of the block.
					cube([overall_length, overall_width, height * block_height]);
					
					// The studs on top of the block (if it's not a tile).
					if ( ! smooth ) {
						// existing stud offset = -(stud_diameter / 2);
						// left to offset = ((stud_diameter * width) + (stud_spacing - stud_diameter)) - 
						translate([stud_diameter / 2, stud_diameter / 2, 0]) 
						translate([(overall_length - total_studs_length)/2, (overall_width - total_studs_width)/2, 0]) {
							for (ycount=[0:width-1]) {
								for (xcount=[0:length-1]) {
									translate([xcount*stud_spacing,ycount*stud_spacing,0]) stud(height);
								}
							}
					   }
					}
				}
				
				translate([wall_thickness,wall_thickness,-roof_thickness]) cube([overall_length-wall_thickness*2,overall_width-wall_thickness*2,block_height*height]);
				
				if (axle_hole) {
					if (width > 1 && length > 1) {
						translate([axle_diameter / 2, axle_diameter / 2, 0]) {
							translate([(overall_length - total_axles_length)/2, (overall_width - total_axles_width)/2, 0]) {
								for (ycount = [ 1 : width - 1 ]) {
									for (xcount = [ 1 : length - 1]) {
										translate([(xcount-1)*stud_spacing,(ycount-1)*stud_spacing,-block_height/2]) axle(height+1);
									}
								}
							}
						}
					}
				}
			}


			if (width > 1 && length > 1) {
				// Reinforcements and posts
				translate([post_diameter / 2, post_diameter / 2, 0]) {
					translate([(overall_length - total_posts_length)/2, (overall_width - total_posts_width)/2, 0]) {
						union() {
							// Posts
							for (ycount=[1:width-1]) {
								for (xcount=[1:length-1]) {
									translate([(xcount-1)*stud_spacing,(ycount-1)*stud_spacing,0]) post(height,axle_hole);
								}
							}
	
							// Reinforcements
							if (reinforcement) {
								difference() {
									for (ycount=[1:width-1]) {
										for (xcount=[1:length-1]) {
											translate([(xcount-1)*stud_spacing,(ycount-1)*stud_spacing,0]) reinforcement(height);
										}
									}

									for (ycount=[1:width-1]) {
										for (xcount=[1:length-1]) {
											translate([(xcount-1)*stud_spacing,(ycount-1)*stud_spacing,-0.5]) cylinder(r=post_diameter/2-0.1, h=height*block_height+0.5, $fs=cylinder_precision);
										}
									}
								}
							}
						}
					}
				}
			}

			if ((width == 1 || length == 1) && width != length) {
				// Pins
				if (width == 1) {
					translate([(pin_diameter/2) + (overall_length - total_pins_length) / 2, overall_width/2, 0]) {
						for (xcount=[1:length-1]) {
							translate([(xcount-1)*stud_spacing,0,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);
						}
					}
				}
				else {
					translate([overall_length/2, (pin_diameter/2) + (overall_width - total_pins_width) / 2, 0]) {
						for (ycount=[1:width-1]) {
							translate([0,(ycount-1)*stud_spacing,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);
						}
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

module stud(height) {
    difference() {
        cylinder(r=stud_diameter/2,h=block_height*height+stud_height,$fs=cylinder_precision);
        
        if (stud_type == "hollow") {
            // 0.5 is for cleaner preview; doesn't affect functionality.
            cylinder(r=hollow_stud_inner_diameter/2,h=block_height*height+stud_height+0.5,$fs=cylinder_precision);
        }
    }
}
