function potential_actions(pomdp)
  return pomdp.actions
end

function num_actions(pomdp)
  return length(pomdp.ACTION_SET)
end

function num_actions(pomdp, s)
  return length(pomdp.actions)
end

function actions(pomdp)
  return [x for x in keys(pomdp.ACTION_SET)]
end

function action(policy::NNPolicy, obs::Bool)
  pomdp = policy.problem

  # choice = pomdp.actions[argmax(obs)]
  choice = pomdp.actions[argmax(obs)]

  if choice in pomdp.been_visited
      for i in 1:length(pomdp.actions)
          if !(pomdp.actions[i] in pomdp.been_visited)
              choice = pomdp.actions[i]
              found = true
              break
          end
      end
  end

  if !(choice in pomdp.been_visited)
      push!(pomdp.been_visited, choice)
  end

  return choice
end

function POMDPs.action(policy, belief::SparseCat)
  pomdp = policy.problem

  # println(argmax(belief.probs))
  # println(belief.vals)

  choice = belief.vals[argmax(belief.probs)]

  if choice in pomdp.been_visited
      for i in 1:length(pomdp.actions)
          if !(pomdp.actions[i] in pomdp.been_visited)
              choice = pomdp.actions[i]
              found = true
              break
          end
      end
  end

  if !(choice in pomdp.been_visited)
      push!(pomdp.been_visited, choice)
  end
  return choice, nothing
end

function take_action(pomdp, act)
  rew = pomdp_class.s_a_reward(pomdp, pomdp.cur_state, act)
  t = (pomdp.c1_spot in pomdp.been_visited && pomdp.c2_spot in pomdp.been_visited)
  return rew, t
end

# function Base.iterate(h::SimHistory, i::Int)
#
# end
