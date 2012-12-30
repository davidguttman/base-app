fs              = require 'fs'
browserify      = require 'browserify'
simpleJadeify   = require 'simple-jadeify'

{version}       = require '../../package.json'

opts = {}
  
if process.env.NODE_ENV is 'development'
  opts.debug = true 

if process.env.NODE_ENV is 'production'
  opts.filter = (require 'uglify-js')

bundle = browserify opts

bundle.prepend "window.VERSION = '#{version}';"

bundle.use simpleJadeify

includes = [
  'jquery.min.js'
]

preBlock = []

for js in includes
  preBlock.push ";"
  preBlock.push "\n// File: #{js} \n"
  preBlock.push fs.readFileSync "./lib/client/vendor/#{js}"

bundle.prepend preBlock.join "\n"

bundle.addEntry './lib/client/entry.coffee'

bundle.prepend 'window.t0 = Date.now();'
bundle.append 'window.t1 = Date.now();'

fs.writeFileSync './public/browserify.js', bundle.bundle()

module.exports = bundle