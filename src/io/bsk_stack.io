BSKStack := Object clone do(
  data := List clone
  whiteRatio := 0.3
  blueRatio := 0.4

  zones := method(
    n := data size
    w := n * self whiteRatio asInteger
    b := n * (self whiteRatio + self blueRatio) asInteger
    return List with(w,b)
  )

  push := method(v, data append(List with("W", v) at(0)) )

  pop := method(
    if(data size == 0, Exception raise("empty"))
    z := self zones
    w := z at(0); b := z at(1)
    i := 0
    while(i < w,
      if(data at(i) at(0) == "W" or data at(i) at(0) == "B",
        v := data at(i) at(1)
        data removeAt(i)
        return v
      )
      i = i + 1
    )
    i = w
    while(i < b,
      if(data at(i) at(0) == "B",
        v := data at(i) at(1)
        data removeAt(i)
        return v
      )
      i = i + 1
    )
    Exception raise("Red zone locked")
  )

  updateColors := method(
    z := self zones
    w := z at(0); b := z at(1)
    i := 0
    while(i < data size,
      if(i < w, data at(i) atPut(0, "W"),
        if(i < b, data at(i) atPut(0, "B"), data at(i) atPut(0, "R"))
      )
      i = i + 1
    )
  )
)
