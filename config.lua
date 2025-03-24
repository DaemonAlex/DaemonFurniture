-- config.lua
Config = {}

-- List of Furniture Recipes (catalog items)
-- Each entry has a name, model (for the crafted item), price, image path, and ingredients (for future crafting)
Config.Recipes = {
    {
        name = "Modern Sofa",
        model = "prop_modern_sofa",
        price = 500,
        img = "images/modern_sofa.png",  -- update this path once you have the PNG
        ingredients = {
            table_top = 1,
            wood_table_leg = 4,
            wood_plank = 2,
            nails = 10,
            metal_bracket = 2,
        },
    },
    {
        name = "Traditional Sofa",
        model = "prop_traditional_sofa",
        price = 450,
        img = "images/traditional_sofa.png",
        ingredients = {
            wood_frame = 1,
            wood_armrest = 2,
            cushion_foam = 2,
            cloth_red = 2,
            nails = 5,
        },
    },
    {
        name = "Leather Traditional Sofa",
        model = "prop_leather_traditional_sofa",
        price = 600,
        img = "images/leather_traditional_sofa.png",
        ingredients = {
            wood_frame = 1,
            wood_armrest = 2,
            cushion_foam = 2,
            leather_black = 2,
            nails = 5,
        },
    },
    {
        name = "Arm Chair",
        model = "prop_arm_chair",
        price = 200,
        img = "images/arm_chair.png",
        ingredients = {
            wood_chair_leg = 4,
            wood_chair_back = 1,
            cushion_foam = 1,
            cloth_green = 1,
        },
    },
    {
        name = "Leather Arm Chair",
        model = "prop_leather_arm_chair",
        price = 250,
        img = "images/leather_arm_chair.png",
        ingredients = {
            wood_chair_leg = 4,
            wood_chair_back = 1,
            cushion_foam = 1,
            leather_brown = 1,
        },
    },
    -- You can add more recipes here...
}
