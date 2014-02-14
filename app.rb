require 'sinatra'
require 'haml'

require './langbar'

get '/' do
  haml :index
end

post '/generate' do
  redirect "#{params[:user]}/#{params[:repo]}.png?500x12"
end

get '/:user/:repo.png' do
  content_type 'image/png'

  width, height = request.query_string.split(/x/i).map(&:to_i)

  width  ||= 500
  height ||=  12

  if width * height <= 10000
    langbar(params[:user], params[:repo], width, height).to_s
  end
end
