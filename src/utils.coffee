fs = require 'fs'

module.exports.parseArgs = (argsPath) ->
  try
    argsFile = fs.readFileSync argsPath, { encoding: 'utf8' }
  catch err
    return null

  args = {}
  re = /([^=]+)="'?([^"']+)'?" /g
  while null != match = re.exec(argsFile)
    args[match[1]] = match[2]
  return args

module.exports.changed = (msg) ->
  res = {
    changed: true
    msg: msg
  }
  console.log JSON.stringify(res)
  process.exit 0

module.exports.failed = (msg) ->
  res = {
    failed: true
    msg: msg
  }
  console.log JSON.stringify(res)
  process.exit 1
