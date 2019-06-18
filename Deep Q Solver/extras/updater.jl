import POMDPs

struct HistoryUpdater <: Updater
    pomdp::PowerGridEnv
end

initialize_belief(up::HistoryUpdater, d) = Any[d]

function POMDPs.update(up::HistoryUpdater, b, a, o)
    up.pomdp.previous_state = up.pomdp.cur_state
    up.pomdp.cur_state = a
    up.pomdp.actions = up.pomdp.ACTION_SET[a]
    # pomdp_class.take_action(up.pomdp, a)
    return SparseCat(up.pomdp.ACTION_SET[up.pomdp.cur_state], pomdp_class.potential_rewards(up.pomdp, up.pomdp.cur_state))
    # return SparseCat([a], [1.0])
end
