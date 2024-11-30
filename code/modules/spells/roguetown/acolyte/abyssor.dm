//////////////////////
//# ABYSSOR'S RAGE #//
//////////////////////
/obj/effect/proc_holder/spell/invoked/projectile/swordfish
	name = "Abyssor's Rage"
	overlay_state = "curse2"
	releasedrain = 50
	chargetime = 60
	range = 10
	projectile_type = /obj/projectile/magic/swordfish
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = /datum/looping_sound/invokegen
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/abyssor)
	sound = 'sound/magic/whiteflame.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 120 SECONDS
	devotion_cost = -40

/obj/item/reagent_containers/food/snacks/fish/swordfish
	name = "Swordfish"
	desc = "But one enactor of Abyssor's wrath."
	icon = 'icons/roguetown/misc/fish.dmi'
	icon_state = "Swordfish"
	force = 10
	dropshrink = 0.8
	possible_item_intents = list(/datum/intent/dagger/thrust)

/obj/projectile/magic/swordfish
	name = "Swordfish"
	desc = "But one enactor of Abyssor's wrath."
	damage = 30
	damage_type = BRUTE
	icon = 'icons/roguetown/misc/fish.dmi'
	icon_state = "SwordfishProjectile"
	ammo_type = /obj/item/reagent_containers/food/snacks/fish/swordfish
	range = 10
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	armor_penetration = 100
	woundclass = BCLASS_STAB
	flag =  "piercing"
	speed = 0.6
