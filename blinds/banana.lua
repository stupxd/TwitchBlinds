local REPLACE_ODDS = 6

local tw_blind = SMODS.Blind {
    key = 'twbl_banana',
    loc_txt = {
        ['en-us'] = {
            name = 'The Banana',
            text = { '#1# in #2# chance to replace', 'Joker with Gros Michel' }
        }
    },
    dollars = 5,
    mult = 2,
    boss = {
        min = 40,
        max = 40
    },
    config = { extra = { odds = REPLACE_ODDS } },
    vars = { '' .. (G.GAME and G.GAME.probabilities.normal or 1), REPLACE_ODDS },
    pos = { x = 0, y = 1 },
    atlas = 'twbl_blind_chips',
    boss_colour = HEX('8e15ad'),
}
table.insert(TWITCH_BLINDS.BLINDS, 'bl_twbl_banana');

function tw_blind:set_blind()
    local _first_dissolve = nil
    for k, v in ipairs(G.jokers.cards) do
        if pseudorandom(pseudoseed('twbl_banana')) < G.GAME.probabilities.normal / self.config.extra.odds then
            G.GAME.blind:wiggle()
            v:start_dissolve(nil, _first_dissolve)
            _first_dissolve = true
            local card = create_card('Joker', G.jokers, false, nil, nil, nil, 'j_gros_michel', nil)
            card:add_to_deck()
            G.jokers:emplace(card)
        end
    end
end