--
-- MSP/SPORT code
--

-- Protocol version
MSP_VERSION = bit32.lshift(1,5)

MSP_STARTFLAG = bit32.lshift(1,4)

-- Sensor ID used by the local LUA script
LOCAL_SENSOR_ID  = 0x0D

-- Sensor ID used by the MSP server (BF, CF, MW, etc...)
REMOTE_SENSOR_ID = 0x1B

REQUEST_FRAME_ID = 0x27
REPLY_FRAME_ID   = REQUEST_FRAME_ID

PAYLOAD_SIZE = 30

-- Sequence number for next MSP packet
local mspSeq = 0
local mspRemoteSeq = 0

local mspRxBuf = {}
local mspRxIdx = 1
local mspRxCRC = 0
local mspStarted = false
local mspLastReq = 0

-- Stats
mspRequestsSent    = 0
mspRepliesReceived = 0
mspPkRxed = 0
mspErrorPk = 0
mspStartPk = 0
mspOutOfOrder = 0
mspCRCErrors = 0
mspPendingRequest = false

local function mspResetStats()
   mspRequestsSent    = 0
   mspRepliesReceived = 0
   mspPkRxed = 0
   mspErrorPk = 0
   mspStartPk = 0
   mspOutOfOrderPk = 0
   mspCRCErrors = 0
end

local mspTxBuf = {}
local mspTxIdx = 1
local mspTxCRC = 0

local mspTxPk = 0

local function mspSendCrossfire(payload)

   payloadOut = { REMOTE_SENSOR_ID, LOCAL_SENSOR_ID }

   for i=1; #(payload) do
      payloadOut[i+2] = payload[math.abs(#(payload)-i)+1]
   end

   crossfireTelemetryPush(REQUEST_FRAME_ID, payloadOut)
   mspTxPk = mspTxPk + 1

end

function mspProcessTxQ()

   if (#(mspTxBuf) == 0) then
      return false
   end

   if not crossfireTelemetryPush() then
      return true
   end

   local payload = {}
   payload[1] = mspSeq + MSP_VERSION
   mspSeq = bit32.band(mspSeq + 1, 0x0F)

   if mspTxIdx == 1 then
      -- start flag
      payload[1] = payload[1] + MSP_STARTFLAG
   end

   local i = 2
   while (i <= PAYLOAD_SIZE) do
      if mspTxIdx > #(mspTxBuf) then
         break
      end
      payload[i] = mspTxBuf[mspTxIdx]
      mspTxIdx = mspTxIdx + 1
      mspTxCRC = bit32.bxor(mspTxCRC,payload[i])  
      i = i + 1
   end

   if i <= PAYLOAD_SIZE then
      payload[i] = mspTxCRC
      i = i + 1

      -- zero fill
      while i <= PAYLOAD_SIZE do
         payload[i] = 0
         i = i + 1
      end

      mspSendCrossfire(payload)
      
      mspTxBuf = {}
      mspTxIdx = 1
      mspTxCRC = 0
      
      return false
   end
      
   mspSendCrossfire(payload)
   return true
end

function mspSendRequest(cmd,payload)

   -- busy
   if #(mspTxBuf) ~= 0 then
      return nil
   end

   mspTxBuf[1] = #(payload)
   mspTxBuf[2] = bit32.band(cmd,0xFF)  -- MSP command

   for i=1,#(payload) do
      mspTxBuf[i+2] = bit32.band(payload[i],0xFF)
   end

   mspLastReq = cmd
   mspRequestsSent = mspRequestsSent + 1
   return mspProcessTxQ()
end

local function mspReceivedReply(payload)

   mspPkRxed = mspPkRxed + 1
   
   local idx      = 1
   local head     = payload[idx]
   local err_flag = (bit32.band(head,0x20) ~= 0)
   idx = idx + 1

   if err_flag then
      -- error flag set
      mspStarted = false

      mspErrorPk = mspErrorPk + 1

      -- return error
      -- CRC checking missing

      --return payload[idx]
      return nil
   end
   
   local start = (bit32.band(head,0x10) ~= 0)
   local seq   = bit32.band(head,0x0F)

   if start then
      -- start flag set
      mspRxIdx = 1
      mspRxBuf = {}

      mspRxSize = payload[idx]
      mspRxCRC  = bit32.bxor(mspRxSize,mspLastReq)
      idx = idx + 1
      mspStarted = true
      
      mspStartPk = mspStartPk + 1

   elseif not mspStarted then
      mspOutOfOrder = mspOutOfOrder + 1
      return nil

   elseif bit32.band(mspRemoteSeq + 1, 0x0F) ~= seq then
      mspOutOfOrder = mspOutOfOrder + 1
      mspStarted = false
      return nil
   end

   while (idx <= PAYLOAD_SIZE) and (mspRxIdx <= mspRxSize) do
      mspRxBuf[mspRxIdx] = payload[idx]
      mspRxCRC = bit32.bxor(mspRxCRC,payload[idx])
      mspRxIdx = mspRxIdx + 1
      idx = idx + 1
   end

   if idx > PAYLOAD_SIZE then
      mspRemoteSeq = seq
      return true
   end

   -- check CRC
   if mspRxCRC ~= payload[idx] then
      mspStarted = false
      mspCRCErrors = mspCRCErrors + 1
      return nil
   end

   mspRepliesReceived = mspRepliesReceived + 1
   mspStarted = false
   return mspRxBuf
end

function mspPollReply()
   while true do
      local command, data = crossfireTelemetryPop()
      if command == REPLY_FRAME_ID then
         local ret = mspReceivedReply(data)
         if type(ret) == "table" then
            return mspLastReq,ret
         end
      else
         break
      end
   end

   return nil
end

--
-- End of MSP/SPORT code
--
