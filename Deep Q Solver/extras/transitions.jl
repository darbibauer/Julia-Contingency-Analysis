function transition_probability()
  P1 = Random.rand()
  P2 = Random.rand()
  c = Random.rand()

  if P1 > P2
    if c > .5
      a = c
      b = 1 - a
    else
      b = c
      a = 1- b
    end

  else
    if c > .5
      b = c
      a = 1 - b
    else
      a = c
      b = 1 - a
    end
  end

  return (a * P1) + (b * P2)
end
