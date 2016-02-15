/**
 * Derived from http://www.thingiverse.com/thing:5699
 *
 * LEGO®, the LEGO® logo, the Brick, DUPLO®, and MINDSTORMS® are trademarks of the LEGO® Group. ©2012 The LEGO® Group.
 */

/* [General] */

// Width of the block, in studs
block_width = 2;

// Length of the block, in studs
block_length = 6;

// Height of the block. A ratio of "1" is a standard LEGO brick height; a ratio of "1/3" is a standard LEGO plate height; "1/2" is a standard DUPLO plate.
block_height_ratio = 1; // [.33333333333:1/3, .5:1/2, 1:1, 2:2, 3:3, 4:4, 5:5, 6:6, 7:7, 8:8, 9:9, 10:10]

// What type of block should this be? For type-specific options, see the "Wings," "Slopes," "Curves", and "Baseplates" tabs.
block_type = "brick"; // [brick:Brick, tile:Tile, wing:Wing, slope:Slope, curve:Curve, baseplate:Baseplate]

// What brand of block should this be? LEGO for regular LEGO bricks, Duplo for the toddler-focused larger bricks.
block_brand = "lego"; // [lego:LEGO, duplo:DUPLO]

// What stud type do you want? Hollow studs allow rods to be pushed into the stud.
stud_type = "solid"; // [solid:Solid, hollow:Hollow]

// Should the block include round horizontal holes like the Technics LEGO bricks have?
technic_holes = "no"; // [no:No, yes:Yes]

// Should the block include vertical cross-shaped axle holes?
vertical_axle_holes = "no"; // [no:No, yes:Yes]

/* [Wings] */

// What type of wing? Full is suitable for the front of a plane, left/right are for the left/right of a plane.
wing_type = "full"; // [full:Full, left:Left, right:Right]

// The number of studs across the end of the wing. If block_width is odd, this needs to be odd, and the same for even.
wing_end_width = 2;

// The length of the rectangular portion of the wing, in studs.
wing_base_length = 3;

// Should the wing edges be notched to accept studs below?
wing_stud_notches = "yes"; // [yes:Yes, no:No]

/* [Slopes] */

// How many rows of studs should be left before the slope?
slope_stud_rows = 1;

// How much vertical height should be left at the end of the slope? e.g, a value of zero means the slope reaches the bottom of the block. A value of 1 means that for a block with height 2, the slope reaches halfway down the block.
slope_end_height = 0;

/* [Curves] */

// How many rows of studs should be left before the curve?
curve_stud_rows = 5;

// Should the curve be convex or concave?
curve_type = "concave"; // [concave:Concave, convex:Convex]

// How much vertical height should be left at the end of the curve? e.g, a value of zero means the curve reaches the bottom of the block. A value of 1 means that for a block with height 2, the curve reaches halfway down the block.
curve_end_height = 0;

/* [Baseplates] */

// If you want a roadway, how wide should it be (in studs)? A roadway is a smooth (non-studded) section of a baseplate.
roadway_width = 0;

// How long should the roadway be?
roadway_length = 0;

// Where should the roadway start (x-value)? A value of zero puts the roadway at the far left side of the plate.
roadway_x = 0;

// Where should the roadway start (y-value)? A value of zero puts the roadway at the front of the plate.
roadway_y = 0;

/* [SNOT] */

// SNOT means Studs Not On Top -- bricks with alternative stud configurations.
// Put studs on the top and buttom?
dual_sided = "no"; // [no:No, yes:Yes]

// Instead of both sides having studs, both sides can have no studs.
dual_bottom = "no"; // [no:No, yes:Yes]

/* [Printer-Specific] */

// Should extra reinforcement be included to make printing on an FDM printer easier? Ignored for tiles, since they're printed upside-down and don't need the reinforcement. Recommended for block heights less than 1 or for Duplo bricks. 
use_reinforcement = "no"; // [no:No, yes:Yes]

// If your printer prints the blocks correctly except for the stud diameter, use this variable to resize just the studs for your printer. A value of 1.05 will print the studs 105% wider than standard.
stud_rescale = 1;
//stud_rescale = 1.0475 * 1; // Orion Delta, T-Glase
//stud_rescale = 1.022 * 1; // Orion Delta, ABS

