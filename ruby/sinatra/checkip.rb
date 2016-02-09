require 'sinatra'

get '/' do
  erb :index
end

private

# Note: Sinatra/Rack built in Request object's 'ip' method does basically the same thing.
# But because it has code to deal with IP address spoofing, it doesn't quite do what
# was required.  So we have this simpler method.
def ip
  forwarded_ips = @env['HTTP_X_FORWARDED_FOR'] ? @env['HTTP_X_FORWARDED_FOR'].strip.split(/[,\s]+/) : []
  @env['Client-IP'] || forwarded_ips.last || @env["REMOTE_ADDR"]
end

__END__

@@ layout
<html>
  <head>
    <title>Current IP Check</title>
  </head>
  <body>
    <%= yield %>
  </body>
</html>

@@ index
  <p>Current Internet Protocol Address: <%= ip %></p>
