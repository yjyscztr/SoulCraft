--- STEAMODDED HEADER
--- MOD_NAME: soulcraft
--- MOD_ID: soulcraft
--- MOD_AUTHOR: [AMADEUS]
--- MOD_DESCRIPTION: enhance your jokers by souls
--- BADGE_COLOUR: 9400D3
--- PRIORITY: 999999999999999
------------------------------
----------------------------------------------
------------MOD CODE -------------------------
function SMODS.INIT.soulcraft() 

  G.localization.misc.dictionary["b_break"] = "分解"
  G.localization.misc.dictionary["b_upgrade"] = "镶嵌"
  G.localization.misc.dictionary["b_soul"] = "灵魂"
  G.localization.misc.dictionary["b_crystal"] = "水晶"
  G.localization.misc.dictionary["b_misprint"] = "印错"
  G.localization.misc.dictionary["b_glass"] = "玻璃"
  G.localization.misc.dictionary["b_chips"] = "筹码"
  G.localization.misc.dictionary["b_mult"] = "倍率"
  G.localization.misc.dictionary["b_freeroll"] = "免费重掷次数"
  G.localization.misc.dictionary["b_points"] = "点数"
  G.localization.misc.dictionary["b_sellcost"] = "售价"
  G.localization.misc.dictionary["b_limit"] = "额度"
  
local localization= {

soul_crystal={
  name = "灵魂水晶",
        text= {
          "蕴含{C:blue}灵魂{}的水晶"
        }
  },
enhance_crystal={
  name = "强化水晶",
        text= {
		  "蕴含{C:purple}神秘力量",
		   "的{C:attention}特殊{}水晶"
        }
  },
}

local jokers= {
soul_crystal = SMODS.Joker:new("soul_crystal", "soul_crystal", 
         {extra = "crystal"}, 
         {x = 0,y = 0}, localization["soul_crystal"], 
		 2,5,1,1,1,1
		 )
,
enhance_crystal = SMODS.Joker:new("enhance_crystal", "enhance_crystal", 
         {extra = "crystal"}, 
         {x = 0,y = 0}, localization["enhance_crystal"], 
		 2,5,1,1,1,1
		 )
,

}  
 
for k,v in pairs(jokers) do
   SMODS.Sprite:new("j_"..k, SMODS.findModByID("soulcraft").path, k..".png", 71, 95, "asset_atli"):register();
   jokers[k]:register()
end