// Print tiles upside down.
translate([0, 0, (block_type == "tile" ? block_height_ratio * block_height : 0)]) rotate([0, (block_type == "tile" ? 180 : 0), 0]) {
    block(
        width=block_width,
        length=block_length,
        height=block_height_ratio,
        type=block_type,
        brand=block_brand,
        stud_type=stud_type,
        horizontal_holes=(technic_holes=="yes"),
        vertical_axle_holes=(vertical_axle_holes=="yes"),
        reinforcement=(use_reinforcement=="yes"),
        wing_type=wing_type,
        wing_end_width=wing_end_width,
        wing_base_length=wing_base_length,
        stud_notches=(wing_stud_notches=="yes"),
        slope_stud_rows=slope_stud_rows,
        slope_end_height=slope_end_height,
        curve_stud_rows=curve_stud_rows,
        curve_type=curve_type,
        curve_end_height=curve_end_height,
        roadway_width=roadway_width,
        roadway_length=roadway_length,
        roadway_x=roadway_x,
        roadway_y=roadway_y,
        stud_rescale=stud_rescale,
        dual_sided=(dual_sided=="yes"),
        dual_bottom=(dual_bottom=="yes")
    );
}

module block(
    width=1,
    length=2,
    height=1,
    type="brick",
    brand="lego",
    stud_type="solid",
    horizontal_holes=false,
    vertical_axle_holes=false,
    reinforcement=false,
    wing_type="full",
    wing_end_width=2,
    wing_base_length=2,
    stud_notches=false,
    slope_stud_rows=1,
    slope_end_height=0,
    curve_stud_rows=1,
    curve_type="concave",
    curve_end_height=0,
    roadway_width=0,
    roadway_length=0,
    roadway_x=0,
    roadway_y=0,
    stud_rescale=1,
    dual_sided=false,
    dual_bottom=false
    ) {
    post_wall_thickness = (brand == "lego" ? 0.85 : 1);
    wall_thickness=(brand == "lego" ? 1.45 : 1.5);
    stud_diameter=(brand == "lego" ? 4.85 : 9.35);
    hollow_stud_inner_diameter = (brand == "lego" ? 3.1 : 6.7);
    stud_height=(brand == "lego" ? 1.8 : 4.4);
    stud_spacing=(brand == "lego" ? 8 : 8 * 2);
    block_height=(brand == "lego" ? (type == "baseplate" ? 1.3 : 9.6) : 9.6 * 2);
    pin_diameter=(brand == "lego" ? 3 : 3 * 2);
    post_diameter=(brand == "lego" ? 6.5 : 13.2);
    cylinder_precision=(brand == "lego" ? 0.1 : 0.05);
    reinforcing_width = (brand == "lego" ? 0.7 : 1);

    spline_length = (brand == "lego" ? 0.25 : 1.7);
    spline_thickness = (brand == "lego" ? 0.7 : 1.3);

    horizontal_hole_diameter = (brand == "lego" ? 4.8 : 4.8 * 2);
    horizontal_hole_z_offset = (brand == "lego" ? 5.8 : 5.8 * 2);
    horizontal_hole_bevel_diameter = (brand == "lego" ? 6.2 : 6.2 * 2);
    horizontal_hole_bevel_depth = (brand == "lego" ? 0.9 : 0.9 * 1.5 / 1.2 );

    roof_thickness = (type == "baseplate" || dual_sided ? block_height * height : 1 * 1);

    // Brand-independent measurements.
    axle_spline_width = 2.0;
    axle_diameter = 5 * 1;
    wall_play = 0.1 * 1;
    horizontal_hole_wall_thickness = 1 * 1;

    // Ensure that width is always less than or equal to length.
    real_width = (type == "wing" ? width : min(width, length) );
    real_length = (type == "wing" ? length : max(width, length) );
    real_height = max((type == "baseplate" ? 1 : 1/3), height);

    // Ensure that the wing end width is even if the width is even, odd if odd, and a reasonable value.
    real_wing_end_width = (wing_type == "full"
        ?
        min(real_width - 2, ((real_width % 2 == 0) ? 
            (max(2, (
                wing_end_width % 2 == 0 ?
                (wing_end_width)
                :
                (wing_end_width-1)
            )))
            :
            (max(1, (
                wing_end_width % 2 == 0 ?
                (wing_end_width-1)
                :
                (wing_end_width)
            )))
        ))
        :
        (min(real_width-1, max(1, wing_end_width))) // Half-wing
    );

    // Ensure that the base length is a reasonable value.
    real_wing_base_length = min(real_length-1, max(1, wing_base_length)) + 1; // +1 because the angle starts before the last stud.
        
    // Validate all the rest of the arguments.
    real_slope_end_height = max(0, min(real_height - 1/3, slope_end_height));
    real_slope_stud_rows = min(real_length - 1, slope_stud_rows);
    real_curve_stud_rows = max(0, curve_stud_rows);
    real_curve_type = (curve_type == "convex" ? "convex" : "concave");
    real_curve_end_height = max(0, min(real_height - 1/3, curve_end_height));
    real_horizontal_holes = horizontal_holes && ((type == "baseplate" && real_height >= 8) || real_height >= 1) && !dual_sided;
    real_vertical_axle_holes = vertical_axle_holes && real_width > 1;
    real_reinforcement = reinforcement && type != "baseplate" && type != "tile" && !dual_sided;

    real_roadway_width = max(0, min(roadway_width, real_width));
    real_roadway_length = max(0, min(roadway_length, real_length));
    real_roadway_x = max(0, min(real_length - real_roadway_length, roadway_x));
    real_roadway_y = max(0, min(real_width - real_roadway_width, roadway_y));

    real_stud_notches = stud_notches && !dual_sided;
    real_dual_sided = dual_sided && type != "curve" && type != "slope" && type != "tile";
    real_dual_bottom = dual_bottom && !real_dual_sided && type != "curve" && type != "slope";

    total_studs_width = (stud_diameter * stud_rescale * real_width) + ((real_width - 1) * (stud_spacing - (stud_diameter * stud_rescale)));
    total_studs_length = (stud_diameter * stud_rescale * real_length) + ((real_length - 1) * (stud_spacing - (stud_diameter * stud_rescale)));

    total_posts_width = (post_diameter * (real_width - 1)) + ((real_width - 2) * (stud_spacing - post_diameter));
    total_posts_length = (post_diameter * (real_length - 1)) + ((real_length - 2) * (stud_spacing - post_diameter));

    total_axles_width = (axle_diameter * (real_width - 1)) + ((real_width - 2) * (stud_spacing - axle_diameter));
    total_axles_length = (axle_diameter * (real_length - 1)) + ((real_length - 2) * (stud_spacing - axle_diameter));

    total_pins_width = (pin_diameter * (real_width - 1)) + max(0, ((real_width - 2) * (stud_spacing - pin_diameter)));
    total_pins_length = (pin_diameter * (real_length - 1)) + max(0, ((real_length - 2) * (stud_spacing - pin_diameter)));

    overall_length = (real_length * stud_spacing) - (2 * wall_play);
    overall_width = (real_width * stud_spacing) - (2 * wall_play);

    wing_slope = (wing_type == "full" ?
        ((real_width - (real_wing_end_width + 1)) / 2) / (real_length - (real_wing_base_length - 1))
        :
        (real_width - (real_wing_end_width)) / (real_length - (real_wing_base_length - 1))
    );

   translate([-overall_length/2, -overall_width/2, 0]) // Comment to position at 0,0,0 instead of centered on X and Y.
        union() {
            difference() {
                union() {
                    /**
                     * Include any union()s that should come before the final difference()s.
                     */
                    
                    // The mass of the block.
                    difference() {
                        cube([overall_length, overall_width, real_height * block_height]);
                        translate([wall_thickness,wall_thickness,-roof_thickness]) cube([overall_length-wall_thickness*2,overall_width-wall_thickness*2,block_height*real_height]);
                    }

                    // The studs on top of the block (if it's not a tile).
                    if ( type != "tile" && !real_dual_bottom ) {
                        translate([stud_diameter * stud_rescale / 2, stud_diameter * stud_rescale / 2, 0]) 
                        translate([(overall_length - total_studs_length)/2, (overall_width - total_studs_width)/2, 0]) {
                            for (ycount=[0:real_width-1]) {
                                for (xcount=[0:real_length-1]) {
                                    if (!skip_this_stud(xcount, ycount)) {
                                        translate([xcount*stud_spacing,ycount*stud_spacing,block_height*real_height]) stud();
                                    }
                                }
                            }
                       }
                    }

                    // Interior splines to catch the studs.
                    translate([stud_spacing / 2 - wall_play - (spline_thickness/2), 0, 0]) for (xcount = [0:real_length-1]) {
                        translate([0,wall_thickness,0]) translate([xcount * stud_spacing, 0, 0]) cube([spline_thickness, spline_length, real_height * block_height]);
                        translate([xcount * stud_spacing, overall_width - wall_thickness -  spline_length, 0]) cube([spline_thickness, spline_length, real_height * block_height]);
                    }

                    translate([0, stud_spacing / 2 - wall_play - (spline_thickness/2), 0]) for (ycount = [0:real_width-1]) {
                        translate([wall_thickness,0,0]) translate([0, ycount * stud_spacing, 0]) cube([spline_length, spline_thickness, real_height * block_height]);
                        translate([overall_length - wall_thickness -  spline_length, ycount * stud_spacing, 0]) cube([spline_length, spline_thickness, real_height * block_height]);
                    }

                    if (type != "baseplate" && real_width > 1 && real_length > 1 && !real_dual_sided && roof_thickness < block_height * height) {
                        // Reinforcements and posts
                        translate([post_diameter / 2, post_diameter / 2, 0]) {
                            translate([(overall_length - total_posts_length)/2, (overall_width - total_posts_width)/2, 0]) {
                                union() {
                                    // Posts
                                    for (ycount=[1:real_width-1]) {
                                        for (xcount=[1:real_length-1]) {
                                            translate([(xcount-1)*stud_spacing,(ycount-1)*stud_spacing,0]) post(real_vertical_axle_holes && !skip_this_vertical_axle_hole(xcount, ycount));
                                        }
                                    }

                                    // Reinforcements
                                    if (real_reinforcement) {
                                        difference() {
                                            for (ycount=[1:real_width-1]) {
                                                for (xcount=[1:real_length-1]) {
                                                    translate([(xcount-1)*stud_spacing,(ycount-1)*stud_spacing,0]) reinforcement();
                                                }
                                            }

                                            for (ycount=[1:real_width-1]) {
                                                for (xcount=[1:real_length-1]) {
                                                    translate([(xcount-1)*stud_spacing,(ycount-1)*stud_spacing,-0.5]) cylinder(r=post_diameter/2-0.1, h=real_height*block_height+0.5, $fs=cylinder_precision);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    if (type != "baseplate" && (real_width == 1 || real_length == 1) && real_width != real_length && !real_dual_sided && roof_thickness < block_height * height) {
                        // Pins
                        if (real_width == 1) {
                            translate([(pin_diameter/2) + (overall_length - total_pins_length) / 2, overall_width/2, 0]) {
                                for (xcount=[1:real_length-1]) {
                                    translate([(xcount-1)*stud_spacing,0,0]) cylinder(r=pin_diameter/2,h=block_height*real_height,$fs=cylinder_precision);
                                }
                            }
                        }
                        else {
                            translate([overall_length/2, (pin_diameter/2) + (overall_width - total_pins_width) / 2, 0]) {
                                for (ycount=[1:real_width-1]) {
                                    translate([0,(ycount-1)*stud_spacing,0]) cylinder(r=pin_diameter/2,h=block_height*real_height,$fs=cylinder_precision);
                                }
                            }
                        }
                    }

                    if (real_horizontal_holes) {
                        // The holes for the horizontal axles.
                        // 1-length bricks have the hole underneath the stud.
                        // >1-length bricks have the holes between the studs.
                        for (height_index = [0 : height - 1]) {
                            translate([horizontal_holes_x_offset(), overall_width, height_index * block_height]) 
                            translate([(overall_length - total_studs_length)/2, 0, 0]) {
                            for (axle_hole_index=[horizontal_hole_start_index() : horizontal_hole_end_index()]) {
                                if (!skip_this_horizontal_hole(axle_hole_index, height_index)) {
                                        translate([axle_hole_index*stud_spacing,0,horizontal_hole_z_offset]) rotate([90, 0, 0])  cylinder(r=horizontal_hole_diameter/2 + horizontal_hole_wall_thickness, h=overall_width,$fs=cylinder_precision);
                                    }
                                }
                            }
                        }
                    }
                }

                
                /**
                 * Include any differences from the basic brick here.
                 */
                
                if (real_vertical_axle_holes) {
                    if (real_width > 1 && real_length > 1) {
                        translate([axle_diameter / 2, axle_diameter / 2, 0]) {
                            translate([(overall_length - total_axles_length)/2, (overall_width - total_axles_width)/2, 0]) {
                                for (ycount = [ 1 : real_width - 1 ]) {
                                    for (xcount = [ 1 : real_length - 1]) {
                                        if (!skip_this_vertical_axle_hole(xcount, ycount)) {
                                            translate([(xcount-1)*stud_spacing,(ycount-1)*stud_spacing,-block_height/2]) axle();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                if (type == "wing") {
                    if (wing_type == "full" || wing_type == "right")  {
                        translate([0, 0, -0.5]) linear_extrude(block_height * real_height + stud_height + 1) polygon(points=[
                            [stud_spacing * (real_wing_base_length-1), -0.01],
                            [overall_length + 0.01, -0.01],
                            [overall_length + 0.01, (wing_type == "full" ?
                                (overall_width / 2 - (real_wing_end_width * stud_spacing / 2))
                                :
                                (overall_width - (real_wing_end_width * stud_spacing))
                            )]
                        ]
                        );
                    }
                    if (wing_type == "full" || wing_type == "left")  {
                        translate([0, 0, -0.5]) linear_extrude(block_height * real_height + stud_height + 1) polygon(points=[
                            [stud_spacing * (real_wing_base_length-1), overall_width + 0.01],
                            [overall_length + 0.01, overall_width + 0.01],
                            [overall_length + 0.01, (wing_type == "full" ? overall_width / 2 : 0) + (real_wing_end_width * stud_spacing / (wing_type == "full" ? 2 : 1))]
                        ]
                        );


                    }
                }
                else if (type == "slope") {
                    translate([0, overall_width+0.5, 0]) rotate([90, 0, 0]) linear_extrude(overall_width+1) polygon(points=[
                        [-0.1, (block_height * real_slope_end_height) + stud_height],
                        [min(overall_length, overall_length - (stud_spacing * real_slope_stud_rows) + (wall_play/2)), real_height * block_height - roof_thickness],
                        [min(overall_length, overall_length - (stud_spacing * real_slope_stud_rows) + (wall_play/2)), real_height * block_height + stud_height + 1],
                        [-0.1, real_height * block_height + stud_height + 1]
                    ]);
                }
                else if (type == "curve") {
                    if (real_curve_type == "concave") {
                                            echo(curve_circle_height());
                        difference() {
                            translate([
                                    -curve_circle_length() / 2, // Align the center of the cube with the end of the block.
                                    -0.5, // Center the extra width on the block.
                                    (real_height * block_height) - (curve_circle_height() / 2)  // Align the bottom of the cube with the center of the curve circle.
                                ])
                                cube([curve_circle_length(), overall_width + 1, curve_circle_height()]);

                            translate([
                                    curve_circle_length() / 2,  // Align the end of the curve with the end of the block.
                                    overall_width / 2, // Center it on the block.
                                    (real_height * block_height) - (curve_circle_height() / 2)  // Align the top of the curve with the top of the block.
                                ])
                                rotate([90, 0, 0]) // Rotate sideways
                                translate([0, 0, -overall_width/2]) // Move so the cylinder is z-centered.
                                resize([curve_circle_length(), curve_circle_height(), 0]) // Resize to the approprate scale.
                                cylinder(r=real_height * block_height, h=overall_width, $fs=cylinder_precision);
                        }
                    }
                    else if (real_curve_type == "convex") {
                        union() {
                            translate([0, 0, real_height * block_height]) cube([overall_length - (real_curve_stud_rows * stud_spacing), overall_width, stud_height + .1]);
                            translate([0, 0, block_height * real_height])
                                translate([0, (overall_width+1)/2-.5, 0]) // Center across the end of the block.
                                rotate([90, 0, 0])
                                translate([0, 0, -((overall_width+1)/2)]) // z-center
                                resize([curve_circle_length(), curve_circle_height(), 0]) // Resize to the final dimensions.
                                cylinder(r=block_height * real_height, h=overall_width+1, $fs=cylinder_precision);
                        }
                    }
                }
                else if (type == "baseplate") {
                    // Rounded corners.
                    union() {
                        translate([overall_length, overall_width, 0]) translate([-((stud_spacing / 2) - wall_play), -((stud_spacing / 2) - wall_play), 0]) negative_rounded_corner(r=((stud_spacing / 2) - wall_play), h=real_height * block_height);
                        
                        translate([0, overall_width, 0]) translate([((stud_spacing / 2) - wall_play), -((stud_spacing / 2) - wall_play), 0]) rotate([0, 0, 90]) negative_rounded_corner(r=((stud_spacing / 2) - wall_play), h=real_height * block_height);
                        translate([((stud_spacing / 2) - wall_play), ((stud_spacing / 2) - wall_play), 0]) rotate([0, 0, 180]) negative_rounded_corner(r=((stud_spacing / 2) - wall_play), h=real_height * block_height);
                        translate([overall_length, 0, 0]) translate([-((stud_spacing / 2) - wall_play), ((stud_spacing / 2) - wall_play), 0]) rotate([0, 0, 270]) negative_rounded_corner(r=((stud_spacing / 2) - wall_play), h=real_height * block_height);
                    }
                }

                if (real_horizontal_holes) {
                    // The holes for the horizontal axles.
                    // 1-length bricks have the hole underneath the stud.
                    // >1-length bricks have the holes between the studs.
                    for (height_index = [0 : height - 1]) {
                        translate([horizontal_holes_x_offset(), 0, height_index * block_height]) 
                        translate([(overall_length - total_studs_length)/2, 0, 0]) {
                            for (axle_hole_index=[horizontal_hole_start_index() : horizontal_hole_end_index()]) {
                                if (!skip_this_horizontal_hole(axle_hole_index, height_index)) {
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
                }
            }

            
            /**
             * Any final union()s for the brick.
             */
            
            if (type == "wing") {
                difference() {
                    union() {
                        if ( wing_type == "full" || wing_type == "right" ){
                            linear_extrude(block_height * real_height) polygon(points=[
                                [stud_spacing * (real_wing_base_length-1), 0],
                                [overall_length, (wing_type == "full" ? 
                                    ((overall_width / 2) - (real_wing_end_width * stud_spacing / 2))
                                    :
                                    (overall_width - (real_wing_end_width * stud_spacing))
                                )],
                                [overall_length, (wing_type == "full" ? 
                                    ((overall_width / 2) - (real_wing_end_width * stud_spacing / 2))
                                    :
                                    (overall_width - (real_wing_end_width * stud_spacing))
                                ) + wall_thickness],
                                [stud_spacing * (real_wing_base_length-1), wall_thickness]
                            ]);
                        }

                        if (wing_type == "full" || wing_type == "left") {
                            linear_extrude(block_height * real_height) polygon(points=[
                                [stud_spacing * (real_wing_base_length-1), overall_width],
                                [overall_length, (wing_type == "full" ? overall_width / 2 : 0) + (real_wing_end_width * stud_spacing / (wing_type == "full" ? 2 : 1))],
                                [overall_length, (wing_type == "full" ? overall_width / 2 : 0) + (real_wing_end_width * stud_spacing / (wing_type == "full" ? 2 : 1)) - wall_thickness],
                                [stud_spacing * (real_wing_base_length-1), overall_width - wall_thickness]
                            ]);
                        }
                    }

                    if (real_stud_notches) {
                        translate([overall_length/2, overall_width/2, 0])
                            translate([0, 0, -(1/3 * block_height)]) block(
                                width=real_width,
                                length=real_length,
                                height=1/3,
                                brand=brand,
                                stud_type="solid",
                                type="brick",
                                stud_rescale=1.5
                            );
                    }
                }
            }
            else if (type == "slope") {
                translate([0, overall_width, 0]) rotate([90, 0, 0]) linear_extrude(overall_width) polygon(points=[
                    [0, (block_height * real_slope_end_height) + stud_height],
                    [0, (block_height * real_slope_end_height) + stud_height + roof_thickness],
                    [min(overall_length, overall_length - (stud_spacing * real_slope_stud_rows) + (wall_play/2)), real_height * block_height],
                    [min(overall_length, overall_length - (stud_spacing * real_slope_stud_rows) + (wall_play/2)), (real_height * block_height) - roof_thickness]
                ]);
            }
            else if (type == "curve") {
                if (real_curve_type == "concave") {
                    intersection() {
                        translate([
                                -curve_circle_length() / 2, // Align the center of the cube with the end of the block.
                                -0.5, // Center the extra width on the block.
                                (real_height * block_height) - (curve_circle_height() / 2)  // Align the bottom of the cube with the center of the curve circle.
                            ])
                            cube([curve_circle_length(), overall_width + 1, curve_circle_height()]);

                        difference() {   
                            translate([
                                    curve_circle_length() / 2,  // Align the end of the curve with the end of the block.
                                    overall_width / 2, // Center it on the block.
                                    (real_height * block_height) - (curve_circle_height() / 2)  // Align the top of the curve with the top of the block.
                                ])
                                rotate([90, 0, 0]) // Rotate sideways
                                translate([0, 0, -overall_width/2]) // Move so the cylinder is z-centered.
                                resize([curve_circle_length(), curve_circle_height(), 0]) // Resize to the approprate scale.
                                cylinder(r=real_height * block_height, h=overall_width, $fs=cylinder_precision);

                            translate([
                                    curve_circle_length() / 2,  // Align the end of the curve with the end of the block.
                                    overall_width / 2, // Center it on the block.
                                    (real_height * block_height) - (curve_circle_height() / 2) // Align the top of the curve with the top of the block.
                                ])
                                rotate([90, 0, 0]) // Rotate sideways
                                translate([0, 0, -overall_width/2]) // Move so the cylinder is z-centered.
                                resize([curve_circle_length() - (wall_thickness * 2), curve_circle_height() - (wall_thickness * 2), 0]) // Resize to the approprate scale.
                                cylinder(r=real_height * block_height, h=overall_width, $fs=cylinder_precision);
                        }
                    }
                }
                else if (real_curve_type == "convex") {
                    intersection() {
                        translate([
                            0,
                            0,
                            (real_height * block_height) - (curve_circle_height() / 2) - wall_thickness // Align the top of the cube with the top of the block.
                        ])
                            cube([curve_circle_length() / 2, overall_width, curve_circle_height() / 2 + wall_thickness]);

                       translate([0, 0, block_height * real_height])
                            translate([0, overall_width/2, 0]) // Center across the end of the block.
                            rotate([90, 0, 0])
                            translate([0, 0, -overall_width/2]) // z-center
                            difference() {
                                resize([curve_circle_length() + (wall_thickness * 2), curve_circle_height() + (wall_thickness * 2), 0]) // Resize to the final dimensions.
                                cylinder(r=block_height * real_height, h=overall_width, $fs=cylinder_precision);

                                translate([0, 0, -0.5]) // The inner cylinder is just a little taller, for nicer OpenSCAD previews.
                                    resize([curve_circle_length(), curve_circle_height(), 0]) // Resize to the final dimensions.
                                    cylinder(r=block_height * real_height, h=overall_width+1, $fs=cylinder_precision);
                            }
                    }
                }
            }
            
            if (real_dual_sided) {
                translate([overall_length/2, overall_width/2, block_height * height]) mirror([0,0,1]) block(
                    width=real_width,
                    length=real_length,
                    height=real_height,
                    type=type,
                    brand=brand,
                    stud_type=stud_type,
                    horizontal_holes=real_horizontal_holes,
                    vertical_axle_holes=real_vertical_axle_holes,
                    reinforcement=real_reinforcement,
                    wing_type=wing_type,
                    wing_end_width=real_wing_end_width,
                    wing_base_length=real_wing_base_length-1,
                    stud_notches=real_stud_notches,
                    slope_stud_rows=real_slope_stud_rows,
                    slope_end_height=real_slope_end_height,
                    curve_stud_rows=real_curve_stud_rows,
                    curve_type=real_curve_type,
                    curve_end_height=real_curve_end_height,
                    roadway_width=real_roadway_width,
                    roadway_length=real_roadway_length,
                    roadway_x=real_roadway_x,
                    roadway_y=real_roadway_y,
                    stud_rescale=stud_rescale,
                    dual_sided=false
                );
            }

            if (real_dual_bottom) {
                translate([overall_length/2, overall_width/2, block_height * height * 2]) mirror([0,0,1]) block(
                    width=real_width,
                    length=real_length,
                    height=real_height,
                    type="tile",
                    brand=brand,
                    stud_type=stud_type,
                    horizontal_holes=real_horizontal_holes,
                    vertical_axle_holes=real_vertical_axle_holes,
                    reinforcement=real_reinforcement,
                    wing_type=wing_type,
                    wing_end_width=real_wing_end_width,
                    wing_base_length=real_wing_base_length-1,
                    stud_notches=real_stud_notches,
                    slope_stud_rows=real_slope_stud_rows,
                    slope_end_height=real_slope_end_height,
                    curve_stud_rows=real_curve_stud_rows,
                    curve_type=real_curve_type,
                    curve_end_height=real_curve_end_height,
                    roadway_width=real_roadway_width,
                    roadway_length=real_roadway_length,
                    roadway_x=real_roadway_x,
                    roadway_y=real_roadway_y,
                    stud_rescale=stud_rescale,
                    dual_sided=false,
                    dual_bottom=false
                );
            }
    }

    module post(vertical_axle_hole) {
        difference() {
            cylinder(r=post_diameter/2, h=real_height*block_height,$fs=cylinder_precision);
            if (vertical_axle_hole==true) {
                translate([0,0,-block_height/2])
                    axle();
            } else {
                translate([0,0,-0.5]) cylinder(r=(post_diameter/2)-post_wall_thickness, h=real_height*block_height+1,$fs=cylinder_precision);
            }
        }
    }

    module reinforcement() {
        union() {
            translate([0,0,real_height*block_height/2]) union() {
                cube([reinforcing_width, 2 * (stud_spacing - (2 * wall_play)), real_height * block_height],center=true);
                rotate(v=[0,0,1],a=90) cube([reinforcing_width, 2 * (stud_spacing - (2 * wall_play)), real_height * block_height], center=true);
            }
        }
    }

    module axle() {
        translate([0,0,(real_height+1)*block_height/2]) union() {
            cube([axle_diameter,axle_spline_width,(real_height+1)*block_height],center=true);
            cube([axle_spline_width,axle_diameter,(real_height+1)*block_height],center=true);
        }
    }

    module stud() {
        difference() {
            cylinder(r=(stud_diameter*stud_rescale)/2,h=stud_height,$fs=cylinder_precision);

            if (stud_type == "hollow") {
                // 0.5 is for cleaner preview; doesn't affect functionality.
                cylinder(r=(hollow_stud_inner_diameter*stud_rescale)/2,h=stud_height+0.5,$fs=cylinder_precision);
            }
        }
    }

    function curve_circle_length() = (overall_length - (stud_spacing * min(real_length - 1, real_curve_stud_rows)) + (wall_play/2)) * 2;
    function curve_circle_height() = (
            (
                (block_height * real_height) - (real_curve_end_height * block_height)) * 2) - (real_curve_type == "convex" ? (stud_height * 2) + (wall_thickness * 2) : 0);

    function wing_width(x_pos) = (real_width - width_loss(x_pos));

    function width_loss(x_pos) = (type != "wing" ? 0 :
        round((wing_type == "full" ?
            max(0, (2 * wing_slope * (x_pos - (real_wing_base_length - 1)))) + 0.3 // Full wing
            :
            max(0, (wing_slope * (x_pos - (real_wing_base_length - 1)))) + 0.2 // Half wing
        )) // +extra is because full studs can still fit on partially missing bases, but not by much
    );

    function horizontal_hole_start_index() = (
        (
            (type == "slope" && real_slope_stud_rows == 1)
            || (type == "curve" && real_curve_stud_rows == 1)
        )
        ?
        real_length - 1
        :
        0
    );
    function horizontal_hole_end_index() = (
        (
            real_length == 1
            || (type == "slope" && real_slope_stud_rows == 1)
            || (type == "curve" && real_curve_stud_rows == 1)
        )
        ?
        real_length - 1
        :
        real_length - 2
    );
    function skip_this_horizontal_hole(xcount, zcount) = (
        (type == "slope" && ((zcount >= slope_end_height) && (xcount <= real_length - real_slope_stud_rows - 1)))
        ||
        (type == "curve" && ((zcount >= curve_end_height) && (xcount <= real_length - real_curve_stud_rows - 1)))
    );

    function horizontal_holes_x_offset() = (
        (horizontal_hole_diameter / 2)
        + (
            (
                real_length == 1
                || (type == "slope" && real_slope_stud_rows == 1)
                || (type == "curve" && real_curve_stud_rows == 1)
            )
            ?
            0
            :
            (stud_spacing / 2)
        )
    );
    
    function put_stud_here(xcount, ycount) = (
        (type != "wing" && real_roadway_width > 0 && real_roadway_length > 0)
        ||
        (type == "wing" && (
            (wing_type == "full" && (ycount+1 > ceil(width_loss(xcount+1)/2)) && (ycount+1 <= floor(real_width - (width_loss(xcount+1)/2))))
            || (wing_type == "left" && ycount+1 <= wing_width(xcount+1))
            || (wing_type == "right" && ycount >= width_loss(xcount+1))
            )
        )
        ||
        (real_roadway_width == 0 && real_roadway_length == 0)
        ||
        (!pos_in_roadway(xcount, ycount))
    );
    
    function put_vertical_axle_hole_here(xcount, ycount) = (
        !skip_this_axle_hole(xcount, ycount)
    );
    
    function skip_this_vertical_axle_hole(xcount, ycount) = (
        (type == "slope" && xcount < (real_length - real_slope_stud_rows + 1))
        ||
        (type == "curve" && xcount < (real_length - real_curve_stud_rows + 1))
        
    );
    
    function skip_this_stud(xcount, ycount) = (
        (type == "wing" && (
            (wing_type == "full" && ((ycount+1 <= ceil(width_loss(xcount+1)/2)) || (ycount+1 > floor(real_width - (width_loss(xcount+1)/2)))))
            || (wing_type == "left" && ycount+1 > wing_width(xcount+1))
            || (wing_type == "right" && ycount < width_loss(xcount+1))
            )
        )
        ||
        (real_roadway_width > 0 && real_roadway_length > 0 && pos_in_roadway(xcount, ycount))
    );

    function pos_in_roadway(x, y) = (
        x >= real_roadway_x
        && y >= real_roadway_y
        && y < real_roadway_y + real_roadway_width
        && x < real_roadway_x + real_roadway_length
    );
        
    
    module negative_rounded_corner(r,h) {
        difference() {
            translate([0, 0, -.5]) cube([r+1, r+1, h+1]);
            translate([0, 0, -1]) cylinder(r=r, h=h + 2, $fs=cylinder_precision);
        }
    }
}

module uncenter(width, length, height) {
    // stud_spacing = 8
    // wall_play = 0.1
    translate([((8 * length) / 2) - 0.1, ((8 * width) / 2) - 0.1, height ? ((8 * height) / 2) - 0.1 : 0]) children();
}

module place(x, y, z=0) {
    translate([8 * y, 8 * x, z * 9.6]) children();
}