use <LEGO.scad>;

rotate([0, 0, 180]) union() {
    place(-5, -6) uncenter(24, 19) rotate([0, 0, 90]) block(
        type="baseplate",
        width=19,
        length=24
    );
    
    place(0, 0, 13/96) {
        color( "red" ) place(1, 0, 0) uncenter(2, 9) block(
            width=2,
            length=9,
            height=2,
            reinforcement=true
        );
        
        color( "blue" ) place(4, 0, 0) uncenter(2, 2) block(
            width=2,
            length=2,
            stud_type="hollow"
        );
        
        color( "white" ) place(4, 3, 0) uncenter(2, 2) block(
            width=2,
            length=2,
            height=1/3,
            vertical_axle_holes=true
        );
        
        color( "green" ) place(4, 6, 0) uncenter(2, 2) block(
            width=2,
            length=2,
            height=1/3,
            type="tile"
        );
        
        color( "white" ) place(7, 0, 0) uncenter(4, 9) block(
            width=4,
            length=9,
            height=1/3,
            type="wing",
            stud_notches=true
        );
    
        color( "yellow" ) place(12, 0, 0) uncenter(1, 8) block(
            width=1,
            length=8,
            horizontal_holes=true
        );
        
        color( "black" ) place(16, -5, 0) uncenter(2, 4) block(
            width=2,
            length=4,
            type="slope"
        );
        
        color( "green" ) place(-4, 0, 0) uncenter(4, 6) block(
            width=2,
            length=3,
            brand="duplo",
            reinforcement=true,
            stud_type="hollow"
        );
        
        color( "blue" ) place(-4, 7, 0) uncenter(4, 4) rotate([0, 0, 180]) block(
            width=2,
            length=2,
            brand="duplo",
            reinforcement=true,
            stud_type="hollow",
            type="curve"
        );
        
        color( "gray" ) place(-4, -5, 0) uncenter(12, 4) rotate([0, 0, 270]) block(
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
    
        color( "blue" ) place(9, -5, 0) uncenter(6, 4) rotate([0, 0, 270]) block(
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
    
        color( "red" ) place(14, 0, 0) uncenter(3, 7) block(
            width=3,
            length=7,
            height=1,
            type="wing",
            wing_type="left",
            wing_end_width=1
        );
    
        color( "green" ) place(1, 10, 0) uncenter(3, 2) rotate([0, 0, 90]) block(
            width=2,
            length=3,
            height=1/3,
            type="wing",
            wing_type="right",
            wing_end_width=1,
            wing_base_length=1
        );
    }
}