require 'erb'

#
# Implements RACK based http server, which is used to serve the recently
# received emails through the mailtrap smtp server.
#
module Mailtrap
  class Mail

    def initialize(p_from, p_recipient_list, p_message)
      @m_from = p_from
      @m_recipient_list = p_recipient_list
      @m_message = p_message
      @m_created_at = Time.now
    end

    def from
      return @m_from
    end

    def recipient_list
      @m_recipient_list
    end

    def message
      @m_message
    end

    def created_at
      @m_created_at
    end
  end

  class MailBoxService

    def initialize(p_http_host, p_http_port, p_headers = {})
      @m_host = p_http_host
      @m_port = p_http_port
      @m_headers = {"Content-type" => "text/html"}.merge(p_headers);
      @m_mails = []
    end

    #
    # Start rack service
    #
    def start
      Rack::Handler::WEBrick.run(method(:dispatch), :Port => @m_port, :Host => @m_host)
    end

    def add_mail(p_mail)
      @m_mails << p_mail
    end

    def mails
      @m_mails
    end

    #
    # Default request handler
    #
    def dispatch(p_environment)
      return [200, @m_headers, render_html]
    end

    private
      def render_html
        template = ERB.new <<-EOF

<html>
  <head>
    <title>mail inbox</title>
  </head>

<style type='text/css'>
body {
  font-size: 10px;
}
.message-body {
  position: fixed;
  top: 20%;
  left: 25%;
  width: 600px;
  height: 400px;
  padding: 10px;
  border: 4px solid #ccc;
  overflow: scroll;
  background: #fff;
}
table {
  margin-left: auto;
  margin-right: auto;
}
table tr th {
  background: #f0f0f0;
  padding: 5px;
}
table tr td {
  padding: 5px;
}
</style>
  <body>
    <center>
      <h2>mail: inbox</h2>
      <table style='padding: 10px; border: 2px solid #ccc'>
        <tr>
          <th>received at</th>
          <th>sender</th>
          <th>receiver(s)</th>
          <th>message</th>
        </tr>

        <% count = 0 %>
        <% @m_mails.reverse.each do |mail| %>
          <% count += 1 %>
          <tr>
            <td><%= mail.created_at %></td>
            <td><%= mail.from.gsub(/[<>]/, '') %></td>
            <td><%= mail.recipient_list.join(", ").gsub(/[<>]/, '') %></td>
            <td>
              <a href='javascript:void(0)'
                 onclick='document.getElementById("message-body-<%= count %>").style.display = "block"'>display message</a>
              <div class="message-body" id='message-body-<%= count %>' style='display: none'>
                <a href='javascript:void(0)' onclick='document.getElementById("message-body-<%= count %>").style.display = "none"'>close</a>
                <%= mail.message %>
              </div>
            </td>
          </tr>
        <% end %>
      </table>
    </center>
  </body>
</html>
EOF
        template.result(binding)
      end
  end
end