G.localization.descriptions.Other["soul_crystal"] = {
    name = "灵魂水晶",
	text = {
	"通过{C:attention}分解小丑",
	"或{C:attention}使用消耗牌",
	"获得的特殊卡牌",
	"将此牌置于想要",
	"镶嵌小丑的{C:attention}右侧"
	}
}
G.localization.descriptions.Other["enhance_crystal"] = {
    name = "强化水晶",
    text = {
	"通过{C:attention}使用消耗牌",
	"获得的特殊卡牌",
	"将此牌置于想要",
	"镶嵌小丑的{C:attention}右侧"
	}
}
function SMODS.Jokers.j_soul_crystal.tooltip(card,info_queue)
    info_queue[#info_queue+1] = { set = 'Other', key ="soul_crystal" }
end
function SMODS.Jokers.j_enhance_crystal.tooltip(card,info_queue)
    info_queue[#info_queue+1] = { set = 'Other', key ="enhance_crystal" }
end


 
 end

-- Soul = {
-- tag = "",
-- name = "",
-- type = "",
-- ability = {},
-- }

-- function Soul:new(tag,name,type,ability)
   -- o = {}
   -- setmetatable(o, self)
   -- o.tag=tag
   -- o.name=name or " "
   -- o.type=type or " "
   -- o.ability=ability or {}
   -- return o
-- end


Souls = {}
Soulss = {}

soul_break_blacklist ={
-- j_abstract = true,
}

joker_soul = {
j_abstract = {tag = "j_abstract", extra = 3, banned = false},
j_midas_mask = {tag = "j_midas_mask", sole = true},
j_perkeo = {tag = "j_perkeo"},
j_madness = {tag = "j_madness", extra = 0.5},
j_vampire = {tag ="j_vampire" , extra = 0.1},
j_mime = {tag = "j_mime"},
j_dusk = {tag = "j_dusk"},
j_mystic_summit = {tag = "j_mystic_summit", extra = 0.1},
j_baron = {tag = "j_baron", extra = 1.5},
j_rough_gem = {tag = "j_rough_gem", extra = 1},
j_oops = {tag = "j_oops", extra = 6},
j_troubadour = {tag = "j_troubadour"},
j_glass = {tag = "j_glass", sole = true},
j_vagabond = {tag = "j_vagabond"},
j_half = {tag = "j_half", extra = 20},
j_stencil = {tag = "j_stencil", extra = 1},
j_egg = {tag = "j_egg", extra = 3},
j_golden = {tag = "j_golden"},
j_misprint = {tag = "j_misprint", sole = true},
j_baseball = {tag = "j_baseball", extra = 1},
j_credit_card={tag = "j_credit_card", extra = 20},
j_ceremonial = {tag = "j_ceremonial"},
j_banner = {tag = "j_banner"},
j_loyalty_card = {tag = "j_loyalty_card"},
j_chaos = {tag = "j_chaos"},
j_blackboard = {tag = "j_blackboard",extra = 3},
j_juggler = {tag = "j_juggler", extra = 1},
j_drunkard = {tag = "j_drunkard", extra = 1},
j_cartomancer = {tag = "j_cartomancer"},
j_hallucination = {tag = "j_hallucination", extra = 4, dollars = 3},
j_luchador = {tag = "j_luchador"},
j_diet_cola = {tag = "j_diet_cola"},
}

consumeable_soul = {
c_strength = {tag = "c_strength", extra = 1, usage = 3},
c_chariot = {tag = "c_chariot", extra = 1.5, usage = 6},
c_heirophant = {tag = "c_heirophant", extra = 30, usage = 3},
c_hermit = {tag = "c_hermit", extra = 2, usage = 3, consumeable = true},
c_temperance = {tag = "c_temperance", extra = 5,usage = 3, consumeable = true},
c_emperor = {tag = "c_emperor", extra = 1, usage = 5},
c_judgement = {tag = "c_judgement", extra = 1, usage = 10},
}

rarity_soul = {
common_soul = {tag = "common_soul",name = "普通灵魂" ,chips = 15},
uncommon_soul = {tag = "uncommon_soul",name = "罕见灵魂",mult = 7},
rare_soul = {tag = "rare_soul",name = "稀有灵魂", x_mult = 1.2},
legendary_soul = {tag = "legendary_soul",name = "传奇灵魂", x_chips = 3},
}

enhance_soul = {
enhance_soul_eternal = {tag = "enhance_soul_eternal",name = "不毁", sole = true},
enhance_soul_slot = {tag ="enhance_soul_slot",name = "扩容", extra = 1, consumeable = true},
enhance_soul_split = {tag = "enhance_soul_split",name = "分裂", extra = 10, sole = true},
enhance_soul_mutation = {tag ="enhance_soul_mutation", name = "突变", extra = 2, consumeable = true},
enhance_soul_unwilling = {tag = "enhance_soul_unwilling", name = "蹈节", sole = true, extra = true},
enhance_soul_source = {tag = "enhance_soul_source", name = "本源", extra = 1, level = 1},
enhance_soul_clear = {tag = "enhance_soul_clear", name = "虚无", consumeable = true},
enhance_soul_zhongliu = {tag = "enhance_soul_zhongliu", name = "中流", consumeable = true},

}
souls = {}
local _soul = {joker_soul,rarity_soul,enhance_soul,consumeable_soul}
for i = 1, #_soul do
    for k,v in pairs(_soul[i]) do
	    souls[#souls+ 1] = v
        Souls[k] = v
        Soulss[k] = {}
    end
end


------------------------
Souls.common_soul.text={
   "{C:blue}+#1#{}筹码"
}
Souls.uncommon_soul.text={
   "{C:red}+#1#{}倍率"
}
Souls.rare_soul.text={
   "{X:mult,C:white}x#1#{}倍率"
}
Souls.legendary_soul.text={
   "{X:blue,C:white}X#1#{}筹码"
}
------------------------
Souls.enhance_soul_eternal.text={
    "选择{C:attention}盲注{}时",
	"给予小丑牌{C:dark_edition}永恒{}",
    "并使得此牌可以",
	"{C:attention}无视永恒{}被售出或分解"
}
Souls.enhance_soul_slot.text={
   "{C:attention}+#1#{}{C:blue}灵魂{}槽位"
}
Souls.enhance_soul_split.text={
    "选择{C:attention}盲注{}时",
	"有{C:green}#2#/#1#{}几率{C:attention}复制{}此牌",
     "{C:inactive}(必须有空间)"
}
Souls.enhance_soul_mutation.text = {
   "此牌的某些数值{C:red}X#1#"
}
Souls.enhance_soul_unwilling.text = {
   "每个盲注限{C:attention}一次",
   "{C:attention}出售{}此牌时",
   "加入一张此牌的{C:attention}复制"
   
}
Souls.enhance_soul_source.text = {
   "可叠加升级",
   "每级减少{C:blue}#1#%",
   "的盲注分数",
   "{C:inactive}(当前:{C:purple}#2#{}{C:inactive}级)"
}
Souls.enhance_soul_clear.text = {
   "清除此牌",
   "的所有{C:blue}灵魂",
   "以及易腐",
   "{C:money}租用{}和{C:dark_edition}永恒{}"
}
Souls.enhance_soul_zhongliu.text = {
   "{C:attention}重新触发{}一次",
   "此牌加入时的效果",
}
------------------------
Souls.j_abstract.text = {
   "每有一张{C:attention}小丑牌{}",
   "{C:mult}+#1#{}倍率"
}
Souls.j_midas_mask.text = {
   "所有打出的{C:attention}人头牌",
   "将在计分时",
   "变为{C:attention}黄金牌"
}
Souls.j_perkeo.text = {
   "在离开商店时",
   "随机复制{C:attention}1{}张",
   "拥有的消耗牌",
   "并给那张牌{C:dark_edition,s:0.9}负片{}效果"
}
Souls.j_madness.text = {
    "选择{C:attention}盲注{}时",
	"随机{C:attention}摧毁{}一张小丑牌",
    "并使此牌的某些数值{C:mult}+#1#"
}
Souls.j_vampire.text = {
    "打出计分增强牌时",
	"移除此牌的{C:attention}增强效果",
    "并使此牌的某些数值{C:mult}+#1#"
}
Souls.j_mime.text = {
   "此牌所有的{C:blue}灵魂{}效果",
   "将额外触发一次"
}
Souls.j_dusk.text = {
   "每回合{C:attention}最后一次{}出牌时",
   "此牌所有的{C:blue}灵魂{}效果",
   "将额外触发两次"
}
Souls.j_mystic_summit.text = {
   "每次出牌时",
   "若剩余{C:attention}弃牌次数{}为{C:attention}0{}",
   "则使此牌的某些数值{C:mult}+#1#"
}
Souls.j_baron.text = {
   "每张与打出的",
   "{C:attention}第一张{}计分牌",
   "{C:attention}点数相同{}的手牌",
   "将给予{X:mult,C:white}X#1#{}倍率",
}
Souls.j_rough_gem.text = {
   "若打出的计分牌花色",
   "是所有计分牌中数量{C:attention}最多{}的花色",
   "则其计分时给予{C:money}$#1#"
}
Souls.j_oops.text = {
   "每次出牌时",
   "将所有以{C:attention}数字标注{}出的",
   "{C:green}几率{}暂时{C:green}X#1#{}",   
}
Souls.j_troubadour.text = {
   "{C:attention}+2{}手牌上限",
   "每回合出牌次数{C:attention}-1"
}
Souls.j_glass.text = {
   "所有打出的牌",
   "将在计分时变为{C:attention}玻璃牌",
}
Souls.j_vagabond.text = {
  "每次出牌时",
  "如果当前资金数",
  "不大于此牌{C:attention}售价",
  "则获得一张{C:purple}塔罗牌"
}
Souls.j_half.text = {
   "如果此牌拥有的",
   "{C:blue}灵魂{}数量不大于{C:attention}2",   
   "则{C:mult}+#1#{}倍率"
}
Souls.j_stencil.text = {
  "每个空的{C:blue}灵魂{}槽位",
  "获得{X:mult,C:white}X#1#{}倍率",
}
Souls.j_egg.text = {
   "回合结束时",
   "此牌的售价{C:money}+#1#",
}
Souls.j_golden.text = {
   "回合结束时",
   "获得等同于此牌",
   "{C:money}售价{}的资金",
}
Souls.j_misprint.text = {
   "{C:attention}+1{}{C:blue}灵魂{}槽位",
   "选择{C:attention}盲注{}时",
   "将此牌的其它{C:blue}灵魂",
   "{C:attention}替换{}为随机{C:blue}灵魂"
}
Souls.j_baseball.text = {
   "镶嵌的每个{C:blue}灵魂{}",
   "会给予{X:mult,C:white}X#1#{}倍率"
}
Souls.j_credit_card.text = {
   "可以负债最多{C:red}-20",
   "回合结束时",
   "额外获得等同于",
   "此牌售价的额度",
   "{C:inactive}(当前额度:{C:attention}#1#{C:inactive})"
}
Souls.j_ceremonial.text = {
   "选择{C:attention}盲注{}时",
   "摧毁{C:attention}右侧{}的小丑牌",
   "并根据被摧毁牌的{C:red}稀有度",
   "将它的购价翻涨",
   "加到这张牌的{C:attention}售价{}上",
   "{C:inactive}(普通:1倍 罕见:2倍 稀有:3倍){}",
   "{C:inactive}(传奇及其他:4倍){}",
}
Souls.j_banner.text = {
   "提供等同于本回合中",
   "剩余{C:attention}弃牌次数",
   "乘此牌{C:money}售价{}的倍率"
}
Souls.j_loyalty_card.text = {
  "提供等同于本回合中",
  "已使用{C:attention}出牌次数{}的倍率",
}
Souls.j_chaos.text = {
   "回合结束时",
   "根据此牌{C:red}稀有度{}",
   "获得免费重掷次数",
   "{C:inactive}(普通:1次 罕见:2次 稀有:3次){}",
   "{C:inactive}(传奇及其他:4次){}",
}
Souls.j_blackboard.text = {
   "如果留在手牌中的",
   "所有牌的{C:attention}花色{}都",
   "与{C:attention}计分牌{}不同",
   "则{X:mult,C:white}X#1#{}倍率" 
}
Souls.j_drunkard.text = {
  "{C:attention}+#1#{}弃牌次数"
}
Souls.j_juggler.text = {
  "{C:attention}+#1#{}手牌上限"
}
Souls.j_cartomancer.text = {
   "选择{C:attention}盲注{}时",
   "随机生成一张{C:purple}水晶",
   "{C:inactive}(必须有空间)"
}
Souls.j_hallucination.text = {
   "使用消耗牌时",
   "有{C:green}#2#/#1#{}几率",
   "花费{C:attention}$#3#{}复制此消耗牌",
   "{C:inactive}(必须有空间)"
}
Souls.j_luchador.text = {
   "每回合{C:attention}第二次{}出牌后",
   "会消除当前回合中",
   "{C:attention}Boss盲注{}的限制条件"
}
Souls.j_diet_cola.text = {
   "出售此牌时",
   "{C:attention}重复触发{}",
   "此牌的出售效果",
   "{C:inactive}(如果有的话)"
}
------------------------
Souls.c_strength.text = {
   "所有打出的牌",
   "将在计分时{C:attention}点数+#1#"
}
Souls.c_chariot.text = {
   "每张手中的{C:attention}钢铁牌",
   "额外给予{X:mult,C:white}X#1#{}倍率"
}
Souls.c_heirophant.text = {
   "所有打出的牌",
   "将在计分时{C:blue}+#1#{}筹码"
}
Souls.c_hermit.text = {
   "此牌的售价{C:attention}翻倍"
}
Souls.c_temperance.text = {
   "获得等同于此牌",
   "{C:attention}#1#倍{}售价的{C:money}资金"
}
Souls.c_emperor.text = {
   "{C:dark_edition}+#1#{}消耗牌槽位"
}
Souls.c_judgement.text = {
   "{C:dark_edition}+#1#{}小丑牌槽位"
}
function soul_vars(soul)
    local seq = {soul.chips,soul.x_chips,soul.mult,soul.x_mult,soul.extra,soul.level,G.GAME.probabilities.normal,soul.dollars}
    local vars = {}
    for k, v in pairs(seq) do
	    if v then
		    table.insert(vars,v)
		end
	end
    return vars
end

for k, v in pairs(Souls) do
    local tag = v.tag
	G.localization.descriptions.Other[v.tag] = {
	    name = v.name or localize{type = 'name_text', key = tag, set = G.P_CENTERS[tag].set}.."之魂",
	    text = v.text or {""}
	}
end
	   
local calculate_jokerref = Card.calculate_joker
function Card.calculate_joker(self, context)
   if self.ability.set == "Joker" and not self.debuff then
       soul_reps = 1
	   souls_calculate(self,{soul_repetitions = true})
	   for i=1, soul_reps do
		    souls_calculate(self,context)
	   end
	   soul_reps = nil
   end
   return calculate_jokerref(self, context)
end

function souls_calculate(self,context)
   for k,v in pairs(self.ability.souls) do
       local obj = Soulss[v.tag]
	   if  obj.calculate and type(obj.calculate) == "function" then
		  obj.calculate(v,self,context)
	   end
   end
end

Soulss.common_soul.calculate = function(self,card,context)
   if hand_chips and SMODS.end_calculate_context(context) and not context.soul_repetitions and context.joker_main then
      hand_chips = hand_chips + self.chips
	  update_hand_text({delay = 0}, {chips = hand_chips})
      card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(self.chips)..localize("b_chips"), colour = G.C.BLUE}) 
   end
end

Soulss.uncommon_soul.calculate = function(self,card,context)
   if mult and SMODS.end_calculate_context(context) and not context.soul_repetitions and context.joker_main then
      mult = mult + self.mult
	  update_hand_text({delay = 0}, {mult = mult})
      card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(self.mult)..localize("b_mult"), colour = G.C.RED}) 
   end
