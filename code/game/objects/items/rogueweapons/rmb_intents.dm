/datum/rmb_intent
	var/name = "intent"
	var/desc = ""
	var/icon_state = ""
	var/def_bonus = 0

/datum/rmb_intent/proc/special_attack(mob/living/user, atom/target)
	if(!isliving(target))
		return
	if(!user)
		return
	if(user.incapacitated())
		return
	var/mob/living/L = target
	user.changeNext_move(CLICK_CD_RAPID)
	playsound(user, 'sound/combat/feint.ogg', 100, TRUE)
	user.visible_message("<span class='danger'>[user] feints an attack at [target]!</span>")
	var/perc = 50
	if(user.mind)
		var/obj/item/I = user.get_active_held_item()
		var/ourskill = 0
		var/theirskill = 0
		if(I)
			if(I.associated_skill)
				ourskill = user.mind.get_skill_level(I.associated_skill)
			if(L.mind)
				I = L.get_active_held_item()
				if(I?.associated_skill)
					theirskill = L.mind.get_skill_level(I.associated_skill)
		perc += (ourskill - theirskill)*15 	//skill is of the essence
		perc += (user.STAINT - L.STAINT)*10	//but it's also mostly a mindgame
		perc += (user.STASPD - L.STASPD)*5 	//yet a speedy feint is hard to counter
	if(L.d_intent == INTENT_DODGE)
		perc = 0
	if(!L.cmode)
		perc = 0
	if(L.has_status_effect(/datum/status_effect/debuff/feinted))
		perc = 0
	if(user.has_status_effect(/datum/status_effect/debuff/feintcd))
		perc -= rand(10,30)
	user.apply_status_effect(/datum/status_effect/debuff/feintcd)
	perc = CLAMP(perc, 0, 90) //no zero risk superfeinting
	if(prob(perc)) //feint intent increases the immobilize duration significantly
		if(istype(user.rmb_intent, /datum/rmb_intent/feint))
			L.apply_status_effect(/datum/status_effect/debuff/feinted)
			L.changeNext_move(10)
			L.Immobilize(15)
			to_chat(user, span_notice("[L] fell for my feint attack!"))
			to_chat(L, span_danger("I fall for [user]'s feint attack!"))
		else
			L.apply_status_effect(/datum/status_effect/debuff/feinted)
			L.changeNext_move(4)
			L.Immobilize(5)
			to_chat(user, span_notice("[L] fell for my feint attack!"))
			to_chat(L, span_danger("I fall for [user]'s feint attack!"))
	else
		if(user.client?.prefs.showrolls)
			to_chat(user, "<span class='warning'>[L] did not fall for my feint... [perc]%</span>")

/datum/rmb_intent/aimed
	name = "aimed"
	desc = "Your attacks are more precise but have a longer recovery time. Higher critrate with precise attacks."
	icon_state = "rmbaimed"
	def_bonus = -20

/datum/rmb_intent/strong
	name = "strong"
	desc = "Your attacks have +1 strength but use more stamina. Higher critrate with brutal attacks."
	icon_state = "rmbstrong"
	def_bonus = -20

/datum/rmb_intent/swift
	name = "swift"
	desc = "Your attacks have less recovery time but are less accurate."
	icon_state = "rmbswift"

/datum/rmb_intent/special
	name = "special"
	desc = "(RMB WHILE DEFENSE IS ACTIVE) A special attack that depends on the type of weapon you are using."
	icon_state = "rmbspecial"

/datum/rmb_intent/feint
	name = "feint"
	desc = "(RMB WHILE DEFENSE IS ACTIVE) A deceptive half-attack with no follow-through, meant to force your opponent to open their guard. Useless against someone who is dodging."
	icon_state = "rmbfeint"
	def_bonus = 10

/datum/status_effect/debuff/feinted
	id = "nofeint"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/feinted
	duration = 50

/atom/movable/screen/alert/status_effect/debuff/feinted
	name = "Feinted"
	desc = "<span class='boldwarning'>I have been tricked, and cannot defend myself!</span>\n"
	icon_state = "muscles"

/datum/status_effect/debuff/feintcd
	id = "feintcd"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/feintcd
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/feintcd
	name = "Feint Cooldown"
	desc = "<span class='warning'>I have feinted recently, my opponents will be wary.</span>\n"

/datum/status_effect/debuff/riposted
	id = "riposted"
	duration = 30

/datum/rmb_intent/riposte
	name = "defend"
	desc = "No delay between dodge and parry rolls."
	icon_state = "rmbdef"

/datum/rmb_intent/guard
	name = "guarde"
	desc = "(RMB WHILE DEFENSE IS ACTIVE) Raise your weapon, ready to attack any creature who moves onto the space you are guarding."
	icon_state = "rmbguard"

/datum/rmb_intent/weak
	name = "weak"
	desc = "Your attacks have -1 strength and will never critically-hit. Surgery steps can only be done with this intent. Useful for longer punishments, play-fighting, and bloodletting."
	icon_state = "rmbweak"
