require "dp"
require "rnn"
require "csvigo"


inputCSV = csvigo.load{path="input.csv",header=false}.var_1
targetCSV = csvigo.load{path="output.csv",header=false}.var_1

inputs = torch.FloatTensor(10000,104)
targets = torch.FloatTensor(10000,16)

function readString(inputString)
   input = _.map(_.split(inputString, ','), function(k,v) 
      v = v:gsub('"','')
      --print(v)
      v = tonumber(v)
      --print(v)
      return v
   end)
   table.remove(input, 1)
   return torch.FloatTensor(input)
end

for i,inputString in ipairs(inputCSV) do
   inputs[i]:copy(readString(inputString))
   targets[i]:copy(readString(targetCSV[i]))
   collectgarbage()
end
