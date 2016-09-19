TeeworldsEcon = require 'teeworlds-econ'
{ parseArgs, changed, failed } = require './utils'

args = parseArgs process.argv[2]
failed 'Can\'t parse arguments' if !args

failed 'Undefined command' if !args.command
failed 'Undefined host' if !args.host
failed 'Undefined port' if !args.port
failed 'Undefined password' if !args.password

econ = new TeeworldsEcon args.host, args.port, args.password

econ.on 'online', () ->
  econ.exec(args.command).then (result) ->
    changed result
    econ.disconnect()
  .catch (err) ->
    failed err.message
    econ.disconnect()

econ.connect { retryCount: 0 }
