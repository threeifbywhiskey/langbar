require 'oily_png'
require 'open-uri'

def langbar user, repo, width, height
  html = open("https://github.com/#{user}/#{repo}").read

  stats = html.scan(/width:(.+?)%.+?color:(.+?);/).map do |percent, color|
   [width * percent.to_f / 100, ChunkyPNG::Color.from_hex(color)]
  end

  off = 0
  bar = ChunkyPNG::Canvas.new width, height, stats[-1][1]

  stats.reduce(bar) do |bar, (width, color)|
    bar.rect off, 0, off += width.to_i, height - 1, color, color
  end
end
