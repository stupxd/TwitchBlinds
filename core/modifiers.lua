local modifiers_to_load = {}

--- @class TWBLModifier
--- @field key string
TWBLModifier = Object:extend()

---@param center { key: string, in_pool: fun(): boolean }
function TWBLModifier:init(center)
	table_merge(self, center)
	if not string_starts(self.key, SMODS.current_mod.key .. "_") then
		self.key = self.key .. SMODS.current_mod.key .. "_"
	end
	self.key = "twblm_" .. self.key
end
function TWBLModifier:in_pool()
	return true
end
function TWBLModifier:should_apply()
	return false
end
function TWBLModifier:apply() end

function twbl_init_modifiers()
	local MODIFIERS = {
		loaded = {},
	}

	TW_BL.MODIFIERS = MODIFIERS

	---@param modifier TWBLModifier
	function MODIFIERS.register(modifier)
		MODIFIERS.loaded[modifier.key] = modifier
	end

	function MODIFIERS.toggle_blind_modifier(type, b)
		TW_BL.G["blind_modifier_" .. type] = b or nil
	end

	function MODIFIERS.emplace()
		print("Emplacing")
		MODIFIERS.toggle_blind_modifier("Small", true)
		MODIFIERS.toggle_blind_modifier("Big", true)
		MODIFIERS.toggle_blind_modifier("Boss", false)
	end

	function MODIFIERS.get_blind_modifier_select_line(type, run_info)
		if not TW_BL.G["blind_modifier_" .. type] then
			return nil
		end
		print("Inserting definition")
		return TW_BL.UI.get_blind_modifier_select_line_definition()
	end

	return MODIFIERS
end
