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

function action(policy::NNPolicy, obs)
  pomdp = policy.problem

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

function POMDPs.action(policy::NNPolicy, belief::SparseCat)
  # println(belief)
  pomdp = policy.problem

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

  return choice
end

function take_action(pomdp, act)
  rew = pomdp_class.s_a_reward(pomdp, pomdp.cur_state, act)
  # if !(act in pomdp.been_visited)
  #   push!(pomdp.been_visited, act)
  # end
  # pomdp.previous_state = copy(pomdp.cur_state)
  # pomdp.cur_state = act
  # pomdp.actions = pomdp.ACTION_SET[act]
  t = (pomdp.c1_spot in pomdp.been_visited && pomdp.c2_spot in pomdp.been_visited)
  return rew, t
end