end

Soulss.rare_soul.calculate = function(self,card,context)
   if mult and SMODS.end_calculate_context(context) and not context.soul_repetitions and context.joker_main then
      mult = mult * self.x_mult
	  update_hand_text({delay = 0}, {mult = mult})
      card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(self.x_mult)..localize("b_mult"), colour = G.C.RED}) 
   end
end

Soulss.legendary_soul.calculate = function(self,card,context)
   if hand_chips and SMODS.end_calculate_context(context) and not context.soul_repetitions and context.joker_main then
      hand_chips = hand_chips * self.x_chips
	  update_hand_text({delay = 0}, {chips = hand_chips})
      card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(self.x_chips)..localize("b_chips"), colour = G.C.BLUE}) 
   end
end



Soulss.enhance_soul_eternal.calculate = function(self,card,context)
    if context.setting_blind and not card.getting_sliced then
         card:set_eternal(true)
    end
end

Soulss.enhance_soul_split.calculate = function(self,card,context)
    if context.setting_blind and not card.getting_sliced then
	    if pseudorandom("j_enhance_soul_split") < G.GAME.probabilities.normal / self.extra then	
		    if #G.jokers.cards < G.jokers.config.card_limit then
			   local card = copy_card(card, nil, nil, nil,nil)
               card:add_to_deck()
               G.jokers:emplace(card)
            end
	    end
	end
end

Soulss.enhance_soul_unwilling.calculate = function(self,card,context)
    if context.selling_self and self.extra then
	    self.extra = false
	    local card_ = copy_card(card, nil, nil, nil,nil)
        card_:add_to_deck()
        G.jokers:emplace(card_)
    end
	if context.setting_blind and not card.getting_sliced then
	    self.extra = true
	end
end

Soulss.enhance_soul_source.calculate = function(self,card,context)
    if context.setting_blind and not card.getting_sliced then
	    G.GAME.blind.chips = G.GAME.blind.chips * (100 - math.min(self.extra * self.level,100)) / 100
	end
end

Soulss.j_abstract.calculate = function(self,card,context)
    if SMODS.end_calculate_context(context) and not context.soul_repetitions and context.joker_main then
	   mult = mult + self.extra * #G.jokers.cards 
	   update_hand_text({delay = 0}, {mult=mult})
       card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..3*#G.jokers.cards..localize("b_mult"), colour = G.C.RED}) 
    end
end

Soulss.j_midas_mask.calculate = function(self,card,context)
    if  context.cardarea == G.jokers and context.before then
	    local faces = {}
		for k, v in ipairs(context.scoring_hand) do
			if v:is_face() then 
				faces[#faces+1] = v
				v:set_ability(G.P_CENTERS.m_gold, nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				})) 
			end
		end
		if #faces > 0 then 
			 card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_gold'), colour = G.C.MONEY}) 
		end
    end
end

Soulss.j_perkeo.calculate = function(self,card,context)
   if context.ending_shop and G.consumeables.cards[1] then 
	    G.E_MANAGER:add_event(Event({
						func = function() 
							local _card = copy_card(pseudorandom_element(G.consumeables.cards, pseudoseed('perkeo')), nil)
							_card:set_edition({negative = true}, true)
							_card:add_to_deck()
							G.consumeables:emplace(_card) 
							return true
						end}))
		card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
    end
