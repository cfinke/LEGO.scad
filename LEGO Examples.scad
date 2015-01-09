use <LEGO.scad>;

rotate([0, 0, 180]) union() {
    color( "green" ) translate([0, (3 * 4) + (-6.5 * 8), 0]) translate([24, 16, 0]) block(
        width=2,
        length=3,
        brand="duplo",
        reinforcement=true,
        stud_type="hollow"
    );

    color( "blue" ) translate([48, (3 * 4) + (-6.5 * 8), 0]) translate([24, 16, 0]) rotate([0, 0, 180]) block(
        width=2,
        length=2,
        brand="duplo",
        reinforcement=true,
        stud_type="hollow",
        type="curve"
    );

    color( "blue" ) translate([-24, (3 * 4) + (-11.5 * 8) + 88 + 76, 0]) rotate([0, 0, 270]) block(
        width=4,
        length=6,
        height=2,
        brand="lego",
        reinforcement=true,
        stud_type="hollow",
        type="slope",
        slope_stud_rows=4,
        slope_end_height=1
    );

    color( "gray" ) translate([-24, (3 * 4) + (-11.5 * 8) + 88, 0]) rotate([0, 0, 270]) block(
        width=2,
        length=6,
        height=2,
        curve_end_height=1,
        curve_stud_rows=5,
        brand="duplo",
        type="curve",
        curve_type="convex",
        curve_stud_rows=5
    );

    color( "red" ) translate([0, 0 * (8 * 2), 0]) translate([36, 8, 0]) block(
        width=2,
        length=9,
        height=2,
        reinforcement=true
    );

    color( "blue" ) translate([(0 * 4) + (0 * 8), (1 * 4) + (2 * 8), 0]) translate([8, 8, 0]) block(
        width=2,
        length=2,
        stud_type="hollow"
    );

    color( "yellow" ) translate([(1 * 4) + (2 * 8), (1 * 4) + (2 * 8), 0]) translate([8, 8, 0]) block(
        width=2,
        length=2,
        height=1/3,
        vertical_axle_holes=true
    );

    color( "gray" ) translate([(2 * 4) + (4 * 8), (1 * 4) + (2 * 8), 0]) translate([8, 8, 0]) block(
        width=2,
        length=2,
        height=1/3,
        smooth=true
    );
    
    color( "green" ) translate([(3 * 4) + (5.5 * 8), (1 * 4) + (2 * 8), 0]) translate([8, 8, 0]) block(
        width=1,
        length=1,
        height=1/3,
        smooth=true
    );

    color( "white" ) translate([0, (2 * 4) + (4 * 8), 0]) translate([36, 16, 0]) block(
        width=4,
        length=9,
        height=1/3,
        type="wing",
        stud_notches=true
    );

    color( "yellow" ) translate([0, (3 * 4) + (8 * 8), 0]) translate([32, 4, 0]) block(
        width=1,
        length=8,
        horizontal_holes=true
    );

    color( "black" ) translate([0, (3 * 4) + (10 * 8), 0]) translate([16, 4, 0]) rotate([0, 0, 180]) block(
        width=2,
        length=4,
	type="slope"
    );
    
    color( "red" ) translate([0, (5 * 4) + (11 * 8), 0]) translate([28, 12, 0]) block(
        width=3,
        length=7,
        height=1,
        type="wing",
        wing_type="left",
        wing_end_width=1
    );
    
    color( "green" ) translate([34, (4 * 4) + (9 * 8), 0]) translate([14, 8, 0]) block(
        width=2,
        length=3,
        height=1/3,
        type="wing",
        wing_type="right",
        wing_end_width=1,
        wing_base_length=1
    );
}