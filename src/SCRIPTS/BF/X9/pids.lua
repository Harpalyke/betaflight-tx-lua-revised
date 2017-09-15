
return {
   read           = 112, -- MSP_PID
   write          = 202, -- MSP_SET_PID
   title          = "PIDs",
   reboot         = false,
   eepromWrite    = true,
   minBytes       = 8,
   text = {
      { t = "P",      x =  70,  y = 14 },
      { t = "I",      x =  98,  y = 14 },
      { t = "D",      x = 126,  y = 14 },
      { t = "ROLL",   x =  25,  y = 26 },
      { t = "PITCH",  x =  25,  y = 36 },
      { t = "YAW",    x =  25,  y = 46 },
   },
   fields = {
      -- P
      { x =  66, y = 26, min = 0, max = 200, vals = { 1 } },
      { x =  66, y = 36, min = 0, max = 200, vals = { 4 } },
      { x =  66, y = 46, min = 0, max = 200, vals = { 7 } },
      -- I
      { x =  94, y = 26, min = 0, max = 200, vals = { 2 } },
      { x =  94, y = 36, min = 0, max = 200, vals = { 5 } },
      { x =  94, y = 46, min = 0, max = 200, vals = { 8 } },
      -- D
      { x = 122, y = 26, min = 0, max = 200, vals = { 3 } },
      { x = 122, y = 36, min = 0, max = 200, vals = { 6 } },
      --{ x = 122, y = 46, i =  9 },
   },
}