end

Soulss.j_madness.calculate = function(self,card,context)
    if context.setting_blind and not card.getting_sliced then 
		local madness_increase = self.extra
		soul_increase(card,madness_increase)	  
		card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+"..tostring(madness_increase)})
		local destructable_jokers = {}
		for i = 1, #G.jokers.cards do
		    if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then destructable_jokers[#destructable_jokers+1] = G.jokers.cards[i] end
		end
		local joker_to_destroy = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('madness')) or nil
		if joker_to_destroy and not card.getting_sliced then 
			joker_to_destroy.getting_sliced = true
			G.E_MANAGER:add_event(Event({func = function()
				card:juice_up(0.8, 0.8)
				joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
				return true end }))
		end        
    end
end

Soulss.j_vampire.calculate = function(self,card,context)
   if context.cardarea == G.jokers and context.before then
      local vampire_increase=self.extra
	  local enhanced = {}
      for k, v in ipairs(context.scoring_hand) do
         if v.config.center ~= G.P_CENTERS.c_base and not v.debuff then 
              enhanced[#enhanced+1] = v
              v:set_ability(G.P_CENTERS.c_base, nil, true)
          end
      end				
       if #enhanced > 0 then 
		  for i=1,#enhanced do
			soul_increase(card,vampire_increase)
			card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(vampire_increase)})
		  end
       end
   end     
end

Soulss.j_mime.calculate = function(self,card,context)
   if context.soul_repetitions then
	  soul_reps = soul_reps + 1
   end
end

Soulss.j_dusk.calculate = function(self,card,context)
   if context.soul_repetitions and  G.GAME.current_round.hands_left == 0 then
	  soul_reps = soul_reps + 2
   end
end

Soulss.j_mystic_summit.calculate = function(self,card,context)
   if context.cardarea == G.jokers and context.before and G.GAME.current_round.discards_left == 0 then
	  soul_increase(card,seolf.extra)
   end
end

Soulss.j_baron.calculate = function(self,card,context)
   if context.individual and context.cardarea == G.hand and not context.end_of_round then
	   if context.other_card.debuff then
		  card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message = localize('k_debuffed')})
	   elseif context.other_card:get_id() == context.scoring_hand[1]:get_id() then
	      mult = mult * self.extra
	      update_hand_text({delay = 0}, {mult=mult})
		  juice_card(card)
          card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message = "X"..self.extra..localize("b_mult"), colour = G.C.RED}) 	
      end	
   end		    
end

Soulss.j_rough_gem.calculate = function(self,card,context)
   if context.individual and context.cardarea == G.play and not context.end_of_round then
      local suits={
	   Spades = 0,
       Hearts = 0,
       Clubs = 0,
       Diamonds = 0,}
	  for i=1,#context.scoring_hand do
	     for k,v in pairs(suits) do
		    if context.scoring_hand[i]:is_suit(k) then
			   v = v+1
			end
		 end
	  end
      local suit_max = math.max(suits["Spades"],suits["Hearts"],suits["Clubs"],suits["Diamonds"])
	  for k,v in pairs(suits) do
	     if v == suit_max then
		    if context.other_card:is_suit(k) then
			   ease_dollars(self.extra)
			   juice_card(card)
			   card_eval_status_text(context.other_card, 'dollars',1, percent)
			   break
			end
		 end
	  end
   end
end

Soulss.j_oops.calculate = function(self,card,context)
   if context.before and context.cardarea == G.jokers then
      for k, v in pairs(G.GAME.probabilities) do 
         G.GAME.probabilities[k] = v * self.extra
      end
   end
   if context.after and context.cardarea == G.jokers then
       for k, v in pairs(G.GAME.probabilities) do 
         G.GAME.probabilities[k] = v / self.extra
      end
   end
end

Soulss.j_glass.calculate = function(self,card,context)
   if context.before and context.cardarea == G.jokers then
      for k, v in ipairs(context.scoring_hand) do
	     v:set_ability(G.P_CENTERS.m_glass, nil, true)
		    G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				})) 
      end
   card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('b_glass'), colour = G.C.BLUE})
   end
end

Soulss.j_vagabond.calculate = function(self,card,context)
   if context.after and context.cardarea == G.jokers then
       if G.GAME.dollars <= card.sell_cost then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.0,
				func = (function()
						local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'vag')
						card:add_to_deck()
						G.consumeables:emplace(card)
						G.GAME.consumeable_buffer = 0
					return true
				end)}))
			 card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot')})
      end
   end
end

Soulss.j_half.calculate = function(self,card,context)
    if SMODS.end_calculate_context(context) and not context.soul_repetitions and context.joker_main and #card.ability.souls <= 2 then
	   mult = mult + self.extra
	   update_hand_text({delay = 0}, {mult=mult})
       card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(self.extra)..localize("b_mult"), colour = G.C.RED}) 
    end
end

Soulss.j_stencil.calculate = function(self,card,context)
   if SMODS.end_calculate_context(context) and not context.soul_repetitions and context.joker_main  then
	   local delta = card.ability.soul_slots_max - #card.ability.souls
	   if delta > 0 then
	      mult = mult*(delta * self.extra + 1)
	      update_hand_text({delay = 0}, {mult=mult})
          card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(delta * self.extra + 1)..localize("b_mult"), colour = G.C.RED}) 
	   end
    end
end

Soulss.j_egg.calculate = function(self,card,context)
    if context.end_of_round  and not context.individual and not context.repetition  then
	    card.ability.extra_value = card.ability.extra_value + self.extra
        card:set_cost()
		card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_val_up'), colour = G.C.MONEY})    
	end
end

Soulss.j_golden.calculate = function(self,card,context)
    if context.end_of_round  and not context.individual and not context.repetition and not context.blueprint then
	   ease_dollars(card.sell_cost)
	   card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "$"..tostring(card.sell_cost), colour = G.C.MONEY})    
	end
end

Soulss.j_misprint.calculate = function(self,card,context)
   if context.setting_blind and not card.getting_sliced then
      local joker_soul_= {}
	  for k, v in pairs(joker_soul)  do
	     if v.tag ~= "j_misprint" and not v.banned then
			joker_soul_[k] = copy_table(v)
		 end
	  end
	  for k,v in pairs(card.ability.souls) do
	     if v.tag ~= "j_misprint" then
	        local random_soul,key = pseudorandom_element(joker_soul_, pseudoseed('j_misprint'))
			local soul = copy_table(random_soul)
			if random_soul.sole then
	            joker_soul_[key] = nil 
			end
			local obj = Soulss[v.tag]
	        if  obj.remove and type(obj.remove) == "function" then
		        obj.remove(v,card)
	        end
			when_upgrade(card,soul)
		    card.ability.souls[k] = soul
	     end
	  end
      if #card.ability.souls > 1 then
         card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('b_misprint'), colour = G.C.RED})
	  end
   end
end

