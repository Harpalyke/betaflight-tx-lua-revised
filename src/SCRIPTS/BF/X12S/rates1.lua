return {
   read           = 111, -- MSP_RC_TUNING
   write          = 204, -- MSP_SET_RC_TUNING
   title          = "Rates (1/2)",
   reboot         = false,
   eepromWrite    = true,
   minBytes       = 12,
   text = {
      { t = "RC",       x = 100,  y = 55, to = SMLSIZE },
      { t = "Rate",     x = 94,  y = 70, to = SMLSIZE },
      { t = "Super",    x = 151,  y = 55, to = SMLSIZE },
      { t = "Rate",     x = 155,  y = 70, to = SMLSIZE },
      { t = "RC",       x = 210,  y = 55, to = SMLSIZE },
      { t = "Expo",     x = 203,  y = 70, to = SMLSIZE },
      { t = "Throttle", x = 280, y = 70, to = SMLSIZE },
      { t = "Mid",      x = 280, y = 104, to = SMLSIZE },
      { t = "Exp",      x = 280, y = 132, to = SMLSIZE },
      { t = "TPA",      x = 360, y = 70, to = SMLSIZE },
      { t = "Thr",      x = 360, y = 104, to = SMLSIZE },
      { t = "Brk",      x = 360, y = 132, to = SMLSIZE },         
      { t = "ROLL",     x = 35,   y = 104, to = SMLSIZE },
      { t = "PITCH",    x = 35,   y = 132, to = SMLSIZE },
      { t = "YAW",      x = 35,   y = 160, to = SMLSIZE },
   },
   fields = {
      { x = 100,   y = 118,  vals = { 1 },  min = 0, max = 255, scale = 100, to = SMLSIZE }, 
      { x = 100,   y = 160,  vals = { 12 }, min = 0, max = 255, scale = 100, to = SMLSIZE },
      { x = 155,   y = 104,  vals = { 3 },  min = 0, max = 100, scale = 100, to = SMLSIZE },
      { x = 155,   y = 132,  vals = { 4 },  min = 0, max = 100, scale = 100, to = SMLSIZE },
      { x = 155,   y = 160,  vals = { 5 },  min = 0, max = 255, scale = 100, to = SMLSIZE },
      { x = 210,   y = 118,  vals = { 2 },  min = 0, max = 100, scale = 100, to = SMLSIZE },
      { x = 210,   y = 160,  vals = { 11 }, min = 0, max = 100, scale = 100, to = SMLSIZE },
      { x = 320,  y = 104,  vals = { 7 },  min = 0, max = 100, scale = 100, to = SMLSIZE },
      { x = 320,  y = 132,  vals = { 8 },  min = 0, max = 100, scale = 100, to = SMLSIZE },  
      { x = 400,  y = 104,  vals = { 6 } , min = 0, max = 100, scale = 100, to = SMLSIZE },
      { x = 400,  y = 132,  vals = { 9, 10 }, min = 1000, max = 2000, to = SMLSIZE },                  
   },
}