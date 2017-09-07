return {
   read           = 111, -- MSP_RC_TUNING
   write          = 204, -- MSP_SET_RC_TUNING
   title          = "Rates (1/2)",
   reboot         = false,
   eepromWrite    = true,
   postRead       = postReadRates,
   getWriteValues = getWriteValuesRates,
   text = {
      { t = "RC",       x = 43,  y = 11, to = SMLSIZE },
      { t = "Rate",     x = 38,  y = 18, to = SMLSIZE },
      { t = "Super",    x = 63,  y = 11, to = SMLSIZE },
      { t = "Rate",     x = 66,  y = 18, to = SMLSIZE },
      { t = "RC",       x = 99,  y = 11, to = SMLSIZE },
      { t = "Expo",     x = 94,  y = 18, to = SMLSIZE },
      { t = "Throttle", x = 126, y = 18, to = SMLSIZE },
      { t = "Mid",      x = 126, y = 31, to = SMLSIZE },
      { t = "Exp",      x = 126, y = 46, to = SMLSIZE },
      { t = "TPA",      x = 186, y = 18, to = SMLSIZE },
      { t = "Thr",      x = 168, y = 31, to = SMLSIZE },
      { t = "Brk",      x = 168, y = 46, to = SMLSIZE },         
      { t = "ROLL",     x = 8,   y = 26, to = SMLSIZE },
      { t = "PITCH",    x = 8,   y = 36, to = SMLSIZE },
      { t = "YAW",      x = 8,   y = 46, to = SMLSIZE },
   },
   fields = {
      -- RC Rate
      { x = 39,   y = 31,  i = 1 }, 
      { x = 39,   y = 46,  i = 12 },
      -- Super Rate
      { x = 71,   y = 26,  i = 3 },
      { x = 71,   y = 36,  i = 4 },
      { x = 71,   y = 46,  i = 5 },
      -- RC Expo
      { x = 99,   y = 31,  i = 2 },
      { x = 99,   y = 46,  i = 11 },
      -- Throttle Expo
      { x = 144,  y = 31,  i = 7 },
      { x = 144,  y = 46,  i = 8 },  
      -- TPA
      { x = 186,  y = 31,  i = 6, min = 0, max = 100 },
      { x = 186,  y = 46,  i = 9, min = 1000, max = 2000 },                  
   },
}