Soulss.j_ceremonial.calculate = function(self,card,context)
   if context.setting_blind and not card.getting_sliced then
       for i = 1, #G.jokers.cards do
          if G.jokers.cards[i] == card and i < #G.jokers.cards and not G.jokers.cards[i+1].ability.eternal then
		     local sliced_card = G.jokers.cards[i+1]
             sliced_card.getting_sliced = true
			 G.E_MANAGER:add_event(Event({func = function()
                card.ability.extra_value = card.ability.extra_value + card.config.center.rarity * G.jokers.cards[i+1].cost
                card:set_cost()
                card:juice_up(0.8, 0.8)
                G.jokers.cards[i+1]:start_dissolve({HEX("57ecab")}, nil, 1.6)
                play_sound('slice1', 0.96+math.random()*0.08)
             return true end }))
			 card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(G.jokers.cards[i+1].config.center.rarity * G.jokers.cards[i+1].cost)..localize("b_sellcost"), colour = G.C.MONEY})
		   end
       end
   end
end

Soulss.j_credit_card.calculate = function(self,card,context)
    if context.end_of_round  and not context.individual and not context.repetition and not context.blueprint then
       G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.sell_cost 
	   self.extra = self.extra + card.sell_cost
	   card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.sell_cost)..localize("b_limit"), colour = G.C.MONEY})    
    end
end

Soulss.j_banner.calculate = function(self,card,context)
    if mult and SMODS.end_calculate_context(context) and not context.soul_repetitions and context.joker_main then
        mult = mult+card.sell_cost * G.GAME.current_round.discards_left
	    update_hand_text({delay = 0}, {mult = mult})
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.sell_cost * G.GAME.current_round.discards_left)..localize("b_mult"), colour = G.C.MULT}) 
    end
end

Soulss.j_baseball.calculate = function(self,card,context)
    if mult and SMODS.end_calculate_context(context) and not context.soul_repetitions and context.joker_main then
       mult = mult * #card.ability.souls * self.extra
	   update_hand_text({delay = 0}, {mult=mult})
       card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(#card.ability.souls)..localize("b_mult"), colour = G.C.MULT}) 
    end
end 

Soulss.j_loyalty_card.calculate = function(self,card,context)
    if mult and SMODS.end_calculate_context(context) and not context.soul_repetitions and context.joker_main then
       local played = G.GAME.current_round.hands_played + 1
	   mult = mult * played
	   update_hand_text({delay = 0}, {mult=mult})
       card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(played)..localize("b_mult"), colour = G.C.MULT}) 
    end
end 

Soulss.j_chaos.calculate = function(self,card,context)
   if context.end_of_round  and not context.individual and not context.repetition and not context.blueprint then
      G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls  + card.config.center.rarity 
	  card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.config.center.rarity)..localize("b_freeroll"), colour = G.C.GREEN}) 
	  calculate_reroll_cost(true)
    end
end

Soulss.j_cartomancer.calculate = function(self,card,context)
    if context.setting_blind and not card.getting_sliced and #G.jokers.cards < G.jokers.config.card_limit then
	    slug = pseudorandom("j_cartomancer") < 0.5 and "j_soul_crystal" or "j_enhance_crystal"
	    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            local card = create_card('Joker', G.jokers, nil, nil, nil, nil,slug,'crystal')
	        card:add_to_deck()
            G.jokers:emplace(card)
        return true end }))
	card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('b_crystal'), colour = G.C.PURPLE})
	end
end

Soulss.j_blackboard.calculate = function(self,card,context)
   if mult and SMODS.end_calculate_context(context) and not context.soul_repetitions and context.joker_main then
       local suits = {
	   Spades = false,
       Hearts = false,
       Clubs = false,
       Diamonds = false,
	   }
	  for i = 1, #context.scoring_hand do
	     for k,v in pairs(suits) do
		    if context.scoring_hand[i]:is_suit(k) then
			   suits[k] = true
			end
		 end
	  end
	  local have = false
	  for i  = 1, #G.hand.cards do
	     for k,v in pairs(suits) do
		    if v and G.hand.cards[i]:is_suit(k) then
			   have = true
			   break
			end
		 end
	  end
	  if not have then
	     mult = mult * self.extra
	     update_hand_text({delay = 0}, {mult = mult})
         card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X"..tostring(self.extra)..localize("b_mult"), colour = G.C.MULT}) 
	  end
   end
end

Soulss.j_hallucination.calculate = function(self,card,context)
    if context.using_consumeable and #G.consumeables.cards < G.consumeables.config.card_limit and pseudorandom("j_cartomancer") < G.GAME.probabilities.normal / self.extra and G.GAME.dollars-G.GAME.bankrupt_at - self.dollars >= 0 then
       ease_dollars(-self.dollars)
	   G.E_MANAGER:add_event(Event({
						func = function() 
							local _card = copy_card(context.consumeable, nil)
							_card:add_to_deck()
							G.consumeables:emplace(_card) 
							return true
						end}))
		card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
    end
end

Soulss.j_luchador.calculate = function(self,card,context)
	if context.after and context.cardarea == G.jokers and G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled and G.GAME.current_round.hands_played == 1 then
       G.GAME.blind:disable()
       card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
    end
end

Soulss.j_diet_cola.calculate = function(self,card,context)
     if context.selling_self and not context.from_diet then
	     card:calculate_joker{selling_self = true,from_diet = true}
		 card:remove_from_deck()
		 card.added_to_deck = true
	 end
end

Soulss.c_strength.calculate = function(self,card,context)
    if context.individual and context.cardarea == G.play and not context.end_of_round then
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				local card = context.other_card
				local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
				local rank_suffix = card.base.id == 14 and 2 or math.min(card.base.id+1, 14)
				if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
				elseif rank_suffix == 10 then rank_suffix = 'T'
				elseif rank_suffix == 11 then rank_suffix = 'J'
				elseif rank_suffix == 12 then rank_suffix = 'Q'
				elseif rank_suffix == 13 then rank_suffix = 'K'
				elseif rank_suffix == 14 then rank_suffix = 'A'
				end
				card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
			return true end }))
	    card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message ="+1"..localize("b_points"), colour = G.C.RED})
	end
end

Soulss.c_chariot.calculate = function(self,card,context)
    if context.individual and context.cardarea == G.hand and not context.end_of_round then
	   if context.other_card.debuff then
		  card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message = localize('k_debuffed')})
	   elseif context.other_card.config.center == G.P_CENTERS.m_steel then
	      mult = mult * self.extra
	      update_hand_text({delay = 0}, {mult = mult})
		  juice_card(card)
          card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message = "X"..self.extra..localize("b_mult"), colour = G.C.RED}) 	
      end	
   end		    
end

Soulss.c_heirophant.calculate = function(self,card,context)
    if context.individual and context.cardarea == G.play and not context.end_of_round then
	    if context.other_card.debuff then
		    card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message = localize('k_debuffed')})
		else
	      hand_chips = hand_chips + self.extra
	      update_hand_text({delay = 0}, {chips = hand_chips})
		  juice_card(card)
          card_eval_status_text(context.other_card,"chips",self.extra) 	
		end
	end
end

local new_roundref = new_round
function new_round()
    new_roundref()
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
			G.HUD_blind:recalculate() 
			G.hand_text_area.blind_chips:juice_up()
			play_sound('chips2')
            return true
        end
        }))
end

