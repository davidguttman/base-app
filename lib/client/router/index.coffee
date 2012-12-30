module.exports = 
  '/': ->
    console.log '@target', @target
    @target.html 'loaded /'