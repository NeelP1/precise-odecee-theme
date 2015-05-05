require 'coffee-script/register'

fs = require 'fs'
marked     = require 'marked'
Handlebars = require 'handlebars'

Handlebars.registerHelper 'md', marked

Handlebars.registerHelper 'logo', (text) ->
  return 'fa-github-square'   if text.toLowerCase() == 'github'
  return 'fa-twitter-square'  if text.toLowerCase() == 'twitter'
  return 'fa-envelope-square' if text.toLowerCase() == 'email'
  return 'fa-linkedin-square' if text.toLowerCase() == 'linkedin'
  return 'fa-bitbucket-square' if text.toLowerCase() == 'bitbucket'

Handlebars.registerHelper 'truncate', (str, len) ->
  if str && str.length > len
    new Handlebars.SafeString(str.substring(0, len-3).concat('...'))
  else
    str

renderProfile   = (profile)   -> render 'profile',   profile
renderPortfolio = (portfolio) -> render 'portfolio', portfolio

render= (name, model) ->
  css = fs.readFileSync "#{__dirname}/style.css", 'utf-8'
  template = fs.readFileSync "#{__dirname}/#{name}.template", 'utf-8'
  options = css: css
  options[name] = model
  Handlebars.compile(template)(options)

module.exports =
  renderProfile:   renderProfile
  renderPortfolio: renderPortfolio