local add_to_deckref = Card.add_to_deck
function Card.add_to_deck(self, from_debuff)
   if not self.added_to_deck then
   
      if self.ability.name == "soul_crystal" then
	     if not next(self.ability.souls) then
		    local soul = create_soul(joker_soul,nil)
		    table.insert(self.ability.souls,soul)
	     end
	  end
	  
    if self.ability.name == "enhance_crystal" then
	     if not next(self.ability.souls) then
		    local soul = create_soul(enhance_soul,nil)
		    table.insert(self.ability.souls,soul)
	     end
	  end
     
	 souls_add(self)
   end
   add_to_deckref(self, from_debuff)
end

local remove_from_deckref = Card.remove_from_deck
function Card.remove_from_deck(self, from_debuff)
   if self.added_to_deck then
      souls_remove(self)
   end
   remove_from_deckref(self, from_debuff)
end

function souls_add(self)
    for k,v in pairs(self.ability.souls) do
        when_upgrade(self,v)
    end
end

function souls_remove(self)
   for k,v in pairs(self.ability.souls) do
       local obj = Soulss[v.tag]
	   if  obj.remove and type(obj.remove) == "function" then
		  obj.remove(v,self)
	   end
   end
end

Soulss.j_credit_card.remove = function(self,card)
   G.GAME.bankrupt_at = G.GAME.bankrupt_at + self.extra
end

Soulss.j_troubadour.remove = function(self,card)
    G.hand:change_size(-2)
	G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
	G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 1
end

Soulss.j_juggler.remove = function(self,card)
    G.hand:change_size(-self.extra)
end

Soulss.j_drunkard.remove = function(self,card)
    G.GAME.current_round.discards_left = G.GAME.current_round.discards_left - self.extra
	G.GAME.round_resets.discards = G.GAME.round_resets.discards - self.extra
end

Soulss.c_emperor.remove = function(self,card)
    G.consumeables.config.card_limit = G.consumeables.config.card_limit - self.extra
end

Soulss.c_judgement.remove = function(self,card)
    G.jokers.config.card_limit = G.jokers.config.card_limit - self.extra
end
function when_upgrade(self,soul)
    if self.ability.extra == "crystal" and soul.consumeable then return end
	if soul.tag == "enhance_soul_slot" then
       self.ability.soul_slots_max = self.ability.soul_slots_max + soul.extra
	end
	if soul.tag == "j_misprint" then
       self.ability.soul_slots_max = self.ability.soul_slots_max + 1
	end
	if soul.tag == "j_troubadour" then
	   G.hand:change_size(2)
	   G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
	   G.GAME.current_round.hands_left = G.GAME.current_round.hands_left - 1
	end
    if soul.tag == "j_credit_card" then  
	   G.GAME.bankrupt_at = G.GAME.bankrupt_at -  soul.extra
	end
    if soul.tag == "j_juggler" then
	   G.hand:change_size(soul.extra)
	end
    if soul.tag == "j_drunkard" then
	    G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + soul.extra
	    G.GAME.round_resets.discards = G.GAME.round_resets.discards + soul.extra
	end
	if soul.tag == "enhance_soul_mutation" then
	    soul_increasex(self,soul.extra)
	end
    if soul.tag == "enhance_soul_clear"  then
	   souls_remove(self)
	   self.ability.souls = {}
	   self:set_eternal(nil)
	   self:set_rental(nil)
	   self.ability.perishable = nil
	end
    if soul.tag == "enhance_soul_zhongliu"  then
	    self.added_to_deck = false
        self:add_to_deck()
	end
    if  soul.tag == "c_hermit" then
	    self.ability.extra_value = self.ability.extra_value + self.sell_cost* (soul.extra - 1)
        self:set_cost()
	end
    if soul.tag == "c_temperance" then
	    ease_dollars(self.sell_cost * soul.extra)
	end
    if soul.tag == "c_emperor" then
	    G.consumeables.config.card_limit = G.consumeables.config.card_limit + soul.extra
	end
	if soul.tag == "c_judgement" then
	    G.jokers.config.card_limit = G.jokers.config.card_limit + soul.extra
	end
end

function soul_increase(self,var)
    local table_extra = {"Xmult","dollars","emult","s_mult","chips","hand_add","chip_mod","increase","size","max","every","max","odds","faces","discards"}
	local notable_extra = {"extra","mult","x_mult","t_chips","t_mult"}
	if type(self.ability.extra) == "table" then
		for k,v in pairs(table_extra) do
			if self.ability.extra[v] and type(self.ability.extra[v]) == "number" and self.ability.extra[v] ~= 0 then 
				if v ~= "emult" then
					self.ability.extra[v] = self.ability.extra[v] + var
				 else
					self.ability.extra.mult = self.ability.extra.mult + var
				end
			end
		end	   
	end   
   for k,v in pairs(notable_extra) do 
	  if v ~= "x_mult" or (v == "x_mult" and self.ability[v] >= 2)  then
		 if self.ability[v] and type(self.ability[v]) == "number" and self.ability[v] ~= 0 then 
			 self.ability[v] = self.ability[v] + var
		 end
	  end
   end
end

function soul_increasex(self,var)
    local table_extra = {"Xmult","dollars","emult","s_mult","chips","hand_add","chip_mod","increase","size","max","every","max","odds","faces","discards"}
	local notable_extra = {"extra","mult","x_mult","t_chips","t_mult"}
	if type(self.ability.extra) == "table" then
		for k,v in pairs(table_extra) do
			if self.ability.extra[v] and type(self.ability.extra[v]) == "number" and self.ability.extra[v] ~= 0 then 
				if v ~= "emult" then
					self.ability.extra[v] = self.ability.extra[v] * var
				 else
					self.ability.extra.mult = self.ability.extra.mult * var
				end
			end
		end	   
	end   
   for k,v in pairs(notable_extra) do 
	  if v ~= "x_mult" or (v == "x_mult" and self.ability[v] >= 2)  then
		 if self.ability[v] and type(self.ability[v]) == "number" and self.ability[v] ~= 0 then 
			 self.ability[v] = self.ability[v] * var
		 end
	  end
   end
end


