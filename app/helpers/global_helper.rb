module Merb
  module GlobalHelper
    
    # fucking ugly (should be UJS)
    def method_delete(text, url)
      %Q(<a href="#{url}" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var m = document.createElement('input'); m.setAttribute('type', 'hidden'); m.setAttribute('name', '_method'); m.setAttribute('value', 'delete'); f.appendChild(m);var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', '606bc409a4d6490f177bf1936c3d6ed38ba730fb'); f.appendChild(s);f.submit();return false;">#{text}</a>)
    end
    
  end
end    