# TeeworldsServer = require 'teeworlds-info'
{ parseArgs, changed, failed } = require './utils'

args = parseArgs process.argv[2]
failed 'Can\'t parse arguments' if !args

changed args