function Card:can_soul_break()
   if (G.play and #G.play.cards > 0) or
         (G.CONTROLLER.locked) or 
         (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) 
         then return false end
   if next(self.ability.souls) or self.ability.extra == "crystal" or self.ability.eternal and not find_soul(self,"j_enhance_soul_eternal") or  (G.GAME.dollars-G.GAME.bankrupt_at - G.P_CENTERS[self.config.center_key].rarity < 0) or soul_break_blacklist[self.config.center_key] then
      return false
   end
    return true
end

function Card:can_soul_upgrade()
   if (G.play and #G.play.cards > 0) or
         (G.CONTROLLER.locked) or 
         (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) 
         then return false end
   if self.ability.extra == "crystal"  then
	   return false
	end
   	for i=1,#G.jokers.cards do
	    if G.jokers.cards[i] == self then
		   if i == #G.jokers.cards then return false end
		   if G.jokers.cards[i+1].ability.extra ~= "crystal" then return false end
		   if #self.ability.souls >= self.ability.soul_slots_max then
		       if G.jokers.cards[i+1].ability.souls[1].level and not find_soul(G.jokers.cards[i],G.jokers.cards[i+1].ability.souls[1].tag) then
			       return false
			   end
		       if not G.jokers.cards[i+1].ability.souls[1].level and not G.jokers.cards[i+1].ability.souls[1].consumeable then
			       return false
			   end
		  end
		   if G.jokers.cards[i+1].ability.souls[1].sole and find_soul(G.jokers.cards[i],G.jokers.cards[i+1].ability.souls[1].tag) then return false end
	   end
	end
    return true
end

G.FUNCS.can_soul_break = function(e)
    if e.config.ref_table:can_soul_break() then 
        e.config.colour = G.C.BLUE
        e.config.button = 'soul_break'
    else
      	e.config.colour = G.C.UI.BACKGROUND_INACTIVE
      	e.config.button = nil
    end
end
  
 G.FUNCS.can_soul_upgrade= function(e)
    if e.config.ref_table:can_soul_upgrade() then 
        e.config.colour = G.C.PURPLE
        e.config.button = 'soul_upgrade'
    else
      	e.config.colour = G.C.UI.BACKGROUND_INACTIVE
      	e.config.button = nil
    end
end
  


G.FUNCS.soul_break = function(e)
    local card = e.config.ref_table
    card:soul_break()
end

G.FUNCS.soul_upgrade = function(e)
    local card = e.config.ref_table
    card:soul_upgrade()
end

function Card:soul_break()
	G.CONTROLLER.locks.selling_card = true
    stop_use()
    local area = self.area
    G.CONTROLLER:save_cardarea_focus('jokers')
    if self.children.use_button then self.children.use_button:remove(); self.children.use_button = nil end
    if self.children.sell_button then self.children.sell_button:remove(); self.children.sell_button = nil end
	ease_dollars(-G.P_CENTERS[self.config.center_key].rarity)
	self:start_dissolve()
	play_sound('glass1')
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                      play_sound('timpani')
                      local card = create_card('Joker', G.jokers, nil, nil, nil, nil,"j_soul_crystal",'soul_crystal')
					  local soul = create_soul(nil,self.config.center_key)
					  card.ability.souls[#card.ability.souls+1] = soul
					  card:add_to_deck()
                          G.jokers:emplace(card)
                          return true end }))
	G.CONTROLLER.locks.selling_card = nil
	G.CONTROLLER:recall_cardarea_focus('jokers')
end

function Card:soul_upgrade()	
	G.CONTROLLER.locks.selling_card = true
    stop_use()
    local area = self.area
    G.CONTROLLER:save_cardarea_focus('jokers')
    if self.children.soul_button then self.children.soul_button:remove(); self.children.soul_button = nil end
    if self.children.use_button then self.children.use_button:remove(); self.children.use_button = nil end
    if self.children.sell_button then self.children.sell_button:remove(); self.children.sell_button = nil end
	
	for i=1,#G.jokers.cards do
	   if G.jokers.cards[i] == self then
	       local soul = G.jokers.cards[i+1].ability.souls[1]
		   local same_soul = find_soul(self,soul.tag)
		   if same_soul and same_soul.level then
		       same_soul.level = same_soul.level + 1
		   elseif not soul.consumeable then
		       self.ability.souls[#self.ability.souls+1] = soul
		   end
		   when_upgrade(self,soul)
		   play_sound('coin1')
		   G.jokers.cards[i+1]:start_dissolve()
		   break
	   end
	end
	
	G.CONTROLLER.locks.selling_card = nil
	G.CONTROLLER:recall_cardarea_focus('jokers')
end

local highlightref = Card.highlight
function Card:highlight(is_higlighted)
    highlightref(self,is_higlighted)
    if self.ability.consumeable or self.ability.set == 'Joker' or (self.area and self.area == G.pack_cards) then
        if self.highlighted and self.area and self.area.config.type ~= 'shop' then
            self.children.soul_button = UIBox{
                definition = G.UIDEF.soul_buttons(self), 
                config = {align=
                        ((self.area == G.jokers) or (self.area == G.consumeables)) and "bm" or
                        "bmi"
                    , offset = 
                        ((self.area == G.jokers) or (self.area == G.consumeables)) and {x=0,y=-0.25} or
                        {x=0,y=0.65},
                    parent =self}
            }
        elseif self.children.soul_button then
            self.children.soul_button:remove()
            self.children.soul_button = nil
        end
    end
end

function G.UIDEF.soul_buttons(card)
    local soul_break = nil
    if card.area and card.area.config.type == 'joker' and card.ability.set == 'Joker' and  card.ability.extra ~= "crystal" then
		 if not next(card.ability.souls) then
		      local dolloars = G.P_CENTERS[card.config.center_key].rarity
			  soul_break = { n=G.UIT.ROOT, config = {ref_table = card, minw = 0.1, maxw = 1.3, padding = 0.1, align = 'bm', colour = G.C.BLUE, shadow = true, r = 0.08, minh = 0.6, one_press = false, button = 'soul_break', func = "can_soul_break", hover = true}, nodes={
                    {n=G.UIT.T, config={text = "$"..dolloars..localize('b_break'),colour = G.C.WHITE, scale = 0.4}}
              }}
	    end
	end
	local t = {
      n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
          {n=G.UIT.R, config={align = 'cl'}, nodes={
          }},
        }},
    }}
    return soul_break or t
end

local use_and_sell_buttonsref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
   local retval = use_and_sell_buttonsref(card)
   if card.area and card.area.config.type == 'joker' and card.ability.set == 'Joker' and  card.ability.extra ~= "crystal" then
	  local soul_upgrade = {
			  n=G.UIT.C, config={align = "cr"}, nodes={
				  {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.PURPLE, one_press = true, button = 'soul_upgrade', func = 'can_soul_upgrade'}, nodes={
					  {n=G.UIT.B, config = {w=0.1,h=0.6}},
					  {n=G.UIT.C, config={align = "tm"}, nodes={
						  {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
							  {n=G.UIT.T, config={text = localize('b_upgrade'), colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
						  }},
						 
					  }}
				  }}
			  }
		  }
		  retval.nodes[1].nodes[3]={n=G.UIT.R, config={align = 'cl'}, nodes={
          }}
		  table.insert(retval.nodes[1].nodes[3].nodes, soul_upgrade)
		  
   end
   return retval
end
  
local set_abilityref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    set_abilityref(self,center, initial, delay_sprites)
    self.ability.soul_slots_max = G.GAME.soul_slots_max
    self.ability.souls={}
end

local init_game_objectref = Game.init_game_object
function Game:init_game_object()
    local t = init_game_objectref(self)
	t["soul_consumeable_usage"] = {}
	t["soul_slots_max"] = 2
	return t
end

function find_soul(card,soul)
   for k,v in pairs(card.ability.souls) do
      if v.tag == soul then
          return v
      end
   end
   return false
end

function Card:is_face(from_boss)
    if self.debuff and not from_boss then return end
    local id = self:get_id()
          if 1 then
            return true
    end
end


function create_soul(area,tag)
	local soul = nil
	if not area then
		if joker_soul[tag] and not joker_soul[tag].banned then
			soul = joker_soul[tag]
		elseif consumeable_soul[tag] and not consumeable_soul[tag].banned then
			soul = consumeable_soul[tag]
		elseif enhance_soul[tag] and not enhance_soul[tag].banned then
			soul = enhance_soul[tag]
		else 
		    local rarity = {"common_soul","uncommon_soul","rare_soul","legendary_soul"}
			soul = rarity_soul[rarity[G.P_CENTERS[tag].rarity]] or rarity_soul[rarity[4]]
		end
	end
    if area then
	    local area_ = {}
		for k, v in pairs(area) do
		    if not v.banned then
		        area_[k] = v
			end
		end
		soul = pseudorandom_element(area_, pseudoseed('create_soul'))
	end
    return copy_table(soul)
end

function soul_text_transform(soul)
    local tag = soul.tag
    if joker_soul[tag] or consumeable_soul[tag] then
          return localize{type = 'name_text', key = tag, set = G.P_CENTERS[tag].set}.."之魂"
    elseif enhance_soul[tag] then
       return enhance_soul[tag].name
    elseif rarity_soul[tag] then
       return rarity_soul[tag].name
	end
end

local use_consumeableref = Card.use_consumeable
function Card:use_consumeable(area, copier)
	use_consumeableref(self,area,copier)
	local o = consumeable_soul[self.config.center_key]
	local usage = o and (o.usage - 1) or 2
	if G.GAME.soul_consumeable_usage[self.config.center_key] ==  usage then
	    if #G.jokers.cards < G.jokers.config.card_limit then
	        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
				local card = {}
				if o then
                    card = create_card('Joker', G.jokers, nil, nil, nil, nil,"j_soul_crystal",'soul_crystal')
					local soul = create_soul(nil,self.config.center_key)
			        card.ability.souls[#card.ability.souls+1] = soul
			    else
				    card = create_card('Joker', G.jokers, nil, nil, nil, nil,"j_enhance_crystal",'enhance_crystal')
				end
				card:add_to_deck()
                G.jokers:emplace(card)
                    return true end }))
	            G.GAME.soul_consumeable_usage[self.config.center_key] = 0
		 else
		     card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_no_room_ex')})
		 end
    else
	     G.GAME.soul_consumeable_usage[self.config.center_key] =  (G.GAME.soul_consumeable_usage[self.config.center_key] or 0) + 1
    end
end

local generate_UIBox_ability_table_ref = Card.generate_UIBox_ability_table
function Card.generate_UIBox_ability_table(self)
   local generate_UIBox_ability_table_val = generate_UIBox_ability_table_ref(self)
   local main_text = generate_UIBox_ability_table_val.main		
   local info = generate_UIBox_ability_table_val.info

   if not(soul_info_indicate and soul_info_indicate == 1)then
       local souls = self.ability.souls 
       local souls_tag = {}
	   for k, v in pairs(self.ability.souls) do
	       souls_tag[v.tag] = false
	   end
       if not(soul_info_indicater and soul_info_indicater == 1 ) then
		   for k, v in pairs(self.ability.souls) do
			   if not souls_tag[v.tag] and G.localization.descriptions.Other[v.tag] then
				   souls_tag[v.tag] = true
				   info[#info + 1] = {}
				   local desc_nodes = info[#info]
				   local loc_vars = soul_vars(v)
				   localize{type = 'other', key = v.tag, nodes = desc_nodes,vars = loc_vars}
				   desc_nodes.name = G.localization.descriptions.Other[v.tag].name
			   end 
		   end
	   end
		  if #self.ability.souls > 0 then
			main_text[#main_text + 1] = {
				{
					n = G.UIT.T,
					config = {
						text = localize('b_soul').."("..tostring(#self.ability.souls).."/"..tostring(self.ability.soul_slots_max)..")",
						colour = G.C.BLUE,
						scale = 0.24
					}
				},
			}
		  end
			for i = 1, #self.ability.souls do
			  main_text[#main_text + 1] = {
			   {
					n = G.UIT.T,
					config = {
						text = soul_text_transform(self.ability.souls[i]),
						colour = G.C.PURPLE,
						scale = 0.24
					}
				}
			}
		end
    end
    return generate_UIBox_ability_table_val
end


-- local key_hold_updateref=Controller.key_hold_update
-- function Controller:key_hold_update(key, dt)
    -- key_hold_updateref(self,key, dt)
    -- if self.held_key_times[key] then
        -- if key == "lctrl" and not G.SETTINGS.paused then
            -- if self.held_key_times[key] > 0.5 then
			  -- soul_info_indicate=true
            -- else
                -- self.held_key_times[key] = self.held_key_times[key] + dt
            -- end
        -- end
    -- end
-- end

-- local key_release_updateref=Controller.key_release_update
-- function Controller:key_release_update(key, dt)
    -- key_release_updateref(self,key, dt)
    -- if key == 'lctrl' then
    -- soul_info_indicate=-soul_info_indicate or -1
    -- end
-- end

local controller_key_press_update_ref = Controller.key_press_update
function Controller:key_press_update(key, dt)
   controller_key_press_update_ref(self, key, dt)
   if key=="lctrl" then
	  soul_info_indicate = soul_info_indicate and -soul_info_indicate or 1
   end
   if key=="rctrl" then
	  soul_info_indicater = soul_info_indicater and -soul_info_indicater or 1
   end
end

G.FUNCS.your_collection_souls = function(e)
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu{
    definition = create_UIBox_your_collection_souls(),
  }
end

function create_UIBox_your_collection_souls()
  local deck_tables = {}
  G.your_collection = {}
  for j = 1, 3 do
    G.your_collection[j] = CardArea(
      G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
      5*G.CARD_W,
      0.95*G.CARD_H, 
      {card_limit = 5, type = 'title', highlight_limit = 0, collection = true})
    table.insert(deck_tables, 
    {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
      {n=G.UIT.O, config={object = G.your_collection[j]}}
    }}
    )
  end

  local soul_options = {}
  for i = 1, math.ceil(#souls/(5*#G.your_collection)) do
    table.insert(soul_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#souls/(5*#G.your_collection))))
  end
  for i = 1, 5 do
    for j = 1, #G.your_collection do
      local center = G.P_CENTERS["j_soul_crystal"]
      local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, nil, center)
      table.insert(card.ability.souls,souls[i+(j-1)*5])
      G.your_collection[j]:emplace(card)
	end
  end

  INIT_COLLECTION_CARD_ALERTS()
  
  local t =  create_UIBox_generic_options({ back_func = 'your_collection', contents = {
        {n=G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables}, 
        {n=G.UIT.R, config={align = "cm"}, nodes={
          create_option_cycle({options = soul_options, w = 4.5, cycle_shoulders = true, opt_callback = 'your_collection_souls_page', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
        }}
    }})
  return t
end

G.FUNCS.your_collection_souls_page = function(args)
  if not args or not args.cycle_config then return end
  for j = 1, #G.your_collection do
    for i = #G.your_collection[j].cards,1, -1 do
      local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
      c:remove()
      c = nil
    end
  end
  for i = 1, 5 do
    for j = 1, #G.your_collection do
	  local soul = souls[i+(j-1)*5 + (5*#G.your_collection*(args.cycle_config.current_option - 1))]
	  if not soul then break end
      local center = string.sub(soul.tag,1,7) ~= "enhance" and G.P_CENTERS["j_soul_crystal"] or G.P_CENTERS["j_enhance_crystal"]
      if not center then break end
      local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
      table.insert(card.ability.souls,soul)
      G.your_collection[j]:emplace(card)
    end
  end
  INIT_COLLECTION_CARD_ALERTS()
end